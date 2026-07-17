// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/ingredient.dart
// O QUÊ:     Modelo de ingrediente de receita. Grama é a base; unidade é
//            referência; flavors é a função de sabor (limão = acidez).
// USA:       freezed + json_serializable (codegen; JSON snake_case via
//            build.yaml), flavor_axis.dart.
// USADO POR: recipe.dart, recipe_seed, IngredientRow, importação, repositórios.
// SPEC:      specs/features/recipes.yaml (data.models, data.sabor)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'flavor_axis.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

/// Um ingrediente: nome + gramas (principal) + quantidade/unidade humana (ref.)
/// + eixos de sabor que ele traz ao prato (exposição repetida, sem julgamento).
/// Usada por: Recipe, telas de detalhe/edição e a lista de compras.
@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    num? grams,
    num? humanQty,
    String? humanUnit,
    @Default([]) List<FlavorAxis> flavors,
  }) = _Ingredient;

  /// Monta a partir do JSON do banco (name/grams/human_qty/human_unit).
  /// Usada por: SupabaseRecipesRepository (linhas de recipe_ingredients).
  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
