// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/models/activity_stats.dart
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
  final int activeDays;
  final int bestStreak;
  final int currentStreak;
  final int totalDays;

  const ActivityStats({
    required this.activeDays,
    required this.bestStreak,
    required this.currentStreak,
    required this.totalDays,
  });
}

/// Calcula dias ativos, melhor sequência e sequência atual a partir das células.
/// A sequência atual tolera a última célula (hoje) sem registro sem quebrar.
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
  if (i >= 0 && days[i].intensity <= 0) i--;
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
