// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/step_tile.dart
// O QUÊ:     Passo numerado do modo de preparo, com WhyCallout opcional.
// USA:       core/widgets/why_callout, theme/*, RecipeStep.
// USADO POR: recipe_detail_screen (e servirá ao cook_mode).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: StepTile)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/why_callout.dart';
import '../../data/recipe_step.dart';

/// Um passo: número em serifa terracota + texto + dica de técnica (se houver).
/// Usada por: recipe_detail_screen.
class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.number,
    required this.step,
    this.showDivider = true,
  });

  final int number;
  final RecipeStep step;
  final bool showDivider;

  /// Monta o número + texto + WhyCallout opcional, com filete. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: AppColors.line, width: AppSpacing.hair),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: AppSpacing.xxxl,
              child: Text('$number', style: AppType.numeralLg)),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.text,
                  style: AppType.on(AppType.body, AppColors.text2)
                      .copyWith(height: 1.55),
                ),
                if (step.tip != null) WhyCallout(text: step.tip!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
