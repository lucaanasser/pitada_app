// ─────────────────────────────────────────────────────────────────────────────
// supabase/seed/gen_ibge_sql.mjs
// O QUÊ:     Gera a migration dos alimentos "como consumidos" do IBGE POF (tabela
//            foods, source='ibge') a partir de supabase/seed/ibge_pof.csv.
// USA:       ibge_pof.csv — extraído do XLS oficial do IBGE (FTP) por um passo
//            Python/xlrd (ver cabeçalho da migration). ODbL não se aplica: dado público.
// USADO POR: dev — `node supabase/seed/gen_ibge_sql.mjs`.
// SPEC:      specs/backend/database.yaml (migration 0009_foods_ibge_seed.sql)
// ─────────────────────────────────────────────────────────────────────────────
import { readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const here = dirname(fileURLToPath(import.meta.url));
const OUT = join(here, '..', 'migrations', '20260715120009_foods_ibge_seed.sql');

/// Escapa aspa simples para literal SQL. Usada por: montagem das linhas.
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

const lines = readFileSync(join(here, 'ibge_pof.csv'), 'utf8').trim().split('\n');
lines.shift();   // cabeçalho

const values = lines.map((line) => {
  const [ext, name, kcal, protein, carb, fat, fiber] = splitCsv(line);
  return `  ('ibge', ${ext}, ${q(name)}, unaccent(lower(${q(name)})), ` +
    `'Preparações', ${kcal}, ${protein}, ${carb}, ${fat}, ${fiber})`;
}).join(',\n');

const sql = `-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120009_foods_ibge_seed.sql
-- O QUÊ:     ${lines.length} alimentos "como consumidos" do IBGE POF na tabela foods
--            (source='ibge', por 100 g). GERADO por gen_ibge_sql.mjs — NÃO editar.
-- FONTE:     IBGE POF 2008-2009, Tabela de Composição Nutricional dos Alimentos
--            Consumidos no Brasil (dado público). XLS: ftp.ibge.gov.br → extraído
--            p/ supabase/seed/ibge_pof.csv (Python/xlrd) → este SQL.
-- USADO POR: search_foods() / Edge Function estimate-food.
-- SPEC:      specs/backend/database.yaml (migration 0009_foods_ibge_seed.sql)
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
console.log(`[Pitada][core] seed IBGE gerado: ${OUT} (${lines.length} preparações)`);
