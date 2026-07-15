// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/insights_section.dart
// O QUÊ:     Seção 'Padrões' do Progresso: um card com borda por insight
//            (ícone por tipo + fato + leitura acionável). Widget burro — recebe
//            a lista pronta; quem decide exibir a seção é a ProgressView.
// USA:       theme/*, progress_insights (ProgressInsight/InsightKind).
// USADO POR: ProgressView (seção 'Padrões', oculta quando não há insights).
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: InsightsSection)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/progress_insights.dart';

/// Lista de cards de padrões lidos dos registros. Usada por: ProgressView.
class InsightsSection extends StatelessWidget {
  const InsightsSection({super.key, required this.insights});

  final List<ProgressInsight> insights;

  /// Monta um card por insight, com respiro entre eles. Usada por: ProgressView.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      children: [
        for (var i = 0; i < insights.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          _card(pit, insights[i]),
        ],
      ],
    );
  }

  /// Um card de insight: ícone do tipo + título (fato) + detalhe (ação).
  /// Usada por: [build].
  Widget _card(PitadaColors pit, ProgressInsight insight) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusXl),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_iconOf(insight.kind), size: 18, color: AppColors.accent),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title, style: AppType.on(AppType.body, pit.text)),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  insight.detail,
                  style: AppType.on(AppType.bodySm, pit.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Ícone de cada tipo de padrão (mapa da spec). Usada por: [_card].
  IconData _iconOf(InsightKind kind) => switch (kind) {
        InsightKind.skippedMeal => AppIcons.removeCircle,
        InsightKind.frequentExtra => AppIcons.add,
        InsightKind.extrasSource => AppIcons.basket,
        InsightKind.weekdayOver => AppIcons.calendarPattern,
      };
}
