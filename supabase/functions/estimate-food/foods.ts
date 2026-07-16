// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/foods.ts
// O QUÊ:     Acesso à base foods: busca os TOP-K candidatos de um nome de alimento
//            via RPC search_foods (word_similarity + boost de palavra-cabeça + rank
//            de fonte). Os candidatos alimentam a decisão do resolvedor (top-1 claro
//            ou desambiguação por IA) e viram as ALTERNATIVAS auditáveis.
// USA:       RPC search_foods (PostgREST) via fetch; consts/tipos de deps.ts.
// USADO POR: resolve.ts.
// SPEC:      specs/backend/database.yaml (search_foods) + edge_functions.yaml
// ─────────────────────────────────────────────────────────────────────────────
import { FoodRow, SUPABASE_KEY, SUPABASE_URL } from "./deps.ts";

/// Devolve os top-K candidatos da base para um nome (ordenados por relevância).
/// Usada por: resolve.ts.
export async function searchCandidates(name: string, k = 5): Promise<FoodRow[]> {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/rpc/search_foods`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      apikey: SUPABASE_KEY,
      Authorization: `Bearer ${SUPABASE_KEY}`,
    },
    body: JSON.stringify({ query: name, max_rows: k }),
  });
  if (!res.ok) throw new Error(`search_foods ${res.status}: ${await res.text()}`);
  const rows = await res.json();
  return Array.isArray(rows) ? rows as FoodRow[] : [];
}
