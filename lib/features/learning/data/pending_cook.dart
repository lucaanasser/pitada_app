// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/pending_cook.dart
// O QUÊ:     Cozinha pendente de registro — receita cozida sem entrada de diário.
//            Alimenta o card "Ontem você cozinhou" do hub do Caderno.
// USA:       nada (modelo imutável puro).
// USADO POR: learning_seed_activity, learning_repository, caderno_providers.
// ─────────────────────────────────────────────────────────────────────────────

/// Uma cozinha ainda não registrada no diário: receita + quando aconteceu.
/// Usada por: card de reativação do hub (abre o diário pré-preenchido).
class PendingCook {
  final String recipeId;
  final String recipeName;
  final DateTime when;

  const PendingCook({
    required this.recipeId,
    required this.recipeName,
    required this.when,
  });
}
