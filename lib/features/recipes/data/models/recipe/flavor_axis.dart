// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/flavor_axis.dart
// O QUÊ:     Eixo de sabor como FUNÇÃO do ingrediente (limão = acidez) — nomes
//            casam 1:1 com o enum flavor_axis do Postgres.
// USA:       nada (enum puro + extension de rótulo).
// USADO POR: ingredient.dart (Ingredient.flavors), ingredient_row (render sóbrio).
// SPEC:      specs/features/recipes.yaml (data.sabor) +
//            specs/backend/database.yaml (0016_ingredient_flavors.sql)
// ─────────────────────────────────────────────────────────────────────────────

/// Os sete eixos de sabor que um ingrediente traz ao prato. Informação, nunca
/// veredito: marcar é transcrição. Usada por: Ingredient, IngredientRow.
enum FlavorAxis { acid, umami, fat, sweet, bitter, salt, fresh }

/// Rótulo pt-BR de cada eixo, para a linha sóbria sob o ingrediente.
/// Usada por: IngredientRow.
extension FlavorAxisLabel on FlavorAxis {
  /// Nome exibível do eixo ('ácido', 'umami'…). Usada por: IngredientRow.
  String get label => switch (this) {
        FlavorAxis.acid => 'ácido',
        FlavorAxis.umami => 'umami',
        FlavorAxis.fat => 'gordura',
        FlavorAxis.sweet => 'doçura',
        FlavorAxis.bitter => 'amargor',
        FlavorAxis.salt => 'sal',
        FlavorAxis.fresh => 'frescor',
      };
}
