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
- [ ] **15 das 48 specs não parseiam como YAML** (medido na Fase 3, e já era assim antes dela —
  conferido no commit `5891015`). A anotação original culpava só o `app_shell.yaml`, que hoje
  parseia; os 15 são outros: `backend/{auth,database,edge_functions}`, `components/cards/option_card`,
  `components/controls/{pitada_button,pitada_toggle}`, `components/recipe_card`,
  `components/tags/{expiry_tag,pitada_tag}`, `design-system/typography`,
  `features/{auth,bancada,groceries,plans_progress,recipes}`. Causa recorrente: `:` sem aspas em
  flow map/seq. Enquanto não parseiam, nenhum portão automático lê spec — só `grep`.

## Fase 3 — Compartimentalizar features (por PAPEL, depois SUB-DOMÍNIO) — FEITO

146 moves em 4 commits (um por feature). **Decisão do dono, 16/jul/2026: a Fase 3 mexe em
CAMINHO, não em identificador.** Renomeia o arquivo onde o nome repete a feature no plural
(o exemplo LITERAL de errado em `architecture.md`), mas tipo e provider ficam — é o precedente
que a Fase 1 fixou: `GroceriesRepository` mora em `repository.dart`. Isso mantém o diff inteiro
dentro do que o script garante e o `analyze` prova.

`recipes/`
- [x] `data/` (20) → `models/` (5 + gerados) · `repositories/` (5) · `seed/` (2)
  - renomes: `recipes_repository`→`recipe_repository`, `seed_recipes_repository`→`seed_recipe_repository`,
    `supabase_recipes_repository`→`supabase_recipe_repository`, `recipes_seed`→`recipe_seed`,
    `recipes_seed_versions`→`recipe_versions_seed` (o `_seed` tem que fechar o nome)
  - `recipe_row_mapper` foi p/ `repositories/`: `mappers/` seria pasta de UM arquivo (proibido)
- [x] `presentation/` (10) → `screens/` (5) · `sheets/` (4) · 2 soltos
- [x] `presentation/widgets/` (25) → `cook/ edit/ folder/ import/ detail/ list/` — `card/` do hint
  virou `list/`: dos 4 membros só `recipe_card` é card (os outros são row/toggle/meta_text)

`notebook/` (ex-learning)
- [x] `data/` (17) → `models/{knowledge,activity,hub}/` · `repository.dart` (solto) · `seed/` (6)
  - o hint dizia `models/{lesson,diary,log,repertoire}/`, mas `diary/` e `log/` dariam pasta de
    UM arquivo; a costura que sobrevive é conhecimento × registro do usuário × view-model do hub
  - o hint dizia `notebook_repository.dart`; ficou `repository.dart` — `notebook_` repete a feature
- [x] `presentation/` (17) → `screens/` (3 + `lesson/ diary/ note/ version/ log/`) · `sheets/` (3)
- [x] `presentation/widgets/` (21) → `lesson/ hub/ note/ version/ repertoire/ shared/` + 2 soltos

`plans/`
- [x] `data/` (11) → `models/` (6) · `repositories/` (2) · `seed/` (3); `plans_repository`→`plan_repository`, `plans_seed`→`plan_seed`
- [x] `presentation/` (9) → `sheets/{plan,log,food}/` · `plans_screen.dart` solto — `screens/` seria
  pasta de UM arquivo; arquivo solto ao lado de subpasta ≠ pasta de um arquivo
- [x] `presentation/widgets/` (12) → `day_log/ progress/ weight/ meal/`
- [x] `application/` (6) — mantido flat, como o plano manda

`profile/`
- [x] `data/` (9) → `models/` (6) + `repository`/`seed`/`activity_builder` soltos
- [x] `presentation/widgets/` (8) → `activity/ settings/` + 4 soltos — `header/` do hint daria pasta
  de UM arquivo (`profile_header`)

`groceries/` (ex-shopping) e `auth/` — ≤ 7 por camada; intocadas, como o plano manda.

### Adendo (16/jul/2026) — sufixo `_seed` no fim, nos seeds do Caderno

Decisão do dono depois da Fase 3: os 5 `seed_*` do notebook tinham o papel na FRENTE, invisíveis p/
`find lib -name '*_seed.dart'` — que é justamente o teste que `architecture.md` usa p/ justificar o
sufixo. Corrigido: `seed_activity`→`activity_seed`, `seed_flavors`→`flavors_seed`,
`seed_guides`→`guides_seed`, `seed_herbs`→`herbs_seed`, `seed_lessons`→`lessons_seed`.
Reverte a metade errada da Fase 1 (linha 47), que de-prefixou `learning_seed*`→`seed*` e no caminho
jogou o papel p/ a frente. Os demais já estavam certos (`recipe_seed`, `plan_seed`, `foods_seed`,
`progress_seed`, `profile_seed`).

