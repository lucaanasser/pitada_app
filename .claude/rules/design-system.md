# Design System and Visual Reuse

**Principle:** every visual decision comes from a token; about to type a hex, a font size, or a spacing number in a screen? Stop and use a token.

Aesthetic: **soft pastel neo-brutalism** — pastel surfaces, **borders** (not hairlines), **Space Grotesk** for titles and numbers, **colored tags**, everything flat.

## Single source of truth

| What | File (API) |
|---|---|
| Raw colors for both themes | `core/theme/colors.dart` (`AppColors`) |
| Per-theme colors | `core/theme/pitada_colors.dart` (`context.pit.*`) |
| Typography | `core/theme/typography.dart` (`AppType`) |
| Spacing / radius / border | `core/theme/spacing.dart` (`AppSpacing`) |
| Icons (Phosphor) | `core/theme/app_icons.dart` (`AppIcons`) |
| Material theme | `core/theme/app_theme.dart` (`light` + `dark`) |

**Never outside these files:** `Color(0xFF…)`, `TextStyle(fontFamily: …)`, a magic layout number, `Icons.*` (Material).

## Two themes (mandatory in all UI)
Colors that change per theme live in `PitadaColors` and are read via **`context.pit.*`**: `bg surf surf2 line line2 border text text2 muted faint`, plus `pit.card('moss')` (photo block) and `pit.tabBg(i)` (per-tab background). Brand (`accent`/`sage`) and heroes stay in `AppColors` (identical in both themes). Exact values live in `colors.dart` — the source of truth, not duplicated here.

**Never use directly** the raw dark tokens (`AppColors.text/text2/muted/faint/line/line2/surf/surf2/bg`) — they are unreadable in light mode. Use the same-named `context.pit.*`. `AppType.*` carries a dark fallback color; always override it with `AppType.on(AppType.<style>, context.pit.<token>)`.

Sole exception: UI that renders one theme while the other is active — a theme preview must name both palettes explicitly (`AppColors.bg` vs `AppColors.bgLight`), because `context.pit.*` only ever yields the active theme.

## Typography
- **Space Grotesk** (`_disp`): titles, numbers (kcal, grams, "Opção N"), buttons.
- **Inter** (`_ui`): body, labels, running text.
- Bundled in `assets/fonts/`, declared in `pubspec.yaml`. Never load over the network.

## Components (reuse is mandatory)
A repeated visual piece becomes a widget in `core/widgets/` (or `presentation/widgets/` if feature-specific). Search for an existing one before creating a new one. Main widgets:

| Widget | What it is |
|---|---|
| Masthead · SectionHeader | brand at the top · section label |
| PitadaTabs · PitadaTabBar | content tabs · the 5-tab dock |
| HairlineRow | list row with a hairline (dense lists) |
| PitadaButton · PitadaChip | button · outline chip (techniques/pairings) |
| PitadaTag | colored pill — **tags only** |
| ExpiryTag · NutritionCard · OptionCard · WhyCallout | expiry · macros · meal · "why" callout |

**A pill is for a TAG only** (classification: technique, type, verdict, category). **Never** for a metric (kcal, time, grams → sober text in `pit.text2`/`pit.muted`) nor for a selector/control (use `PitadaTabs` or a title-with-caret that opens a sheet). See the `PitadaTag` spec.

## Forbidden / allowed
Forbidden: any **shadow** (including "hard"/offset), gradient, cursive font.
Allowed: borders (`AppSpacing.borderStrong`, color `pit.border`), pastels, bordered cards, hairlines only in dense lists. Usability over decoration: breathing room, never crowd.

## Checklist
1. Color/font/spacing/icon come from a token, not a literal.
2. Per-theme colors via `context.pit.*` plus `AppType.on(...)`; the screen works in light and dark.
3. Reused a shared widget instead of duplicating the visual.
4. No shadow, gradient, or cursive font.