# Plano de reestruturação — nomenclatura & pastas

Migração única para o padrão de `rules/nomenclatura-e-pastas.md`. Guia vivo: marque
`[x]` conforme avança. Decisões travadas: **nomes em inglês uniforme**, **regra dos 7**,
**specs espelham o código**.

## Princípio que guia tudo

- A **pasta** nomeia a feature uma vez; arquivos usam **papel + entidade** (sufixo fixo).
- **Máx. 7 soltos** por pasta → quebra por PAPEL, depois por SUB-DOMÍNIO.
- Ao **mover** um arquivo, o **cabeçalho** muda junto (caminho, `USA`, `USADO POR`,
  `SPEC`) — e o cabeçalho de quem o importa. Comentário nunca fica desatualizado.
- A **spec espelho** move no mesmo caminho relativo (`lib/` ↔ `specs/`).

## Fase 0 — Regras (FEITO)

- [x] `rules/nomenclatura-e-pastas.md` (a regra)
- [x] `CLAUDE.md` (regra de ouro 5 + árvore-alvo + lista de regras)
- [x] Memória `estrutura-nomenclatura.md`
- [x] `specs/README.yaml` (convenção de nomes + espelho)

## Fase 1 — Renomes legados (semântico, maior valor)

Nome da feature só na pasta + tela-raiz + tipos de nível-feature. Entidades de domínio
(`ShoppingList`, `PantryItem`) NÃO mudam.

- [ ] `features/shopping/` → `features/pantry/`  ·  `specs/features/shopping.yaml` → `specs/features/pantry/`
  - `shopping_screen.dart` → `pantry_screen.dart` (tela-raiz); `ShoppingScreen` → `PantryScreen`
  - `shopping_providers.dart` → `application/providers.dart`; `shopping_repository.dart` → `data/pantry_repository.dart`; `shopping_seed.dart` → `data/pantry_seed.dart`; `shopping_add_sheet.dart` → `presentation/add_sheet.dart`
  - entidades `shopping_list.dart` / `shopping_item.dart` / `pantry_item.dart` ficam
  - `AppLog` tag `'shopping'` → `'pantry'`
- [ ] `features/learning/` → `features/notebook/`  ·  `specs/features/learning.yaml` → `specs/features/notebook/`
  - `learning_screen.dart` → `notebook_screen.dart`; `LearningScreen` → `NotebookScreen`
  - `learning_providers.dart` + `caderno_providers.dart` → `application/providers.dart` (+ split se > 7)
  - `caderno_add_sheet.dart` → `presentation/sheets/add_sheet.dart`
  - `learning_repository.dart` → `data/notebook_repository.dart`; `learning_seed*.dart` → `data/seed/*`
  - `AppLog` tag `'learning'` → `'notebook'`
- [ ] Atualizar `core/router/routes.dart` (imports + paths de rota `/learning/*` se quiser trocar para `/notebook/*`), `app_shell.dart` e qualquer `import` cruzado.
- [ ] `flutter analyze` limpo antes de seguir.

## Fase 2 — Core + specs de componentes (regra dos 7)

- [ ] `core/widgets/` (25) → `controls/ sheets/ tabs/ tags/ layout/ cards/` (mapa na regra §5)
- [ ] Ajustar TODOS os imports de `core/widgets/x.dart` → `core/widgets/<grupo>/x.dart` (sweep global)
- [ ] `specs/components/` (20) → mesmos grupos (`controls/ sheets/ tabs/ tags/ layout/ cards/`)
- [ ] Quebrar `specs/components/atoms.yaml` nas specs-espelho de cada átomo (RecipeThumb→cards/, PitadaSearchField→controls/, FuelBar/StepProgress→cards/, EmptyState/PitadaScaffold→layout/)

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

`pantry/` (ex-shopping) e `auth/` — ≤ 7 por camada; só o renome da Fase 1, sem quebrar.

## Fase 4 — Sweep de cabeçalhos & comentários (o QUÊ, não o COMO)

Cada arquivo movido já teve o cabeçalho atualizado na hora; esta fase pega os restos:
- [ ] `grep -rn "// lib/features/\(shopping\|learning\)" lib` → cabeçalhos com caminho velho
- [ ] `grep -rn "\(shopping\|learning\|caderno\)" lib specs` → refs órfãs em `USA`/`USADO POR`/`SPEC`/imports
- [ ] Conferir `SPEC:` de cada arquivo aponta pro novo caminho da spec espelho
- [ ] Reescrever descrições `O QUÊ` que citavam nome velho (ex.: "aba Compras" → "aba Ingredientes")

## Fase 5 — Verificação

- [ ] `flutter analyze` — 0 erros
- [ ] `grep -rn "features/shopping\|features/learning" lib specs` — zero resultados
- [ ] Build web release + smoke das 5 abas (ver memória `verificacao-web-headless`)
- [ ] `git status` revisado; commit por fase (não um commitão)

## Receita de rename (reusável em QUALQUER troca futura)

Como o nome da feature só vive na pasta/tela-raiz/tipos, renomear é mecânico. `sed` é
cego — **revise o diff antes de aplicar**.

```bash
OLD=shopping; NEW=pantry                       # da raiz do repo
git mv lib/features/$OLD lib/features/$NEW
git mv lib/features/$NEW/presentation/${OLD}_screen.dart \
       lib/features/$NEW/presentation/${NEW}_screen.dart
# caminhos nos cabeçalhos + imports + campos file: das specs:
grep -rl "features/$OLD" lib specs | xargs sed -i "s#features/$OLD#features/$NEW#g"
# tipos/tags de nível-feature — LISTAR e revisar 1 a 1 antes de trocar:
grep -rn "Shopping\|'shopping'" lib
```
