// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/recipe_component.dart
// O QUÊ:     Componente de receita = SUB-RECEITA (massa, cobertura, molho):
//            macros somam no prato (rules/data-model.md), nunca é pasta.
// USA:       freezed + json_serializable, ingredient.dart, recipe_step.dart.
// USADO POR: recipe.dart (Recipe.components), recipe_row_mapper, seeds.
// SPEC:      specs/features/recipes.yaml (data.componentes) +
//            specs/backend/database.yaml (0014_recipe_components.sql)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'recipe_step.dart';

part 'recipe_component.freezed.dart';
part 'recipe_component.g.dart';

/// Uma parte nomeada da receita (massa/cobertura) com seus ingredientes e
/// passos. [name] null = componente implícito: a receita não tem partes e a
/// tela não mostra subcabeçalho. Usada por: Recipe.components.
@freezed
abstract class RecipeComponent with _$RecipeComponent {
  const RecipeComponent._();

  const factory RecipeComponent({
    String? name,
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<RecipeStep> steps,
  }) = _RecipeComponent;

  /// Monta a partir do JSON aninhado do mapper. Usada por: Recipe.fromJson.
  factory RecipeComponent.fromJson(Map<String, dynamic> json) =>
      _$RecipeComponentFromJson(json);
}
