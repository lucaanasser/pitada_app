// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/import-recipe/schema.ts
// O QUÊ:     Prompt + responseSchema do Gemini para a importação: componentes
//            (massa/cobertura), técnica por passo (com anchor) e eixo de sabor
//            por ingrediente. A IA só transcreve — nunca julga o prato.
// USA:       nada (constantes puras).
// USADO POR: index.ts (generationConfig + prompt).
// SPEC:      specs/backend/edge_functions.yaml (functions.import-recipe)
// ─────────────────────────────────────────────────────────────────────────────

const INGREDIENT = {
  type: "object",
  properties: {
    name: { type: "string" },
    grams: { type: "number" },
    human_qty: { type: "number" },
    human_unit: { type: "string" },
    flavors: {
      type: "array",
      items: {
        type: "string",
        enum: ["acid", "umami", "fat", "sweet", "bitter", "salt", "fresh"],
      },
    },
  },
  required: ["name"],
};

const STEP_TECHNIQUE = {
  type: "object",
  properties: {
    name: { type: "string" }, // a técnica ('selar'); o app canoniza pelo slug
    anchor: { type: "string" }, // trecho LITERAL e contíguo de text a grifar
  },
  required: ["name", "anchor"],
};

const STEP = {
  type: "object",
  properties: {
    text: { type: "string" },
    tip: { type: "string" },
    techniques: { type: "array", items: STEP_TECHNIQUE },
  },
  required: ["text"],
};

const COMPONENT = {
  type: "object",
  properties: {
    name: { type: "string" }, // ausente = receita simples (sem partes nomeadas)
    ingredients: { type: "array", items: INGREDIENT },
    steps: { type: "array", items: STEP },
  },
  required: ["ingredients", "steps"],
};

export const RESPONSE_SCHEMA = {
  type: "object",
  properties: {
    title: { type: "string" },
    servings: { type: "integer" },
    time_minutes: { type: "integer" },
    components: { type: "array", items: COMPONENT },
    kcal: { type: "number" },
    protein: { type: "number" },
    carb: { type: "number" },
    fat: { type: "number" },
  },
  required: ["title", "components"],
};

export const PROMPT = [
  "Você recebe o conteúdo de uma receita (texto de site/Instagram ou um PDF).",
  "Extraia a receita de forma estruturada, em português do Brasil.",
  "COMPONENTES: se a receita tiver partes com nome próprio (massa, cobertura,",
  "molho, recheio), devolva um componente por parte, com o nome que a receita",
  "usa e SÓ os ingredientes e passos daquela parte. Receita sem partes = UM",
  "componente sem name.",
  "TÉCNICAS: para cada passo, marque as técnicas que ele executa. name = a",
  "técnica ('selar', 'emulsionar'); anchor = o trecho LITERAL e contíguo de",
  "text que a nomeia. Não invente técnica que o passo não faz; passo sem",
  "técnica = lista vazia.",
  "SABOR: marque os eixos que o ingrediente TRAZ ao prato — isto é transcrição,",
  "não julgamento: limão=acid, shoyu=umami+salt, manteiga=fat, salsinha=fresh.",
  "Na dúvida, lista vazia.",
  "Regras: grams = quantidade em gramas (base p/ macros); human_qty/human_unit =",
  "a medida humana original (ex.: 2 / 'unidade', 3 / 'c. sopa'). kcal/protein/",
  "carb/fat são POR PORÇÃO, estimados quando não vierem explícitos. time_minutes",
  "em minutos. Se o conteúdo NÃO for uma receita, devolva title vazio.",
].join(" ");
