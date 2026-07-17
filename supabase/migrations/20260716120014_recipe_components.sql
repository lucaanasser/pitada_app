-- ─────────────────────────────────────────────────────────────────────────────
-- 20260716120014_recipe_components.sql
-- Componentes de receita (massa/cobertura/molho) — componente é SUB-RECEITA
-- (macros somam no prato, ver rules/data-model.md), nunca pasta.
-- component_id null nas filhas = componente implícito (receita simples);
-- por isso NENHUM backfill: receitas existentes não mudam.
-- SPEC: specs/backend/database.yaml (0014_recipe_components.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create table public.recipe_components (
  id        uuid primary key default gen_random_uuid(),
  recipe_id uuid not null references public.recipes (id) on delete cascade,
  position  int  not null default 0,
  name      text  -- null = componente implícito (receita sem partes nomeadas)
);

alter table public.recipe_ingredients
  add column component_id uuid references public.recipe_components (id) on delete cascade;
alter table public.recipe_steps
  add column component_id uuid references public.recipe_components (id) on delete cascade;

create index recipe_components_rec_idx      on public.recipe_components (recipe_id);
create index recipe_ingredients_comp_idx    on public.recipe_ingredients (component_id);
create index recipe_steps_comp_idx          on public.recipe_steps (component_id);

grant select, insert, update, delete on public.recipe_components to authenticated;

alter table public.recipe_components enable row level security;

-- Dono é quem possui a receita-mãe (mesmo padrão de recipe_steps).
create policy "componentes: dono da receita" on public.recipe_components
  for all using (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())));
