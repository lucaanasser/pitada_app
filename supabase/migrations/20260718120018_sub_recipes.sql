-- ─────────────────────────────────────────────────────────────────────────────
-- 20260718120018_sub_recipes.sql
-- Subreceita COMPARTILHADA: entidade própria com id ESTÁVEL (upsert, nunca
-- delete+insert da linha) usada por várias receitas via recipe_components.
-- Editar propaga; a única variação por uso é o scale. Desvincular = copiar
-- p/ componente local. Ver specs/features/sub_recipes.yaml.
-- SPEC: specs/backend/database.yaml (0018_sub_recipes.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create table public.sub_recipes (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name       text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger sub_recipes_set_updated_at
  before update on public.sub_recipes
  for each row execute function public.set_updated_at();

-- Espelho de recipe_ingredients: grama é a base; unidade humana é referência.
create table public.sub_recipe_ingredients (
  id            uuid primary key default gen_random_uuid(),
  sub_recipe_id uuid not null references public.sub_recipes (id) on delete cascade,
  position      int  not null default 0,
  name          text not null,
  grams         numeric,
  human_qty     numeric,
  human_unit    text,
  flavors       public.flavor_axis[] not null default '{}'
);

create table public.sub_recipe_steps (
  id            uuid primary key default gen_random_uuid(),
  sub_recipe_id uuid not null references public.sub_recipes (id) on delete cascade,
  position      int  not null default 0,
  text          text not null,
  tip           text
);

-- Qual técnica cada passo executa (espelho de recipe_step_techniques).
create table public.sub_recipe_step_techniques (
  step_id      uuid not null references public.sub_recipe_steps (id) on delete cascade,
  technique_id uuid not null references public.techniques (id) on delete cascade,
  anchor       text,
  primary key (step_id, technique_id)
);

-- O componente passa a poder APONTAR para uma subreceita (sem cascade: apagar
-- subreceita em uso é erro — desvincular primeiro). name fica null no vínculo.
alter table public.recipe_components
  add column sub_recipe_id uuid references public.sub_recipes (id),
  add column scale numeric not null default 1;

create index sub_recipes_user_idx              on public.sub_recipes (user_id);
create index sub_recipe_ingredients_sub_idx    on public.sub_recipe_ingredients (sub_recipe_id);
create index sub_recipe_steps_sub_idx          on public.sub_recipe_steps (sub_recipe_id);
create index sub_recipe_step_techniques_t_idx  on public.sub_recipe_step_techniques (technique_id);
create index recipe_components_sub_idx         on public.recipe_components (sub_recipe_id);

grant select, insert, update, delete on public.sub_recipes                to authenticated;
grant select, insert, update, delete on public.sub_recipe_ingredients     to authenticated;
grant select, insert, update, delete on public.sub_recipe_steps           to authenticated;
grant select, insert, update, delete on public.sub_recipe_step_techniques to authenticated;

alter table public.sub_recipes                enable row level security;
alter table public.sub_recipe_ingredients     enable row level security;
alter table public.sub_recipe_steps           enable row level security;
alter table public.sub_recipe_step_techniques enable row level security;

create policy "subreceitas: dono tudo" on public.sub_recipes
  for all using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

-- Dono é quem possui a subreceita-mãe (mesmo padrão de recipe_steps).
create policy "ingredientes de subreceita: dono" on public.sub_recipe_ingredients
  for all using (exists (
    select 1 from public.sub_recipes s
    where s.id = sub_recipe_id and s.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.sub_recipes s
    where s.id = sub_recipe_id and s.user_id = (select auth.uid())));

create policy "passos de subreceita: dono" on public.sub_recipe_steps
  for all using (exists (
    select 1 from public.sub_recipes s
    where s.id = sub_recipe_id and s.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.sub_recipes s
    where s.id = sub_recipe_id and s.user_id = (select auth.uid())));

create policy "tecnicas do passo de subreceita: dono" on public.sub_recipe_step_techniques
  for all using (exists (
    select 1 from public.sub_recipe_steps p
    join public.sub_recipes s on s.id = p.sub_recipe_id
    where p.id = step_id and s.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.sub_recipe_steps p
    join public.sub_recipes s on s.id = p.sub_recipe_id
    where p.id = step_id and s.user_id = (select auth.uid())));
