// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/models/activity/diary_entry.dart
// O QUÊ:     Entrada do diário de cozinha — registro após cozinhar uma receita.
// USA:       nada (modelo imutável puro).
// USADO POR: activity_seed, repository, providers, DiaryScreen, DiaryEntryScreen,
//            DiaryRow.
// SPEC:      specs/features/notebook.yaml (data.models.DiaryEntry)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma entrada de diário: o que você mudou/aprendeu ao cozinhar uma receita.
/// `label` é o veredito curto (ex.: 'Refazer'/'Ajustar'); `body` é a reflexão.
/// Usada por: lista do diário e a tela de detalhe da entrada.
class DiaryEntry {
  final String id;
  final String recipeName;
  final DateTime date;
  final String label;
  final String body;
  final List<String> recipeIds;

  const DiaryEntry({
    required this.id,
    required this.recipeName,
    required this.date,
    this.label = '',
    this.body = '',
    this.recipeIds = const [],
  });
}
