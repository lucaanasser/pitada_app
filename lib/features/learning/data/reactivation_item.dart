// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/reactivation_item.dart
// O QUÊ:     Item de reativação do hub ("Para hoje"): cozinha pendente, refazer
//            esquecido ou revisão do dia. Puxa o usuário de volta ao Caderno.
// USA:       nada (modelo imutável puro, derivado dos outros modelos).
// USADO POR: caderno_providers (montagem), ReactivationCard (render no hub).
// ─────────────────────────────────────────────────────────────────────────────

/// O gatilho que gerou o card (define a ação primária no widget).
enum ReactivationKind { cook, redo, review }

/// Um card de reativação: kicker versalete + título + corpo curto + ação.
/// [kind] == cook abre o diário rápido pré-preenchido com [title];
/// os demais navegam para [actionRoute]. Usada por: ReactivationCard.
class ReactivationItem {
  final String id;
  final ReactivationKind kind;
  final String kicker;
  final String title;
  final String body;
  final String hero;
  final String actionLabel;
  final String? actionRoute;
  final String? trailing;

  const ReactivationItem({
    required this.id,
    required this.kind,
    required this.kicker,
    required this.title,
    required this.body,
    required this.hero,
    required this.actionLabel,
    this.actionRoute,
    this.trailing,
  });
}
