// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/sub_recipe/sub_recipe_row_mapper.dart
// O QUÊ:     Tradução linha do Postgres <-> modelo SubRecipe. Também expõe o
//            ordenador por position usado pelos dois mappers (receita e sub).
// USA:       sub_recipe.dart (modelo).
// USADO POR: supabase_sub_recipe_repository, recipe_row_mapper (sortedByPosition
//            + resolução do embed sub_recipes).
// SPEC:      specs/features/sub_recipes.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/recipe/sub_recipe.dart';

/// Ordena uma lista embutida por `position` e devolve como List<Map>. Usada
/// por: subRecipeFromRow e recipe_row_mapper (ingredientes/passos em ordem).
List<Map<String, dynamic>> sortedByPosition(Object? embedded) {
  final rows = (embedded as List? ?? const []).cast<Map<String, dynamic>>();
  return [...rows]..sort(
      (a, b) =>
          ((a['position'] ?? 0) as num).compareTo((b['position'] ?? 0) as num),
    );
}

/// Converte a linha de `sub_recipes` (com embedding das filhas) no modelo.
/// As técnicas de cada passo chegam aninhadas e viram o campo `techniques`.
/// Usada por: SupabaseSubRecipesRepository e recipe_row_mapper (embed do vínculo).
SubRecipe subRecipeFromRow(Map<String, dynamic> row) {
  final steps = [
    for (final s in sortedByPosition(row['sub_recipe_steps']))
      {...s, 'techniques': s['sub_recipe_step_techniques'] ?? const []},
  ];
  return SubRecipe.fromJson({
    ...row,
    'ingredients': sortedByPosition(row['sub_recipe_ingredients']),
    'steps': steps,
  });
}

/// Converte a SubRecipe na linha da tabela `sub_recipes` (só colunas reais).
/// [withId]=false remove o id (insert com uuid novo do Postgres).
/// Usada por: SupabaseSubRecipesRepository (create/update).
Map<String, dynamic> subRecipeToRow(SubRecipe sub, {bool withId = true}) {
  final row = sub.toJson()
    ..remove('ingredients')
    ..remove('steps');
  if (!withId) row.remove('id');
  return row;
}

/// Linhas de `sub_recipe_ingredients` para [subRecipeId] (position = ordem).
/// Usada por: SupabaseSubRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> subIngredientRows(SubRecipe sub, String subRecipeId) =>
    [
      for (final (i, ing) in sub.ingredients.indexed)
        {...ing.toJson(), 'sub_recipe_id': subRecipeId, 'position': i},
    ];

/// Linhas de `sub_recipe_steps` para [subRecipeId] (position = ordem; técnicas
/// vão em tabela própria). Usada por: SupabaseSubRecipesRepository.
List<Map<String, dynamic>> subStepRows(SubRecipe sub, String subRecipeId) => [
      for (final (i, step) in sub.steps.indexed)
        {
          ...step.toJson()..remove('techniques'),
          'sub_recipe_id': subRecipeId,
          'position': i,
        },
    ];

/// Linhas de `sub_recipe_step_techniques` a partir dos passos JÁ inseridos:
/// [stepIds] alinha com sub.steps (ordem de position).
/// Usada por: SupabaseSubRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> subStepTechniqueRows(
  SubRecipe sub,
  List<String> stepIds,
) =>
    [
      for (final (i, step) in sub.steps.indexed)
        for (final t in step.techniques)
          {
            'step_id': stepIds[i],
            'technique_id': t.techniqueId,
            'anchor': t.anchor,
          },
    ];
