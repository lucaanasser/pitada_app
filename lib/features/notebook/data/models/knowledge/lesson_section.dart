// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/models/knowledge/lesson_section.dart
// O QUÊ:     Bloco de conteúdo de uma Lesson (ficha). Renderizado conforme o kind.
// USA:       nada (modelo imutável puro).
// USADO POR: lesson.dart, os seeds de fichas, LessonBody e LessonSectionView
//            (presentation).
// SPEC:      specs/features/notebook.yaml (data.models.LessonSection)
// ─────────────────────────────────────────────────────────────────────────────

/// Tipo de renderização de uma seção de ficha.
/// text = parágrafo; pairs = chips; keys = lista numerada; tip = callout "Dica".
/// Usada por: LessonSection e a camada de apresentação para escolher o layout.
enum SectionKind { text, pairs, keys, tip }

/// Uma seção de ficha: rótulo + tipo + corpo (linhas). Cada linha de `body`
/// vira um item (parágrafo, chip, ponto-chave etc.) conforme o `kind`.
/// Usada por: Lesson (composição) e LessonDetailScreen.
class LessonSection {
  final String label;
  final SectionKind kind;
  final List<String> body;

  const LessonSection({
    required this.label,
    this.kind = SectionKind.text,
    this.body = const [],
  });
}
