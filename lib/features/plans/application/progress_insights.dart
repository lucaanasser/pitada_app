// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/progress_insights.dart
// O QUÊ:     Motor de "Padrões" do Progresso: lê os dias logados (janela de 14
//            dias) e devolve até 3 insights acionáveis (refeição mais pulada,
//            extra mais frequente, origem das kcal extras, dia que estoura).
// USA:       day_log.dart, food_item.dart, day_log_providers, plans_providers,
//            progress_providers (foods), riverpod. Sem Flutter: a UI mapeia
//            InsightKind -> ícone.
// USADO POR: InsightsSection (via progressInsightsProvider).
// SPEC:      specs/features/plans_progress.yaml (application.insights)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/day_log.dart';
import '../data/models/food_item.dart';
import 'day_log_providers.dart';
import 'plans_providers.dart';
import 'progress_providers.dart';

/// Tipo de padrão detectado — a UI escolhe o ícone por aqui. Usada por: InsightsSection.
enum InsightKind { skippedMeal, frequentExtra, extrasSource, weekdayOver }

/// Um padrão lido dos registros: título com o fato (e o número) + leitura
/// acionável, sem julgamento. Imutável. Usada por: InsightsSection.
class ProgressInsight {
  final InsightKind kind;
  final String title;
  final String detail;

  const ProgressInsight({
    required this.kind,
    required this.title,
    required this.detail,
  });
}

/// Mínimo de dias logados na janela para os padrões terem chão estatístico.
const int _kMinLoggedDays = 5;

/// Até 3 padrões dos últimos 14 dias, em ordem de prioridade. Lista vazia
/// enquanto há poucos dias logados (a seção some). Usada por: InsightsSection.
final progressInsightsProvider = Provider<List<ProgressInsight>>((ref) {
  final logs = ref.watch(dayLogControllerProvider);
  final goal = ref.watch(planControllerProvider).dailyKcalGoal;
  final foods = ref.watch(foodsProvider);
  return buildInsights(logs, goal, foods, DateTime.now());
});

/// Monta os insights (função pura, testável). A ordem das regras é a
/// prioridade de exibição. Usada por: [progressInsightsProvider].
List<ProgressInsight> buildInsights(
  List<DayLog> logs,
  int goal,
  List<FoodItem> foods,
  DateTime now,
) {
  final today = DateTime(now.year, now.month, now.day);
  final start = today.subtract(const Duration(days: 13));
  final window = [
    for (final d in logs)
      if (!_day(d.date).isBefore(start) && !_day(d.date).isAfter(today)) d,
  ];
  if (window.length < _kMinLoggedDays) return const [];
  final found = [
    _skippedMeal(window),
    _frequentExtra(window),
    _extrasSource(window, foods),
    _weekdayOver(window, goal),
  ];
  return [
    for (final i in found)
      if (i != null) i
  ].take(3).toList();
}

/// Refeição pulada >= 3x na janela (a campeã). Pular sempre = plano desonesto.
/// Usada por: [buildInsights].
ProgressInsight? _skippedMeal(List<DayLog> window) {
  final counts = <String, int>{};
  for (final d in window) {
    for (final m in d.meals) {
      if (m.skipped) counts[m.mealName] = (counts[m.mealName] ?? 0) + 1;
    }
  }
  final top = _top(counts);
  if (top == null || top.value < 3) return null;
  return ProgressInsight(
    kind: InsightKind.skippedMeal,
    title: 'Você pulou “${top.key}” ${top.value}x em 2 semanas',
    detail: 'Se virou rotina, talvez o plano fique melhor sem essa refeição — '
        'ou com uma opção mais leve nela.',
  );
}