**O agregado `seed.dart` FICA `seed.dart`** — não `notebook_seed.dart`. Tentei e reverti: a pasta já
diz `notebook`, então `notebook_seed` é o "arquivo repete a feature" da linha 25-26. E é o irmão
exato de `groceries/data/seed.dart` — mesmo papel (o agregado que o `repository` importa; os 5
`*_seed` só o agregado importa). Sem entidade p/ nomear, o papel sozinho é o nome certo.

Achados ao mover:
- **`recipe_item_edit.dart` é `part of` `recipe_quick_edit.dart`** — o único `part` escrito à mão do
  repo (o resto é freezed/`.g`). São UMA biblioteca: não separam, e `part` é string de nome de
  arquivo, que import nenhum reescreve. Ficaram os dois soltos em `presentation/`.
- **`RecipeQuickEdit` não é sheet.** É fachada (classe com `BuildContext`+`ref`, um método por campo);
  não declara widget nem `show*`. Chamar de `_sheet` seria sufixo mentindo — e o sheet DE VERDADE
  (`quick_edit_sheet.dart`, tem `showQuickEditSheet`) estava em `widgets/`. Foi ele que subiu p/
  `sheets/`; a fachada ficou com o nome que tem. Nenhum sufixo de presentation descreve fachada.
- 3 imports davam a volta (`../../../features/recipes/…` sobe até `lib/` e desce de novo). Resolvem
  no mesmo alvo; a aritmética de caminho normalizou.

Pendências que a Fase 3 destapou (anotadas, não feitas — nenhuma é de estrutura):
- [ ] `<feature>_providers.dart` repete a feature no plural em `recipes` e `plans` (o exemplo literal
  de errado). Os dois estão igualmente errados: consertar um só deixa o corpus MENOS consistente.
  Sweep coordenado, ~30 importadores — decisão do dono.
- [ ] Identificadores pt-BR vivos: `CardapioView`/`cardapio_view.dart` e `fio_entry`/`FioEntry`/`fio_tile`.
  `language.md` chama isso de bug. São irmãos: ou os dois, ou nenhum.
- [ ] **52 arquivos de `presentation/`+`core/widgets/` sem sufixo do vocabulário** — contado
  16/jul/2026 (a anotação anterior dizia "~35", número repassado sem ninguém contar). Distribuição:
  `core/widgets` 17 · recipes 12 · notebook 8 · plans 7 · profile 6 · groceries 2.
  **Não é lapso dos arquivos, é a regra que não fecha.** O vocabulário (`_screen _sheet _card _row
  _tile _view _bar _header _grid _chart _painter`) não tem palavra p/ botão, tag, campo editável,
  empty state ou animação — e é isso que são `pitada_button`, `pitada_tag`, `editable`, `empty_state`,
  `paper_fly`, `principle_quote`, `key_point`. A Fase 2 revisou `core/widgets` inteiro (agrupou os 25,
  espelho exato 25 `.dart` ↔ 25 `.yaml`) e **não renomeou nenhum** — não por esquecimento, por não
  haver sufixo verdadeiro p/ dar. Renomear aqui seria inventar sufixo p/ encaixar (`pitada_button_view`),
  o que piora o nome. Decisão do dono sobre a REGRA, não sweep: ou `architecture.md` assume que a
  lista é indicativa p/ widget folha (obrigatória só p/ screen/sheet/repository/providers/seed), ou
  amplia o vocabulário com o que falta (`_button _field _panel _section _quote _anim`…).

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

- [x] Repetir o sweep depois da Fase 3 (mover arquivo mexe em `USA`/`USADO POR`/`SPEC` de novo).
  230 arquivos conferidos, 24 campos corrigidos, diff **100% linha de comentário** (0 linha de código).
  Portão: `grep` dos 7 nomes mortos em `lib specs` → zero.

  **O cabeçalho é metade do comentário.** O sweep foi tocado como "só o bloco de cabeçalho" e
  deixou 7 linhas `///` contradizendo o cabeçalho do MESMO arquivo (`recipe_seed.dart` linha 6 já
  dizia `seed_recipe_repository`, e a linha 14 ainda dizia `recipes_repository`). `comments-and-logs.md`
  manda `///` em toda declaração pública — então `///` mente igual. Varra os dois.

  **E o `USADO POR` é semântico, não textual.** `recipe_seed.dart` dizia "Usada por: recipes_repository";
  o sed óbvio (`recipes_repository`→`recipe_repository`) escreveria uma falsidade NOVA — quem importa
  o seed é o `seed_recipe_repository`, não o contrato. Confira o importador real com `grep` antes de
  reescrever a linha. Fora de `lib/`, a prosa das specs (`seed: recipes_seed.dart`, comentário
  `# data/supabase_recipes_repository.dart`) também escapa: não é `file:`, nenhum script pega.

