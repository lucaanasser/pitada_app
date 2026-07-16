// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/source_note.dart
// O QUÊ:     Nota de fonte (livro/vídeo/curso/chef) — o que ficou de uma fonte.
// USA:       nada (modelo imutável puro).
// USADO POR: seed_activity, repository, providers, NotesScreen, NoteDetailScreen,
//            NoteRow.
// SPEC:      specs/features/notebook.yaml (data.models.SourceNote)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma nota de fonte: destila o que aprendeu de um livro/vídeo/curso/chef e
/// liga aos aprendizados (`takeaways`) e às receitas que aplica (`recipeIds`).
/// Usada por: lista de notas e a tela de detalhe da nota.
class SourceNote {
  final String id;
  final String title;
  final String kind;
  final String meta;
  final List<String> takeaways;
  final List<String> recipeIds;
  final DateTime? date;

  const SourceNote({
    required this.id,
    required this.title,
    required this.kind,
    this.meta = '',
    this.takeaways = const [],
    this.recipeIds = const [],
    this.date,
  });
}
