// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/models/activity_day.dart
// O QUÊ:     Modelo de uma célula do gráfico de atividade (um dia REAL estilo
//            GitHub): data + posição na grade + intensidade + registros do dia.
// USA:       activity_entry.dart (os registros do dia).
// USADO POR: activity_builder, activity_stats, profile_providers (seleção) e
//            os widgets ActivityGraph/ActivityGrid.
// SPEC:      specs/features/profile.yaml (models.ActivityDay)
// ─────────────────────────────────────────────────────────────────────────────
import 'activity_entry.dart';

/// Uma célula (dia) do gráfico de atividade da cozinha. Classe pura imutável.
/// [date] é o dia real do calendário; a posição na grade vem de [weekIndex]
/// (coluna) e [dayIndex] (linha 0..6, 0 = segunda). A cor é ÚNICA (estilo
/// GitHub): a intensidade deriva de [intensity] — nº de registros no dia.
/// Dia real carrega os registros em [entries]; dia de preenchimento histórico
/// tem intensity > 0 e entries vazio (a UI o rotula "histórico de exemplo").
/// Usada por: ActivityGrid (pintar/tocar), ActivityGraph (detalhe do dia).
class ActivityDay {
  final DateTime date;
  final int weekIndex;
  final int dayIndex;
  final int intensity;
  final List<ActivityEntry> entries;

  const ActivityDay({
    required this.date,
    required this.weekIndex,
    required this.dayIndex,
    required this.intensity,
    this.entries = const [],
  });
}
