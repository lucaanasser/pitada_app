-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120004_foods.sql
-- O QUÊ:     Tabela `foods` (composição nutricional por 100 g) + busca fuzzy por
--            nome. Base da estimativa CONFIÁVEL de calorias: a IA só decompõe o
--            texto em ingredientes+gramas; a CONTA sai daqui (valores reais TACO).
-- USA:       extensões pg_trgm (similaridade) e unaccent (busca sem acento).
-- USADO POR: Edge Function estimate-food (search_foods); seed em 0005_foods_taco.
-- SPEC:      specs/backend/database.yaml (migration 0004_foods.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create extension if not exists pg_trgm;
create extension if not exists unaccent;

-- Dado de REFERÊNCIA (não é de usuário): 1 linha por alimento, valores por 100 g.
create table public.foods (
  id         uuid primary key default gen_random_uuid(),
  source     text        not null default 'taco',   -- origem (taco, tbca, off...)
  ext_id     int,                                    -- id na fonte (rastreabilidade)
  name       text        not null,                   -- description da fonte
  name_norm  text        not null,                   -- unaccent(lower(name)) p/ busca
  category   text,
  kcal       numeric     not null,                   -- por 100 g
  protein    numeric     not null default 0,         -- g por 100 g
  carb       numeric     not null default 0,         -- g por 100 g
  fat        numeric     not null default 0,         -- g por 100 g
  fiber      numeric     default 0,                  -- g por 100 g
  created_at timestamptz not null default now()
);

-- Não duplica o mesmo alimento da mesma fonte (seed idempotente usa isto).
create unique index foods_source_ext_id_key on public.foods (source, ext_id);
-- Busca por similaridade de nome (trigram).
create index foods_name_norm_trgm on public.foods using gin (name_norm gin_trgm_ops);

-- Dado público de referência: qualquer usuário logado lê; ninguém escreve pelo app
-- (só migration/seed via role de serviço, que ignora RLS).
alter table public.foods enable row level security;
create policy foods_read_authenticated on public.foods
  for select to authenticated using (true);

-- ─────────────────────────────────────────────────────────────────────────────
-- search_foods(query, max_rows): casa um ingrediente com a(s) linha(s) mais
-- parecida(s) da tabela. Usa word_similarity (insensível a acento/caixa): mede o
-- quanto a query casa uma PALAVRA/trecho do nome — ideal p/ ingrediente curto
-- ("arroz") contra descrição longa da TACO ("Arroz, tipo 1, cozido"). Usada pela
-- Edge Function estimate-food p/ achar os valores por 100 g de cada ingrediente.
-- Retorna as melhores linhas com `score` (0..1) desc; corta abaixo de 0.4.
-- ─────────────────────────────────────────────────────────────────────────────
-- security definer: roda como dono (postgres), então lê `foods` sem depender de
-- grant por role (a Edge Function chama com a service role). search_path fixo evita
-- sequestro de nome. Só faz SELECT de dado público — seguro expor.
create or replace function public.search_foods(query text, max_rows int default 5)
returns table (
  id uuid, name text, category text,
  kcal numeric, protein numeric, carb numeric, fat numeric, fiber numeric,
  score real
)
language sql stable security definer set search_path = public as $$
  select f.id, f.name, f.category,
         f.kcal, f.protein, f.carb, f.fat, f.fiber,
         word_similarity(unaccent(lower(query)), f.name_norm) as score
  from public.foods f
  where word_similarity(unaccent(lower(query)), f.name_norm) >= 0.4
  order by score desc
  limit greatest(max_rows, 1);
$$;

grant execute on function public.search_foods(text, int) to authenticated, anon, service_role;
