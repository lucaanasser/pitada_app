// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/plans_providers.dart
// O QUÊ:     Providers Riverpod de Planos (plano ativo, escolha de opção, totais do dia).
// USA:       plans_repository, plan.dart, meal.dart, meal_option.dart, riverpod, app_log.
// USADO POR: plans_screen, DaySummaryCard, MealCard (camada de apresentação).
// SPEC:      specs/features/plans.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/meal.dart';
import '../data/meal_option.dart';
import '../data/plan.dart';
import '../data/plans_repository.dart';

/// Totais nutricionais agregados de um dia (opções escolhidas). Imutável.
/// Usada por: dayTotalsProvider, DaySummaryCard (legenda de macros).
class DayTotals {
  final int kcal;
  final num protein;
  final num carb;
  final num fat;

  const DayTotals({
    this.kcal = 0,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
  });
}

/// Instância do repositório. Usada por: planControllerProvider.
final plansRepositoryProvider =
    Provider<PlansRepository>((ref) => const PlansRepository());

/// Estado do plano ativo + ações que mutam a escolha de opções.
/// Usada por: planControllerProvider (StateNotifierProvider).
class PlanController extends StateNotifier<Plan> {
  PlanController(PlansRepository repository) : super(repository.fetchPlan());

  /// Marca `optionIndex` como escolhida na refeição `mealId` e recalcula o estado.
  /// Índice inválido ou refeição inexistente => nenhuma mudança (com aviso no log).
  /// Usada por: OptionCard.onChoose em MealCard.
  void chooseOption(String mealId, int optionIndex) {
    final meals = [
      for (final meal in state.meals)
        if (meal.id != mealId) meal else _applyChoice(meal, optionIndex),
    ];
    state = state.copyWith(meals: meals);
    AppLog.i('plans', 'opção escolhida: $mealId #$optionIndex');
  }

  /// Retorna a refeição com apenas a opção `optionIndex` marcada como escolhida.
  /// Fora do intervalo => devolve a refeição intacta. Usada por: chooseOption.
  Meal _applyChoice(Meal meal, int optionIndex) {
    if (optionIndex < 0 || optionIndex >= meal.options.length) {
      AppLog.w('plans', 'índice de opção inválido em ${meal.id}: $optionIndex');
      return meal;
    }
    final options = <MealOption>[
      for (var i = 0; i < meal.options.length; i++)
        meal.options[i].copyWith(chosen: i == optionIndex),
    ];
    return meal.copyWith(options: options);
  }

  /// Total de kcal do dia (soma das opções escolhidas). Usada por: dayTotalsProvider.
  int get dayTotalKcal => state.chosenKcal;
}

/// Controlador do plano ativo (estado + escolha de opções). Usada por: telas de Planos.
final planControllerProvider =
    StateNotifierProvider<PlanController, Plan>((ref) {
  return PlanController(ref.watch(plansRepositoryProvider));
});

/// Índice do dia selecionado (0 = primeiro dia; 2 = dia ativo no protótipo).
/// Usada por: ChapterTabs de dias em plans_screen.
final selectedDayProvider = StateProvider<int>((ref) => 2);

/// Totais nutricionais do dia (kcal + macros das opções escolhidas).
/// Usada por: DaySummaryCard (total grande, FuelBar, legenda de macros).
final dayTotalsProvider = Provider<DayTotals>((ref) {
  final plan = ref.watch(planControllerProvider);
  var kcal = 0;
  num protein = 0;
  num carb = 0;
  num fat = 0;
  for (final meal in plan.meals) {
    final option = meal.chosenOption;
    if (option == null) continue;
    for (final item in option.items) {
      kcal += item.kcal;
      protein += item.protein;
      carb += item.carb;
      fat += item.fat;
    }
  }
  return DayTotals(kcal: kcal, protein: protein, carb: carb, fat: fat);
});
