// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/source_note.dart
// O QUÊ:     Nota de fonte (livro/vídeo/curso/chef) — o que ficou de uma fonte.
// USA:       nada (modelo imutável puro).
// USADO POR: learning_seed, learning_repository, NotesScreen, NoteDetailScreen.
// SPEC:      specs/features/learning.yaml (data.models.SourceNote)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma nota de fonte: destila o que aprendeu de um livro/vídeo/curso/chef e
/// liga aos aprendizados (`takeaways`) e às receitas que aplica (`recipeIds`).
/// Usada por: lista de notas e a tela de detalhe da nota.
class SourceNote {
  final String id;
  final String title;
  final String kind; // rótulo livre: 'Livro', 'Vídeo', 'Curso', 'Chef'
  final String meta; // linha de contexto (ex.: autor, canal)
  final List<String> takeaways; // "O que fica" — pontos numerados
  final List<String> recipeIds; // receitas onde a nota se aplica
  final DateTime? date; // quando foi capturada (entra no fio do Caderno)

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
