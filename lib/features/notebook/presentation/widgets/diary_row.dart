// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/diary_row.dart
// O QUÊ:     Linha do diário (miniatura + receita + data, tag Refazer/Ajustar à direita).
// USA:       core/widgets (HairlineRow, RecipeThumb), utils/format, theme/*, DiaryEntry.
// USADO POR: DiaryScreen.
// SPEC:      specs/features/notebook.yaml (DiaryScreen: HairlineRow + tag veredito)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/cards/recipe_thumb.dart';
import '../../data/models/activity/diary_entry.dart';

/// Uma entrada de diário como linha de lista, com o veredito à direita.
/// Usada por: DiaryScreen.
class DiaryRow extends StatelessWidget {
  const DiaryRow({
    super.key,
    required this.entry,
    this.onTap,
    this.showDivider = true,
  });

  final DiaryEntry entry;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha: miniatura, receita, data e tag do veredito. Usada por: DiaryScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(color: AppColors.heroOf('moss')),
      title: Text(
        entry.recipeName,
        style: AppType.on(AppType.titleSm, pit.text),
      ),
      subtitle: Text(
        formatDayMonth(entry.date),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: _VerdictTag(label: entry.label),
    );
  }
}

/// Tag do veredito em contorno: 'Refazer' (sage) ou 'Ajustar' (accent2).
/// Usada por: [DiaryRow] e DiaryEntryScreen.
class _VerdictTag extends StatelessWidget {
  const _VerdictTag({required this.label});

  final String label;

  /// Escolhe a cor pelo texto do veredito e desenha a tag. Usada por: [DiaryRow].
  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    final color = label == 'Refazer' ? AppColors.sage : AppColors.accent2;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: color),
      ),
      child: Text(label, style: AppType.on(AppType.caption, color)),
    );
  }
}
