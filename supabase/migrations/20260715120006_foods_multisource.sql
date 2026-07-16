-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120006_foods_multisource.sql
-- O QUÊ:     Prepara `foods` p/ VÁRIAS fontes (TACO, IBGE, Open Food Facts, USDA):
--            coluna barcode, tabela food_sources (rank/atribuição) e search_foods
--            devolvendo source+barcode, desempatando por confiança da fonte.
-- USA:       extensões pg_trgm/unaccent (migration 0004).
-- USADO POR: Edge Function estimate-food (re-rank); ingestões 0007+ (OFF, IBGE).
-- SPEC:      specs/backend/database.yaml (migration 0006_foods_multisource.sql)
-- ─────────────────────────────────────────────────────────────────────────────

-- Código de barras (Open Food Facts) — permite ligar a estimativa ao scanner.
alter table public.foods add column barcode text;
-- Único por fonte: chave natural do seed da OFF (barcode estoura int, não vira ext_id).
create unique index foods_source_barcode_key
  on public.foods (source, barcode) where barcode is not null;

-- Metadados por fonte: rank de confiança (desempate) + atribuição (ODbL da OFF exige).
create table public.food_sources (
  source      text primary key,
  rank        int  not null,   -- menor = mais confiável quando o score empata
  label       text,
  license     text,
  attribution text
);

insert into public.food_sources (source, rank, label, license, attribution) values
  ('taco', 1, 'TACO 4ª ed. (NEPA/UNICAMP)', 'digitalização MIT', 'NEPA/UNICAMP'),
  ('ibge', 2, 'IBGE POF — Alimentos consumidos no Brasil', 'dado público', 'IBGE'),
  ('off',  3, 'Open Food Facts (Brasil)', 'ODbL', 'Open Food Facts contributors'),
  ('usda', 4, 'USDA FoodData Central', 'domínio público', 'U.S. Department of Agriculture');

alter table public.food_sources enable row level security;
create policy food_sources_read_authenticated on public.food_sources
  for select to authenticated using (true);

-- ─────────────────────────────────────────────────────────────────────────────
-- search_foods (v2): igual à v1 (word_similarity + unaccent), mas devolve também
-- source e barcode, e desempata por rank da fonte (score igual → fonte mais
-- confiável primeiro). Retorna top max_rows p/ o re-rank da IA escolher.
-- ─────────────────────────────────────────────────────────────────────────────
-- Mudou o tipo de retorno (agora traz source/barcode): precisa dropar antes.
drop function if exists public.search_foods(text, int);
create function public.search_foods(query text, max_rows int default 5)
returns table (
  id uuid, name text, category text, source text, barcode text,
  kcal numeric, protein numeric, carb numeric, fat numeric, fiber numeric,
  score real
)
language sql stable security definer set search_path = public as $$
  with q as (
    select unaccent(lower(query)) as t,
           split_part(unaccent(lower(query)), ' ', 1) as head   -- palavra-cabeça da busca
  )
  select f.id, f.name, f.category, f.source, f.barcode,
         f.kcal, f.protein, f.carb, f.fat, f.fiber,
         word_similarity(q.t, f.name_norm) as score
  from public.foods f
  cross join q
  left join public.food_sources s on s.source = f.source
  where word_similarity(q.t, f.name_norm) >= 0.3
    and f.kcal > 0                       -- descarta linhas zeradas (dado ruim/água)
  -- Ranking: (1) quem COMEÇA com a palavra-cabeça vem primeiro ("arroz branco" acha
  -- "arroz…", não "molho branco"); (2) blend word_similarity+similarity premia o nome
  -- mais específico/curto; (3) rank da fonte desempata.
  order by (f.name_norm like q.head || '%') desc,
           (word_similarity(q.t, f.name_norm) * 0.5 + similarity(q.t, f.name_norm) * 0.5) desc,
           coalesce(s.rank, 99) asc
  limit greatest(max_rows, 1);
$$;

grant execute on function public.search_foods(text, int) to authenticated, anon, service_role;
