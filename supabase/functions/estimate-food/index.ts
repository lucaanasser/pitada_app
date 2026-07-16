// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/estimate-food/index.ts  (Edge Function — Deno/TypeScript)
// O QUÊ:     Estima kcal/macros de texto livre com NÚMEROS 100% de tabela. Fluxo:
//            (1) parser determinístico extrai qty/unidade/alimento; (2) resolvedor
//            determinístico calcula das tabelas; (3) só se um alimento não casa, a
//            IA canonicaliza o NOME (nunca o número); (4) só se o parser nem
//            tokeniza, a IA normaliza a linguagem inteira. Recebe { text }, devolve
//            { name, portion, kcal, protein, carb, fat, via, breakdown[], unresolved[] }.
// USA:       parser.ts, gemini.ts (normalize/canonicalizeFoods), hints.ts, resolve.ts.
// USADO POR: GeminiFoodEstimateService (lib/features/plans/application) via invoke.
// SPEC:      specs/backend/edge_functions.yaml (functions.estimate-food)
// ─────────────────────────────────────────────────────────────────────────────
import { CORS, GEMINI_API_KEY, json, Token } from "./deps.ts";
import { parseDeterministic } from "./parser.ts";
import { canonicalizeFoods, normalize } from "./gemini.ts";
import { loadPortionHints } from "./hints.ts";
import { loadAliases } from "./aliases.ts";
import { resolveTokens } from "./resolve.ts";

// Handler HTTP. Parser determinístico primeiro; IA só como resgate de linguagem.
Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });
  if (req.method !== "POST") return json({ error: "método inválido" }, 405);

  let text = "";
  try {
    const body = await req.json();
    text = (body?.text ?? "").toString().trim();
  } catch (_) {
    return json({ error: "corpo inválido" }, 400);
  }
  if (!text) return json({ error: "text vazio" }, 400);

  try {
    const [{ map, vocab }, aliases] = await Promise.all([loadPortionHints(), loadAliases()]);
    const hintKeys = new Set(Object.keys(map));

    // (1) Tier 0: parser determinístico extrai qty/unidade/alimento — sem IA.
    let tokens: Token[] | null = parseDeterministic(text, hintKeys);
    let via: "parser" | "ia" = "parser";
    let name = text, portion = text;

    // Fallback total: só se o parser nem consegue tokenizar. A IA normaliza a
    // linguagem em tokens (não produz número — gramas ainda saem de tabela).
    if (!tokens) {
      if (!GEMINI_API_KEY) return json({ error: "GEMINI_API_KEY ausente" }, 500);
      const norm = await normalize(text, vocab);
      tokens = norm.tokens;
      name = norm.name;
      portion = norm.portion;
      via = "ia";
    }

    // (2) Resolvedor híbrido: gramas de tabela; match por alias → busca → IA de
    // desambiguação quando ambíguo. Número nunca vem da IA.
    let totals = await resolveTokens(tokens, map, aliases);

    // (3) Resgate: alimento SEM candidato → IA canonicaliza SÓ o nome; recalcula.
    if (totals.unresolved.length > 0 && GEMINI_API_KEY) {
      const canon = await canonicalizeFoods(totals.unresolved);
      const retryTokens = tokens.map((t) => ({ ...t, food: canon[t.food] ?? t.food }));
      const retry = await resolveTokens(retryTokens, map, aliases);
      if (retry.unresolved.length < totals.unresolved.length) totals = retry;
    }

    return json({
      name, portion, via,
      kcal: totals.kcal, protein: totals.protein, carb: totals.carb, fat: totals.fat,
      breakdown: totals.breakdown, unresolved: totals.unresolved,
    });
  } catch (err) {
    return json({ error: "falha na estimativa", detail: `${err}` }, 502);
  }
});
