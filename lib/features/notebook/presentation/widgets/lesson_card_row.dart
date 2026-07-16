// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/lesson_card_row.dart
// O QUÊ:     Linha de ficha na lista de Fichas: título + chevron + resumo;
//            framework mostra também a fórmula (lead).
// USA:       core/widgets (HairlineRow), theme/*, data/lesson.dart.
// USADO POR: LessonCardsScreen (lista de fichas por categoria).
// SPEC:      specs/features/notebook.yaml (screens.LessonCardsScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../data/lesson.dart';

/// Uma linha de ficha (enciclopédia): [lesson.title] em serifa, resumo abaixo e,
/// para frameworks, a fórmula (lead) em destaque. Usada por: LessonCardsScreen.
class LessonCardRow extends StatelessWidget {
  const LessonCardRow({
    super.key,
    required this.lesson,
    required this.onTap,
    this.showDivider = true,
  });

  final Lesson lesson;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final isFramework = lesson.category == LessonKind.framework;
    return HairlineRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      showDivider: showDivider,
      onTap: onTap,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              lesson.title,
              style: AppType.on(AppType.title, pit.text),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(AppIcons.chevron, size: 20, color: pit.faint),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.summary,
            style: AppType.on(AppType.bodySm, pit.text2),
          ),
          if (isFramework && lesson.lead != null) ...[
            const SizedBox(height: AppSpacing.xs + 2),
            Text(
              lesson.lead!,
              style: AppType.on(AppType.tip, AppColors.accent2),
            ),
          ],
        ],
      ),
    );
  }
}
