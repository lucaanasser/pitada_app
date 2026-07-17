-- ─────────────────────────────────────────────────────────────────────────────
-- 20260717120017_drop_recipe_techniques.sql
-- Fim das técnicas soltas: semeia aliases comuns, migra recipes.techniques
-- (text[]) para entidades canônicas e dropa a coluna. As técnicas migradas
-- existem e listam suas receitas, mas SEM grifo no passo (não há como saber
-- qual passo) — a pessoa liga ao editar. Degradação correta.
-- SPEC: specs/backend/database.yaml (0017_drop_recipe_techniques.sql)
-- ─────────────────────────────────────────────────────────────────────────────

-- Aliases universais termo -> slug canônico (referência global, como food_aliases).
insert into public.technique_aliases (term, canonical) values
  ('selar a carne', 'selar'),
  ('dourar', 'selar'),
  ('dourar a carne', 'selar'),
  ('emulsionar um molho', 'emulsionar'),
  ('emulsionar o molho', 'emulsionar'),
  ('refogado', 'refogar')
on conflict (term) do nothing;

-- Backfill: cada string solta vira uma técnica do usuário (slug via alias
-- quando houver; senão unaccent+lower da própria string).
insert into public.techniques (user_id, slug, name)
select distinct
  r.user_id,
  coalesce(a.canonical, lower(public.unaccent(t))),
  t
from public.recipes r
cross join lateral unnest(r.techniques) as t
left join public.technique_aliases a on a.term = lower(public.unaccent(t))
on conflict (user_id, slug) do nothing;

alter table public.recipes drop column techniques;
