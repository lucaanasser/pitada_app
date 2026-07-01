// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/ingredient.dart
// O QUÊ:     Modelo de ingrediente de receita. Grama é a base; unidade é referência.
// USA:       nada (modelo imutável puro).
// USADO POR: recipe.dart, recipes_seed, IngredientRow, importação.
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────

/// Um ingrediente: nome + gramas (principal) + quantidade/unidade humana (ref.).
/// Usada por: Recipe, telas de detalhe/edição e a lista de compras.
class Ingredient {
  final String name;
  final num? grams; // base para cálculo de macros
  final num? humanQty; // ex.: 2
  final String? humanUnit; // ex.: 'unidade', 'c. sopa'

  const Ingredient({
    required this.name,
    this.grams,
    this.humanQty,
    this.humanUnit,
  });
}