/// Mesmo extra (por nome) >= 3x na janela. Hábito merece lugar no cardápio.
/// Usada por: [buildInsights].
ProgressInsight? _frequentExtra(List<DayLog> window) {
  final counts = <String, int>{};
  final kcals = <String, int>{};
  for (final d in window) {
    for (final e in d.extras) {
      counts[e.name] = (counts[e.name] ?? 0) + 1;
      kcals[e.name] = (kcals[e.name] ?? 0) + e.kcal;
    }
  }
  final top = _top(counts);
  if (top == null || top.value < 3) return null;
  final avg = (kcals[top.key]! / top.value).round();
  return ProgressInsight(
    kind: InsightKind.frequentExtra,
    title: '${top.key} entrou ${top.value}x fora do plano',
    detail: '≈$avg kcal por vez. Se é hábito, vale dar um lugar a ele no '
        'cardápio — dentro do plano ele para de pesar como deslize.',
  );
}

/// Nome de exibição (minúsculo, pt-BR) de cada categoria do dataset de comidas.
/// Usada por: [_extrasSource].
const _kCategoryNames = {
  'doce': 'doces',
  'salgado': 'salgados',
  'bebida': 'bebidas',
  'alcool': 'álcool',
  'fastfood': 'fast food',
  'fruta': 'frutas',
  'lanche': 'lanches',
  'prato': 'pratos',
};

/// Uma categoria concentra >= 50% de um volume relevante (>= 600 kcal) de
/// extras. Saber a fonte é meio caminho. Usada por: [buildInsights].
ProgressInsight? _extrasSource(List<DayLog> window, List<FoodItem> foods) {
  final catOf = {for (final f in foods) f.id: f.category};
  final byCat = <String, int>{};
  var total = 0;
  for (final d in window) {
    for (final e in d.extras) {
      final cat = catOf[e.foodId] ?? 'outros';
      byCat[cat] = (byCat[cat] ?? 0) + e.kcal;
      total += e.kcal;
    }
  }
  final top = _top(byCat);
  if (total < 600 || top == null || top.key == 'outros') return null;
  final share = top.value / total;
  if (share < 0.5) return null;
  final name = _kCategoryNames[top.key] ?? top.key;
  return ProgressInsight(
    kind: InsightKind.extrasSource,
    title: '${(share * 100).round()}% das kcal fora do plano vêm de $name',
    detail: '≈$total kcal em 2 semanas. Se fizer sentido, reserve um espaço '
        'planejado para isso no cardápio.',
  );
}

/// Plural pt-BR dos dias da semana (DateTime.weekday 1..7). Usada por: [_weekdayOver].
const _kWeekdaysPlural = [
  'Segundas',
  'Terças',
  'Quartas',
  'Quintas',
  'Sextas',
  'Sábados',
  'Domingos',
];

/// Um dia da semana estourou a meta >= 2x E na maioria dos seus registros.
/// Usada por: [buildInsights].
ProgressInsight? _weekdayOver(List<DayLog> window, int goal) {
  final logged = <int, int>{};
  final over = <int, int>{};
  for (final d in window) {
    final wd = d.date.weekday;
    logged[wd] = (logged[wd] ?? 0) + 1;
    if (d.kcal > goal) over[wd] = (over[wd] ?? 0) + 1;
  }
  final top = _top(over);
  if (top == null || top.value < 2) return null;
  final m = logged[top.key]!;
  if (top.value * 2 <= m) return null;
  return ProgressInsight(
    kind: InsightKind.weekdayOver,
    title: '${_kWeekdaysPlural[top.key - 1]} costumam passar da meta',
    detail: 'Passou da meta em ${top.value} dos $m registros nesse dia. '
        'Vale já deixar planejado o que comer nele.',
  );
}

/// Entrada de maior valor de um mapa de contagens (null se vazio).
/// Usada por: as regras acima.
MapEntry<K, int>? _top<K>(Map<K, int> counts) {
  MapEntry<K, int>? top;
  for (final e in counts.entries) {
    if (top == null || e.value > top.value) top = e;
  }
  return top;
}

/// Normaliza uma data para o dia (zera a hora). Usada por: [buildInsights].
DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
