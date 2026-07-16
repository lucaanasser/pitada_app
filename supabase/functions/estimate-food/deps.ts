// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/deps.ts
// O QUÊ:     Config, CORS, tipos e helper de resposta JSON compartilhados pela
//            Edge Function estimate-food (índice + gemini + foods).
// USA:       env (GEMINI_*, SUPABASE_*) do runtime Deno da Edge Function.
// USADO POR: index.ts, gemini.ts, foods.ts.
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food)
// ─────────────────────────────────────────────────────────────────────────────

// Modelo padrão: alias do Flash-Lite atual — rápido (~1s), barato e o que chaves
// novas do free tier conseguem usar. GEMINI_MODEL sobrescreve.
export const GEMINI_MODEL = Deno.env.get("GEMINI_MODEL") ?? "gemini-flash-lite-latest";
export const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY") ?? "";

// URL/chave do próprio Supabase — injetadas no runtime da Edge Function. Usadas
// para chamar a RPC search_foods (busca na TACO). Service role ignora RLS (leitura
// de dado de referência), mas search_foods também é liberada a authenticated/anon.
export const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ?? "";
export const SUPABASE_KEY =
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? Deno.env.get("SUPABASE_ANON_KEY") ?? "";

// CORS: functions.invoke do app faz um preflight OPTIONS; liberamos o essencial.
export const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

// Token estruturado: a saída do parser (Tier 0) OU da IA normalizadora. NÃO carrega
// número nenhum além de `qty` (a quantidade que o usuário disse). Gramas e macros
// são resolvidos depois, só a partir de tabela.
export interface Token {
  qty: number | null;    // quantidade explícita do usuário (null = não disse)
  unit: string | null;   // massa/volume ("g","ml"...) ou termo de portion_hints
  food: string;          // nome do alimento p/ buscar em foods
}

// Linha devolvida por search_foods (valores por 100 g + fonte + score da busca).
export interface FoodRow {
  name: string;
  source: string;    // taco | ibge | off | usda
  barcode: string | null;
  kcal: number;
  protein: number;
  carb: number;
  fat: number;
  score: number;
}

// Alternativa auditável: outra linha que o usuário pode escolher no lugar.
export interface Alternative {
  name: string;
  source: string;
  kcal: number;   // por 100 g
}

// Uma linha do breakdown final: macros JÁ multiplicados pelas gramas do ingrediente.
// TODO número aqui saiu de tabela — a IA nunca preenche kcal/macros/grams. Carrega
// confiança + alternativas para a estimativa ser AUDITÁVEL (usuário confere/troca).
export interface BreakdownItem {
  name: string;
  grams: number;
  kcal: number;
  protein: number;
  carb: number;
  fat: number;
  matched?: string;        // nome da linha casada em foods
  matchedSource?: string;  // fonte da linha: taco | ibge | off | usda
  barcode?: string;        // código de barras (quando veio da OFF)
  score?: number;          // similaridade da busca
  via?: "alias" | "busca" | "ia";  // como o match foi decidido (auditoria)
  confidence: "alta" | "media" | "baixa";
  assumed: boolean;        // porção assumida (qty/unit ausentes) — conferir
  unresolved: boolean;     // sem match na base — NÃO entra no total
  alternatives: Alternative[];     // outras opções (UI permite trocar)
}

/// Resposta JSON padronizada com os headers de CORS. Usada por: index handler.
export function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS, "Content-Type": "application/json" },
  });
}
