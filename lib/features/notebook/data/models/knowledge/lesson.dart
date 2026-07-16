// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/models/knowledge/lesson.dart
// O QUÊ:     Ficha de conhecimento do Caderno (técnica, framework, guia).
// USA:       lesson_section.dart (composição das seções).
// USADO POR: os seeds de fichas, repository, providers e telas de Fichas.
// SPEC:      specs/features/notebook.yaml (data.models.Lesson)
// ─────────────────────────────────────────────────────────────────────────────
import 'lesson_section.dart';

/// Categoria de uma ficha — define a aba/kicker onde ela aparece.
/// technique/framework = capítulos próprios; ingredient/flavor/herb = guias.
/// Usada por: Lesson e selectedLessonCategoryProvider (abas das Fichas).
enum LessonKind { technique, framework, ingredient, flavor, herb }

/// Uma ficha completa. `summary` é o princípio (técnica) ou a descrição
/// (framework); `lead` abre os guias. `sections` traz o conteúdo detalhado.
/// Usada por: LessonCardsScreen (lista) e LessonDetailScreen (detalhe).
class Lesson {
  final String id;
  final LessonKind category;
  final String title;
  final String summary;
  final String? lead;
  final List<LessonSection> sections;

  const Lesson({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    this.lead,
    this.sections = const [],
  });
}
