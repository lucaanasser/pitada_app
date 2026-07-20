// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/food/estimate_result_view.dart
// O QUÊ:     Modo resultado do sheet de estimativa: nome/porção, kcal grande
//            (ou campo de ajuste), macros aproximados e ações
//            (ajustar/adicionar/refazer).
// USA:       theme/*, PitadaButton, EstimateFieldView, data (day_log:
//            ExtraEntry).
// USADO POR: estimate_food_sheet (quando já há resultado).
// SPEC:      specs/features/plans_progress.yaml (sheets: showEstimateFoodSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../data/models/day_log.dart';
import 'estimate_field_view.dart';

/// Estimativa pronta: kcal (ou campo de ajuste via [kcalController]) + ações.
/// Usada por: EstimateFoodSheet.
class EstimateResultView extends StatelessWidget {
  const EstimateResultView({
    super.key,
    required this.result,
    required this.adjusting,
    required this.kcalController,
    required this.onToggleAdjust,
    required this.onAdd,
    required this.onReset,
  });

  final ExtraEntry result;
  final bool adjusting;
  final TextEditingController kcalController;
  final VoidCallback onToggleAdjust;
  final VoidCallback onAdd;
  final VoidCallback onReset;

  /// Monta a estimativa + botões de ajustar/adicionar/refazer. Usada por: o sheet.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(result.name, style: AppType.on(AppType.titleSm, pit.text)),
        if (result.portion.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              result.portion,
              style: AppType.on(AppType.caption, pit.muted),
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        if (adjusting)
          EstimateFieldView(
            controller: kcalController,
            hint: 'kcal',
            numeric: true,
            suffixText: 'kcal',
          )
        else
          Text(
            '${result.kcal} kcal',
            style: AppType.on(AppType.displayXl, pit.text),
          ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Aprox. P ${_g(result.protein)} · C ${_g(result.carb)} · G ${_g(result.fat)}',
          style: AppType.on(AppType.caption, pit.text2),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: PitadaButton(
                label: adjusting ? 'Pronto' : 'Ajustar',
                variant: PitadaButtonVariant.outline,
                onPressed: onToggleAdjust,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PitadaButton(label: 'Adicionar', onPressed: onAdd)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: GestureDetector(
            onTap: onReset,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                'Descrever outra coisa',
                style: AppType.on(AppType.caption, AppColors.accent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Formata gramas curtinho p/ a legenda de macros. Usada por: [build].
  String _g(num n) => '${n.round()} g';
}
