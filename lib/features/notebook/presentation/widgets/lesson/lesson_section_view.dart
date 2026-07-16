// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/lesson/lesson_section_view.dart
// O QUÊ:     Renderiza uma LessonSection conforme o kind (text/pairs/keys/tip).
//            Usada pelos guias e para reaproveitar os pontos-chave.
// USA:       core/widgets (SectionHeader, PitadaChip, WhyCallout), theme/*,
//            KeyPoint (lista numerada), data (LessonSection).
// USADO POR: LessonDetailScreen (guias) e as seções das técnicas/frameworks.
// SPEC:      specs/features/notebook.yaml (LessonSection.render)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_chip.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../../../core/widgets/cards/why_callout.dart';
import '../../../data/models/knowledge/lesson_section.dart';
import 'key_point.dart';

/// Renderiza uma [section] com seu cabeçalho e o corpo conforme o [SectionKind].
/// [tipLabel] troca o rótulo do callout (ex.: 'Erro comum', 'Dica').
/// Usada por: LessonDetailScreen (guias e blocos reutilizados).
class LessonSectionView extends StatelessWidget {
  const LessonSectionView({
    super.key,
    required this.section,
    this.topGap = AppSpacing.xxxl,
    this.tipLabel = 'Dica',
  });

  final LessonSection section;
  final double topGap;
  final String tipLabel;

  @override
  Widget build(BuildContext context) {
    if (section.kind == SectionKind.tip) {
      return Padding(
        padding: EdgeInsets.only(top: topGap),
        child: WhyCallout(
          text: section.body.isEmpty ? '' : section.body.first,
          label: tipLabel,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: section.label, topGap: topGap),
        _body(context.pit),
      ],
    );
  }

  /// Corpo da seção segundo o kind: parágrafo, chips ou lista numerada.
  /// Usada por: [build].
  Widget _body(PitadaColors pit) {
    switch (section.kind) {
      case SectionKind.pairs:
        return Wrap(
          spacing: AppSpacing.sm + 1,
          runSpacing: AppSpacing.sm + 1,
          children: [
            for (final item in section.body) PitadaChip(label: item),
          ],
        );
      case SectionKind.keys:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < section.body.length; i++)
              KeyPoint(number: i + 1, text: section.body[i]),
          ],
        );
      case SectionKind.text:
      case SectionKind.tip:
        return Text(
          section.body.isEmpty ? '' : section.body.first,
          style: AppType.on(AppType.body, pit.text),
        );
    }
  }
}
