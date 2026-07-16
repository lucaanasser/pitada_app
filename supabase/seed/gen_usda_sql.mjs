// ─────────────────────────────────────────────────────────────────────────────
// supabase/seed/gen_usda_sql.mjs
// O QUÊ:     Gera a migration do USDA SR Legacy (tabela foods, source='usda') a
//            partir de supabase/seed/usda_sr.csv. Nomes em INGLÊS — cobre lacunas
//            (peixes, cortes, suplementos) que TACO/IBGE/OFF não têm. A busca
//            cross-idioma vem depois via embeddings/pgvector.
// USA:       usda_sr.csv — extraído do bulk CSV do FoodData Central (SR Legacy,
//            domínio público) por um passo Python documentado.
// USADO POR: dev — `node supabase/seed/gen_usda_sql.mjs`.
// SPEC:      specs/backend/database.yaml (migration 0012_foods_usda_seed.sql)
// ─────────────────────────────────────────────────────────────────────────────
import { readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const here = dirname(fileURLToPath(import.meta.url));
const OUT = join(here, '..', 'migrations', '20260716120012_foods_usda_seed.sql');

const q = (s) => `'${String(s).replace(/'/g, "''")}'`;

/// Divide uma linha CSV respeitando aspas ("" = aspa interna). Usada por: parse.
function splitCsv(line) {
  const out = [];
  let cur = '', inQ = false;
  for (let i = 0; i < line.length; i++) {
    const c = line[i];
    if (inQ) {
      if (c === '"' && line[i + 1] === '"') { cur += '"'; i++; }
      else if (c === '"') inQ = false;
      else cur += c;
    } else if (c === '"') inQ = true;
    else if (c === ',') { out.push(cur); cur = ''; }
    else cur += c;
  }
  out.push(cur);
  return out;
}

const lines = readFileSync(join(here, 'usda_sr.csv'), 'utf8').trim().split('\n');
lines.shift();

const values = lines.map((line) => {
  const [ext, name, kcal, protein, carb, fat, fiber] = splitCsv(line);
  return `  ('usda', ${ext}, ${q(name)}, unaccent(lower(${q(name)})), ` +
    `'USDA', ${kcal}, ${protein}, ${carb}, ${fat}, ${fiber})`;
}).join(',\n');

const sql = `-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260716120012_foods_usda_seed.sql
-- O QUÊ:     ${lines.length} alimentos do USDA SR Legacy na tabela foods (source='usda',
--            por 100 g, nomes em inglês). GERADO por gen_usda_sql.mjs — NÃO editar.
-- FONTE:     USDA FoodData Central, SR Legacy (domínio público). CSV bulk →
--            supabase/seed/usda_sr.csv (Python) → este SQL. Preenche lacunas
--            (peixes, cortes, suplementos); busca cross-idioma via embeddings.
-- USADO POR: search_foods() / Edge Function estimate-food.
-- SPEC:      specs/backend/database.yaml (migration 0012_foods_usda_seed.sql)
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
console.log(`[Pitada][core] seed USDA gerado: ${OUT} (${lines.length} alimentos)`);
