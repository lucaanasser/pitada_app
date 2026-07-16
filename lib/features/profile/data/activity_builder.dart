// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/activity_builder.dart
// O QUÊ:     Constrói a grade de atividade (22 semanas ancoradas no calendário
//            real) a partir dos registros REAIS por dia, completando o passado
//            pré-registro com um padrão determinístico de exemplo.
// USA:       activity_day.dart, activity_entry.dart (função pura, sem estado).
// USADO POR: overview_providers (activityProvider).
// SPEC:      specs/features/profile.yaml (data.builder)
// ─────────────────────────────────────────────────────────────────────────────
import 'activity_day.dart';
import 'activity_entry.dart';

/// Quantas semanas o gráfico de atividade cobre (~1 semestre).
/// Usada por: buildActivityDays.
const int kActivityWeeks = 22;

/// Monta as 22 semanas de células ancoradas em [today]: a última coluna é a
/// semana ATUAL (dias futuros não geram célula) e as colunas voltam no tempo;
/// dayIndex 0 = segunda. Dias presentes em [realByDate] (chave = meia-noite)
/// carregam seus registros; dias a partir do 1º registro real e sem registros
/// ficam honestamente em 0; dias ANTERIORES ao 1º registro real recebem o
/// preenchimento determinístico de exemplo (sem random) — o semestre não nasce
/// vazio enquanto não há histórico no backend.
/// Usada por: overview_providers.activityProvider.
List<ActivityDay> buildActivityDays(
  DateTime today,
  Map<DateTime, List<ActivityEntry>> realByDate,
) {
  final anchor = DateTime(today.year, today.month, today.day);
  final monday = anchor.subtract(Duration(days: anchor.weekday - 1));
  final start = monday.subtract(const Duration(days: 7 * (kActivityWeeks - 1)));

  DateTime? firstReal;
  for (final d in realByDate.keys) {
    if (firstReal == null || d.isBefore(firstReal)) firstReal = d;
  }

  final days = <ActivityDay>[];
  for (var week = 0; week < kActivityWeeks; week++) {
    for (var day = 0; day < 7; day++) {
      final date = start.add(Duration(days: week * 7 + day));
      if (date.isAfter(anchor)) continue;
      final entries = realByDate[date] ?? const <ActivityEntry>[];
      var intensity = entries.length;
      if (entries.isEmpty && (firstReal == null || date.isBefore(firstReal))) {
        intensity = _fillerIntensity(week, day);
      }
      days.add(
        ActivityDay(
          date: date,
          weekIndex: week,
          dayIndex: day,
          intensity: intensity,
          entries: entries,
        ),
      );
    }
  }
  return days;
}

/// Padrão esparso de exemplo (estável entre execuções no mesmo dia): alguns
/// dias descansam (0) e os demais variam 1..4 só a partir dos índices.
/// Usada por: [buildActivityDays].
int _fillerIntensity(int week, int day) {
  final seed = week * 7 + day;
  final isRest = (seed * 3 + week) % 5 == 0;
  return isRest ? 0 : 1 + (seed * 7 + day * 3) % 4;
}
