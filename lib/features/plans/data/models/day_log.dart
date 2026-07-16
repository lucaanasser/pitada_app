// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/models/day_log.dart
// O QUÊ:     Registro aproximado de um dia (feito no fim do dia): o que a pessoa
//            comeu por refeição (opção escolhida ou "pulei") + extras fora do plano.
// USA:       food_item.dart (ExtraEntry.fromFood).
// USADO POR: progress_seed, dayLogControllerProvider, adherenceProvider, LogDaySheet.
// SPEC:      specs/features/plans_progress.yaml (data.models: DayLog/MealLogEntry/ExtraEntry)
// ─────────────────────────────────────────────────────────────────────────────
import 'food_item.dart';

/// O que se comeu numa refeição do plano num dia. `skipped` => pulou (não conta).
/// `optionId` guarda qual opção foi comida (null se pulada). Usada por: DayLog.
class MealLogEntry {
  final String mealId;
  final String mealName;
  final String? optionId;
  final bool skipped;
  final int kcal;
  final num protein;
  final num carb;
  final num fat;

  const MealLogEntry({
    required this.mealId,
    required this.mealName,
    this.optionId,
    this.skipped = false,
    this.kcal = 0,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
  });
}

/// Algo comido FORA do plano, logado rápido (do dataset ou item livre).
/// Usada por: DayLog (lista de extras), LogDaySheet, FoodSearchSheet.
class ExtraEntry {
  final String? foodId;
  final String name;
  final String portion;
  final int kcal;
  final num protein;
  final num carb;
  final num fat;

  const ExtraEntry({
    this.foodId,
    required this.name,
    this.portion = '',
    required this.kcal,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
  });

  /// Cria um extra a partir de um item do dataset. Usada por: FoodSearchSheet.
  factory ExtraEntry.fromFood(FoodItem f) => ExtraEntry(
        foodId: f.id,
        name: f.name,
        portion: f.portion,
        kcal: f.kcal,
        protein: f.protein,
        carb: f.carb,
        fat: f.fat,
      );
}

/// O registro de um dia inteiro: refeições feitas/puladas + extras fora do plano.
/// Imutável — o sheet monta um novo DayLog e o controller faz upsert por data.
/// Usada por: DayLogController, adherenceProvider.
class DayLog {
  final DateTime date;
  final List<MealLogEntry> meals;
  final List<ExtraEntry> extras;

  const DayLog({
    required this.date,
    this.meals = const [],
    this.extras = const [],
  });

  /// kcal total do dia: refeições feitas (não puladas) + todos os extras.
  /// Usada por: adherenceProvider, rodapé do LogDaySheet.
  int get kcal {
    var sum = 0;
    for (final m in meals) {
      if (!m.skipped) sum += m.kcal;
    }
    for (final e in extras) {
      sum += e.kcal;
    }
    return sum;
  }

  /// Quantas refeições do plano foram puladas nesse dia. Usada por: resumo/UI.
  int get skippedCount => meals.where((m) => m.skipped).length;
}
