// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/widgets/activity_graph.dart
// O QUÊ:     Gráfico de atividade estilo GitHub (22 semanas x 7 dias). Cada célula
//            é um dia; a cor vem da categoria e a opacidade da intensidade (0..4).
// USA:       core/theme (AppColors, AppSpacing), ActivityDay (modelo), home_providers.
// USADO POR: ProfileScreen (bloco "Seu semestre na cozinha").
// SPEC:      specs/features/home.yaml (components_da_feature.ActivityGraph)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/activity_day.dart';
import '../../application/home_providers.dart';

/// Lado de cada célula do gráfico (~11px, como no protótipo). Usada por: [ActivityGraph].
const double _kCell = 11;

/// Gráfico de atividade da cozinha. Lê activityProvider e pinta a grade + legenda.
/// Usada por: ProfileScreen.
class ActivityGraph extends ConsumerWidget {
  const ActivityGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ref.watch(activityProvider);
    return activity.when(
      loading: () => const SizedBox(
        height: _kCell * 7 + AppSpacing.md * 6,
        child:
            Center(child: CircularProgressIndicator(color: AppColors.accent)),
      ),
      error: (e, _) => Text('Erro no gráfico: $e', style: AppType.caption),
      data: (days) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _grid(days),
          const SizedBox(height: AppSpacing.lg),
          const _Legend(),
        ],
      ),
    );
  }

  /// Monta a grade de colunas (semanas) x linhas (dias). Usada por: [build].
  Widget _grid(List<ActivityDay> days) {
    final weeks = days.isEmpty
        ? 0
        : days.map((d) => d.weekIndex).reduce((a, b) => a > b ? a : b) + 1;
    // Índice rápido por (semana, dia) para não varrer a lista em cada célula.
    final byPos = <int, ActivityDay>{
      for (final d in days) d.weekIndex * 7 + d.dayIndex: d,
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var w = 0; w < weeks; w++)
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Column(
                children: [
                  for (var day = 0; day < 7; day++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: _Cell(day: byPos[w * 7 + day]),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Uma célula (dia) do gráfico. Cor pela categoria, opacidade pela intensidade.
/// Usada por: [ActivityGraph].
class _Cell extends StatelessWidget {
  const _Cell({required this.day});

  final ActivityDay? day;

  /// Cor base da categoria do dia (receitas/caderno/cozinha). Usada por: [build].
  static Color _kindColor(String kind) {
    switch (kind) {
      case 'receitas':
        return AppColors.accent2;
      case 'caderno':
        return AppColors.sage;
      case 'cozinha':
        return AppColors.teal;
      default:
        return AppColors.accent2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = day;
    // Sem registro (ou célula ausente): quadradinho neutro discreto.
    if (d == null || d.intensity <= 0) {
      return Container(
        width: _kCell,
        height: _kCell,
        decoration: BoxDecoration(
          color: AppColors.surf2,
          borderRadius: AppSpacing.br(2),
        ),
      );
    }
    // Opacidade discreta escalonada pela intensidade 1..4.
    final alpha = 0.28 + (d.intensity.clamp(1, 4) - 1) * 0.22; // 0.28..0.94
    return Container(
      width: _kCell,
      height: _kCell,
      decoration: BoxDecoration(
        color: _kindColor(d.kind).withValues(alpha: alpha),
        borderRadius: AppSpacing.br(2),
      ),
    );
  }
}

/// Legenda de categorias: Receitas (accent2) / Caderno (sage) / Cozinha (teal).
/// Usada por: [ActivityGraph].
class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _LegendItem(color: AppColors.accent2, label: 'Receitas'),
        SizedBox(width: AppSpacing.lg),
        _LegendItem(color: AppColors.sage, label: 'Caderno'),
        SizedBox(width: AppSpacing.lg),
        _LegendItem(color: AppColors.teal, label: 'Cozinha'),
      ],
    );
  }
}

/// Um ponto colorido + rótulo da legenda. Usada por: [_Legend].
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
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
        Text(label, style: AppType.on(AppType.caption, AppColors.muted)),
      ],
    );
  }
}
