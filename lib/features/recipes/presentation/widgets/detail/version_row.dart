// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/version_row.dart
// O QUÊ:     Linha do seletor de versões: "V{n}" + chip "atual" + nota "o que
//            mudou"; realçada quando é a versão escolhida.
// USA:       core/theme (AppIcons, AppColors, pit, AppSpacing, AppType),
//            core/widgets/controls/pitada_chip.
// USADO POR: recipe_version_sheet (lista de versões).
// SPEC:      specs/features/recipes.yaml (sheets.RecipeVersionSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_chip.dart';

/// Uma linha do seletor: "V{n}" + chip "atual" + nota; realçada quando escolhida.
/// Usada por: RecipeVersionSheet.
class VersionRow extends StatelessWidget {
  const VersionRow({
    super.key,
    required this.version,
    required this.isCurrent,
    required this.isSelected,
    required this.note,
    required this.onTap,
  });

  final int version;
  final bool isCurrent;
  final bool isSelected;
  final String? note;
  final VoidCallback onTap;

  /// Monta o cartão tocável da versão (rótulo + chip + nota). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentSoft : pit.surf2,
              borderRadius: AppSpacing.br(AppSpacing.radiusLg),
              border: Border.all(
                color: isSelected ? AppColors.accentLine : pit.line,
                width: AppSpacing.borderStrong,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'V$version',
                      style: AppType.on(
                        AppType.numeralSm,
                        isSelected ? AppColors.accent : pit.text,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: AppSpacing.md),
                      const PitadaChip(
                        label: 'atual',
                        variant: PitadaChipVariant.accent,
                      ),
                    ],
                    const Spacer(),
                    if (isSelected)
                      const Icon(
                        AppIcons.check,
                        size: 18,
                        color: AppColors.accent,
                      ),
                  ],
                ),
                if (note != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(note!, style: AppType.on(AppType.bodySm, pit.text2)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
