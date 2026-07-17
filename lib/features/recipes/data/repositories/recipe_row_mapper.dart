// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe_row_mapper.dart
// O QUÊ:     Tradução linha do Postgres <-> modelo Recipe. O embedding do
//            PostgREST (recipe_ingredients/recipe_steps/recipe_folders) vira o
//            shape do Recipe.fromJson; toRow tira o que não é coluna de recipes.
// USA:       recipe.dart (modelo).
// USADO POR: supabase_recipe_repository (leitura e escrita).
// SPEC:      specs/features/recipes.yaml (data.repository_supabase)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/recipe.dart';

/// Ordena uma lista embutida por `position` e devolve como List<Map>. Usada
/// por: recipeFromRow (ingredientes e passos mantêm a ordem da receita).
List<Map<String, dynamic>> _sortedByPosition(Object? embedded) {
  final rows = (embedded as List? ?? const []).cast<Map<String, dynamic>>();
  return [...rows]..sort(
      (a, b) =>
          ((a['position'] ?? 0) as num).compareTo((b['position'] ?? 0) as num),
    );
}

/// Agrupa ingredientes/passos por component_id no shape de RecipeComponent.
/// Sem componentes: tudo cai num componente sem nome; órfãos (component_id
/// null) caem no primeiro componente. Usada por: recipeFromRow.
List<Map<String, dynamic>> _componentMaps(
  List<Map<String, dynamic>> components,
  List<Map<String, dynamic>> ingredients,
  List<Map<String, dynamic>> steps,
) {
  if (components.isEmpty) {
    return [
      {'name': null, 'ingredients': ingredients, 'steps': steps},
    ];
  }
  List<Map<String, dynamic>> of(List<Map<String, dynamic>> rows, int i) => [
        for (final r in rows)
          if (r['component_id'] == components[i]['id'] ||
              (i == 0 && r['component_id'] == null))
            r,
      ];
  return [
    for (var i = 0; i < components.length; i++)
      {
        'name': components[i]['name'],
        'ingredients': of(ingredients, i),
        'steps': of(steps, i),
      },
  ];
}

/// Converte a linha de `recipes` (com embedding) no modelo Recipe.
/// Usada por: SupabaseRecipesRepository (fetchRecipes/fetchById/fetchVersionGroup).
Recipe recipeFromRow(Map<String, dynamic> row) {
  final ingredients = _sortedByPosition(row['recipe_ingredients']);
  final steps = _sortedByPosition(row['recipe_steps']);
  final components = _sortedByPosition(row['recipe_components']);
  return Recipe.fromJson({
    ...row,
    'ingredients': ingredients,
    'steps': steps,
    'components': _componentMaps(components, ingredients, steps),
    'folder_ids': [
      for (final f in (row['recipe_folders'] as List? ?? const []))
        (f as Map)['folder_id'] as String,
    ],
  });
}

/// Converte o Recipe na linha da tabela `recipes` (só colunas reais — filhas
/// vão em tabelas próprias; is_definitive/user_id são do banco). [withId]=false
/// remove o id (insert com uuid novo gerado pelo Postgres).
/// Usada por: SupabaseRecipesRepository (updateRecipe/saveAsNewVersion).
Map<String, dynamic> recipeToRow(Recipe recipe, {bool withId = true}) {
  final row = recipe.toJson()
    ..remove('ingredients')
    ..remove('steps')
    ..remove('components')
    ..remove('folder_ids');
  if (!withId) row.remove('id');
  return row;
}

/// Linhas de `recipe_ingredients` para [recipeId] (position = ordem da lista).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> ingredientRows(Recipe recipe, String recipeId) => [
      for (final (i, ing) in recipe.ingredients.indexed)
        {...ing.toJson(), 'recipe_id': recipeId, 'position': i},
    ];

/// Linhas de `recipe_steps` para [recipeId] (position = ordem da lista).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> stepRows(Recipe recipe, String recipeId) => [
      for (final (i, step) in recipe.steps.indexed)
        {...step.toJson(), 'recipe_id': recipeId, 'position': i},
    ];

/// Linhas de `recipe_folders` (N:N) para [recipeId].
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> folderRows(Recipe recipe, String recipeId) => [
      for (final folderId in recipe.folderIds)
        {'recipe_id': recipeId, 'folder_id': folderId},
    ];
