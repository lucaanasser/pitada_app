// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/parser.ts
// O QUÊ:     Tokenizador DETERMINÍSTICO: extrai {qty, unit, food} de cada segmento
//            ("300g de arroz", "2 scoops de whey", "uma colher de granola",
//            "1 banana prata pequena") SEM IA. A extração de quantidade/unidade
//            (a parte que vira número) é sempre feita aqui — a IA só entra depois,
//            pra canonicalizar nome de alimento que não casa. Exporta MASS/VOLUME.
// USA:       tipos de deps.ts.
// USADO POR: index.ts (Tier 0); resolve.ts (mapas de unidade).
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food.estrategia)
// ─────────────────────────────────────────────────────────────────────────────
import { Token } from "./deps.ts";

// Unidades de massa/volume → fator para gramas (volume assume densidade ~1).
export const MASS: Record<string, number> = {
  g: 1, grama: 1, gramas: 1, gr: 1, kg: 1000, quilo: 1000, quilos: 1000,
};
export const VOLUME: Record<string, number> = {
  ml: 1, l: 1000, litro: 1000, litros: 1000,
};
const NUMBER_WORDS: Record<string, number> = {
  um: 1, uma: 1, dois: 2, duas: 2, tres: 3, "três": 3, meia: 0.5, meio: 0.5,
};

/// Singulariza uma palavra pt-BR de forma ingênua (scoops→scoop, colheres→colher).
/// Usada por: matchUnit para casar unidade no plural.
function singular(w: string): string {
  if (w.length > 4 && w.endsWith("es")) return w.slice(0, -2);
  if (w.length > 3 && w.endsWith("s")) return w.slice(0, -1);
  return w;
}

/// Converte "300", "1,5" ou "um" em número (ou null). Usada por: parseSegment.
function parseQty(raw: string): number | null {
  if (raw in NUMBER_WORDS) return NUMBER_WORDS[raw];
  const n = Number(raw.replace(",", "."));
  return Number.isFinite(n) ? n : null;
}

/// Quebra o texto nos separadores de itens (+ , e com). Usada por: parseDeterministic.
function segments(text: string): string[] {
  return text.toLowerCase().split(/\s*\+\s*|\s*,\s*|\s+e\s+|\s+com\s+/)
    .map((s) => s.trim()).filter(Boolean);
}

/// Acha a unidade no início de `words` (massa/volume ou termo de portion_hints, com
/// singularização e prefixo multi-palavra). Devolve [unit|null, nº de palavras consumidas].
/// Não casa se consumir TODAS as palavras (não sobraria alimento) — aí o resolvedor
/// trata a frase como "alimento-porção" (ex.: "banana prata pequena"). Usada por: parseSegment.
function matchUnit(words: string[], hints: Set<string>): [string | null, number] {
  const w0 = singular(words[0] ?? "");
  if ((w0 in MASS || w0 in VOLUME) && words.length > 1) return [w0, 1];
  // termo de portion_hints: prefixo mais longo (até 4 palavras), singularizando cada uma.
  for (let n = Math.min(4, words.length); n >= 1; n--) {
    if (n === words.length) continue;   // deixaria o alimento vazio → não é unidade
    const cand = words.slice(0, n).map(singular).join(" ");
    if (hints.has(cand)) return [cand, n];
  }
  return [null, 0];
}

/// Interpreta UM segmento em {qty, unit, food}. Sempre retorna algo (o food pode
/// não casar na base depois). Usada por: parseDeterministic.
function parseSegment(seg: string, hints: Set<string>): Token | null {
  // Separa número grudado na unidade ("300g"→"300 g", "200ml"→"200 ml").
  let words = seg.replace(/(\d)\s*([a-zç]+)/g, "$1 $2").split(/\s+/).filter(Boolean);
  if (words.length === 0) return null;
  let qty: number | null = null;
  const q = parseQty(words[0]);
  if (q != null) { qty = q; words = words.slice(1); }
  let [unit, used] = matchUnit(words, hints);
  let rest = words.slice(used);
  if (rest[0] === "de") rest = rest.slice(1);   // "300g de arroz" → tira o "de"
  const food = rest.join(" ").trim();
  if (!food) return null;   // segmento sem alimento (ex.: só "colher") → deixa pra IA
  return { qty, unit, food };
}

/// Tokeniza o texto inteiro deterministicamente. null só se algum segmento não tiver
/// alimento reconhecível. Usada por: index.ts (Tier 0). `hints` = chaves de portion_hints.
export function parseDeterministic(text: string, hints: Set<string>): Token[] | null {
  const segs = segments(text);
  if (segs.length === 0) return null;
  const tokens: Token[] = [];
  for (const seg of segs) {
    const t = parseSegment(seg, hints);
    if (!t) return null;
    tokens.push(t);
  }
  return tokens;
}
