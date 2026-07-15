// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/adherence_section.dart
// O QUÊ:     Aderência ao plano nos últimos ~14 dias: uma barra por dia (altura =
//            kcal do log / meta; cor por status) + resumo (dias dentro + média
//            de kcal dos dias logados) e legenda. Flat, sem sombra.
// USA:       theme/*, utils/format, plans/application (adherenceProvider, DayAdherence).
// USADO POR: ProgressView.
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: AdherenceSection)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../application/day_log_providers.dart';

/// Altura da faixa de barras (px). Usada por: [AdherenceSection].
const double _kTrack = 92;

/// Seção de aderência: resumo + faixa de barras (uma por dia) + legenda.
/// Usada por: ProgressView.
class AdherenceSection extends ConsumerWidget {
  const AdherenceSection({super.key});

  /// Monta o resumo e as barras dos últimos dias. Usada por: ProgressView.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final days = ref.watch(adherenceProvider);
    final loggedDays = [
      for (final d in days)
        if (d.logged) d,
    ];
    final logged = loggedDays.length;
    final within = loggedDays.where((d) => d.within).length;
    // Média de kcal só dos dias logados (dias sem registro não puxam p/ baixo).
    final avg = logged == 0
        ? 0
        : (loggedDays.fold<int>(0, (s, d) => s + d.kcal) / logged).round();
    final summary = logged == 0
        ? 'Nenhum dia registrado ainda. Toque em “Registrar dia”.'
        : '$within de $logged dias dentro da meta · média de '
            '${formatKcal(avg)} kcal';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(summary, style: AppType.on(AppType.body, pit.text2)),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: _kTrack,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [for (final d in days) _bar(pit, d)],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _legend(pit),
      ],
    );
  }

  /// Uma barra do dia: altura pela razão kcal/meta; cor pelo status. Usada por: [build].
  Widget _bar(PitadaColors pit, DayAdherence d) {
    final Color color;
    final double frac;
    if (!d.logged) {
      color = pit.surf2; // sem registro: stub neutro
      frac = 0.05;
    } else {
      color = d.over ? AppColors.accent2 : AppColors.sage;
      frac = d.ratio.clamp(0.08, 1.0);
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: _kTrack * frac,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppSpacing.br(AppSpacing.radiusSm),
            ),
          ),
        ),
      ),
    );
  }

  /// Legenda das cores das barras. Usada por: [build].
  Widget _legend(PitadaColors pit) {
    return Row(
      children: [
        _dot(AppColors.sage, 'Dentro', pit),
        const SizedBox(width: AppSpacing.lg),
        _dot(AppColors.accent2, 'Acima', pit),
        const SizedBox(width: AppSpacing.lg),
        _dot(pit.surf2, 'Sem registro', pit),
      ],
    );
  }

  /// Um quadradinho colorido + rótulo da legenda. Usada por: [_legend].
  Widget _dot(Color color, String label, PitadaColors pit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration:
              BoxDecoration(color: color, borderRadius: AppSpacing.br(2)),
        ),
        const SizedBox(width: AppSpacing.xs + 2),
        Text(label, style: AppType.on(AppType.caption, pit.muted)),
      ],
    );
  }
}
