// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/disambiguate.ts
// O QUÊ:     IA de DESAMBIGUAÇÃO (usada só quando a busca é ambígua): dado o termo
//            do usuário e os candidatos da base, a IA escolhe o que melhor casa e dá
//            uma CONFIANÇA. Aumenta a precisão do match (ex.: "leite"→leite integral,
//            não "leite em pó") — mas NÃO produz número: só índice + confiança.
// USA:       callGemini (gemini.ts); tipos de deps.ts.
// USADO POR: resolve.ts (quando não há vencedor lexical claro).
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food.estrategia)
// ─────────────────────────────────────────────────────────────────────────────
import { FoodRow } from "./deps.ts";
import { callGemini } from "./gemini.ts";

// Uma pergunta de desambiguação: o termo + seus candidatos numerados.
export interface AmbiguousItem {
  index: number;      // índice do ingrediente no pedido original
  term: string;       // o que o usuário quis dizer
  candidates: FoodRow[];
}

const SCHEMA = {
  type: "object",
  properties: {
    picks: {
      type: "array",
      items: {
        type: "object",
        properties: {
          index: { type: "integer" },           // ecoa o índice do ingrediente
          candidate: { type: "integer" },        // índice do candidato escolhido (-1 = nenhum)
          confidence: { type: "string", enum: ["alta", "media", "baixa"] },
        },
        required: ["index", "candidate", "confidence"],
      },
    },
  },
  required: ["picks"],
};

/// Monta o prompt listando cada termo e seus candidatos. Usada por: disambiguate.
function buildPrompt(items: AmbiguousItem[]): string {
  const blocks = items.map((it) => {
    const list = it.candidates
      .map((c, j) => `    [${j}] ${c.name} — ${c.kcal} kcal/100g (${c.source})`)
      .join("\n");
    return `Ingrediente ${it.index}: "${it.term}"\n${list}`;
  }).join("\n");
  return [
    "Escolha, para cada ingrediente, o candidato que MELHOR representa o que a pessoa",
    "quis dizer no dia a dia (ex.: 'leite' = leite integral fluido, NÃO leite em pó;",
    "'arroz' = arroz cozido, NÃO arroz-doce). Considere nome E plausibilidade das kcal.",
    "Dê confidence alta/media/baixa. Se nenhum servir, candidate=-1. Não invente números.",
    "\n" + blocks,
  ].join(" ");
}

/// Devolve, por índice de ingrediente, {candidate, confidence}. Em falha, top-1 média.
/// Usada por: resolve.ts.
export async function disambiguate(
  items: AmbiguousItem[],
): Promise<Record<number, { candidate: number; confidence: string }>> {
  const fallback: Record<number, { candidate: number; confidence: string }> = {};
  for (const it of items) fallback[it.index] = { candidate: 0, confidence: "media" };
  if (items.length === 0) return {};
  try {
    const out = await callGemini(buildPrompt(items), SCHEMA);
    const picks = Array.isArray(out.picks) ? out.picks : [];
    const result = { ...fallback };
    for (const p of picks as Array<Record<string, unknown>>) {
      const i = p.index as number;
      const it = items.find((x) => x.index === i);
      if (!it) continue;
      const c = p.candidate as number;
      const valid = Number.isInteger(c) && c >= -1 && c < it.candidates.length;
      result[i] = {
        candidate: valid ? c : 0,
        confidence: typeof p.confidence === "string" ? p.confidence : "media",
      };
    }
    return result;
  } catch (_) {
    return fallback;   // sem IA, usa o top-1 (confiança média)
  }
}
