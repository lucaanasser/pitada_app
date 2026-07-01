# Pitada

App pessoal de receitas, aprendizado de cozinha, planos alimentares e despensa.
**Flutter + Riverpod + go_router**, backend Supabase (opcional no preview) e IA via
Gemini (Edge Functions). Alvo visual: `pitada.html`. Conteúdo em pt-BR.

## Rodar no PC (preview, sem backend)

```bash
flutter pub get
flutter run -d chrome   # ou: flutter run -d linux
```

Sem chaves do Supabase, o app usa **dados de exemplo em memória** (as receitas do
protótipo). Para conectar o backend depois:

```bash
flutter run -d chrome \
  --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJ...
```

Fontes (Cormorant + Inter): ver `assets/fonts/README.md` (o app roda sem elas,
caindo na fonte do sistema).

## Como o código é organizado

Arquitetura **feature-first** com 3 camadas por feature (`data` → `application`
→ `presentation`) e um `core` compartilhado. Regras completas em `.claude/rules/`.

```
specs/            # SPEC .yaml de tudo (design system, componentes, telas) — vem antes do código
lib/core/         # design system (theme), widgets reutilizáveis, router, utils, config
lib/features/     # recipes, learning (Caderno), home (comunidade+perfil), plans, shopping
```

### Regras de ouro (ver `.claude/CLAUDE.md`)
1. **Spec antes de código** — nada é implementado sem `.yaml` em `specs/`.
2. **Máx. 200 linhas por arquivo** — quebre em widgets/helpers.
3. **Reutilize o visual** — cor/fonte/espaço/botão/tag vêm sempre dos tokens
   (`lib/core/theme/`) e widgets (`lib/core/widgets/`). Zero valor "chumbado".
4. **Comentários padronizados** — cabeçalho (o quê/usa/usado por) em todo arquivo;
   doc em toda função. Logs só via `AppLog`.

## Estado da implementação (frontend)

Frontend completo — **30 telas/sheets**, todas navegáveis com dados de exemplo:

- ✅ Design system (cores, tipografia, espaçamento, tema) + 18 widgets reutilizáveis
- ✅ Shell das 5 abas (Receitas · Caderno · Home · Planos · Compras) + navegação
- ✅ **Receitas**: lista + pastas, detalhe, editar, cozinhar, importar (sheet), chat pós-preparo
- ✅ **Planos**: resumo do dia, refeições, opções, sheets de refeição/receita
- ✅ **Compras**: lista (somada por unidade) + despensa (validade), sheet adicionar
- ✅ **Caderno**: hub, fichas, lições, notas, diário, versões, logs, repertório, editor
- ✅ **Home/Perfil**: feed, perfil com gráfico de atividade, sheet compartilhar

Backend (Supabase + Edge Functions/Gemini) ainda não — os repositórios são em memória
(seed). Cada feature segue o molde de `features/recipes/`.
