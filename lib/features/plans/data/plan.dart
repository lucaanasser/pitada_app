// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/plan.dart
// O QUÊ:     Modelo do plano alimentar ativo (nome interno + meta diária de kcal).
// USA:       meal.dart (composição das refeições do dia).
// USADO POR: plans_seed, plans_repository, plans_providers, PlansScreen.
// SPEC:      specs/features/plans.yaml (data.models: Plan)
// ─────────────────────────────────────────────────────────────────────────────
import 'meal.dart';

/// O plano ativo do usuário: nome, meta diária de kcal e as refeições do dia.
/// Imutável — mudanças (escolher opção) geram uma cópia via copyWith.
/// Usada por: PlanController (estado), PlansScreen, DaySummary.
class Plan {
  final String id;
  final String name;
  final int dailyKcalGoal;
  final List<Meal> meals;

  const Plan({
    required this.id,
    required this.name,
    required this.dailyKcalGoal,
    this.meals = const [],
  });

  /// Soma das kcal das opções escolhidas em todas as refeições. Usada por: total do dia.
  int get chosenKcal {
    var sum = 0;
    for (final meal in meals) {
      sum += meal.chosenKcal;
    }
    return sum;
  }

  /// Cópia com as refeições trocadas (imutável). Usada por: PlanController.chooseOption.
  Plan copyWith({List<Meal>? meals}) => Plan(
        id: id,
        name: name,
        dailyKcalGoal: dailyKcalGoal,
        meals: meals ?? this.meals,
      );
}
