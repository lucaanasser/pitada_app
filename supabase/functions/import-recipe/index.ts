// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/import-recipe/index.ts  (Edge Function — Deno/TypeScript)
// O QUÊ:     Extrai uma receita estruturada de um site/Instagram/PDF via Gemini:
//            componentes (massa/cobertura), técnica por passo, sabor por
//            ingrediente. Recebe { source, url?, content? }.
// USA:       source.ts (coleta do conteúdo), schema.ts (prompt + responseSchema),
//            Gemini REST (generateContent).
// USADO POR: GeminiRecipeImportService (lib/features/recipes/application) via functions.invoke.
// SPEC:      specs/backend/edge_functions.yaml (functions.import-recipe)
// ─────────────────────────────────────────────────────────────────────────────
import { PROMPT, RESPONSE_SCHEMA } from "./schema.ts";
import { buildParts, type Part } from "./source.ts";

const GEMINI_MODEL = Deno.env.get("GEMINI_MODEL") ?? "gemini-flash-lite-latest";
const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY") ?? "";

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

/// Resposta JSON com headers de CORS. Usada por: handler.
function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS, "Content-Type": "application/json" },
  });
}

/// Converte nossas Parts no formato de `parts` do Gemini. Usada por: extract.
function toGeminiParts(parts: Part[]): unknown[] {
  return parts.map((p) =>
    p.kind === "text"
      ? { text: p.text }
      : { inlineData: { mimeType: p.mimeType, data: p.dataBase64 } }
  );
}

/// Chama o Gemini com o prompt + conteúdo e devolve o objeto extraído.
/// Lança em falha de rede/formato. Usada por: handler.
async function extract(parts: Part[]): Promise<Record<string, unknown>> {
  const url =
    `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`;
  const res = await fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "x-goog-api-key": GEMINI_API_KEY,
    },
    body: JSON.stringify({
      contents: [{ parts: [{ text: PROMPT }, ...toGeminiParts(parts)] }],
      generationConfig: {
        responseMimeType: "application/json",
        responseSchema: RESPONSE_SCHEMA,
        temperature: 0.2,
      },
    }),
  });
  if (!res.ok) throw new Error(`gemini ${res.status}: ${await res.text()}`);
  const data = await res.json();
  const raw = data?.candidates?.[0]?.content?.parts?.[0]?.text;
  if (typeof raw !== "string") throw new Error("gemini sem conteúdo");
  return JSON.parse(raw);
}

// Handler HTTP: valida entrada, coleta a fonte, chama o Gemini e mapeia erros.
Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });
  if (req.method !== "POST") return json({ error: "método inválido" }, 405);

  let source = "", url: string | undefined, content: string | undefined;
  try {
    const body = await req.json();
    source = (body?.source ?? "").toString();
    url = body?.url?.toString();
    content = body?.content?.toString();
  } catch (_) {
    return json({ error: "corpo inválido" }, 400);
  }

  let parts: Part[];
  try {
    parts = await buildParts(source, url, content);
  } catch (err) {
    return json({ error: "fonte inválida", detail: `${err}` }, 400);
  }

  if (!GEMINI_API_KEY) return json({ error: "GEMINI_API_KEY ausente" }, 500);

  try {
    const out = await extract(parts);
    // title vazio = o conteúdo não era uma receita (regra do prompt).
    if (!(out.title as string)?.trim()) {
      return json({ error: "nenhuma receita encontrada no conteúdo" }, 422);
    }
    return json({ ...out, source, source_url: url ?? null });
  } catch (err) {
    return json({ error: "falha na importação", detail: `${err}` }, 502);
  }
});
