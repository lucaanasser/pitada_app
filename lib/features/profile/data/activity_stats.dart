// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/activity_stats.dart
// O QUÊ:     Estatísticas derivadas da lista de atividade (dias ativos, melhor
//            sequência, sequência atual) — função pura, sem estado.
// USA:       activity_day.dart (modelo).
// USADO POR: ActivityGraph (linha de stats) e ProfileHeader (tag de sequência).
// SPEC:      specs/features/profile.yaml (models.ActivityStats)
// ─────────────────────────────────────────────────────────────────────────────
import 'activity_day.dart';

/// Números derivados do gráfico de atividade. Classe pura imutável.
/// Usada por: ActivityGraph ("X dias ativos · recorde N") e ProfileHeader
/// (PitadaTag "currentStreak dias seguidos").
class ActivityStats {
  final int activeDays; // dias com pelo menos 1 registro
  final int bestStreak; // maior sequência de dias consecutivos ativos
  final int currentStreak; // sequência que termina hoje (tolera hoje vazio)
  final int totalDays; // total de células geradas (denominador)

  const ActivityStats({
    required this.activeDays,
    required this.bestStreak,
    required this.currentStreak,
    required this.totalDays,
  });
}

/// Calcula dias ativos, melhor sequência e sequência atual a partir das células.
/// Assume a lista em ordem cronológica (como o seed/repositório entregam).
/// A sequência atual anda de trás pra frente e tolera SÓ a última célula
/// (hoje) sem registro — o dia ainda não acabou, a sequência não quebrou.
/// Usada por: ActivityGraph e ProfileHeader.
ActivityStats computeActivityStats(List<ActivityDay> days) {
  var active = 0;
  var best = 0;
  var run = 0;
  for (final d in days) {
    if (d.intensity > 0) {
      active++;
      run++;
      if (run > best) best = run;
    } else {
      run = 0;
    }
  }

  var current = 0;
  var i = days.length - 1;
  if (i >= 0 && days[i].intensity <= 0) i--; // hoje ainda sem registro: tolera
  while (i >= 0 && days[i].intensity > 0) {
    current++;
    i--;
  }

  return ActivityStats(
    activeDays: active,
    bestStreak: best,
    currentStreak: current,
    totalDays: days.length,
  );
}
