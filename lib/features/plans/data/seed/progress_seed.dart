// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/seed/progress_seed.dart
// O QUÊ:     Dados de exemplo do Progresso, com datas RELATIVAS a hoje (demo viva):
//            pesagens semanais em leve queda + ~11 dias logados nos últimos 14,
//            desenhados p/ exercitar streak (5 dias até ontem) e os insights
//            (lanche pulado 4x, brigadeiro 4x, doces >50% dos extras, um dia da
//            semana que estoura). Hoje fica SEM registro (mostra o CTA).
// USA:       weight_entry.dart, day_log.dart, foods_seed.dart (extras por id).
// USADO POR: progress_repository (fetchWeights/fetchDayLogs).
// SPEC:      specs/features/plans_progress.yaml (data.seeds: progress_seed.dart)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/day_log.dart';
import 'foods_seed.dart';
import '../models/weight_entry.dart';

/// Dia normalizado (sem hora) N dias atrás. Usada por: seeds abaixo.
DateTime _daysAgo(int n) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day).subtract(Duration(days: n));
}

/// Extra de exemplo a partir do dataset curado (kcal/macros consistentes).
/// Usada por: [kSeedDayLogs].
ExtraEntry _extra(String foodId) =>
    ExtraEntry.fromFood(kSeedFoods.firstWhere((f) => f.id == foodId));

/// Pesagens de exemplo (kg), ~1x/semana, com leve tendência de queda.
/// Usada por: ProgressRepository.fetchWeights (estado inicial do gráfico de peso).
final List<WeightEntry> kSeedWeights = [
  WeightEntry(date: _daysAgo(66), kg: 80.5),
  WeightEntry(date: _daysAgo(59), kg: 80.1),
  WeightEntry(date: _daysAgo(52), kg: 79.6),
  WeightEntry(date: _daysAgo(45), kg: 79.7),
  WeightEntry(date: _daysAgo(38), kg: 79.2),
  WeightEntry(date: _daysAgo(31), kg: 78.9),
  WeightEntry(date: _daysAgo(24), kg: 78.6),
  WeightEntry(date: _daysAgo(17), kg: 78.7),
  WeightEntry(date: _daysAgo(10), kg: 78.5),
  WeightEntry(date: _daysAgo(3), kg: 78.4),
];

/// Um dia logado de exemplo: total das refeições numa entrada única + uma
/// refeição pulada opcional + extras (o log real quebra por refeição).
/// Usada por: [kSeedDayLogs].
DayLog _seedDay(
  int daysAgo,
  int mealsKcal, {
  String? skips,
  List<ExtraEntry> extras = const [],
}) =>
    DayLog(
      date: _daysAgo(daysAgo),
      meals: [
        MealLogEntry(mealId: 'seed', mealName: 'Dia', kcal: mealsKcal),
        if (skips != null)
          MealLogEntry(mealId: 'seed_skip', mealName: skips, skipped: true),
      ],
      extras: extras,
    );

/// Dias registrados nas últimas 2 semanas (meta do plano seed = 1900 kcal).
/// Buracos em -6 e -11 (streak = 5 até ontem); -5 e -12 caem no MESMO dia da
/// semana e estouram a meta (insight weekdayOver).
/// Usada por: ProgressRepository.fetchDayLogs.
final List<DayLog> kSeedDayLogs = [
  _seedDay(13, 1850),
  _seedDay(12, 1750, extras: [_extra('brigadeiro'), _extra('cerveja')]),
  _seedDay(10, 1780, skips: 'Lanche da tarde'),
  _seedDay(9, 1700, extras: [_extra('brigadeiro')]),
  _seedDay(8, 1820, skips: 'Lanche da tarde'),
  _seedDay(7, 1600, extras: [_extra('bolo_choco')]),
  _seedDay(5, 1750, extras: [_extra('cerveja'), _extra('brigadeiro')]),
  _seedDay(4, 1690, skips: 'Lanche da tarde'),
  _seedDay(3, 1880),
  _seedDay(2, 1740, skips: 'Lanche da tarde', extras: [_extra('brigadeiro')]),
  _seedDay(1, 1850),
];
