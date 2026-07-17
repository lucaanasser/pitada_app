// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_meta_text.dart
// O QUÊ:     Monta a linha de meta de uma receita em texto: "tempo · kcal".
// USA:       core/utils/format (formatMinutes/formatKcal), Recipe.
// USADO POR: recipe_card (meta do card) e recipe_row (subtítulo da linha).
// SPEC:      specs/components/recipe_card.yaml (linha de meta em texto)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/utils/format.dart';
import '../../../data/models/recipe/recipe.dart';

/// Monta a meta curta de uma receita: "tempo · kcal".
/// Partes ausentes (tempo) são omitidas. Usada por: RecipeCard, RecipeRow.
String recipeMetaText(Recipe recipe) {
  final parts = <String>[
    if (recipe.timeMinutes != null) formatMinutes(recipe.timeMinutes),
    '${formatKcal(recipe.kcal)} kcal',
  ];
  return parts.join('  ·  ');
}
