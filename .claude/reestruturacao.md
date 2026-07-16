# Plano de reestruturação — nomenclatura & pastas

Migração única para o padrão de `rules/architecture.md`. Guia vivo: marque
`[x]` conforme avança. Decisões travadas: **nomes em inglês uniforme**, **regra dos 7**,
**specs espelham o código**.

## Princípio que guia tudo

- A **pasta** nomeia a feature uma vez; arquivos usam **papel + entidade** (sufixo fixo).
- **Máx. 7 soltos** por pasta → quebra por PAPEL, depois por SUB-DOMÍNIO.
- Ao **mover** um arquivo, o **cabeçalho** muda junto (caminho, `USA`, `USADO POR`,
  `SPEC`) — e o cabeçalho de quem o importa. Comentário nunca fica desatualizado.
- A **spec espelho** move no mesmo caminho relativo (`lib/` ↔ `specs/`).

## Fase 0 — Regras (FEITO)

- [x] `rules/architecture.md` (a regra — nomenclatura + pastas + camadas)
- [x] `CLAUDE.md` (regra de ouro 5 + árvore-alvo + lista de regras)
- [x] Memória `estrutura-nomenclatura.md`
- [x] `specs/README.yaml` (convenção de nomes + espelho)

## Fase 1 — Renomes legados (semântico, maior valor)

Feature = **plural** (pasta/tela-raiz/tipos de feature); entidade = **singular**. Já
de-prefixamos os arquivos de papel (não repetem a pasta); a subpasta é a Fase 3.
Route strings (`/learning/*`, `/shopping`) e `AppIcons.learning` ficam por ora.

