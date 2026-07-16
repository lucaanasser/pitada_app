# Pitada — Project Guide (read before coding)

Personal app for recipes, a cooking notebook, meal plans, and a pantry.
**Flutter + Riverpod + go_router**, **Supabase** backend, AI via **Gemini** (Edge Functions).
Aesthetic: **soft pastel neo-brutalism**. Code identifiers, file names, and these docs are in English; in-code comments and product UI/content are in pt-BR.
Living visual references: `pitada-estilo.html`, `pitada-guia-de-construcao.html`.

## Golden rules (non-negotiable) — one file each in `rules/`

1. **Spec before code.** Nothing is built without a `.yaml` spec in `specs/`. The order is spec → code, never the reverse. → `specs-first.md`
2. **Architecture and naming.** Feature-first layers, ≤ 200 lines per file, English snake_case with a role suffix, max 7 loose files per folder. → `architecture.md`
3. **No hard-coded visuals.** Every color, font, spacing, icon, and reused widget comes from the design tokens / `core/widgets`. → `design-system.md`
4. **Comments only in the header and above declarations**, stating WHAT, never HOW. → `comments-and-logs.md`
5. **Always version.** Finished something that works? Local commit, sole author, no push. → `versioning.md`

## Structure (details and the rule of 7 in `architecture.md`)

```
specs/            # .yaml specs — always first; MIRRORS the code path
lib/core/         # theme (tokens) · widgets (reuse) · router · config · supabase · utils
lib/features/<f>/ # data (models + repository) · application (providers) · presentation (screens + widgets)
```

Data flow (the arrow never reverses): `presentation → application → data → Supabase`.
The UI never calls Supabase directly and only imports models from `data/`.

## Conventions

- File/folder/feature names in English; tab labels in pt-BR (`Caderno` → `notebook`, `Ingredientes` → `groceries`). Never keep a legacy name (see `architecture.md`).
- Two themes (light/dark): per-theme color via `context.pit.*`, brand in `AppColors`; every screen works in both.
- Hardware (scanner/camera/share) sits behind an abstract service (real + mock) so the app runs on desktop.
- Forbidden visuals: shadow, gradient, cursive font. Allowed: borders, pastels, Space Grotesk, colored tags, bordered cards.
- Usability over decoration: generous breathing room, never crowd the screen.

Living migration plan toward the naming standard: `.claude/reestruturacao.md`.
