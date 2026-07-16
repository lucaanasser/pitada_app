// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/weight_section.dart
// O QUÊ:     Bloco COMPACTO de peso do Progresso (o destaque da aba é o registro
//            do dia): atual + variação numa linha, gráfico, e o lembrete de como
//            se pesar só enquanto o hábito não existe (< 3 pesagens).
// USA:       theme/*, utils/format, plans/application (weightStats/weight), WeightChart.
// USADO POR: ProgressView (última seção).
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: WeightSection)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../application/progress_providers.dart';
import 'weight_chart.dart';

/// Seção compacta de peso: atual + variação numa linha, gráfico e (no começo)
/// a recomendação de pesagem. Usada por: ProgressView.
class WeightSection extends ConsumerWidget {
  const WeightSection({super.key});

  /// Monta o bloco de peso (ou um estado vazio se nunca pesou). Usada por: ProgressView.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final stats = ref.watch(weightStatsProvider);
    final entries = ref.watch(weightControllerProvider);
    if (stats == null) {
      return Text(
        'Nenhuma pesagem ainda. Toque em “Registrar peso” para começar.',
        style: AppType.on(AppType.body, pit.text2),
      );
    }
    final down = stats.delta < 0;
    final arrow = stats.delta == 0 ? '' : (down ? '▼ ' : '▲ ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              formatKg(stats.current),
              style: AppType.on(AppType.display, pit.text),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              '$arrow${formatKgDelta(stats.delta)} desde o início',
              style: AppType.on(AppType.caption, pit.text2),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        WeightChart(entries: entries),
        if (entries.length < 3) ...[
          const SizedBox(height: AppSpacing.lg),
          _reminder(pit),
        ],
      ],
    );
  }

  /// Caixa-lembrete de como se pesar (borda tinta, texto muted). Usada por: [build].
  Widget _reminder(PitadaColors pit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusXl),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Text(
        'Pese-se 1x por semana (ou a cada 15 dias), de manhã, em jejum e no mesmo '
        'horário. Assim a linha mostra o progresso real, não a variação do dia a dia.',
        style: AppType.on(AppType.bodySm, pit.muted),
      ),
    );
  }
}
