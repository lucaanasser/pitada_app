# Specs First

**Principle:** the order is always spec → code, never the reverse; nothing is implemented without a matching `.yaml` spec in `specs/`.

A spec describes the what, inputs, variants, and tokens used. Changed the code? The spec already existed and agrees. Diverged? Update the spec — spec and code never disagree.

## Where specs live (they mirror the code — see `architecture.md`)
```
specs/
  design-system/   # tokens (colors, typography, spacing, theme)
  components/      # one per core/widgets/ widget (grouped like the code)
  features/        # one per screen/flow (becomes a folder as it grows)
  README.yaml      # index
```
The spec path mirrors the code path (`lib/` ↔ `specs/`, `.dart` ↔ `.yaml`). Every `file:` points to the real `.dart`.

## Component skeleton
```yaml
component: PitadaButton
file: lib/core/widgets/pitada_button.dart
purpose: Standard reusable button.
uses: [AppColors.accent, AppType.button, AppSpacing.radiusLg]
variants:
  - {name: primary, background: AppColors.accent, foreground: AppColors.onAccent}
  - {name: icon, border: AppColors.line2}
api: {label: String, icon: IconData?, onPressed: VoidCallback?}
used_by: [recipe_detail_screen]
```

## Screen skeleton
```yaml
screen: RecipesScreen
file: lib/features/recipes/presentation/recipes_screen.dart
purpose: Recipe list by folder.
layout: [Masthead, PitadaTabs, list of RecipeRow]
providers: [recipesProvider, selectedFolderProvider]
navigates_to: [RecipeDetailScreen]
```

## Checklist
1. Spec written or updated before the code.
2. `file:` points to the real target path.
3. Spec and code agree (fields, variants, tokens).
4. Spec kept short and true.
