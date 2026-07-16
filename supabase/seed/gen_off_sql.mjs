// ─────────────────────────────────────────────────────────────────────────────
// supabase/seed/gen_off_sql.mjs
// O QUÊ:     Gera a migration de produtos de MARCA do Brasil (tabela foods,
//            source='off') consultando a API do Open Food Facts por termos
//            relevantes ao app. Filtra dados sãos e deduplica por barcode.
// USA:       API pública Open Food Facts (país=brasil). ODbL: atribuição em
//            food_sources (migration 0006).
// USADO POR: dev — `node supabase/seed/gen_off_sql.mjs` (precisa de rede).
// SPEC:      specs/backend/database.yaml (migration 0007_foods_off_seed.sql)
// ─────────────────────────────────────────────────────────────────────────────
import { writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const here = dirname(fileURLToPath(import.meta.url));
const OUT = join(here, '..', 'migrations', '20260715120007_foods_off_seed.sql');

// Termos que cobrem o mercado brasileiro comum + os exemplos do usuário.
const TERMS = [
  'leite integral', 'leite desnatado', 'toddy', 'nescau', 'whey protein',
  'granola', 'aveia', 'iogurte', 'requeijão', 'pão de forma', 'queijo mussarela',
  'manteiga', 'margarina', 'achocolatado', 'suco de laranja', 'refrigerante',
  'biscoito', 'barra de cereal', 'creme de leite', 'leite condensado',
];
const PER_TERM = 8;          // teto de produtos por termo
const UA = 'PitadaApp/1.0 (contato: lucanaasser@gmail.com)';   // OFF pede User-Agent

/// Escapa aspa simples para literal SQL. Usada por: montagem das linhas.
const q = (s) => `'${String(s).replace(/'/g, "''")}'`;
/// Número são (0..max) ou null. Usada por: validação de nutriente.
const num = (v, max) => {
  const x = +v;
  return Number.isFinite(x) && x >= 0 && x <= max ? Math.round(x * 100) / 100 : null;
};

/// Espera ms milissegundos. Usada por: throttle entre chamadas à OFF.
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

/// GET com retry/backoff — a OFF devolve 503 sob carga. Usada por: fetchTerm.
async function getJson(url) {
  for (let attempt = 1; attempt <= 4; attempt++) {
    const res = await fetch(url, { headers: { 'User-Agent': UA } });
    if (res.ok) return res.json();
    if (res.status !== 503 || attempt === 4) throw new Error(`OFF ${res.status}`);
    await sleep(attempt * 2000);   // 2s, 4s, 6s
  }
}

/// Busca produtos BR de um termo na OFF e devolve linhas válidas. Usada por: main.
async function fetchTerm(term) {
  const url = 'https://world.openfoodfacts.org/cgi/search.pl?' + new URLSearchParams({
    search_terms: term, tagtype_0: 'countries', tag_contains_0: 'contains',
    tag_0: 'brazil', fields: 'code,product_name,brands,nutriments',
    json: '1', page_size: String(PER_TERM * 3), sort_by: 'unique_scans_n',
  });
  const { products = [] } = await getJson(url);
  const out = [];
  for (const p of products) {
    const n = p.nutriments ?? {};
    const kcal = num(n['energy-kcal_100g'], 900);        // energia plausível por 100 g
    const name = (p.product_name ?? '').trim();
    if (!p.code || !name || kcal == null || kcal <= 0) continue;  // descarta dado ruim
    const label = p.brands ? `${name} (${p.brands})` : name;
    out.push({
      barcode: String(p.code), name: label,
      kcal, protein: num(n.proteins_100g, 100) ?? 0,
      carb: num(n.carbohydrates_100g, 100) ?? 0, fat: num(n.fat_100g, 100) ?? 0,
      fiber: num(n.fiber_100g, 100) ?? 0,
    });
    if (out.length >= PER_TERM) break;
  }
  return out;
}

const seen = new Set();
const rows = [];
for (const term of TERMS) {
  try {
    for (const r of await fetchTerm(term)) {
      if (seen.has(r.barcode)) continue;         // dedup por barcode entre termos
      seen.add(r.barcode);
      rows.push(r);
    }
    console.log(`[Pitada][core] OFF "${term}": ${seen.size} acumulados`);
  } catch (e) {
    console.log(`[Pitada][core] OFF "${term}" falhou: ${e.message}`);
  }
  await sleep(1500);   // throttle entre termos p/ não tomar 503
}

const values = rows.map((r) =>
  `  ('off', ${q(r.barcode)}, ${q(r.name)}, unaccent(lower(${q(r.name)})), ` +
  `'Industrializados', ${r.kcal}, ${r.protein}, ${r.carb}, ${r.fat}, ${r.fiber})`,
).join(',\n');

const sql = `-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120007_foods_off_seed.sql
-- O QUÊ:     ${rows.length} produtos de marca do Brasil na tabela foods (source='off').
--            GERADO por supabase/seed/gen_off_sql.mjs — NÃO editar à mão.
-- FONTE:     Open Food Facts (ODbL — atribuição em food_sources). Dado colaborativo,
--            filtrado por energia/nome válidos e deduplicado por barcode.
-- USADO POR: search_foods() / Edge Function estimate-food.
-- SPEC:      specs/backend/database.yaml (migration 0007_foods_off_seed.sql)
-- ─────────────────────────────────────────────────────────────────────────────
insert into public.foods
  (source, barcode, name, name_norm, category, kcal, protein, carb, fat, fiber)
values
${values}
on conflict (source, barcode) where barcode is not null do update set
  name = excluded.name, name_norm = excluded.name_norm, category = excluded.category,
  kcal = excluded.kcal, protein = excluded.protein, carb = excluded.carb,
  fat = excluded.fat, fiber = excluded.fiber;
`;

writeFileSync(OUT, sql);
console.log(`[Pitada][core] seed OFF gerado: ${OUT} (${rows.length} produtos)`);
