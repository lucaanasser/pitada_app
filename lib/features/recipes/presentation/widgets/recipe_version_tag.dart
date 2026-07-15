// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_version_tag.dart
// O QUÊ:     Marcador "V3" da versão atual ao lado do título da receita — em ACCENT
//            (terracota) + caret, tocável (abre o seletor de versões).
// USA:       core/theme (AppColors, AppType, AppSpacing, AppIcons).
// USADO POR: recipe_detail_screen (linha do título, quando a receita tem versões).
// SPEC:      specs/features/recipes.yaml (feature_widgets.RecipeVersionTag)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Pílula-controle "V{version}" em accent, com caret, que abre o seletor de versão.
/// Não é métrica: identifica QUAL versão está na tela e é o gatilho do seletor.
/// Usada por: RecipeDetailScreen.
class RecipeVersionTag extends StatelessWidget {
  const RecipeVersionTag({
    super.key,
    required this.version,
    required this.onTap,
  });

  final int version;
  final VoidCallback onTap;

  /// Monta a pílula tocável "V{n} ⌄" em terracota. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.br(AppSpacing.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: AppSpacing.br(AppSpacing.radiusSm),
            border: Border.all(
              color: AppColors.accentLine,
              width: AppSpacing.borderStrong,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'V$version',
                style: AppType.on(AppType.numeralSm, AppColors.accent),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(AppIcons.expand, size: 15, color: AppColors.accent),
            ],
          ),
        ),
      ),
    );
  }
}
