// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/aliases.ts
// O QUÊ:     Lê a tabela food_aliases (termo coloquial → consulta canônica). Atalho
//            determinístico de ALTA confiança para os alimentos mais comuns
//            ("leite"→"leite integral"), antes da busca/IA.
// USA:       PostgREST (food_aliases) via fetch; consts de deps.ts.
// USADO POR: index.ts (passa o mapa para resolve.ts).
// SPEC:      specs/backend/database.yaml (food_aliases).
// ─────────────────────────────────────────────────────────────────────────────
import { SUPABASE_KEY, SUPABASE_URL } from "./deps.ts";

/// Busca os aliases e devolve o mapa termo→canônico ({} se falhar). Usada por: index.ts.
export async function loadAliases(): Promise<Record<string, string>> {
  try {
    const res = await fetch(
      `${SUPABASE_URL}/rest/v1/food_aliases?select=term,canonical`,
      { headers: { apikey: SUPABASE_KEY, Authorization: `Bearer ${SUPABASE_KEY}` } },
    );
    if (!res.ok) return {};
    const rows = await res.json() as Array<{ term: string; canonical: string }>;
    const map: Record<string, string> = {};
    for (const r of rows) map[r.term.toLowerCase()] = r.canonical;
    return map;
  } catch (_) {
    return {};
  }
}
