// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/sub_recipe.dart
// O QUÊ:     Modelo de SUBRECEITA COMPARTILHADA: existe uma vez, é usada por
//            várias receitas via vínculo (RecipeComponent.subRecipeId).
//            Editar propaga; id é ESTÁVEL (escrita por upsert).
// USA:       freezed + json_serializable (codegen), ingredient.dart,
//            recipe_step.dart.
// USADO POR: recipe_component (resolvedWith), repositórios de subreceita,
//            biblioteca de subreceitas (telas).
// SPEC:      specs/features/sub_recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'recipe_step.dart';

part 'sub_recipe.freezed.dart';
part 'sub_recipe.g.dart';

/// Uma subreceita da biblioteca (cobertura, massa, molho): nome + ingredientes
/// + passos, idêntica em todos os pratos que a vinculam (só o scale do vínculo
/// varia). Usada por: RecipeComponent.resolvedWith, SubRecipesRepository, telas.
@freezed
abstract class SubRecipe with _$SubRecipe {
  const factory SubRecipe({
    required String id,
    required String name,
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<RecipeStep> steps,
  }) = _SubRecipe;

  /// Monta a partir do JSON do banco (aninhados já mapeados pelo repositório).
  /// Usada por: SupabaseSubRecipesRepository.
  factory SubRecipe.fromJson(Map<String, dynamic> json) =>
      _$SubRecipeFromJson(json);
}
