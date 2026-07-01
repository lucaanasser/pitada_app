// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipe_step.dart
// O QUÊ:     Modelo de passo de preparo, com dica 'Por quê' opcional.
// USA:       nada (modelo imutável puro).
// USADO POR: recipe.dart, StepTile, cook_mode.
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────

/// Um passo do modo de preparo. [tip] vira o callout WhyCallout, quando existe.
/// Usada por: Recipe, RecipeDetailScreen e CookModeScreen.
class RecipeStep {
  final String text;
  final String? tip; // callout "Por quê" (técnica)

  const RecipeStep({required this.text, this.tip});
}
