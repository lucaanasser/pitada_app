// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/day_log_providers.dart
// O QUÊ:     Providers do Progresso ligados ao LOG DO DIA: dias registrados
//            (controller com upsert por data), aderência dos últimos 14 dias,
//            log de hoje e sequência de dias registrando (streak).
// USA:       day_log.dart, progress_repository, plans_providers (meta do plano),
//            riverpod, app_log.
// USADO POR: AdherenceSection, TodaySection, LogDaySheet.
// SPEC:      specs/features/plans_progress.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/models/day_log.dart';
import '../data/repositories/progress_repository.dart';
import 'plans_providers.dart';
import 'progress_providers.dart';

/// Quantos dias da faixa de aderência são mostrados (últimas 2 semanas).
const int kAdherenceDays = 14;

/// Aderência de um dia: kcal logada vs meta. `logged=false` => sem registro.
/// `over` marca acima da meta. `ratio` (kcal/meta) dimensiona a barra. Imutável.
/// Usada por: AdherenceSection (barras + resumo).
class DayAdherence {
  final DateTime date;
  final bool logged;
  final int kcal;
  final int goal;

  const DayAdherence({
    required this.date,
    required this.logged,
    this.kcal = 0,
    required this.goal,
  });

  /// Proporção da meta atingida (0 se sem meta). Usada por: altura da barra.
  double get ratio => goal == 0 ? 0 : kcal / goal;

  /// True quando o dia logado passou da meta. Usada por: cor da barra.
  bool get over => logged && kcal > goal;

  /// True quando logado e dentro da meta. Usada por: contagem do resumo.
  bool get within => logged && kcal <= goal;
}

/// Dias registrados (upsert por data) + estado inicial vindo do seed.
/// Usada por: dayLogControllerProvider (StateNotifierProvider).
class DayLogController extends StateNotifier<List<DayLog>> {
  DayLogController(ProgressRepository repository)
      : super(repository.fetchDayLogs());

  /// Salva o log do dia, substituindo um registro existente da mesma data (upsert).
  /// Usada por: LogDaySheet (botão "Salvar dia").
  void saveDay(DayLog log) {
    final kept = [
      for (final d in state)
        if (!_sameDay(d.date, log.date)) d,
    ];
    state = [...kept, log];
    AppLog.i(
      'plans',
      'dia registrado: ${log.date.toIso8601String()} · ${log.kcal} kcal · ${log.skippedCount} puladas',
    );
  }

  /// True se as duas datas caem no mesmo dia (ignora hora). Usada por: saveDay.
  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Controlador dos dias logados. Usada por: AdherenceSection, LogDaySheet.
final dayLogControllerProvider =
    StateNotifierProvider<DayLogController, List<DayLog>>((ref) {
  return DayLogController(ref.watch(progressRepositoryProvider));
});

/// Aderência dos últimos [kAdherenceDays] dias (mais antigo -> hoje), cruzando os
/// dias logados com a meta diária do plano. Usada por: AdherenceSection.
final adherenceProvider = Provider<List<DayAdherence>>((ref) {
  final logs = ref.watch(dayLogControllerProvider);
  final goal = ref.watch(planControllerProvider).dailyKcalGoal;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final byDay = <int, DayLog>{
    for (final d in logs) _key(d.date): d,
  };
  return [
    for (var i = kAdherenceDays - 1; i >= 0; i--)
      _dayAdherence(today.subtract(Duration(days: i)), byDay, goal),
  ];
});

/// Monta a aderência de um dia a partir do índice de logs e da meta. Usada por: [adherenceProvider].
DayAdherence _dayAdherence(DateTime day, Map<int, DayLog> byDay, int goal) {
  final log = byDay[_key(day)];
  return DayAdherence(
    date: day,
    logged: log != null,
    kcal: log?.kcal ?? 0,
    goal: goal,
  );
}

/// Log de HOJE, ou null se o dia ainda não foi registrado.
/// Usada por: TodaySection (estados do card), LogDaySheet (pré-preenchimento).
final todayLogProvider = Provider<DayLog?>((ref) {
  final logs = ref.watch(dayLogControllerProvider);
  final today = _key(DateTime.now());
  for (final d in logs) {
    if (_key(d.date) == today) return d;
  }
  return null;
});

/// Dias consecutivos registrando, contando para trás a partir de hoje (se já
/// registrado) ou de ontem — o dia só "quebra" a sequência quando termina sem log.
/// Usada por: TodaySection (linha de sequência, exibida quando >= 2).
final logStreakProvider = Provider<int>((ref) {
  final logged = {
    for (final d in ref.watch(dayLogControllerProvider)) _key(d.date)
  };
  final now = DateTime.now();
  var day = DateTime(now.year, now.month, now.day);
  if (!logged.contains(_key(day))) day = day.subtract(const Duration(days: 1));
  var streak = 0;
  while (logged.contains(_key(day))) {
    streak++;
    day = day.subtract(const Duration(days: 1));
  }
  return streak;
});

/// Chave inteira de um dia (ignora hora). Usada por: [adherenceProvider],
/// [todayLogProvider], [logStreakProvider].
int _key(DateTime d) => d.year * 10000 + d.month * 100 + d.day;
