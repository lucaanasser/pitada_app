// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/ingredient.dart
// O QUÊ:     Modelo de ingrediente de receita. Grama é a base; unidade é referência.
// USA:       freezed + json_serializable (codegen; JSON snake_case via build.yaml).
// USADO POR: recipe.dart, recipes_seed, IngredientRow, importação, repositórios.
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

/// Um ingrediente: nome + gramas (principal) + quantidade/unidade humana (ref.).
/// Usada por: Recipe, telas de detalhe/edição e a lista de compras.
@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    num? grams,
    num? humanQty,
    String? humanUnit,
  }) = _Ingredient;

  /// Monta a partir do JSON do banco (name/grams/human_qty/human_unit).
  /// Usada por: SupabaseRecipesRepository (linhas de recipe_ingredients).
  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
