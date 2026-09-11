// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/option_panel.dart
// O QUÊ:     Painel da opção ativa (dentro do MealCard, abaixo das abas): lista de
//            pratos + rodapé (total kcal + encaixe + macros P/C/G). Fundo surf2,
//            borda line2; topo reto p/ conectar com a fita de abas. Sem registrar consumo.
// USA:       theme/*, utils/format, data/meal_option.
// USADO POR: MealCard (via MealOptionTabs).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MealOptionPanel)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../data/models/meal_option.dart';

/// Painel da opção ativa: pratos (nome + kcal + chevron se linkado) e rodapé com o
/// total, o encaixe na meta e a linha de macros. [onTapDish] só dispara em pratos
/// linkados (abre a receita). Usada por: MealCard.
class MealOptionPanel extends StatelessWidget {
  const MealOptionPanel({super.key, required this.option, this.onTapDish});

  final MealOption option;
  final ValueChanged<int>? onTapDish;

  /// Monta o painel (borda, pratos, filete e rodapé). Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: pit.surf2,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(AppSpacing.radiusLg)),
        border: Border.all(color: pit.line2, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < option.items.length; i++) _dish(pit, i),
          const SizedBox(height: AppSpacing.md),
          Container(height: AppSpacing.hair, color: pit.line),
          const SizedBox(height: AppSpacing.md),
          _footer(pit),
        ],
      ),
    );
  }

  /// Um prato: nome + kcal (+ chevron se linkado -> abre a receita). Usada por: [build].
  Widget _dish(PitadaColors pit, int i) {
    final item = option.items[i];
    return GestureDetector(
      onTap: item.linked ? () => onTapDish?.call(i) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm - 2),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: AppType.on(
                  AppType.bodySm,
                  item.linked ? pit.text : pit.text2,
                ),
              ),
            ),
            Text(
              '${formatKcal(item.kcal)} kcal',
              style: AppType.on(AppType.caption, pit.muted),
            ),
            if (item.linked) ...[
              const SizedBox(width: AppSpacing.sm),
              Icon(AppIcons.chevron, size: 15, color: pit.faint),
            ],
          ],
        ),
      ),
    );
  }

  /// Rodapé: total kcal grande + selo de encaixe + linha de macros P/C/G. Usada por: [build].
  Widget _footer(PitadaColors pit) {
    var kcal = 0;
    num protein = 0, carb = 0, fat = 0;
    for (final it in option.items) {
      kcal += it.kcal;
      protein += it.protein;
      carb += it.carb;
      fat += it.fat;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('${formatKcal(kcal)} kcal',
                style: AppType.on(AppType.numeral, pit.text)),
            const Spacer(),
            Text(
              option.fits ? 'Dentro da meta' : '${option.fitLabel} kcal',
              style: AppType.on(
                AppType.caption,
                option.fits ? AppColors.sage : AppColors.accent2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'P ${formatMacro(protein)} · C ${formatMacro(carb)} · G ${formatMacro(fat)}',
          style: AppType.on(AppType.caption, pit.muted),
        ),
      ],
    );
  }
}
