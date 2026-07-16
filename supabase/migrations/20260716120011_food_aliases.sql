-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260716120011_food_aliases.sql
-- O QUÊ:     Canonicalização determinística de termos coloquiais comuns → consulta
--            canônica que a busca resolve bem ("leite"→"leite integral"). Atalho de
--            ALTA confiança para os alimentos mais registrados, sem IA. O long tail
--            ambíguo fica pra IA de desambiguação (rerank em disambiguate.ts).
-- USA:       —
-- USADO POR: resolve.ts (estimate-food) via leitura de food_aliases.
-- SPEC:      specs/backend/database.yaml (migration 0011_food_aliases.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create table public.food_aliases (
  term      text primary key,   -- termo coloquial normalizado (unaccent+lower)
  canonical text not null,      -- consulta p/ search_foods
  note      text
);

alter table public.food_aliases enable row level security;
create policy food_aliases_read_authenticated on public.food_aliases
  for select to authenticated using (true);
grant select on public.food_aliases to anon, authenticated, service_role;

-- Mapeia o termo BARE/coloquial p/ a forma canônica (fluida/cozida/mais comum).
insert into public.food_aliases (term, canonical) values
  ('leite', 'leite integral'),
  ('leite em po', 'leite em pó'),
  ('arroz', 'arroz cozido'),
  ('feijao', 'feijão carioca cozido'),
  ('pao', 'pão francês'),
  ('pao de forma', 'pão de forma'),
  ('ovo', 'ovo de galinha cozido'),
  ('ovos', 'ovo de galinha cozido'),
  ('cafe', 'café'),
  ('macarrao', 'macarrão cozido'),
  ('miojo', 'macarrão instantâneo'),
  ('batata', 'batata cozida'),
  ('batata frita', 'batata frita'),
  ('frango', 'peito de frango grelhado'),
  ('carne', 'carne bovina cozida'),
  ('carne moida', 'carne moída refogada'),
  ('queijo', 'queijo minas'),
  ('banana', 'banana prata'),
  ('maca', 'maçã'),
  ('acucar', 'açúcar'),
  ('oleo', 'óleo de soja'),
  ('azeite', 'azeite de oliva'),
  ('manteiga', 'manteiga com sal'),
  ('margarina', 'margarina'),
  ('suco', 'suco de laranja'),
  ('refrigerante', 'refrigerante'),
  ('refri', 'refrigerante'),
  ('iogurte', 'iogurte natural'),
  ('aveia', 'aveia em flocos'),
  ('tapioca', 'tapioca'),
  ('cuscuz', 'cuscuz de milho'),
  ('farofa', 'farofa'),
  ('pizza', 'pizza'),
  ('hamburguer', 'hambúrguer'),
  ('tomate', 'tomate'),
  ('cebola', 'cebola'),
  ('alho', 'alho'),
  ('cenoura', 'cenoura cozida'),
  ('brocolis', 'brócolis cozido'),
  ('achocolatado', 'achocolatado em pó'),
  ('toddy', 'achocolatado em pó'),
  ('nescau', 'achocolatado em pó'),
  ('whey', 'whey protein');
