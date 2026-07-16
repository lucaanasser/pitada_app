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

## Renaming or moving a file
Renaming a file is three jobs, and only the first is `git mv`:
1. **The path** — every import in this repo is relative, so a move breaks both the file's own `../` imports and every importer's path to it. Both depend on where each end landed: that is path **arithmetic**, not `sed`. Resolve each import against the file's old location, map the target, recompute it from the new one.
2. **The identifiers** — types, providers, `AppLog` tags. List them and review one by one; `sed` cannot tell a name from a substring.
3. **The prose** — the header (`// path`, `USA`, `USADO POR`, `SPEC`), every `///` doc, and spec prose that names the file outside a `file:` key. No compiler checks these, so they rot silently. The only gate is `grep` for the dead name across `lib specs` → zero.

A rename is done when `flutter analyze` reports 0 errors **and** `flutter build web --release` succeeds — `analyze` alone does not prove it compiles.

## Checklist (creating or moving a file)
1. English snake_case with the correct role suffix.
2. Do not repeat the folder name in the file (only a tab's root screen may).
3. Destination folder has ≤ 7 loose files? If the new file is the 8th, split by role first.
4. Update the file header (`// path`, `O QUÊ`, `USA`, `USADO POR`, `SPEC`) of the file and of whoever references it.
5. Create or move the mirror spec under `specs/` at the same relative path.