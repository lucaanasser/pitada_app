# Architecture and Naming

**Principle:** feature-first layers with a one-way data flow, small files, and English names whose role suffix and folder reveal each file's purpose at a glance.

## Layers (per feature)
- **data/** — models (`freezed`/`json_serializable`) and the repository. The **only** layer that talks to Supabase / Edge Functions.
- **application/** — Riverpod providers and controllers; orchestrates the repository.
- **presentation/** — screens and feature widgets; watches providers, never calls the repository.

Flow (the arrow never reverses): `presentation → application → data → Supabase`.
The UI imports only models from `data/`.

## Core (shared)
`theme/` (design system) · `widgets/` (visual reuse — see `design-system.md`) · `router/` (go_router: tab shell + routes) · `config/` (env via `--dart-define`) · `supabase/` (client) · `utils/` (`AppLog`, formatting, units).

## File size — max 200 lines (hard)
Over the limit? Split, in this order:
1. Extract widgets (each visual section becomes a widget in `presentation/widgets/`).
2. Split by responsibility (a large repository → one per entity).
3. Extract pure helpers into `core/utils/`.
4. One model per file in `data/`.

## Names
- **snake_case, always English** (files, folders, features). Types `PascalCase`, providers/vars `lowerCamelCase`. Which language goes where: `language.md`.
- **The folder names the feature once; the file never repeats it.** File name = ROLE + ENTITY.
  - Wrong: `recipes/data/recipes_repository.dart`
  - Right: `recipes/data/repositories/recipe_repository.dart`
  - Only exception: a tab's root screen may carry the feature name (`<feature>_screen.dart`).
- **Role suffix is mandatory** — a searchable, fixed vocabulary (`find lib -name '*_repository.dart'`):

  | Layer | Suffixes |
  |---|---|
  | presentation | `_screen` `_sheet` `_card` `_row` `_tile` `_view` `_bar` `_header` `_grid` `_chart` `_painter` |
  | application | `_providers` `_controller` `_service` |
  | data | `_repository` `_seed` `_mapper`; a **model is a plain noun** (`recipe.dart`), no suffix |
  | generated | `*.freezed.dart` `*.g.dart` next to the model |

## Rule of 7
**Max 7 loose files per directory; the 8th forces a subfolder.** Generated files do not count. 7 is a ceiling, not a floor — do not fragment for symmetry, and never create a one-file folder. When a directory overflows, split in this order:
1. **By role:** `data/` → `models/ repositories/ seed/`; `presentation/` → `screens/ sheets/ widgets/`.
2. **By sub-domain** (when one role still exceeds 7): e.g. `recipes/presentation/widgets/` → `recipe_detail/ cook/ folder/ import/ edit/`; `core/widgets/` → `controls/ sheets/ tabs/ tags/ layout/ cards/`.

Canonical skeleton:
```
features/<feature>/
  data/{models,repositories,seed}/
  application/            # *_providers, *_controller, *_service
  presentation/{screens,sheets,widgets}/
core/
  config/ supabase/ router/ theme/ utils/
  widgets/{controls,sheets,tabs,tags,layout,cards}/   # only once it exceeds 7
```
Apply **only when the count demands it** — a small feature (≤ 7 per layer) stays flat.

## Preview on desktop
All hardware (scanner/camera/share) sits behind an abstract service: a real implementation and a **mock** (desktop/web), injected via a Riverpod override. This is what enables running in Chrome/Linux with hot reload.

## Renaming and moving files
The `shopping/` → `groceries/` and `learning/` → `notebook/` migrations are **done** (jul/2026); the tree now follows this file. Two leftovers are still open and tracked in `.claude/reestruturacao.md`: the route strings `/learning` and `/shopping`, and `AppIcons.learning`.

Before any future rename or move, read `.claude/reestruturacao.md`: it carries the reusable rename recipe and, above all, the two rules those migrations cost us — **`flutter analyze` (and `build web`) before you call a rename done**, and **a moved file is path ARITHMETIC, never `sed`** (every import here is relative, so moving a file breaks both its own imports and every importer's path to it).

## Checklist (creating or moving a file)
1. English snake_case with the correct role suffix.
2. Do not repeat the folder name in the file (only a tab's root screen may).
3. Destination folder has ≤ 7 loose files? If the new file is the 8th, split by role first.
4. Update the file header (`// path`, `O QUÊ`, `USA`, `USADO POR`, `SPEC`) of the file and of whoever references it.
5. Create or move the mirror spec under `specs/` at the same relative path.