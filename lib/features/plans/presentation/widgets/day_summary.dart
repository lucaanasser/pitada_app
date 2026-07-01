// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_summary.dart
// O QUÊ:     Cartão de resumo do dia: total grande, status, FuelBar e macros.
// USA:       theme/*, core/widgets/fuel_bar, utils/format, plans_providers.
// USADO POR: plans_screen (logo abaixo do cabeçalho do plano).
// SPEC:      specs/features/plans.yaml (DaySummaryCard)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/fuel_bar.dart';
import '../../application/plans_providers.dart';

/// Resumo nutricional do dia: total/meta, status, barra e legenda de macros.
/// [goalKcal] é a meta diária do plano; [totals] são as opções escolhidas.
/// Usada por: plans_screen.
class DaySummaryCard extends StatelessWidget {
  const DaySummaryCard(
      {super.key, required this.goalKcal, required this.totals});

  final int goalKcal;
  final DayTotals totals;

  /// Monta o cartão inteiro (total + status + barra + macros). Usada por: plans_screen.
  @override
  Widget build(BuildContext context) {
    final over = totals.kcal > goalKcal;
    final diff = (goalKcal - totals.kcal).abs();
    final status = over
        ? 'Acima da meta · $diff kcal a mais'
        : 'Dentro da meta · sobram $diff kcal';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${formatKcal(totals.kcal)} / ${formatKcal(goalKcal)} kcal hoje',
            style: AppType.displayXl,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            status,
            style: AppType.on(
                AppType.caption, over ? AppColors.accent2 : AppColors.sage),
          ),
          const SizedBox(height: AppSpacing.md),
          FuelBar(
              progress: goalKcal == 0 ? 0 : totals.kcal / goalKcal, over: over),
          const SizedBox(height: AppSpacing.lg),
          _macros(),
        ],
      ),
    );
  }

  /// Linha de macros com bolinhas coloridas (Prot/Carb/Gord). Usada por: [build].
  Widget _macros() {
    return Row(
      children: [
        _macro(AppColors.terra, 'Prot', totals.protein),
        const SizedBox(width: AppSpacing.xl),
        _macro(AppColors.ochre, 'Carb', totals.carb),
        const SizedBox(width: AppSpacing.xl),
        _macro(AppColors.teal, 'Gord', totals.fat),
      ],
    );
  }

  /// Uma bolinha + rótulo + valor em gramas de um macro. Usada por: [_macros].
  Widget _macro(Color dot, String label, num grams) {
    return Row(
      children: [
        Container(
          width: AppSpacing.sm,
          height: AppSpacing.sm,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$label ${formatMacro(grams)}',
          style: AppType.on(AppType.caption, AppColors.text2),
        ),
      ],
    );
  }
}
