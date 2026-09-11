// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/macro_lines_view.dart
// O QUÊ:     Forma COLAPSADA do resumo do dia: 4 barras horizontais finas (uma
//            por macro, mesma ordem/cor do anel) — rótulo curto + FuelBar +
//            'valor / meta'. Aparece no cabeçalho quando o corpo do Plano rola,
//            pra acompanhar as metas sem roubar altura das refeições.
// USA:       theme/*, utils/format, FuelBar, MacroRing.
// USADO POR: plans_screen (troca com DaySummaryView via AnimatedCrossFade no scroll).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MacroLinesView)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../../../core/widgets/cards/fuel_bar.dart';
import 'macro_ring_painter.dart';

/// Resumo compacto do dia como linhas de macro (Cal/Prot/Carb/Gord). [rings]
/// são os mesmos 4 macros do anel (dayMacroRings). Usada por: plans_screen.
class MacroLinesView extends StatelessWidget {
  const MacroLinesView({super.key, required this.rings});

  final List<MacroRing> rings;

  /// Monta as linhas de macro na mesma ordem do anel. Usada por: plans_screen.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < rings.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          _line(context, rings[i]),
        ],
      ],
    );
  }

  /// Uma linha de macro: rótulo curto + barra fina (cor do macro) + 'valor / meta'
  /// (kcal sem unidade, macros em 'g'). Usada por: [build].
  Widget _line(BuildContext context, MacroRing ring) {
    final pit = context.pit;
    final goal =
        ring.unit == 'kcal' ? formatKcal(ring.goal) : formatMacro(ring.goal);
    return Row(
      children: [
        SizedBox(
          width: 44,
          child: Text(
            ring.shortLabel,
            style: AppType.on(AppType.caption, pit.text2),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: FuelBar(progress: ring.fraction, color: ring.color)),
        const SizedBox(width: AppSpacing.md),
        SizedBox(
          width: 84,
          child: Text(
            '${formatKcal(ring.value)} / $goal',
            textAlign: TextAlign.right,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: AppType.on(AppType.captionSm, pit.muted),
          ),
        ),
      ],
    );
  }
}
