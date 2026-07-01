// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/meal_option.dart
// O QUÊ:     Modelos de opção de cardápio de uma refeição e seus pratos (itens).
// USA:       nada (modelos imutáveis puros).
// USADO POR: meal.dart, plans_seed, plans_repository, plans_providers, OptionCard.
// SPEC:      specs/features/plans.yaml (data.models: MealOption, MealOptionItem)
// ─────────────────────────────────────────────────────────────────────────────

/// Um prato dentro de uma opção de refeição.
/// `recipeId != null` => prato linkado (abrível na tela de detalhe da receita).
/// Macros (protein/carb/fat) alimentam o agregado do dia; kcal é a base do encaixe.
/// Usada por: MealOption, plans_seed, OptionCard (mapeado p/ OptionDish).
class MealOptionItem {
  final String name;
  final int kcal;
  final String? recipeId;
  final num protein;
  final num carb;
  final num fat;

  const MealOptionItem({
    required this.name,
    required this.kcal,
    this.recipeId,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
  });

  /// true quando o prato aponta para uma receita salva. Usada por: OptionCard.
  bool get linked => recipeId != null;
}

/// Uma alternativa de cardápio ("Opção N") para uma refeição.
/// `chosen` marca a opção ativa; `fits`/`fitLabel` descrevem o encaixe na meta.
/// Usada por: Meal, plans_seed, plans_repository, OptionCard.
class MealOption {
  final String id;
  final bool fits;
  final String fitLabel;
  final bool chosen;
  final List<MealOptionItem> items;

  const MealOption({
    required this.id,
    required this.fits,
    required this.fitLabel,
    this.chosen = false,
    this.items = const [],
  });

  /// Soma das kcal dos itens da opção. Usada por: total do dia e OptionCard.
  int get totalKcal {
    var sum = 0;
    for (final item in items) {
      sum += item.kcal;
    }
    return sum;
  }

  /// Cópia com campos trocados (imutável). Usada por: PlanController.chooseOption.
  MealOption copyWith({bool? chosen}) => MealOption(
        id: id,
        fits: fits,
        fitLabel: fitLabel,
        chosen: chosen ?? this.chosen,
        items: items,
      );
}
