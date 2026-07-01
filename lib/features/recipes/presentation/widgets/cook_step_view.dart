// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/cook_step_view.dart
// O QUÊ:     Passo em tela cheia do modo cozinhar: "Passo N de M" + texto grande
//            e arejado + WhyCallout quando o passo tem dica de técnica.
// USA:       core/widgets/why_callout, theme/*, RecipeStep (modelo).
// USADO POR: cook_mode_screen (conteúdo central do passo atual).
// SPEC:      specs/features/recipes.yaml (CookModeScreen: CookStepView)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/why_callout.dart';
import '../../data/recipe_step.dart';

/// Mostra um passo isolado, com folga generosa. [index] é base 0; [total] o nº de passos.
/// Usada por: cook_mode_screen.
class CookStepView extends StatelessWidget {
  const CookStepView({
    super.key,
    required this.step,
    required this.index,
    required this.total,
  });

  final RecipeStep step;
  final int index;
  final int total;

  /// Monta rótulo + texto grande + callout opcional. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xxxl,
        AppSpacing.gutter,
        AppSpacing.xxxl,
      ),
      children: [
        Text(
          'Passo ${index + 1} de $total'.toUpperCase(),
          style: AppType.on(AppType.label, AppColors.accent),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(step.text,
            style: AppType.on(AppType.title, AppColors.text)
                .copyWith(height: 1.4)),
        if (step.tip != null) ...[
          const SizedBox(height: AppSpacing.xl),
          WhyCallout(text: step.tip!),
        ],
      ],
    );
  }
}
