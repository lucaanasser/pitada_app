// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/progress_providers.dart
// O QUÊ:     Providers do Progresso ligados ao PESO: histórico (controller),
//            estatísticas (atual/início/variação) e o dataset de comidas p/ extras.
// USA:       progress_repository, weight_entry, food_item, riverpod, app_log.
// USADO POR: WeightSection, WeightChart, FoodSearchSheet, LogWeightSheet.
// SPEC:      specs/features/plans_progress.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/food_item.dart';
import '../data/progress_repository.dart';
import '../data/weight_entry.dart';

/// Instância do repositório de Progresso. Usada por: controllers e foodsProvider.
final progressRepositoryProvider =
    Provider<ProgressRepository>((ref) => const ProgressRepository());

/// Resumo do peso: primeiro registro, atual e variação (atual - início).
/// `delta < 0` => emagreceu. Imutável. Usada por: WeightSection.
class WeightStats {
  final double start;
  final double current;

  const WeightStats({required this.start, required this.current});

  /// Variação de peso desde o primeiro registro (kg). Usada por: WeightSection.
  double get delta => current - start;
}

/// Histórico de pesagens (ordenado por data crescente) + ação de registrar peso.
/// Usada por: weightControllerProvider (StateNotifierProvider).
class WeightController extends StateNotifier<List<WeightEntry>> {
  WeightController(ProgressRepository repository)
      : super(_sorted(repository.fetchWeights()));

  /// Registra uma pesagem; substitui a do mesmo dia se já existir. Reordena por data.
  /// Usada por: LogWeightSheet (botão "Salvar").
  void addWeight(double kg, {DateTime? date}) {
    final day = date ?? DateTime.now();
    final kept = [
      for (final e in state)
        if (!_sameDay(e.date, day)) e,
    ];
    state = _sorted([...kept, WeightEntry(date: day, kg: kg)]);
    AppLog.i('plans', 'peso registrado: $kg kg em ${day.toIso8601String()}');
  }

  /// Ordena uma lista de pesagens por data crescente. Usada por: construtor/addWeight.
  static List<WeightEntry> _sorted(List<WeightEntry> list) {
    final copy = [...list]..sort((a, b) => a.date.compareTo(b.date));
    return copy;
  }

  /// True se as duas datas caem no mesmo dia (ignora hora). Usada por: addWeight.
  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Controlador do histórico de peso. Usada por: WeightChart, WeightSection.
final weightControllerProvider =
    StateNotifierProvider<WeightController, List<WeightEntry>>((ref) {
  return WeightController(ref.watch(progressRepositoryProvider));
});

/// Estatísticas do peso (início/atual/variação) ou null se ainda não há registro.
/// Usada por: WeightSection (número grande + variação).
final weightStatsProvider = Provider<WeightStats?>((ref) {
  final entries = ref.watch(weightControllerProvider);
  if (entries.isEmpty) return null;
  return WeightStats(start: entries.first.kg, current: entries.last.kg);
});

/// Dataset curado de comidas comuns p/ o log de extras. Usada por: FoodSearchSheet.
final foodsProvider = Provider<List<FoodItem>>((ref) {
  return ref.watch(progressRepositoryProvider).fetchFoods();
});
