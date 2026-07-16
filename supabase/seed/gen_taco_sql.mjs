// ─────────────────────────────────────────────────────────────────────────────
// supabase/seed/gen_taco_sql.mjs
// O QUÊ:     Gera a migration de dados da TACO (tabela foods) a partir de TACO.json.
//            Roda uma vez para (re)criar 0005_foods_taco_seed.sql — idempotente.
// USA:       supabase/seed/TACO.json (TACO 4ª ed., digitalização MIT marcelosanto).
// USADO POR: dev que atualiza a base — `node supabase/seed/gen_taco_sql.mjs`.
// SPEC:      specs/backend/database.yaml (migration 0005_foods_taco_seed.sql)
// ─────────────────────────────────────────────────────────────────────────────
import { readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const here = dirname(fileURLToPath(import.meta.url));
const OUT = join(here, '..', 'migrations', '20260715120005_foods_taco_seed.sql');

/// Escapa aspa simples para literal SQL. Usada por: montagem das linhas.
const q = (s) => `'${String(s).replace(/'/g, "''")}'`;
/// Número seguro (null/NA -> 0), arredondado a 2 casas. Usada por: montagem.
const n = (v) => (v == null || Number.isNaN(+v) ? 0 : Math.round(+v * 100) / 100);

const rows = JSON.parse(readFileSync(join(here, 'TACO.json'), 'utf8'));

// name_norm fica como expressão unaccent(lower(...)) — mesma normalização da busca.
const values = rows.map((r) =>
  `  ('taco', ${r.id}, ${q(r.description)}, unaccent(lower(${q(r.description)})), ` +
  `${q(r.category)}, ${n(r.energy_kcal)}, ${n(r.protein_g)}, ` +
  `${n(r.carbohydrate_g)}, ${n(r.lipid_g)}, ${n(r.fiber_g)})`,
).join(',\n');

const sql = `-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120005_foods_taco_seed.sql
-- O QUÊ:     Dados: ${rows.length} alimentos da TACO 4ª ed. na tabela foods (por 100 g).
--            GERADO por supabase/seed/gen_taco_sql.mjs — NÃO editar à mão.
-- FONTE:     TACO 4ª ed. (NEPA/UNICAMP, 2011); digitalização MIT
--            github.com/marcelosanto/tabela_taco (TACO.json).
-- USADO POR: search_foods() / Edge Function estimate-food.
-- SPEC:      specs/backend/database.yaml (migration 0005_foods_taco_seed.sql)
-- ─────────────────────────────────────────────────────────────────────────────
insert into public.foods
  (source, ext_id, name, name_norm, category, kcal, protein, carb, fat, fiber)
values
${values}
on conflict (source, ext_id) do update set
  name = excluded.name, name_norm = excluded.name_norm, category = excluded.category,
  kcal = excluded.kcal, protein = excluded.protein, carb = excluded.carb,
  fat = excluded.fat, fiber = excluded.fiber;
`;

writeFileSync(OUT, sql);
console.log(`[Pitada][core] seed gerado: ${OUT} (${rows.length} alimentos)`);
