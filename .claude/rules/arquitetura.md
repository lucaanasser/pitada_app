# Regra: Arquitetura & tamanho de arquivo

## Organização feature-first (3 camadas por feature)

Cada feature (`recipes`, `learning`, `plans`, `shopping`) tem 3 camadas:

- **data/** — modelos (`freezed` + `json_serializable`) e o **repositório** que fala
  com o Supabase / Edge Functions. É a ÚNICA camada que conhece o Supabase.
- **application/** — controllers e providers Riverpod. Orquestra o repositório e
  expõe estado para a UI.
- **presentation/** — telas (`*_screen.dart`) e widgets específicos da feature
  (`presentation/widgets/`). Observa providers; nunca chama o repositório direto.

Regra de fluxo: `presentation → application (provider) → data (repository) → Supabase`.
A seta nunca volta. A UI **nunca** importa nada de `data/` a não ser modelos.

## Core (compartilhado entre features)

- `core/theme/` — o design system (cores, tipografia, espaçamento, tema). Ver
  `design-system.md`.
- `core/widgets/` — widgets reutilizáveis (Masthead, SectionHeader, ChapterTabs,
  HairlineRow, ExpiryTag, WhyCallout, PitadaButton, PitadaTag...).
- `core/router/` — `go_router` com shell das 4 abas + rotas de detalhe/edição.
- `core/config/` — env (`SUPABASE_URL`/`ANON_KEY` via `--dart-define`).
- `core/supabase/` — cliente e helpers.
- `core/utils/` — `AppLog`, formatação, conversão de unidades.

## Limite de 200 linhas de código por arquivo (rígido)

Se um arquivo passar de 200 linhas, **quebre-o**. Estratégias, em ordem:

1. **Extraia widgets.** Uma tela grande vira `xxx_screen.dart` + vários widgets em
   `presentation/widgets/`. Cada seção visual do protótipo tende a virar um widget.
2. **Extraia por responsabilidade.** Repositório grande → separe por entidade
   (`recipes_repository.dart`, `recipe_photos_repository.dart`).
3. **Extraia helpers puros** para `core/utils/`.
4. **Um modelo por arquivo** em `data/` (ex.: `recipe.dart`, `ingredient.dart`).

Contam como "linhas de código" as linhas não vazias e não comentário. Ainda assim,
mire em arquivos curtos no total — se o arquivo inteiro passa de ~200 linhas, quebre.

## Regras de dados (do guia — não negociáveis)

- **Grama é a base**; a unidade humana ("2 ovos") é referência. Macros calculam em grama.
- **Lista de compras soma por UNIDADE humana** (2 receitas com 2 ovos = "4 un"),
  depois subtrai a despensa.
- **Pasta** = agrupador de receitas independentes. **Sub-receita** = componentes que
  somam macros num prato só. São coisas distintas.

## Preview no PC

Todo acesso a hardware fica atrás de um service abstrato com implementação real
(Android) e **mock** (desktop/web), injetado via override do Riverpod. É o que
destrava rodar no Chrome/Linux com hot reload.
