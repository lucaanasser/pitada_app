// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/models/radar_item.dart
// O QUÊ:     Modelo de uma pendência acionável do radar do perfil (cozinha sem
//            registro, item vencendo/acabando na despensa, refazer pendente).
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: overview_providers (monta a lista) e KitchenRadar (exibe as linhas).
// SPEC:      specs/features/profile.yaml (models.RadarItem)
// ─────────────────────────────────────────────────────────────────────────────

/// Tipo da pendência — define ícone e tag da linha no KitchenRadar.
enum RadarKind { cook, expiry, low, redo }

/// Uma pendência do radar: o quê, detalhe opcional e para onde o toque navega.
/// [expiresOn] alimenta a ExpiryTag quando [kind] é expiry. [push] separa rota
/// full-screen (push, volta cai no Perfil) de troca de aba (go).
/// Usada por: KitchenRadar (via kitchenRadarProvider).
class RadarItem {
  final RadarKind kind;
  final String title;
  final String? detail;
  final DateTime? expiresOn;
  final String route;
  final bool push;

  const RadarItem({
    required this.kind,
    required this.title,
    required this.route,
    this.detail,
    this.expiresOn,
    this.push = false,
  });
}
