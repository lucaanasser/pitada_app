// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/meal.dart
// O QUÊ:     Modelo de refeição do dia (Café, Almoço, Jantar, Lanche) e suas opções.
// USA:       meal_option.dart (composição).
// USADO POR: plan.dart, plans_seed, plans_repository, plans_providers, MealCard.
// SPEC:      specs/features/plans.yaml (data.models: Meal)
// ─────────────────────────────────────────────────────────────────────────────
import 'meal_option.dart';

/// Uma refeição do plano: nome, meta de kcal e opções de cardápio.
/// A opção escolhida é a que tem `chosen == true` (ou nenhuma, se vazia/sem escolha).
/// Usada por: Plan, plans_seed, PlanController, MealCard.
class Meal {
  final String id;
  final String name;
  final int kcalGoal;
  final List<MealOption> options;

  const Meal({
    required this.id,
    required this.name,
    required this.kcalGoal,
    this.options = const [],
  });

  /// A opção marcada como escolhida, ou null se nenhuma. Usada por: total do dia.
  MealOption? get chosenOption {
    for (final option in options) {
      if (option.chosen) return option;
    }
    return null;
  }

  /// kcal da opção escolhida (0 se nenhuma). Usada por: dayTotalsProvider.
  int get chosenKcal => chosenOption?.totalKcal ?? 0;

  /// Cópia com as opções trocadas (imutável). Usada por: PlanController.chooseOption.
  Meal copyWith({List<MealOption>? options}) => Meal(
        id: id,
        name: name,
        kcalGoal: kcalGoal,
        options: options ?? this.options,
      );
}
