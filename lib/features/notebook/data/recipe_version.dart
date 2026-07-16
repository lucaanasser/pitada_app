// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/recipe_version.dart
// O QUÊ:     Histórico de versões de uma receita (linha do tempo v1 -> v2 -> …).
// USA:       nada (modelos imutáveis puros).
// USADO POR: seed_activity, repository, providers, VersionsScreen,
//            VersionHistoryScreen e RecipeVersionSheet (receitas).
// SPEC:      specs/features/notebook.yaml (data.models.RecipeVersion)
// ─────────────────────────────────────────────────────────────────────────────

/// Um ponto na linha do tempo de versões: rótulo (ex.: 'v2') + o que mudou.
/// Usada por: RecipeVersion (composição) e VersionHistoryScreen.
class VersionStep {
  final String label;
  final String change;

  const VersionStep({
    required this.label,
    required this.change,
  });
}

/// O histórico de versões de uma receita: uma sequência de VersionStep.
/// Usada por: lista de versões e a tela de histórico da receita.
class RecipeVersion {
  final String id;
  final String recipeName;
  final String recipeId;
  final List<VersionStep> timeline;
  final DateTime? date;

  const RecipeVersion({
    required this.id,
    required this.recipeName,
    required this.recipeId,
    this.timeline = const [],
    this.date,
  });
}
