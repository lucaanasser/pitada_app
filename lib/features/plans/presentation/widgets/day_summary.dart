// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_summary.dart
// O QUÊ:     Resumo do plano (SEM caixa): total grande, status, FuelBar e macros.
// USA:       theme/*, core/widgets/fuel_bar, utils/format, plans_providers.
// USADO POR: plans_screen (logo abaixo do cabeçalho do plano).
// SPEC:      specs/features/plans.yaml (DaySummary)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/fuel_bar.dart';
import '../../application/plans_providers.dart';

/// Resumo nutricional do plano: total/meta, status, barra e legenda de macros.
/// Sem caixa/borda — só o plano (refeições) fica em cartões. É lista, não log.
/// [goalKcal] é a meta diária do plano; [totals] são as opções escolhidas.
/// Usada por: plans_screen.
class DaySummary extends StatelessWidget {
  const DaySummary({super.key, required this.goalKcal, required this.totals});

  final int goalKcal;
  final DayTotals totals;

  /// Monta o resumo (total + status + barra + macros). Usada por: plans_screen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final over = totals.kcal > goalKcal;
    final diff = (goalKcal - totals.kcal).abs();
    final status = over
        ? 'Acima da meta · $diff kcal a mais'
        : 'Dentro da meta · sobram $diff kcal';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${formatKcal(totals.kcal)} / ${formatKcal(goalKcal)} kcal',
          style: AppType.on(AppType.displayXl, pit.text),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          status,
          style: AppType.on(
            AppType.caption,
            over ? AppColors.accent2 : AppColors.sage,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        FuelBar(
          progress: goalKcal == 0 ? 0 : totals.kcal / goalKcal,
          over: over,
        ),
        const SizedBox(height: AppSpacing.lg),
        _macros(pit),
      ],
    );
  }

  /// Linha de macros com bolinhas coloridas (Prot/Carb/Gord). Usada por: [build].
  Widget _macros(PitadaColors pit) {
    return Row(
      children: [
        _macro(pit, AppColors.terra, 'Prot', totals.protein),
        const SizedBox(width: AppSpacing.xl),
        _macro(pit, AppColors.ochre, 'Carb', totals.carb),
        const SizedBox(width: AppSpacing.xl),
        _macro(pit, AppColors.teal, 'Gord', totals.fat),
      ],
    );
  }

  /// Uma bolinha + rótulo + valor em gramas de um macro. Usada por: [_macros].
  Widget _macro(PitadaColors pit, Color dot, String label, num grams) {
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
          style: AppType.on(AppType.caption, pit.text2),
        ),
      ],
    );
  }
}
