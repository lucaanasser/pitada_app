// ─────────────────────────────────────────────────────────────────────────────
// supabase/functions/import-recipe/source.ts  (helpers — Deno/TypeScript)
// O QUÊ:     Coleta o conteúdo bruto de uma fonte (site/instagram/pdf) e devolve
//            o que será enviado ao Gemini: texto legível de páginas ou o PDF em base64.
// USA:       fetch (HTTP) para páginas; nada externo.
// USADO POR: index.ts (import-recipe) antes de montar o prompt do Gemini.
// SPEC:      specs/backend/edge_functions.yaml (import-recipe.coleta_no_servidor)
// ─────────────────────────────────────────────────────────────────────────────

// User-Agent de navegador — muitos sites/CDNs bloqueiam clientes sem UA.
const UA =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122 Safari/537.36";

/// Parte enviada ao Gemini: ou um bloco de texto, ou um arquivo inline (PDF).
/// Usada por: index.ts para montar `contents.parts`.
export type Part =
  | { kind: "text"; text: string }
  | { kind: "file"; mimeType: string; dataBase64: string };

/// Extrai os blocos JSON-LD (schema.org/Recipe) — a fonte estruturada mais
/// confiável quando a página tem. Usada por: fetchPageText (vai antes do texto).
function jsonLdRecipes(html: string): string {
  const out: string[] = [];
  const re =
    /<script[^>]+type=["']application\/ld\+json["'][^>]*>([\s\S]*?)<\/script>/gi;
  for (const m of html.matchAll(re)) {
    const block = m[1].trim();
    if (/"Recipe"/.test(block)) out.push(block);
  }
  return out.join("\n").slice(0, 8000);
}

/// Remove scripts/estilos e tags, colapsa espaços — texto legível de um HTML.
/// Usada por: fetchPageText.
function htmlToText(html: string): string {
  return html
    .replace(/<script[\s\S]*?<\/script>/gi, " ")
    .replace(/<style[\s\S]*?<\/style>/gi, " ")
    .replace(/<[^>]+>/g, " ")
    .replace(/&nbsp;/g, " ")
    .replace(/&amp;/g, "&")
    .replace(/&#39;|&apos;/g, "'")
    .replace(/&quot;/g, '"')
    .replace(/\s+/g, " ")
    .trim();
}

/// Extrai o conteúdo de uma meta tag (og:description etc.) do HTML cru.
/// Usada por: fetchInstagramText (legenda costuma vir em og:description).
function metaContent(html: string, property: string): string | null {
  const re = new RegExp(
    `<meta[^>]+(?:property|name)=["']${property}["'][^>]*content=["']([^"']+)["']`,
    "i",
  );
  const m = html.match(re);
  return m ? m[1] : null;
}

/// Baixa uma página e devolve o JSON-LD Recipe (se houver) + texto legível,
/// limitado p/ não estourar tokens. Usada por: buildParts (source = site/youtube).
async function fetchPageText(url: string, limit = 12000): Promise<string> {
  const res = await fetch(url, { headers: { "User-Agent": UA } });
  if (!res.ok) throw new Error(`fetch ${res.status} em ${url}`);
  const html = await res.text();
  const ld = jsonLdRecipes(html);
  const text = htmlToText(html).slice(0, limit);
  return ld ? `DADOS ESTRUTURADOS (schema.org/Recipe):\n${ld}\n\nTEXTO:\n${text}` : text;
}

/// Instagram: tenta a legenda em og:description; cai no texto legível da página.
/// Best-effort — login-wall pode devolver pouca coisa. Usada por: buildParts.
async function fetchInstagramText(url: string): Promise<string> {
  const res = await fetch(url, { headers: { "User-Agent": UA } });
  if (!res.ok) throw new Error(`fetch ${res.status} em ${url}`);
  const html = await res.text();
  const caption = metaContent(html, "og:description") ??
    metaContent(html, "description");
  const body = htmlToText(html).slice(0, 4000);
  return [caption, body].filter(Boolean).join("\n\n");
}

/// Monta as partes de conteúdo p/ o Gemini a partir de source/url/content.
/// Lança se faltar dado obrigatório. Usada por: index.ts (handler).
export async function buildParts(
  source: string,
  url: string | undefined,
  content: string | undefined,
): Promise<Part[]> {
  if (source === "pdf") {
    if (!content) throw new Error("pdf sem content (base64)");
    return [{ kind: "file", mimeType: "application/pdf", dataBase64: content }];
  }
  if (!url) throw new Error(`source ${source} exige url`);
  const text = source === "instagram"
    ? await fetchInstagramText(url)
    : await fetchPageText(url);
  if (text.length < 40) throw new Error("conteúdo insuficiente na fonte");
  return [{ kind: "text", text }];
}
