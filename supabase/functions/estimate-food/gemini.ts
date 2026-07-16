// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/gemini.ts
// O QUÊ:     A IA como TRADUTORA (nunca calculadora): normaliza texto livre em
//            tokens {qty, unit, food} buscáveis na base. NÃO emite kcal/macros/gramas
//            — só a quantidade que o usuário disse e a unidade dentro do vocabulário.
//            Fallback: só roda quando o parser determinístico (Tier 0) não resolve.
// USA:       Gemini REST (generateContent) via fetch; consts de deps.ts.
// USADO POR: index.ts (normalize).
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food.estrategia)
// ─────────────────────────────────────────────────────────────────────────────
import { GEMINI_API_KEY, GEMINI_MODEL, Token } from "./deps.ts";

/// Chamada genérica ao Gemini com saída JSON forçada (responseSchema).
/// Usada por: normalize, canonicalizeFoods (gemini.ts) e disambiguate.ts.
export async function callGemini(prompt: string, schema: unknown): Promise<Record<string, unknown>> {
  const url =
    `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`;
  const res = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json", "x-goog-api-key": GEMINI_API_KEY },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: "application/json", responseSchema: schema, temperature: 0.1,
      },
    }),
  });
  if (!res.ok) throw new Error(`gemini ${res.status}: ${await res.text()}`);
  const raw = (await res.json())?.candidates?.[0]?.content?.parts?.[0]?.text;
  if (typeof raw !== "string") throw new Error("gemini sem conteúdo");
  return JSON.parse(raw);
}

// Saída forçada: SÓ tokens. Sem campos de kcal/macros — a IA não produz número.
const NORMALIZE_SCHEMA = {
  type: "object",
  properties: {
    name: { type: "string" },
    portion: { type: "string" },
    items: {
      type: "array",
      items: {
        type: "object",
        properties: {
          qty: { type: "number", nullable: true },
          unit: { type: "string", nullable: true },
          food: { type: "string" },
        },
        required: ["food"],
      },
    },
  },
  required: ["name", "portion", "items"],
};

/// Monta o prompt de normalização, com o vocabulário de unidades permitido. Usada por: normalize.
function buildPrompt(text: string, unitVocab: string): string {
  return [
    "Você TRADUZ linguagem, não calcula. NÃO devolva calorias, macros nem gramas.",
    "Converta a comida/bebida descrita em itens estruturados para busca numa tabela",
    "nutricional brasileira. Para cada item devolva EXATAMENTE:",
    "• food = nome canônico do alimento (ex.: 'leite integral', 'achocolatado em pó',",
    "  'arroz cozido', 'peito de frango grelhado', 'whey protein', 'banana prata');",
    "• qty = o NÚMERO que o usuário disse (extraia sempre; 'um/uma'=1, 'dois'=2,",
    "  'meia'=0.5). null só se ele não disse quantidade;",
    `• unit = a unidade, SOMENTE deste vocabulário: ${unitVocab}, g, kg, ml, l — ou null.`,
    "SEMPRE mapeie a medida para o vocabulário. Exemplos OBRIGATÓRIOS:",
    "'2 scoops de whey' → {qty:2, unit:'scoop', food:'whey protein'};",
    "'uma colher de granola' → {qty:1, unit:'colher de sopa', food:'granola'};",
    "'1 banana prata pequena' → {qty:1, unit:'banana prata pequena', food:'banana prata'};",
    "'um copo de leite com toddy' → [{qty:1, unit:'copo', food:'leite integral'},",
    "  {qty:null, unit:null, food:'achocolatado em pó'}].",
    "Decomponha pratos compostos nos ingredientes básicos. name = nome curto do prato;",
    "portion = porção reconhecida no texto.",
    `Descrição do usuário: "${text}"`,
  ].join(" ");
}

const CANON_SCHEMA = {
  type: "object",
  properties: {
    mapping: {
      type: "array",
      items: {
        type: "object",
        properties: { from: { type: "string" }, to: { type: "string" } },
        required: ["from", "to"],
      },
    },
  },
  required: ["mapping"],
};

/// A IA como TRADUTORA de NOME: mapeia alimentos que não casaram na base p/ o nome
/// canônico brasileiro (ex.: "miojo"→"macarrão instantâneo", "toddy"→"achocolatado em
/// pó"). NÃO mexe em quantidade/gramas — só linguagem. Usada por: index.ts (rescue).
export async function canonicalizeFoods(names: string[]): Promise<Record<string, string>> {
  if (names.length === 0) return {};
  const prompt = [
    "Para cada alimento abaixo, dê o nome canônico como aparece numa tabela",
    "nutricional brasileira (TACO/IBGE), p/ facilitar a busca. NÃO invente números,",
    "só traduza o nome. Ex.: 'miojo'→'macarrão instantâneo', 'refri'→'refrigerante'.",
    `Alimentos: ${names.map((n) => `"${n}"`).join(", ")}`,
  ].join(" ");
  const out = await callGemini(prompt, CANON_SCHEMA);
  const map: Record<string, string> = {};
  for (const m of (out.mapping as Array<Record<string, string>> ?? [])) {
    if (m.from && m.to) map[m.from] = m.to;
  }
  return map;
}

/// Normaliza o texto em tokens (fallback quando o Tier 0 não resolve). Usada por: index.ts.
export async function normalize(
  text: string,
  unitVocab: string,
): Promise<{ name: string; portion: string; tokens: Token[] }> {
  const parsed = await callGemini(buildPrompt(text, unitVocab), NORMALIZE_SCHEMA);
  const items = Array.isArray(parsed.items) ? parsed.items : [];
  const tokens: Token[] = (items as Array<Record<string, unknown>>).map((i) => ({
    qty: typeof i.qty === "number" ? i.qty : null,
    unit: typeof i.unit === "string" && i.unit ? i.unit : null,
    food: String(i.food ?? "").trim(),
  })).filter((t) => t.food);
  return {
    name: String(parsed.name ?? text),
    portion: String(parsed.portion ?? text),
    tokens,
  };
}
