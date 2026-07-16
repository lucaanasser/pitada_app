// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/hints.ts
// O QUÊ:     Lê a tabela portion_hints (medida caseira → gramas). Devolve o MAPA
//            termo→gramas (usado pelo resolvedor p/ converter unidade em gramas) e
//            o VOCABULÁRIO de termos (injetado no prompt da IA p/ ela só usar
//            unidades que existem na tabela).
// USA:       PostgREST (tabela portion_hints) via fetch; consts de deps.ts.
// USADO POR: index.ts (passa mapa p/ resolve e vocab p/ normalize).
// SPEC:      specs/backend/database.yaml (portion_hints) + edge_functions.yaml
// ─────────────────────────────────────────────────────────────────────────────
import { SUPABASE_KEY, SUPABASE_URL } from "./deps.ts";

/// Busca as medidas caseiras. Devolve {map: termo→gramas, vocab: "t1, t2, ..."}.
/// map/vocab vazios se falhar (o resolvedor ainda trata massa/volume). Usada por: index.ts.
export async function loadPortionHints(): Promise<{
  map: Record<string, number>;
  vocab: string;
}> {
  try {
    const res = await fetch(
      `${SUPABASE_URL}/rest/v1/portion_hints?select=term,grams&order=term`,
      { headers: { apikey: SUPABASE_KEY, Authorization: `Bearer ${SUPABASE_KEY}` } },
    );
    if (!res.ok) return { map: {}, vocab: "" };
    const rows = await res.json() as Array<{ term: string; grams: number }>;
    const map: Record<string, number> = {};
    for (const r of rows) map[r.term.toLowerCase()] = Number(r.grams);
    return { map, vocab: rows.map((r) => r.term).join(", ") };
  } catch (_) {
    return { map: {}, vocab: "" };
  }
}
