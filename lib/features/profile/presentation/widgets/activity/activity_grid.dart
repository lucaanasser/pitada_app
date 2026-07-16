// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/activity/activity_grid.dart
// O QUÊ:     A grade do gráfico de atividade: rótulos de mês no topo, seg/qua/sex
//            à esquerda, células tocáveis em COR ÚNICA estilo GitHub (quanto mais
//            registros no dia, mais intensa). Rolagem horizontal reversa.
// USA:       core/theme (AppColors, context.pit, AppSpacing, AppType),
//            core/utils/format (meses/dias pt-BR), profile_providers (seleção),
//            ActivityDay (modelo).
// USADO POR: ActivityGraph (dentro do card do gráfico).
// SPEC:      specs/features/profile.yaml (components_da_feature.ActivityGrid)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../application/profile_providers.dart';
import '../../../data/models/activity_day.dart';

/// Lado de cada célula e vão entre células (~GitHub). Usadas por: [ActivityGrid].
const double _kCell = 12;
const double _kGap = 3;
const double _kCol = _kCell + _kGap;

/// Cor de uma célula ativa pela intensidade 1..4 — rampa de COR ÚNICA estilo
/// GitHub: sempre accent2, só o alpha varia (0.28..0.94). Um dia pode misturar
/// receitas+caderno+cozinha, então categoria não escolhe cor.
/// Usada por: células da grade e rampa "menos → mais" do ActivityGraph.
Color activityColor(int intensity) => AppColors.accent2
    .withValues(alpha: 0.28 + (intensity.clamp(1, 4) - 1) * 0.22);

/// Grade 22 semanas x 7 dias com meses e dias reais. Tocar num dia grava a
/// seleção em selectedActivityDayProvider. Usada por: ActivityGraph.
class ActivityGrid extends ConsumerWidget {
  const ActivityGrid({super.key, required this.days});

  final List<ActivityDay> days;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final selected = ref.watch(selectedActivityDayProvider);
    final weeks = days.isEmpty
        ? 0
        : days.map((d) => d.weekIndex).reduce((a, b) => a > b ? a : b) + 1;
    final byPos = <int, ActivityDay>{
      for (final d in days) d.weekIndex * 7 + d.dayIndex: d,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _weekdayLabels(pit),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _monthLabels(pit, byPos, weeks),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var w = 0; w < weeks; w++)
                      Column(
                        children: [
                          for (var d = 0; d < 7; d++)
                            _Cell(
                              day: byPos[w * 7 + d],
                              selected: byPos[w * 7 + d] != null &&
                                  byPos[w * 7 + d] == selected,
                              onTap: (day) => _select(ref, day),
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Grava (ou limpa, se tocar de novo) o dia selecionado. Usada por: [_Cell].
  void _select(WidgetRef ref, ActivityDay day) {
    final sel = ref.read(selectedActivityDayProvider.notifier);
    sel.state = sel.state == day ? null : day;
  }

  /// Coluna fixa seg/qua/sex alinhada às linhas 0/2/4. Usada por: [build].
  Widget _weekdayLabels(PitadaColors pit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var d = 0; d < 7; d++)
          SizedBox(
            height: _kCol,
            child: d.isEven && d < 6
                ? Text(
                    kWeekdaysAbbr[d],
                    style: AppType.on(AppType.captionSm, pit.muted),
                  )
                : null,
          ),
      ],
    );
  }

  /// Rótulos de mês posicionados na coluna onde o mês vira. Usada por: [build].
  Widget _monthLabels(
    PitadaColors pit,
    Map<int, ActivityDay> byPos,
    int weeks,
  ) {
    final labels = <Widget>[];
    int? lastMonth;
    for (var w = 0; w < weeks; w++) {
      final first = byPos[w * 7];
      if (first == null) continue;
      final month = first.date.month;
      if (lastMonth != null && month != lastMonth) {
        labels.add(
          Positioned(
            left: w * _kCol,
            child: Text(
              formatMonthAbbr(first.date),
              style: AppType.on(AppType.captionSm, pit.muted),
            ),
          ),
        );
      }
      lastMonth = month;
    }
    return SizedBox(
      width: weeks * _kCol,
      height: 14,
      child: Stack(clipBehavior: Clip.none, children: labels),
    );
  }
}

/// Uma célula (dia): cor única, alpha pela intensidade; a célula selecionada
/// ganha borda accent. Dias futuros (null) ficam invisíveis.
/// Usada por: [ActivityGrid].
class _Cell extends StatelessWidget {
  const _Cell({required this.day, required this.selected, required this.onTap});

  final ActivityDay? day;
  final bool selected;
  final ValueChanged<ActivityDay> onTap;

  @override
  Widget build(BuildContext context) {
    final d = day;
    if (d == null) return const SizedBox(width: _kCol, height: _kCol);
    return GestureDetector(
      onTap: () => onTap(d),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(right: _kGap, bottom: _kGap),
        child: Container(
          width: _kCell,
          height: _kCell,
          decoration: BoxDecoration(
            color: d.intensity <= 0
                ? context.pit.surf2
                : activityColor(d.intensity),
            borderRadius: AppSpacing.br(3),
            border: selected
                ? Border.all(
                    color: AppColors.accent,
                    width: AppSpacing.borderThick,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
