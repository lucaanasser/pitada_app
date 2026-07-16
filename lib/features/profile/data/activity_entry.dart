// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/activity_entry.dart
// O QUÊ:     Modelo de UM registro dentro de um dia do gráfico de atividade
//            (o que responde "quais registros fiz naquele dia").
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: activity_day (lista do dia), activity_builder, overview_providers
//            (conversão fio -> registro) e ActivityGraph (detalhe do dia).
// SPEC:      specs/features/profile.yaml (models.ActivityEntry)
// ─────────────────────────────────────────────────────────────────────────────

/// Um registro de um dia: tipo legível, título e a rota do detalhe.
/// Vem do fio do Caderno (diário/nota/versão/log) via overview_providers.
/// Usada por: ActivityGraph (lista do dia selecionado, toque navega).
class ActivityEntry {
  final String label;
  final String title;
  final String route;

  const ActivityEntry({
    required this.label,
    required this.title,
    required this.route,
  });
}
