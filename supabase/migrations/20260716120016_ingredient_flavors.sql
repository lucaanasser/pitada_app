-- ─────────────────────────────────────────────────────────────────────────────
-- 20260716120016_ingredient_flavors.sql
-- Eixo de sabor como FUNÇÃO do ingrediente (limão = acidez): informação, nunca
-- veredito do prato. Base da substituição futura (frescor -> frescor).
-- SPEC: specs/backend/database.yaml (0016_ingredient_flavors.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create type public.flavor_axis as enum
  ('acid', 'umami', 'fat', 'sweet', 'bitter', 'salt', 'fresh');

alter table public.recipe_ingredients
  add column flavors public.flavor_axis[] not null default '{}';
