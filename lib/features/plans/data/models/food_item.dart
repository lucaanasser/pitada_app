// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/models/food_item.dart
// O QUÊ:     Item do dataset curado de comidas comuns (aproximação por porção).
//            Usado no log rápido do que se comeu FORA do plano.
// USA:       nada (modelo imutável puro).
// USADO POR: foods_seed, progress_repository, foodsProvider, FoodSearchSheet.
// SPEC:      specs/features/plans_progress.yaml (data.models: FoodItem)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma comida comum (parcialmente genérica) com porção humana e macros aproximados.
/// Não é precisão de balança — é uma boa estimativa em um toque.
/// `category` agrupa nos chips de atalho (doce/salgado/bebida/alcool/fastfood/fruta/lanche/prato).
/// Usada por: FoodSearchSheet (busca + chips), ExtraEntry.fromFood.
class FoodItem {
  final String id;
  final String name;
  final String portion;
  final int kcal;
  final num protein;
  final num carb;
  final num fat;
  final String category;

  const FoodItem({
    required this.id,
    required this.name,
    required this.portion,
    required this.kcal,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
    required this.category,
  });
}
