// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/nutrition_card.dart
// O QUÊ:     Caixa de macros com borda (proteína · gordura · carbo) em 3 células.
//            Inspirada na caixa quadrada da referência. kcal fica no título da tela.
// USA:       theme/pitada_colors, theme/spacing, theme/typography, utils/format.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/components/nutrition_card.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../utils/format.dart';

/// Caixa com borda dividida em três células de macro. Usada por: recipe_detail_screen.
class NutritionCard extends StatelessWidget {
  const NutritionCard({
    super.key,
    required this.protein,
    required this.carb,
    required this.fat,
  });

  final num protein;
  final num carb;
  final num fat;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _cell(pit, 'Proteína', protein, first: true),
            _cell(pit, 'Gordura', fat),
            _cell(pit, 'Carbo', carb),
          ],
        ),
      ),
    );
  }

  /// Uma célula: rótulo em versalete + gramas em Space Grotesk. Usada por: [build].
  Widget _cell(PitadaColors pit, String k, num grams, {bool first = false}) {
    return Expanded(
      child: Container(
        decoration: first
            ? null
            : BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: pit.border,
                    width: AppSpacing.borderStrong,
                  ),
                ),
              ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(k.toUpperCase(), style: AppType.on(AppType.label, pit.muted)),
            const SizedBox(height: AppSpacing.xs + 1),
            Text(
              formatMacro(grams),
              style: AppType.on(AppType.numeral, pit.text),
            ),
          ],
        ),
      ),
    );
  }
}
