// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/lesson/lesson_body.dart
// O QUÊ:     Monta o corpo do detalhe de uma ficha conforme o kind (técnica,
//            framework, guia): kicker, título, abertura e as seções.
// USA:       theme/*, LessonSectionView, PrincipleQuote, data (Lesson).
// USADO POR: LessonDetailScreen (delega a construção das seções por kind).
// SPEC:      specs/features/notebook.yaml (LessonDetailScreen.layout_por_kind)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/knowledge/lesson.dart';
import '../../../data/models/knowledge/lesson_section.dart';
import 'lesson_section_view.dart';
import 'principle_quote.dart';

/// Rótulo (kicker) da ficha por categoria. Usada por: [lessonBody].
String kickerFor(LessonKind category) {
  switch (category) {
    case LessonKind.technique:
      return 'Técnica';
    case LessonKind.framework:
      return 'Framework';
    case LessonKind.ingredient:
      return 'Ingrediente';
    case LessonKind.flavor:
      return 'Sabor';
    case LessonKind.herb:
      return 'Erva & especiaria';
  }
}

/// Constrói os widgets do detalhe de [lesson] de cima para baixo, por kind.
/// technique -> princípio + pontos-chave + erro comum; framework -> descrição +
/// fórmula/ordem; guide -> lead + N seções livres. Usada por: LessonDetailScreen.
List<Widget> lessonBody(PitadaColors pit, Lesson lesson) {
  final header = <Widget>[
    Text(
      kickerFor(lesson.category).toUpperCase(),
      style: AppType.on(AppType.label, pit.muted),
    ),
    const SizedBox(height: AppSpacing.sm),
    Text(lesson.title, style: AppType.on(AppType.display, pit.text)),
    const SizedBox(height: AppSpacing.lg),
  ];

  switch (lesson.category) {
    case LessonKind.technique:
      return [
        ...header,
        PrincipleQuote(text: lesson.summary),
        ..._sections(lesson.sections),
      ];
    case LessonKind.framework:
      return [
        ...header,
        Text(lesson.summary, style: AppType.on(AppType.body, pit.text2)),
        if (lesson.lead != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(lesson.lead!, style: AppType.on(AppType.tip, AppColors.accent2)),
        ],
        ..._sections(lesson.sections),
      ];
    case LessonKind.ingredient:
    case LessonKind.flavor:
    case LessonKind.herb:
      return [
        ...header,
        if (lesson.lead != null)
          Text(lesson.lead!, style: AppType.on(AppType.quote, pit.text2)),
        ..._sections(lesson.sections),
      ];
  }
}

/// Renderiza cada seção; o callout de técnica leva o rótulo 'Erro comum'.
/// Usada por: [lessonBody].
List<Widget> _sections(List<LessonSection> sections) {
  return [
    for (final section in sections)
      LessonSectionView(
        section: section,
        tipLabel: section.kind == SectionKind.tip ? section.label : 'Dica',
      ),
  ];
}
