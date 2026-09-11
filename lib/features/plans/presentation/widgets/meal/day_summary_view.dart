// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/day_summary_view.dart
// O QUÊ:     Resumo do dia (SEM caixa): anel de macros à ESQUERDA + legenda com
//            valores ('nome' + 'valor / meta') à DIREITA. Tocar (anel ou legenda)
//            seleciona: engrossa o anel e o centro mostra só o número dele.
// USA:       theme/*, utils/format, MacroRing/MacroRingPainter.
// USADO POR: plans_screen (forma EXPANDIDA do resumo, em repouso).
// SPEC:      specs/features/plans/plans.yaml (DaySummaryView)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import 'macro_ring_painter.dart';

/// Resumo nutricional do dia: anel de macros interativo + legenda com valores.
/// [rings] são os 4 macros já montados (dayMacroRings). Usada por: plans_screen.
class DaySummaryView extends StatefulWidget {
  const DaySummaryView({super.key, required this.rings});

  final List<MacroRing> rings;

  @override
  State<DaySummaryView> createState() => _DaySummaryViewState();
}

class _DaySummaryViewState extends State<DaySummaryView> {
  /// Lado máximo do anel — destaque moderado, sem roubar espaço das refeições.
  static const double _maxSide = 170;

  /// Fração da largura reservada ao anel (o resto é legenda).
  static const double _ringF = 0.44;

  /// Anel selecionado: 0 Calorias, 1 Proteína, 2 Carboidratos, 3 Gorduras.
  int _selected = 0;

  /// Seleciona o anel [i] (toque no anel ou na legenda). Usada por: [build].
  void _select(int i) => setState(() => _selected = i);

  /// Monta a linha anel (esquerda) + legenda (direita). Usada por: plans_screen.
  @override
  Widget build(BuildContext context) {
    final rings = widget.rings;
    return LayoutBuilder(
      builder: (context, constraints) {
        final side =
            (constraints.maxWidth * _ringF).clamp(140.0, _maxSide).toDouble();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: side,
              height: side,
              child: _ring(context, rings, side),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < rings.length; i++) ...[
                    if (i > 0) const SizedBox(height: AppSpacing.md),
                    _legendItem(context, rings[i], i),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// O anel pintado + toque de seleção + centro compacto. Usada por: [build].
  Widget _ring(BuildContext context, List<MacroRing> rings, double side) {
    final pit = context.pit;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (d) {
        final i =
            MacroRingPainter.ringAtOffset(d.localPosition, side, rings.length);
        if (i != null) _select(i);
      },
      child: CustomPaint(
        painter: MacroRingPainter(
          rings: rings,
          selected: _selected,
          track: pit.line2,
          trackDim: pit.line,
        ),
        child: Center(child: _center(context, rings[_selected], side)),
      ),
    );
  }

  /// Centro do anel: só o número grande do selecionado + unidade, limitado ao
  /// furo central (nunca vaza sobre os anéis). Usada por: [_ring].
  Widget _center(BuildContext context, MacroRing ring, double side) {
    final pit = context.pit;
    final hole = MacroRingPainter.holeRadius(side, 4);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: hole * 2 * 0.9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatKcal(ring.value),
              style: AppType.on(AppType.displayXl, pit.text),
            ),
          ),
          Text(ring.unit, style: AppType.on(AppType.caption, pit.muted)),
        ],
      ),
    );
  }

  /// Um item da legenda, discreto de propósito: bolinha pequena + rótulo
  /// (caption) + 'valor / meta' (captionSm muted; 'g' só nos macros — kcal fica
  /// implícito no centro). Toque seleciona. Usada por: [build].
  Widget _legendItem(BuildContext context, MacroRing ring, int i) {
    final pit = context.pit;
    final goal =
        ring.unit == 'kcal' ? formatKcal(ring.goal) : formatMacro(ring.goal);
    return GestureDetector(
      onTap: () => _select(i),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSpacing.sm,
            height: AppSpacing.sm,
            margin: const EdgeInsets.only(top: 3),
            decoration:
                BoxDecoration(color: ring.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ring.label, style: AppType.on(AppType.caption, pit.text2)),
                Text(
                  '${formatKcal(ring.value)} / $goal',
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: AppType.on(AppType.captionSm, pit.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
