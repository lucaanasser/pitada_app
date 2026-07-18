// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/recipe_row_mapper.dart
// O QUÊ:     Tradução linha do Postgres <-> modelo Recipe. O embedding do
//            PostgREST vira o shape do Recipe.fromJson; componente VINCULADO
//            resolve da sub_recipes embutida na leitura e grava só o vínculo.
// USA:       recipe.dart, recipe_component.dart, recipe_step.dart (modelos),
//            sub_recipe_row_mapper (sortedByPosition + subRecipeFromRow).
// USADO POR: supabase_recipe_repository (leitura e escrita).
// SPEC:      specs/features/recipes.yaml (data.repository_supabase) +
//            specs/features/sub_recipes.yaml (data.leitura, data.escrita)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/recipe/recipe.dart';
import '../../models/recipe/recipe_component.dart';
import '../../models/recipe/recipe_step.dart';
import '../sub_recipe/sub_recipe_row_mapper.dart';

/// Agrupa ingredientes/passos por component_id no shape de RecipeComponent.
/// Sem componentes: tudo cai num componente sem nome; órfãos (component_id
/// null) caem no primeiro componente. Vinculado entra vazio (resolve depois).
/// Usada por: recipeFromRow.
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
        'sub_recipe_id': components[i]['sub_recipe_id'],
        'scale': components[i]['scale'] ?? 1,
      },
  ];
}

/// Preenche os componentes VINCULADOS a partir da sub_recipes embutida em cada
/// linha de componente (resolvedWith escala os ingredientes). Usada por:
/// recipeFromRow.
Recipe _resolveLinks(Recipe recipe, List<Map<String, dynamic>> componentRows) {
  if (componentRows.isEmpty) return recipe;
  var changed = false;
  final resolved = <RecipeComponent>[];
  for (var i = 0; i < recipe.components.length; i++) {
    final c = recipe.components[i];
    final subRow = i < componentRows.length ? componentRows[i]['sub_recipes'] : null;
    if (c.isLinked && subRow is Map<String, dynamic>) {
      resolved.add(c.resolvedWith(subRecipeFromRow(subRow)));
      changed = true;
    } else {
      resolved.add(c);
    }
  }
  return changed ? recipe.copyWith(components: resolved) : recipe;
}

/// Converte a linha de `recipes` (com embedding) no modelo Recipe. As técnicas
/// de cada passo chegam aninhadas (recipe_step_techniques) e viram o campo
/// `techniques` do passo; componentes vinculados resolvem da sub embutida.
/// Usada por: SupabaseRecipesRepository (fetchRecipes/fetchById/fetchVersionGroup).
Recipe recipeFromRow(Map<String, dynamic> row) {
  final ingredients = sortedByPosition(row['recipe_ingredients']);
  final steps = [
    for (final s in sortedByPosition(row['recipe_steps']))
      {...s, 'techniques': s['recipe_step_techniques'] ?? const []},
  ];
  final components = sortedByPosition(row['recipe_components']);
  final recipe = Recipe.fromJson({
    ...row,
    'components': _componentMaps(components, ingredients, steps),
    'folder_ids': [
      for (final f in (row['recipe_folders'] as List? ?? const []))
        (f as Map)['folder_id'] as String,
    ],
  });
  return _resolveLinks(recipe, components);
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

/// True quando a receita dispensa linhas de componente (1 componente LOCAL sem
/// nome: as filhas ficam com component_id null). Usada por: SupabaseRecipesRepository.
bool isSingleImplicitComponent(Recipe recipe) =>
    recipe.components.length == 1 &&
    recipe.components.first.name == null &&
    !recipe.components.first.isLinked;

/// Linhas de `recipe_components` para [recipeId] (position = ordem da lista).
/// Vinculado grava sub_recipe_id + scale e name null (o nome vem da sub).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> componentRows(Recipe recipe, String recipeId) => [
      for (final (i, c) in recipe.components.indexed)
        {
          'recipe_id': recipeId,
          'position': i,
          'name': c.isLinked ? null : c.name,
          'sub_recipe_id': c.subRecipeId,
          'scale': c.scale,
        },
    ];

/// Linhas de `recipe_ingredients` para [recipeId], com component_id alinhado a
/// [componentIds] (nulls = componente implícito; position = ordem global).
/// Componente vinculado NÃO gera linhas (conteúdo mora na subreceita).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> ingredientRows(
  Recipe recipe,
  String recipeId,
  List<String?> componentIds,
) {
  var position = 0;
  return [
    for (final (c, comp) in recipe.components.indexed)
      if (!comp.isLinked)
        for (final ing in comp.ingredients)
          {
            ...ing.toJson(),
            'recipe_id': recipeId,
            'component_id': componentIds[c],
            'position': position++,
          },
  ];
}

/// Linhas de `recipe_steps` para [recipeId] (mesma regra: vinculado fica fora).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> stepRows(
  Recipe recipe,
  String recipeId,
  List<String?> componentIds,
) {
  var position = 0;
  return [
    for (final (c, comp) in recipe.components.indexed)
      if (!comp.isLinked)
        for (final step in comp.steps)
          {
            ...step.toJson()..remove('techniques'),
            'recipe_id': recipeId,
            'component_id': componentIds[c],
            'position': position++,
          },
  ];
}

/// Passos LOCAIS achatados na ordem de escrita (vinculados ficam fora — o
/// conteúdo deles mora nas tabelas de subreceita). Usada por: stepTechniqueRows.
List<RecipeStep> _localSteps(Recipe recipe) =>
    [for (final c in recipe.components) if (!c.isLinked) ...c.steps];

/// Linhas de `recipe_step_techniques` a partir dos passos JÁ inseridos:
/// [stepIds] alinha com os passos LOCAIS (mesma ordem de stepRows).
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> stepTechniqueRows(
  Recipe recipe,
  List<String> stepIds,
) =>
    [
      for (final (i, step) in _localSteps(recipe).indexed)
        for (final t in step.techniques)
          {
            'step_id': stepIds[i],
            'technique_id': t.techniqueId,
            'anchor': t.anchor,
          },
    ];

/// Linhas de `recipe_folders` (N:N) para [recipeId].
/// Usada por: SupabaseRecipesRepository (escrita das filhas).
List<Map<String, dynamic>> folderRows(Recipe recipe, String recipeId) => [
      for (final folderId in recipe.folderIds)
        {'recipe_id': recipeId, 'folder_id': folderId},
    ];
