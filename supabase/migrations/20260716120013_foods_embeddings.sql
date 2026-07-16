-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260716120013_foods_embeddings.sql
-- O QUÊ:     Busca SEMÂNTICA (pgvector): coluna de embedding em foods + função
--            search_foods_hybrid que mistura lexical (word_similarity) com vetor
--            (cosseno). Cruza idioma/sinônimo — "tilápia grelhada" acha "Fish,
--            tilapia, cooked" (USDA). O embedding é populado à parte por
--            gen_embeddings.mjs (dado derivado). Sem ele, cai p/ lexical puro.
-- USA:       extensão vector (pgvector); pg_trgm/unaccent (0004).
-- USADO POR: Edge Function estimate-food (foods.ts) via search_foods_hybrid.
-- SPEC:      specs/backend/database.yaml (migration 0013_foods_embeddings.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create extension if not exists vector;

alter table public.foods add column embedding vector(768);   -- gemini-embedding-001, 768d
-- Vizinho mais próximo por cosseno (populado depois; índice mantém-se incremental).
create index foods_embedding_hnsw on public.foods
  using hnsw (embedding vector_cosine_ops);

-- ─────────────────────────────────────────────────────────────────────────────
-- search_foods_hybrid: mesma saída de search_foods, mas o ranking mistura lexical
-- e semântico. query_embedding chega como texto '[...]' (a Edge Function embeda a
-- query) e é convertido em vetor; se null, vira busca lexical pura. Inclui a linha
-- quando casa lexical (>=0.3) OU semanticamente (cosseno alto).
-- ─────────────────────────────────────────────────────────────────────────────
create or replace function public.search_foods_hybrid(
  query text, query_embedding text default null, max_rows int default 5
)
returns table (
  id uuid, name text, category text, source text, barcode text,
  kcal numeric, protein numeric, carb numeric, fat numeric, fiber numeric,
  score real
)
language sql stable security definer set search_path = public, extensions as $$
  with q as (
    select unaccent(lower(query)) as t,
           split_part(unaccent(lower(query)), ' ', 1) as head,
           case when query_embedding is null then null else query_embedding::vector(768) end as qe
  )
  select f.id, f.name, f.category, f.source, f.barcode,
         f.kcal, f.protein, f.carb, f.fat, f.fiber,
         word_similarity(q.t, f.name_norm) as score
  from public.foods f
  cross join q
  left join public.food_sources s on s.source = f.source
  where f.kcal > 0
    and (
      word_similarity(q.t, f.name_norm) >= 0.3
      or (q.qe is not null and f.embedding is not null and (f.embedding <=> q.qe) < 0.45)
    )
  order by (
      0.40 * word_similarity(q.t, f.name_norm)
    + 0.50 * (case when q.qe is not null and f.embedding is not null
                   then greatest(0, 1 - (f.embedding <=> q.qe)) else 0 end)
    + 0.10 * (case when f.name_norm like q.head || '%' then 1 else 0 end)
  ) desc, coalesce(s.rank, 99) asc
  limit greatest(max_rows, 1);
$$;

grant execute on function public.search_foods_hybrid(text, text, int)
  to authenticated, anon, service_role;

-- Escrita em lote dos embeddings (usada só pelo gen_embeddings.mjs com service role).
-- data = jsonb array de {id, e:'[...]'}. security definer: escreve sem grant por role.
create or replace function public.set_embeddings(data jsonb)
returns int
language sql security definer set search_path = public as $$
  with upd as (
    update public.foods f
    set embedding = (e->>'e')::vector(768)
    from jsonb_array_elements(data) e
    where f.id = (e->>'id')::uuid
    returning 1
  )
  select count(*)::int from upd;
$$;

grant execute on function public.set_embeddings(jsonb) to service_role;
