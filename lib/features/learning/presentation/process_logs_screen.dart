// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/process_logs_screen.dart
// O QUÊ:     Lista de logs de processo (avançado): dica + linhas de ProcessLog.
// USA:       learning_providers, core/widgets, widgets locais, go_router, theme/*.
// USADO POR: core/router (/learning/logs).
// SPEC:      specs/features/learning.yaml (screens.ProcessLogsScreen — view-logs)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/recipe_thumb.dart';
import '../../../core/utils/format.dart';
import '../application/learning_providers.dart';
import '../data/process_log.dart';
import 'widgets/detail_header.dart';
import 'widgets/hint_card.dart';

/// Tela de logs de processo. Fica oculta até ser ativada; reúne processos longos
/// e sensíveis (fermentação, sous-vide, cura). Usada por: router (/learning/logs).
class ProcessLogsScreen extends ConsumerWidget {
  const ProcessLogsScreen({super.key});

  /// Monta cabeçalho, dica e lista de logs a partir de [logsProvider].
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(logsProvider);
    return PitadaScaffold(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const DetailHeader(
            kicker: 'Prática · avançado',
            title: 'Logs de processo',
            lead: 'Registros longos de fermentação, sous-vide e cura.',
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.lg,
              AppSpacing.gutter,
              0,
            ),
            child: HintCard(
              text: 'Fica oculto até você ativar. É para processos longos e '
                  'sensíveis — anote medidas e cada etapa.',
            ),
          ),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxxl),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child: Text('Erro: $e', style: AppType.body),
            ),
            data: (logs) => _list(context, logs),
          ),
        ],
      ),
    );
  }

  /// Renderiza a lista de logs ou um estado vazio. Usada por: [build].
  Widget _list(BuildContext context, List<ProcessLog> logs) {
    if (logs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Nenhum log ainda',
          message: 'Ative um log ao iniciar um processo longo.',
          icon: AppIcons.science,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        children: [
          for (var i = 0; i < logs.length; i++)
            _row(context, logs[i], showDivider: i != logs.length - 1),
        ],
      ),
    );
  }

  /// Uma linha de log: miniatura de processo + título + "tipo · data". Usada por: [_list].
  Widget _row(
    BuildContext context,
    ProcessLog log, {
    required bool showDivider,
  }) {
    return Padding(
      padding: AppSpacing.screenH,
      child: HairlineRow(
        showDivider: showDivider,
        onTap: () => context.push('/log/${log.id}'),
        leading: RecipeThumb(
          color: AppColors.heroOf('moss'),
          icon: AppIcons.science,
        ),
        title: Text(log.title, style: AppType.titleSm),
        subtitle: Text(
          '${log.type}  ·  ${formatDayMonth(log.date)}',
          style: AppType.on(AppType.caption, AppColors.muted),
        ),
        trailing:
            const Icon(AppIcons.chevron, size: 16, color: AppColors.faint),
      ),
    );
  }
}
