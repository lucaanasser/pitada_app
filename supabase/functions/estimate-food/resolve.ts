// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/resolve.ts
// O QUÊ:     Resolvedor HÍBRIDO e AUDITÁVEL. Números 100% de tabela; a decisão do
//            MATCH usa (1) alias canônico → (2) vencedor lexical claro → (3) IA de
//            desambiguação quando ambíguo (aumenta precisão sem produzir número).
//            Cada item sai com confiança + alternativas (auditável); sem match →
//            unresolved (fora do total, nunca chuta).
// USA:       MASS/VOLUME (parser.ts), searchCandidates (foods.ts), disambiguate.ts.
// USADO POR: index.ts.
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food.estrategia)
// ─────────────────────────────────────────────────────────────────────────────
import { Alternative, BreakdownItem, FoodRow, Token } from "./deps.ts";
import { MASS, VOLUME } from "./parser.ts";
import { searchCandidates } from "./foods.ts";
import { AmbiguousItem, disambiguate } from "./disambiguate.ts";

const DEFAULT_SERVING_G = 100;   // porção assumida quando não há unidade nem hint
const r1 = (v: number) => Math.round(v * 10) / 10;
const norm = (s: string) =>
  s.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").trim();

/// Converte um token em gramas usando SÓ tabela (massa/volume ou portion_hints).
/// Usada por: resolveTokens.
function toGrams(t: Token, hints: Record<string, number>): { grams: number; assumed: boolean } {
  const unit = t.unit?.toLowerCase() ?? "";
  const q = t.qty ?? 1;
  const assumedQty = t.qty == null;
  if (unit in MASS) return { grams: q * MASS[unit], assumed: false };
  if (unit in VOLUME) return { grams: q * VOLUME[unit], assumed: false };
  if (unit in hints) return { grams: q * hints[unit], assumed: assumedQty };
  const food = norm(t.food);
  if (food in hints) return { grams: q * hints[food], assumed: assumedQty };
  return { grams: q * DEFAULT_SERVING_G, assumed: true };
}

// Estado por ingrediente antes de decidir o match.
interface Prep { t: Token; grams: number; assumed: boolean; aliasHit: boolean; cands: FoodRow[] }

/// Decide o índice do candidato: alias/vencedor claro (sem IA) ou marca p/ desambiguar.
/// Devolve {idx, via, conf} ou null (ambíguo → IA). Usada por: resolveTokens.
function decide(p: Prep): { idx: number; via: "alias" | "busca"; conf: "alta" | "media" } | null {
  if (p.aliasHit) return { idx: 0, via: "alias", conf: "alta" };
  const s0 = p.cands[0].score, s1 = p.cands[1]?.score ?? 0;
  if (p.cands.length === 1 || (s0 - s1 >= 0.15 && s0 >= 0.55)) {
    return { idx: 0, via: "busca", conf: s0 >= 0.7 ? "alta" : "media" };
  }
  return null;   // vencedor não é claro → IA de desambiguação
}

/// Monta a linha final do breakdown a partir do candidato escolhido. Usada por: resolveTokens.
function buildItem(
  p: Prep, idx: number, via: "alias" | "busca" | "ia", conf: "alta" | "media" | "baixa",
): BreakdownItem {
  const g = p.grams;
  if (idx < 0 || p.cands.length === 0) {
    return {
      name: p.t.food, grams: g, kcal: 0, protein: 0, carb: 0, fat: 0,
      confidence: "baixa", assumed: p.assumed, unresolved: true, alternatives: [],
    };
  }
  const food = p.cands[idx], f = g / 100;
  const alts: Alternative[] = p.cands.filter((_, j) => j !== idx).slice(0, 3)
    .map((c) => ({ name: c.name, source: c.source, kcal: c.kcal }));
  // Confiança honesta: match fraco (score baixo) é sempre "baixa", mesmo se a IA
  // escolheu; porção assumida nunca é "alta" (incerteza na quantidade).
  let confidence: "alta" | "media" | "baixa" = conf;
  if (food.score < 0.45) confidence = "baixa";
  else if (p.assumed && confidence === "alta") confidence = "media";
  return {
    name: p.t.food, grams: g,
    kcal: r1(food.kcal * f), protein: r1(food.protein * f),
    carb: r1(food.carb * f), fat: r1(food.fat * f),
    matched: food.name, matchedSource: food.source,
    barcode: food.barcode ?? undefined, score: r1(food.score),
    via, confidence, assumed: p.assumed, unresolved: false, alternatives: alts,
  };
}

/// Resolve todos os tokens (alias → busca → IA se ambíguo → conta) e soma o que casou.
/// Usada por: index.ts.
export async function resolveTokens(
  tokens: Token[],
  hints: Record<string, number>,
  aliases: Record<string, string>,
): Promise<{
  kcal: number; protein: number; carb: number; fat: number;
  breakdown: BreakdownItem[]; unresolved: string[];
}> {
  // Gramas + consulta (com alias) + candidatos, tudo em paralelo.
  const prep: Prep[] = await Promise.all(tokens.map(async (t) => {
    const { grams, assumed } = toGrams(t, hints);
    const alias = aliases[norm(t.food)];
    const cands = await searchCandidates(alias ?? t.food, 5);
    return { t, grams: r1(Math.max(0, grams)), assumed, aliasHit: !!alias, cands };
  }));

  // Decide o que dá p/ resolver sem IA e junta o resto p/ uma chamada de desambiguação.
  const decided = prep.map((p) => (p.cands.length ? decide(p) : { idx: -1, via: "busca" as const, conf: "media" as const }));
  const ambiguous: AmbiguousItem[] = [];
  prep.forEach((p, i) => {
    if (p.cands.length && decided[i] === null) ambiguous.push({ index: i, term: p.t.food, candidates: p.cands });
  });
  const picks = await disambiguate(ambiguous);

  const breakdown = prep.map((p, i) => {
    const d = decided[i];
    if (d) return buildItem(p, d.idx, d.via, d.conf);
    const pk = picks[i] ?? { candidate: 0, confidence: "media" };
    return buildItem(p, pk.candidate, "ia", pk.confidence as "alta" | "media" | "baixa");
  });

  const ok = breakdown.filter((b) => !b.unresolved);
  const sum = (k: "kcal" | "protein" | "carb" | "fat") => r1(ok.reduce((a, b) => a + b[k], 0));
  return {
    kcal: Math.round(sum("kcal")), protein: sum("protein"), carb: sum("carb"), fat: sum("fat"),
    breakdown, unresolved: breakdown.filter((b) => b.unresolved).map((b) => b.name),
  };
}