## Fase 5 — Verificação

Refeita ao fim da Fase 3 (números medidos agora, não herdados):

- [x] `flutter analyze` — 0 erros (0 warnings, 19 infos pré-existentes de vírgula — as MESMAS 19 de antes da fase)
- [x] `grep -rn "features/shopping\|features/learning" lib specs` — zero resultados
- [x] Todo `file:` de spec aponta p/ `.dart` existente — **78/78**
- [x] `grep` dos 7 nomes de arquivo mortos da Fase 3 em `lib specs` — zero
- [x] Cabeçalho `// <caminho>` bate com o caminho real — 0 mentindo (conferido por script, 239 arquivos)
- [x] `git status` revisado; **commit por feature** (5 commits, não um commitão)
- [x] `flutter build web --release` → `✓ Built build/web` (o `analyze` sozinho não prova que compila)
- [ ] Smoke das 5 abas no browser (ver memória `verificacao-web-headless`) — **continua não rodado**;
  o build passa, mas ninguém abriu o app pra ver as abas de pé. A Fase 3 mexeu em caminho, não em
  comportamento, e `analyze`+`build` cobrem caminho — mas isso é argumento, não é ter olhado.

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

## Mover pasta ≠ renomear arquivo — use aritmética de caminho, não `sed` (lição da Fase 3)

`sed` casa TEXTO; move de pasta é ARITMÉTICA. O import é 100% relativo neste repo (1033 imports,
zero `package:pitada`), então mover um arquivo quebra os dois lados: os `../` de dentro dele **e**
o caminho que todo importador usa p/ chegar nele. Os dois dependem de ONDE cada ponta parou —
`sed` não sabe disso. Na Fase 3 foram 146 moves e **862 imports** reescritos; à mão ou por sed,
não fecha.

O algoritmo (vale p/ qualquer move futuro):
```
p/ cada .dart, com o par (caminho ANTIGO, caminho NOVO) fixado ANTES de mover:
  p/ cada import relativo:
    alvo   = normpath(dirname(ANTIGO) + '/' + import)   # resolve de onde ele resolvia
    alvo'  = mapa.get(alvo, alvo)                       # o alvo também pode ter andado
    import'= relpath(alvo', dirname(NOVO))              # recalcula de onde ele vai resolver
```
Duas coisas que isso dá de graça e o sed não dá: pega import que não contém o caminho trocado
(`'../widgets/x.dart'`), e não toca no import de quem se mudou JUNTO com o alvo.

**Valide o script com o mapa IDENTIDADE antes de confiar nele**: todo arquivo mapeado p/ ele
mesmo tem que dar **zero** reescrita. Se der qualquer coisa, a aritmética está errada e você
descobre isso de graça, não em cima de 146 moves. (Aqui deu 3 — e eram reais: imports que davam
a volta por `lib/` e voltavam.)

E **`--dry` tem que simular o move**, senão ele mente: a primeira versão listava os arquivos
andando em `lib/` DEPOIS do move — em dry nada tinha movido, então ela calculava tudo como se o
arquivo tivesse ficado parado. Mostrou 331 reescritas; o certo era 862. Fixe o par
(antigo, novo) ANTES de mover e os dois modos usam a mesma conta.

Armadilhas que já morderam:
- **`for x in $var` não separa palavras no zsh.** Loop de sed some sem erro nenhum. Rode
  script de migração com `bash script.sh`, nunca colado no shell interativo.
- **Import relativo quebra ao descer um nível**: mover p/ subpasta exige `../theme` → `../../theme`.
- **`part` é string de nome de arquivo, não import.** Renomear um arquivo `part` exige trocar as
  DUAS pontas (`part 'x.dart'` e `part of 'y.dart'`) — nenhuma reescrita de import pega isso.
- **Pasta de camada ≠ pasta de split.** `auth/data/` com 1 arquivo é o esqueleto, não violação;
  "nunca pasta de um arquivo" fala de quebrar demais. Arquivo solto ao lado de subpasta também
  é legítimo (`plans/presentation/plans_screen.dart` + `sheets/`).
- **Nem todo import casa com o caminho novo**: `core/router/app_shell.dart` importava
  `'../widgets/pitada_tab_bar.dart'` — não contém `core/widgets/`, então escapou do sweep.
  Confira também com `grep -rn "import '\.\./widgets/" lib/core/`.
- **A spec renomeada continua mentindo por dentro**: `git mv shopping.yaml groceries.yaml` não
  toca os `file:` lá dentro. Teste cada um: `test -f` no caminho que a spec afirma.
