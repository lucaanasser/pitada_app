// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/progress_repository.dart
// O QUÊ:     Fonte dos dados de Progresso (peso, dias logados, dataset de comidas).
//            Hoje em memória (seeds); depois, Supabase — mesma API.
// USA:       weight_entry, day_log, food_item e os seeds correspondentes.
// USADO POR: progress_providers, day_log_providers. A UI nunca chama isto direto.
// SPEC:      specs/features/plans_progress.yaml (repository: ProgressRepository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'day_log.dart';
import 'food_item.dart';
import 'foods_seed.dart';
import 'progress_seed.dart';
import 'weight_entry.dart';

/// Repositório do Progresso. Implementação atual serve os seeds de exemplo.
/// Usada por: progress_providers/day_log_providers. Versão Supabase mantém a API.
class ProgressRepository {
  const ProgressRepository();

  /// Histórico de pesagens (estado inicial do gráfico). Usada por: WeightController.
  List<WeightEntry> fetchWeights() {
    AppLog.d('plans', 'carregando pesagens (seed): ${kSeedWeights.length}');
    return kSeedWeights;
  }

  /// Dias já registrados (estado inicial da aderência). Usada por: DayLogController.
  List<DayLog> fetchDayLogs() {
    AppLog.d('plans', 'carregando dias logados (seed): ${kSeedDayLogs.length}');
    return kSeedDayLogs;
  }

  /// Dataset curado de comidas comuns p/ o log de extras. Usada por: foodsProvider.
  List<FoodItem> fetchFoods() {
    AppLog.d(
      'plans',
      'carregando dataset de comidas (seed): ${kSeedFoods.length}',
    );
    return kSeedFoods;
  }
}
