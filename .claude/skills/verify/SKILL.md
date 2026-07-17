---
name: verify
description: Roda o Pitada de verdade e captura a tela para conferir uma mudança visual. Use ao verificar qualquer alteração de UI (tela, widget, token) antes de commitar.
---

# Verificar o Pitada rodando

O Pitada é **web-only** hoje: não existe target macOS/Linux configurado
(`flutter run -d macos` falha com "No macOS desktop project configured").
O caminho que funciona é build web + servidor local + Playwright.

## Handle

```bash
flutter build web --release          # ~25s
(cd build/web && python3 -m http.server 8899 &)
curl -s -o /dev/null -w "%{http_code}" http://localhost:8899   # 200 = no ar
```

Ao terminar: `lsof -ti:8899 | xargs kill -9`

`./run.sh` sobe com hot reload no Chrome (bom para desenvolver), mas ele
abre janela e não serve para captura headless.

## Dirigir

Playwright não vem instalado. No scratchpad:

```bash
npm install playwright && npx playwright install chromium
```

**Flutter web desenha em canvas** — não existe DOM para consultar. Não adianta
`page.getByText(...)`: **clique por coordenada** e leia o screenshot. Viewport
420x900 dá o enquadramento de celular.

```js
const page = await browser.newPage({ viewport: { width: 420, height: 900 } });
await page.goto('http://localhost:8899', { waitUntil: 'networkidle' });
await page.waitForTimeout(6000);        // o canvas demora a pintar
await page.mouse.click(x, y);
await page.waitForTimeout(900);         // deixa a animação assentar
await page.screenshot({ path: 'out.png' });
```

Sempre ligue `page.on('pageerror')` — erro de Dart no runtime só aparece aí.

**Coordenada envelhece.** Mudou alinhamento/layout? Tire um screenshot novo e
releia as posições antes de clicar; clique em coordenada velha "passa" sem
fazer nada e parece que a feature quebrou.

## Onde olhar

- Aba Receitas (`/`): filtros, busca, pastas, lista.
- O seed dá 4 receitas previsíveis — Frango xadrez (25min, 512kcal, domino),
  Strogonoff (30min, 680kcal, domino), Bowl de quinoa (15min, 438kcal, nunca fiz),
  Panqueca (10min, 286kcal, nunca fiz). Serve de matriz de teste pronta.

## Tema

`themeModeProvider` está **fixo em `ThemeMode.dark`** (`core/theme/theme_providers.dart`),
então o claro não é alcançável pela UI hoje. Widget que só lê `context.pit.*` e
`AppType.on(...)` atende os dois temas por construção — não gaste tempo tentando
forçar o claro pelo navegador.
