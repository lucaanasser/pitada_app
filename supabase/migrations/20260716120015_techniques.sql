-- ─────────────────────────────────────────────────────────────────────────────
-- 20260716120015_techniques.sql
-- Técnica vira ENTIDADE canônica: tabela por usuário (slug único) + aliases
-- globais (espelho de food_aliases) + N:N passo<->técnica com a âncora do grifo.
-- recipes.techniques (text[]) fica DEPRECADA até a 0017.
-- SPEC: specs/backend/database.yaml (0015_techniques.sql) + specs/backend/rls.yaml
-- ─────────────────────────────────────────────────────────────────────────────

create table public.techniques (
  id      uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  slug    text not null,  -- normalizado: unaccent+lower ('selar')
  name    text not null,  -- como a pessoa escreveu ('Selar a carne')
  notion  text,           -- a noção; IA rascunha no import, a pessoa edita
  unique (user_id, slug)
);

-- Referência GLOBAL termo -> slug canônico ('dourar a carne' -> 'selar').
create table public.technique_aliases (
  term      text primary key,
  canonical text not null
);

-- Qual técnica cada passo executa; anchor = trecho LITERAL do passo a grifar.
create table public.recipe_step_techniques (
  step_id      uuid not null references public.recipe_steps (id) on delete cascade,
  technique_id uuid not null references public.techniques (id) on delete cascade,
  anchor       text,
  primary key (step_id, technique_id)
);

create index techniques_user_idx           on public.techniques (user_id);
create index recipe_step_techniques_t_idx  on public.recipe_step_techniques (technique_id);

grant select, insert, update, delete on public.techniques             to authenticated;
grant select                          on public.technique_aliases     to anon, authenticated, service_role;
grant select, insert, update, delete on public.recipe_step_techniques to authenticated;

alter table public.techniques             enable row level security;
alter table public.technique_aliases      enable row level security;
alter table public.recipe_step_techniques enable row level security;

create policy "tecnicas: dono tudo" on public.techniques
  for all using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "aliases de tecnica: leitura autenticada" on public.technique_aliases
  for select to authenticated using (true);

-- Dono é quem possui a receita do passo.
create policy "tecnicas do passo: dono da receita" on public.recipe_step_techniques
  for all using (exists (
    select 1 from public.recipe_steps s
    join public.recipes r on r.id = s.recipe_id
    where s.id = step_id and r.user_id = (select auth.uid())))
  with check (exists (
    select 1 from public.recipe_steps s
    join public.recipes r on r.id = s.recipe_id
    where s.id = step_id and r.user_id = (select auth.uid())));
