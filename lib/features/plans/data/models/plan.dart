// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/models/plan.dart
// O QUÊ:     Modelo do plano alimentar ativo (nome interno + metas diárias:
//            kcal e macros em gramas).
// USA:       meal.dart (composição das refeições do dia).
// USADO POR: plan_seed, plan_repository, plan_providers, PlansScreen.
// SPEC:      specs/features/plans/plans.yaml (data.models: Plan)
// ─────────────────────────────────────────────────────────────────────────────
import 'meal.dart';

/// O plano ativo do usuário: nome, metas diárias (kcal + macros em gramas) e as
/// refeições do dia. Imutável — mudanças (escolher opção) geram uma cópia via copyWith.
/// As metas de macro alimentam os anéis concêntricos do DaySummaryView.
/// Usada por: PlanController (estado), PlansScreen, DaySummaryView.
class Plan {
  final String id;
  final String name;
  final int dailyKcalGoal;
  final int proteinGoal;
  final int carbGoal;
  final int fatGoal;
  final List<Meal> meals;

  const Plan({
    required this.id,
    required this.name,
    required this.dailyKcalGoal,
    this.proteinGoal = 0,
    this.carbGoal = 0,
    this.fatGoal = 0,
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
        proteinGoal: proteinGoal,
        carbGoal: carbGoal,
        fatGoal: fatGoal,
        meals: meals ?? this.meals,
      );
}
