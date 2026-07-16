-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260707120002_recipes.sql
-- O QUÊ:     Fatia Receitas: enum de origem, pastas, receitas (com versões),
--            ingredientes, passos e o N:N receita<->pasta. RLS em tudo.
-- SPEC:      specs/backend/database.yaml (0002) + specs/backend/rls.yaml
-- NOTA:      snake_case aqui <-> camelCase no Dart (json field_rename: snake).
--            Grama é a base dos macros; unidade humana é referência (regra de dados).
-- ─────────────────────────────────────────────────────────────────────────────

-- Origem da receita (espelha enum RecipeSource do app).
create type public.recipe_source as enum
  ('youtube', 'instagram', 'site', 'pdf', 'photo', 'manual');

-- Atualiza updated_at a cada UPDATE (usada por recipes; reutilizável).
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- ── Pastas (capítulos) — agrupador de receitas independentes (≠ sub-receita) ──
create table public.folders (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name       text not null,
  hero_color text not null default 'clay',
  position   int  not null default 0,
  created_at timestamptz not null default now()
);

-- ── Receitas — cada VERSÃO é uma linha completa ("trocar tudo") ──────────────
-- A definitiva mantém o id canônico (id = version_group_id); antigas são linhas
-- próprias no mesmo grupo, fora de listas/pastas/favoritas.
create table public.recipes (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid not null default auth.uid() references auth.users (id) on delete cascade,
  title            text not null,
  source           public.recipe_source not null default 'manual',
  source_url       text,
  servings         int  not null default 2,
  time_minutes     int,
  kcal             int  not null default 0,
  protein          numeric not null default 0,
  carb             numeric not null default 0,
  fat              numeric not null default 0,
  difficulty       text,
  hero_color       text not null default 'clay',
  photo_count      int  not null default 0,
  notes            text,
  techniques       text[] not null default '{}',
  version          int  not null default 1,
  version_group_id uuid,  -- sem FK: chave lógica de grupo (id canônico da definitiva)
  -- Coluna gerada: definitiva = sem grupo OU dona do id canônico. Permite filtrar
  -- listas no servidor (PostgREST não compara coluna com coluna).
  is_definitive    boolean generated always as
                     (version_group_id is null or version_group_id = id) stored,
  created_at       timestamptz not null default now(),
  updated_at       timestamptz not null default now()
);

create trigger recipes_set_updated_at
  before update on public.recipes
  for each row execute function public.set_updated_at();

-- ── Ingredientes — grama é a base; humanQty/humanUnit são a referência ───────
create table public.recipe_ingredients (
  id         uuid primary key default gen_random_uuid(),
  recipe_id  uuid not null references public.recipes (id) on delete cascade,
  position   int  not null default 0,
  name       text not null,
  grams      numeric,
  human_qty  numeric,
  human_unit text
);

-- ── Passos do modo de preparo — tip vira o callout "Por quê" ─────────────────
create table public.recipe_steps (
  id        uuid primary key default gen_random_uuid(),
  recipe_id uuid not null references public.recipes (id) on delete cascade,
  position  int  not null default 0,
  text      text not null,
  tip       text
);

-- ── N:N receita <-> pasta (uma receita pode estar em várias pastas) ──────────
create table public.recipe_folders (
  recipe_id uuid not null references public.recipes (id) on delete cascade,
  folder_id uuid not null references public.folders (id) on delete cascade,
  primary key (recipe_id, folder_id)
);

-- ── Índices ──────────────────────────────────────────────────────────────────
create index folders_user_idx            on public.folders (user_id);
create index recipes_user_idx            on public.recipes (user_id);
create index recipes_group_idx           on public.recipes (version_group_id);
create index recipe_ingredients_rec_idx  on public.recipe_ingredients (recipe_id);
create index recipe_steps_rec_idx        on public.recipe_steps (recipe_id);

-- ── Grants explícitos: a porta abre SÓ para authenticated (anon = zero acesso);
-- a RLS abaixo filtra as linhas. O CLI atual não concede DML por padrão. ──────
grant select, insert, update, delete on public.folders            to authenticated;
grant select, insert, update, delete on public.recipes            to authenticated;
grant select, insert, update, delete on public.recipe_ingredients to authenticated;
grant select, insert, update, delete on public.recipe_steps       to authenticated;
grant select, insert, update, delete on public.recipe_folders     to authenticated;

-- ── RLS: cada usuário só enxerga/altera as PRÓPRIAS linhas ───────────────────
alter table public.folders            enable row level security;
alter table public.recipes            enable row level security;
alter table public.recipe_ingredients enable row level security;
alter table public.recipe_steps       enable row level security;
alter table public.recipe_folders     enable row level security;

create policy "folders: dono tudo" on public.folders
  for all using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "recipes: dono tudo" on public.recipes
  for all using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

-- Filhas: dono é quem possui a receita-mãe.
create policy "ingredientes: dono da receita" on public.recipe_ingredients
  for all using (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())));

create policy "passos: dono da receita" on public.recipe_steps
  for all using (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.recipes r
    where r.id = recipe_id and r.user_id = (select auth.uid())));

-- N:N: exige ser dono da receita E da pasta.
create policy "recipe_folders: dono dos dois" on public.recipe_folders
  for all using (
    exists (select 1 from public.recipes r
            where r.id = recipe_id and r.user_id = (select auth.uid()))
    and exists (select 1 from public.folders f
            where f.id = folder_id and f.user_id = (select auth.uid())))
  with check (
    exists (select 1 from public.recipes r
            where r.id = recipe_id and r.user_id = (select auth.uid()))
    and exists (select 1 from public.folders f
            where f.id = folder_id and f.user_id = (select auth.uid())));