> **Lição (jul/2026).** Esta fase foi dada como pronta com os arquivos renomeados mas o
> **conteúdo intocado**: os imports ainda apontavam para `shopping_item.dart` /
> `learning_providers.dart` e os tipos seguiam `Shopping*` / `Learning*`. O `master` ficou
> **243 erros de análise** — não compilava. A caixa "`flutter analyze` limpo" abaixo estava
> marcada sem o comando ter passado. Consertado em `d088440`.
> **`git mv` é metade do renome**; a outra metade é o conteúdo. Só marque a caixa depois de
> `flutter analyze` rodar de verdade — e a regra de versionamento ("nunca comite código
> quebrado") vale para renome também.

- [x] `features/shopping/` → `features/groceries/`  ·  `specs/features/shopping.yaml` → `specs/features/groceries.yaml`
  - `shopping_screen.dart` → `groceries_screen.dart` (tela-raiz); `ShoppingScreen` → `GroceriesScreen`
  - `shopping_providers.dart` → `providers.dart`; `shopping_repository.dart` → `repository.dart` (`ShoppingRepository`→`GroceriesRepository`); `shopping_seed.dart` → `seed.dart`; `shopping_add_sheet.dart` → `add_sheet.dart` (`showShoppingAddSheet`→`showGroceriesAddSheet`)
  - entidades → singular: `shopping_list.dart`→`grocery_list.dart` (`ShoppingList`→`GroceryList`), `shopping_item.dart`→`grocery_item.dart` (`ShoppingItem`→`GroceryItem`), `shopping_list_view.dart`→`grocery_list_view.dart`
  - **despensa FICA `pantry`** (`pantry_item.dart`, `add_pantry_sheet.dart`, `pantry_view.dart`, `PantryItem`, `pantryProvider`)
  - `AppLog` tag `'shopping'` → `'groceries'`
- [x] `features/learning/` → `features/notebook/`  ·  `specs/features/learning.yaml` → `specs/features/notebook.yaml`
  - `learning_screen.dart` → `notebook_screen.dart` (`LearningScreen`→`NotebookScreen`)
  - `learning_providers.dart` → `providers.dart`; `caderno_providers.dart` → `hub_providers.dart` (hub do Caderno: fio/reativação)
  - `caderno_add_sheet.dart` → `add_sheet.dart` (`showCadernoAddSheet`→`showNotebookAddSheet`)
  - `learning_repository.dart` → `repository.dart` (`LearningRepository`→`NotebookRepository`); `learning_seed*.dart` → `seed*.dart`
  - "Caderno" (palavra pt-BR na UI/prosa) e `AppIcons.learning` FICAM; `AppLog` tag `'learning'` → `'notebook'`
- [x] Cross-imports: `core/router/routes.dart`, `core/router/router.dart`, `profile/application/overview_providers.dart`.
- [x] **Conteúdo dos arquivos** (o que faltava): imports (`shopping_item.dart`→`grocery_item.dart`,
  `learning_providers.dart`→`providers.dart`, …), tipos (`ShoppingList`→`GroceryList`,
  `ShoppingItem`→`GroceryItem`, `ShoppingRepository`→`GroceriesRepository`,
  `LearningScreen`→`NotebookScreen`, `CadernoAddSheet`→`NotebookAddSheet`, …), providers
  (`shoppingListsProvider`→`groceryListsProvider`, `learningRepositoryProvider`→`notebookRepositoryProvider`)
  e tags do `AppLog` (`'shopping'`→`'groceries'`, `'learning'`→`'notebook'`).
- [x] `flutter analyze` limpo — **conferido**: 0 erros, 0 warnings, 19 infos pré-existentes de vírgula.
- [x] Specs de feature sincronizadas: `groceries.yaml`/`notebook.yaml` foram renomeadas na Fase 1 mas
  seguiam descrevendo `lib/features/shopping/…`; todo `file:` volta a apontar p/ `.dart` existente.
- [ ] PENDENTE (decisão do dono): trocar route strings `/learning`→`/notebook`, `/shopping`→`/groceries` (produtores + consumidores + comentários). Mantidas por ora.

## Fase 2 — Core + specs de componentes (regra dos 7) — FEITO

- [x] `core/widgets/` (25) → `controls/` (7) · `cards/` (7) · `layout/` (4) · `sheets/` (3) · `tabs/` (2) · `tags/` (2)
- [x] Ajustar TODOS os imports de `core/widgets/x.dart` → `core/widgets/<grupo>/x.dart` (sweep global)
- [x] `specs/components/` → mesmos grupos; **espelho exato: 25 `.dart` ↔ 25 `.yaml`**
- [x] Quebrar `specs/components/atoms.yaml` nas specs-espelho de cada átomo (RecipeThumb→cards/, PitadaSearchField→controls/, FuelBar/StepProgress→cards/, EmptyState/PitadaScaffold→layout/, SheetGrip→sheets/); `atoms.yaml` apagado
- [x] `tab_bar:` saiu de `specs/features/app_shell.yaml` → `specs/components/tabs/pitada_tab_bar.yaml`
  (é widget de `core/`, então a spec mora em `components/`; o `app_shell` ficou só com o ponteiro + `ordem`,
  que amarra o índice do branch). Decisão do dono, 16/jul/2026.

Achados ao mover (o `atoms.yaml` mentia — specs novas já corrigidas):
- `uses` de vários átomos ainda citava `AppColors.*` cru de **antes da migração de tema**; o código
  real lê `context.pit.*`. Ex.: FuelBar `AppColors.surf2` → `context.pit.surf2`.
- `used_by` desatualizado: FuelBar é usado por `DaySummary` (não `plans_screen`); `PitadaSearchField`
  tem 3 consumidores (não 1); `StepProgress` também é usado por `cook_mode_screen`.

Pendências que a Fase 2 destapou (não são dela — anotar e seguir):
- [ ] Chave `detalhes:` está em pt-BR em ~15 specs; `language.md` manda chave em inglês (`details:`).
  Renome coordenado no corpus inteiro — decisão do dono, não dá p/ fazer arquivo a arquivo.
- [ ] Números mágicos de layout em `core/widgets/` (`empty_state` `size: 34`, `fuel_bar` `height: 6`,
  `pitada_search_field` `size: 18`) e `Colors.white` cru em `recipe_thumb` — violam `design-system.md`.
- [ ] `specs/features/app_shell.yaml` não parseia como YAML (linha 18, `/recipe/:id` sem aspas em flow map).

## Fase 3 — Compartimentalizar features (por PAPEL, depois SUB-DOMÍNIO)

`recipes/`
- [ ] `data/` (20) → `models/` (folder, ingredient, recipe, recipe_step, recipe_draft + gerados) · `repositories/` (recipe/seed/supabase/photos + row_mapper) · `seed/` (recipe_seed, recipe_versions_seed)
- [ ] `presentation/` (10) → `screens/` (recipes, recipe_detail, recipe_edit, cook_mode, folder) · `sheets/` (import, cook_chat, recipe_version) · edits (`recipe_item_edit`, `recipe_quick_edit`) por papel real
- [ ] `presentation/widgets/` (25) → `cook/ edit/ folder/ import/ detail/ card/` (detail/ divide em `detail/ + blocks/` se passar de 7)

`notebook/` (ex-learning)
- [ ] `data/` (17) → `models/` (subagrupa: `lesson/ diary/ log/ repertoire/ …`, pois > 7) · `notebook_repository.dart` (solto) · `seed/` (6)
- [ ] `presentation/` (17) → `screens/` (14 → subagrupa `lesson/ diary/ note/ version/ log/`) · `sheets/` (add, diary_quick, note_quick)
- [ ] `presentation/widgets/` (21) → subgrupos por sub-domínio (`lesson/ diary/ version/ log/ repertoire/ shared/`)

`plans/`
- [ ] `data/` (11) → `models/ repositories/ seed/`
- [ ] `presentation/` (9) → `screens/` (plans) · `sheets/` (8 → subagrupa `log/ food/ plan/` se > 7)
- [ ] `presentation/widgets/` (12) → `day_log/ progress/ weight/ meal/`
- [ ] `application/` (6) — ok, mantém flat

`profile/`
- [ ] `data/` (9) → `models/` (+ repository/seed soltos ou em pastas)
- [ ] `presentation/widgets/` (8) → `activity/ settings/ header/`

`groceries/` (ex-shopping) e `auth/` — ≤ 7 por camada; só o renome da Fase 1, sem quebrar.

## Fase 4 — Sweep de cabeçalhos & comentários (o QUÊ, não o COMO)

Antecipada: o cabeçalho **não** foi atualizado na hora (a Fase 1 só renomeou arquivo), então
não eram "restos" — eram 73 linhas mentindo em 75 arquivos. Feito junto com a Fase 2:
- [x] `grep -rn "// lib/features/\(shopping\|learning\)" lib` → cabeçalhos com caminho velho
- [x] `grep -rn "\(shopping\|learning\|caderno\)" lib specs` → refs órfãs em `USA`/`USADO POR`/`SPEC`/imports
- [x] Conferir `SPEC:` de cada arquivo aponta pro novo caminho da spec espelho (25/25 em `core/widgets`)
- [x] Reescrever descrições `O QUÊ` que citavam nome velho (ex.: "aba Compras" → "aba Ingredientes")

Sobras **legítimas** (não são bug — não tente "consertar"):
`AppIcons.learning`/`learningFill` e as rotas `/learning`, `/shopping` (decisão pendente do dono,
acima); `PhosphorIconsRegular.shoppingCartSimple` (nome de pacote de terceiro); "Caderno" na prosa/UI.

- [ ] Repetir o sweep depois da Fase 3 (mover arquivo mexe em `USA`/`USADO POR`/`SPEC` de novo).

## Fase 5 — Verificação

- [x] `flutter analyze` — 0 erros (0 warnings, 19 infos pré-existentes de vírgula)
- [x] `grep -rn "features/shopping\|features/learning" lib specs` — zero resultados
- [x] Todo `file:` de spec aponta p/ `.dart` existente — 72/72
- [x] `git status` revisado; commit por fase (não um commitão)
- [x] `flutter build web --release` → `✓ Built build/web` (o `analyze` sozinho não prova que compila)
- [ ] Smoke das 5 abas no browser (ver memória `verificacao-web-headless`) — **não rodado**; o build
  passa, mas ninguém abriu o app pra ver as abas de pé.

## Receita de rename (reusável em QUALQUER troca futura)

`git mv` é **metade** do renome — a outra metade é o conteúdo (imports + tipos). Pular a
segunda metade foi o que deixou o `master` com 243 erros. `sed` é cego: **revise o diff**.

```bash
OLD=shopping; NEW=groceries                    # da raiz do repo

# 1. os arquivos
git mv lib/features/$OLD lib/features/$NEW
git mv lib/features/$NEW/presentation/${OLD}_screen.dart \
       lib/features/$NEW/presentation/${NEW}_screen.dart

# 2. o CONTEÚDO — a metade que já foi esquecida uma vez.
#    2a. imports de arquivo: do nome MAIS específico p/ o mais genérico, senão
#        'shopping_list.dart' come o prefixo de 'shopping_list_view.dart'.
#    2b. caminhos de pasta nos cabeçalhos, imports e 'file:' das specs:
grep -rl "features/$OLD" lib specs | xargs sed -i '' "s#features/$OLD#features/$NEW#g"
#    2c. tipos/providers/tags — LISTE e revise 1 a 1 antes de trocar:
grep -rn "Shopping\|'shopping'" lib

# 3. o portão: sem isto o renome NÃO está feito
flutter analyze          # tem que dar 0 erros antes de marcar a caixa / commitar
```

Armadilhas que já morderam:
- **`for x in $var` não separa palavras no zsh.** Loop de sed some sem erro nenhum. Rode
  script de migração com `bash script.sh`, nunca colado no shell interativo.
- **Import relativo quebra ao descer um nível**: mover p/ subpasta exige `../theme` → `../../theme`.
- **Nem todo import casa com o caminho novo**: `core/router/app_shell.dart` importava
  `'../widgets/pitada_tab_bar.dart'` — não contém `core/widgets/`, então escapou do sweep.
  Confira também com `grep -rn "import '\.\./widgets/" lib/core/`.
- **A spec renomeada continua mentindo por dentro**: `git mv shopping.yaml groceries.yaml` não
  toca os `file:` lá dentro. Teste cada um: `test -f` no caminho que a spec afirma.
