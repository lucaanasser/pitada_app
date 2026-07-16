// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/activity/activity_graph.dart
// O QUÊ:     Gráfico de atividade estilo GitHub, SEM card: grade em cor única,
//            rodapé (dias ativos · recorde + rampa "menos → mais") e o detalhe
//            do dia tocado com a LISTA de registros (navegável).
// USA:       core/theme (AppColors, context.pit, AppSpacing, AppType),
//            core/utils (format, app_log), profile_providers (seleção),
//            overview_providers (atividade), activity_stats, ActivityGrid,
//            go_router (abrir registro).
// USADO POR: ProfileScreen (bloco "Seu semestre na cozinha").
// SPEC:      specs/features/profile.yaml (components_da_feature.ActivityGraph)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/format.dart';
import '../../../application/overview_providers.dart';
import '../../../application/profile_providers.dart';
import '../../../data/models/activity_day.dart';
import '../../../data/models/activity_entry.dart';
import '../../../data/models/activity_stats.dart';
import 'activity_grid.dart';

/// Gráfico de atividade da cozinha (grade + rodapé + detalhe do dia), assentado
/// direto no fundo da aba — sem moldura. Usada por: ProfileScreen.
class ActivityGraph extends ConsumerWidget {
  const ActivityGraph({super.key});

  /// Lê atividade e seleção; monta grade, rodapé e detalhe. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final days = ref.watch(activityProvider);
    final sel = ref.watch(selectedActivityDayProvider);
    final stats = computeActivityStats(days);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivityGrid(days: days),
        const SizedBox(height: AppSpacing.md),
        _footer(pit, stats),
        const SizedBox(height: AppSpacing.lg),
        if (sel == null)
          Text(
            'toque num dia para ver os registros',
            style: AppType.on(AppType.caption, pit.faint),
          )
        else
          _DayDetail(day: sel),
      ],
    );
  }

  /// Rodapé da grade: stats à esquerda, rampa de intensidade à direita.
  /// Usada por: [build].
  Widget _footer(PitadaColors pit, ActivityStats stats) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${stats.activeDays} dias ativos · recorde ${stats.bestStreak}',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ),
        Text('menos', style: AppType.on(AppType.captionSm, pit.muted)),
        const SizedBox(width: AppSpacing.xs),
        for (var i = 1; i <= 4; i++)
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: activityColor(i),
                borderRadius: AppSpacing.br(2),
              ),
            ),
          ),
        const SizedBox(width: AppSpacing.xs - 3),
        Text('mais', style: AppType.on(AppType.captionSm, pit.muted)),
      ],
    );
  }
}

/// Detalhe do dia selecionado: data + total e a lista de registros (cada linha
/// abre o detalhe do registro). Dia de preenchimento explica que é exemplo.
/// Usada por: [ActivityGraph].
class _DayDetail extends StatelessWidget {
  const _DayDetail({required this.day});

  final ActivityDay day;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final n = day.intensity;
    final total =
        n <= 0 ? 'sem registros' : '$n ${n == 1 ? 'registro' : 'registros'}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${formatDayLabel(day.date)} — $total',
          style: AppType.on(AppType.bodySm, pit.text)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        if (n > 0 && day.entries.isEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'histórico de exemplo — anterior aos seus primeiros registros',
            style: AppType.on(AppType.captionSm, pit.faint),
          ),
        ],
        for (final e in day.entries) _EntryRow(entry: e),
      ],
    );
  }
}

/// Uma linha de registro do dia: bolinha de tinta + título + tipo + seta.
/// Toque abre o detalhe do registro (push — voltar cai no Perfil).
/// Usada por: [_DayDetail].
class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry});

  final ActivityEntry entry;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppLog.i('profile', 'registro do dia -> ${entry.route}');
        context.push(entry.route);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm + 2),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pit.isDark ? AppColors.accent : pit.border,
              ),
            ),
            const SizedBox(width: AppSpacing.sm + 2),
            Expanded(
              child: Text(
                entry.title,
                style: AppType.on(AppType.bodySm, pit.text),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(entry.label, style: AppType.on(AppType.captionSm, pit.muted)),
            const SizedBox(width: AppSpacing.xs + 1),
            Icon(AppIcons.chevron, size: 13, color: pit.faint),
          ],
        ),
      ),
    );
  }
}
