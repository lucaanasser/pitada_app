// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/day_summary_view.dart
// O QUÊ:     Resumo do dia como anéis de macro concêntricos e interativos (SEM
//            caixa): Calorias + Proteína/Carbo/Gordura, cada anel valor/meta.
//            Tocar num anel (ou no ponto da legenda mínima) o seleciona: ele acende
//            e o centro mostra os dados dele. Começa em Calorias.
// USA:       theme/*, utils/format, plan_providers (DayTotals), MacroRingPainter.
// USADO POR: plans_screen (cabeçalho fixo do Plano, acima das sub-abas).
// SPEC:      specs/features/plans/plans.yaml (DaySummaryView)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../application/plan_providers.dart';
import 'macro_ring_painter.dart';

/// Resumo nutricional do dia como anel de macros interativo (4 anéis concêntricos).
/// [totals] são as opções escolhidas; os `*Goal` são as metas diárias do plano.
/// Usada por: plans_screen.
class DaySummaryView extends StatefulWidget {
  const DaySummaryView({
    super.key,
    required this.goalKcal,
    required this.proteinGoal,
    required this.carbGoal,
    required this.fatGoal,
    required this.totals,
  });

  final int goalKcal;
  final int proteinGoal;
  final int carbGoal;
  final int fatGoal;
  final DayTotals totals;

  @override
  State<DaySummaryView> createState() => _DaySummaryViewState();
}

class _DaySummaryViewState extends State<DaySummaryView> {
  /// Lado máximo do anel — mantém o herói compacto no cabeçalho fixo.
  static const double _maxSide = 224;

  /// Anel selecionado: 0 Calorias, 1 Proteína, 2 Carbo, 3 Gordura.
  int _selected = 0;

  /// Os 4 anéis na ordem de fora p/ dentro (Calorias externo). Usada por: [build].
  List<MacroRing> _rings() {
    final t = widget.totals;
    return [
      MacroRing(
          label: 'Calorias',
          short: 'Kcal',
          value: t.kcal,
          goal: widget.goalKcal,
          color: AppColors.accent,
          unit: 'kcal'),
      MacroRing(
          label: 'Proteína',
          short: 'Prot',
          value: t.protein,
          goal: widget.proteinGoal,
          color: AppColors.terra,
          unit: 'g'),
      MacroRing(
          label: 'Carbo',
          short: 'Carb',
          value: t.carb,
          goal: widget.carbGoal,
          color: AppColors.ochre,
          unit: 'g'),
      MacroRing(
          label: 'Gordura',
          short: 'Gord',
          value: t.fat,
          goal: widget.fatGoal,
          color: AppColors.teal,
          unit: 'g'),
    ];
  }

  /// Seleciona o anel [i] (toque no anel ou na legenda). Usada por: [build].
  void _select(int i) => setState(() => _selected = i);

  /// Monta o anel (quadrado + centro) e a legenda mínima abaixo. Usada por: plans_screen.
  @override
  Widget build(BuildContext context) {
    final rings = _rings();
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final side = math.min(constraints.maxWidth, _maxSide);
            return SizedBox(
              width: side,
              height: side,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (d) {
                  final i = MacroRingPainter.ringAtOffset(
                      d.localPosition, side, rings.length);
                  if (i != null) _select(i);
                },
                child: CustomPaint(
                  painter: MacroRingPainter(rings: rings, selected: _selected),
                  child: Center(child: _center(context, rings[_selected], side)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        _legend(context, rings),
      ],
    );
  }

  /// Centro do anel: rótulo do selecionado + número grande + '/ meta unidade'.
  /// Usada por: [build].
  Widget _center(BuildContext context, MacroRing ring, double side) {
    final pit = context.pit;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: side * 0.44),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(ring.label, style: AppType.on(AppType.caption, ring.color)),
          const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatKcal(ring.value),
              style: AppType.on(AppType.display, pit.text),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '/ ${formatKcal(ring.goal)} ${ring.unit}',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ],
      ),
    );
  }

  /// Legenda mínima: 4 pontos+rótulo curtos que também selecionam o anel.
  /// Usada por: [build].
  Widget _legend(BuildContext context, List<MacroRing> rings) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < rings.length; i++)
          _legendItem(context, rings[i], i),
      ],
    );
  }

  /// Um item da legenda (ponto colorido + rótulo curto); o selecionado ganha cor
  /// cheia e texto forte, os demais ficam muted. Usada por: [_legend].
  Widget _legendItem(BuildContext context, MacroRing ring, int i) {
    final pit = context.pit;
    final sel = i == _selected;
    return GestureDetector(
      onTap: () => _select(i),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpacing.sm,
            height: AppSpacing.sm,
            decoration: BoxDecoration(
              color: sel ? ring.color : ring.color.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xs + 1),
          Text(
            ring.short,
            style: AppType.on(AppType.caption, sel ? pit.text : pit.muted),
          ),
        ],
      ),
    );
  }
}
