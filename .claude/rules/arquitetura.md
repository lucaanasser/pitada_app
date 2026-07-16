# Regra: Arquitetura & tamanho de arquivo

## Feature-first — 3 camadas por feature
- **data/** — modelos (`freezed`/`json_serializable`) + repositório. **Única** camada
  que fala com Supabase / Edge Functions.
- **application/** — providers/controllers Riverpod; orquestra o repositório.
- **presentation/** — telas + widgets da feature; observa providers, nunca chama o repo.

Fluxo (a seta nunca volta): `presentation → application → data → Supabase`.
A UI só importa modelos de `data/`. (Nomes e regra dos 7: `nomenclatura-e-pastas.md`.)

## Core (compartilhado)
`theme/` (design system) · `widgets/` (reuso — ver `design-system.md`) · `router/`
(go_router: shell das abas + rotas) · `config/` (env via `--dart-define`) · `supabase/`
(cliente) · `utils/` (`AppLog`, formatação, unidades).

## ≤ 200 linhas por arquivo (rígido)
Passou? Quebre, nesta ordem:
1. Extraia widgets (cada seção do protótipo vira um widget em `presentation/widgets/`).
2. Separe por responsabilidade (repo grande → por entidade).
3. Extraia helpers puros p/ `core/utils/`.
4. Um modelo por arquivo em `data/`.

## Dados (inegociáveis)
- **Grama é a base**; a unidade humana ("2 ovos") é referência. Macros calculam em grama.
- **Lista de compras soma por unidade humana** (2 receitas × 2 ovos = "4 un"), depois
  subtrai a despensa.
- **Pasta** agrupa receitas independentes. **Sub-receita** = componentes que somam macros
  num prato só. Coisas distintas.

## Preview no PC
Hardware (scanner/câmera/share) atrás de service abstrato: real + **mock** (desktop/web),
injetado por override do Riverpod. Destrava rodar no Chrome/Linux com hot reload.