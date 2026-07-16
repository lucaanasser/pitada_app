// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/models/weight_entry.dart
// O QUÊ:     Modelo de uma pesagem: data + peso em kg. Base do gráfico de peso.
// USA:       nada (modelo imutável puro).
// USADO POR: progress_seed, progress_repository, progress_providers, WeightChart.
// SPEC:      specs/features/plans_progress.yaml (data.models: WeightEntry)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma pesagem do usuário (peso corporal num dia). Imutável.
/// A recomendação é registrar 1x por semana, de manhã e no mesmo horário.
/// Usada por: WeightController (histórico), weightStatsProvider, WeightChart.
class WeightEntry {
  final DateTime date;
  final double kg;

  const WeightEntry({required this.date, required this.kg});
}
