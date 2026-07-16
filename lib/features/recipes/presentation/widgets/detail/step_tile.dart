// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/step_tile.dart
// O QUÊ:     Passo do preparo com número em "bolinha" terracota + WhyCallout opcional.
// USA:       core/theme (AppColors, PitadaColors), core/widgets/why_callout, RecipeStep.
// USADO POR: recipe_detail_screen (e servirá ao cook_mode).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: StepTile)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/editable.dart';
import '../../../../../core/widgets/cards/why_callout.dart';
import '../../../data/models/recipe_step.dart';

/// Um passo: bolinha numerada terracota + texto + dica de técnica (se houver).
/// Editável por gesto ([onEdit]): segurar/duplo-clique abre a edição do passo.
/// Usada por: recipe_detail_screen.
class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.number,
    required this.step,
    this.showDivider = true,
    this.onEdit,
  });

  final int number;
  final RecipeStep step;
  final bool showDivider;
  final VoidCallback? onEdit;

  /// Monta a bolinha + texto + WhyCallout opcional, com filete. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Editable(
      onEdit: onEdit,
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: pit.line, width: AppSpacing.hair),
                ),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _circle(pit),
            const SizedBox(width: AppSpacing.md + 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.text,
                    style: AppType.on(AppType.body, pit.text2)
                        .copyWith(height: 1.55),
                  ),
                  if (step.tip != null) WhyCallout(text: step.tip!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A "bolinha" do número: círculo terracota com borda e número claro. Usada por: [build].
  Widget _circle(PitadaColors pit) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Text(
        '$number',
        style: AppType.on(AppType.numeralSm, AppColors.onAccent)
            .copyWith(fontSize: 15, height: 1.0),
      ),
    );
  }
}
