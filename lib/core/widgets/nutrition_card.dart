// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/nutrition_card.dart
// O QUÊ:     Cartão de nutrição: kcal grande + macros (proteína/carbo/gordura).
// USA:       theme/*, utils/format (formatKcal, formatMacro).
// USADO POR: recipe_detail_screen.
// SPEC:      specs/components/nutrition_card.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../utils/format.dart';

/// Cartão de nutrição por porção. Usada por: recipe_detail_screen.
class NutritionCard extends StatelessWidget {
  const NutritionCard({
    super.key,
    required this.kcal,
    required this.protein,
    required this.carb,
    required this.fat,
  });

  final int kcal;
  final num protein;
  final num carb;
  final num fat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusXl),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(formatKcal(kcal), style: AppType.display),
              Text(
                'kcal por porção',
                style: AppType.on(AppType.captionSm, AppColors.muted),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(
            child: Column(
              children: [
                _MacroRow(
                    name: 'Proteína', grams: protein, color: AppColors.sage),
                _MacroRow(
                    name: 'Carboidrato', grams: carb, color: AppColors.accent),
                _MacroRow(name: 'Gordura', grams: fat, color: AppColors.ochre),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Uma linha de macro: bolinha colorida + nome + valor em gramas.
/// Usada por: [NutritionCard].
class _MacroRow extends StatelessWidget {
  const _MacroRow(
      {required this.name, required this.grams, required this.color});
  final String name;
  final num grams;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm + 1),
          Expanded(
              child: Text(name,
                  style: AppType.on(AppType.caption, AppColors.text2))),
          Text(
            formatMacro(grams),
            style: AppType.on(AppType.bodySm, AppColors.text)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
