// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/process_log_screen.dart
// O QUÊ:     Detalhe de um log de processo: tipo, título, data, parâmetros,
//            linha do tempo de eventos e nota final.
// USA:       learning_providers, core/widgets, widgets locais, theme/*, format.
// USADO POR: core/router (/log/:id).
// SPEC:      specs/features/notebook.yaml (screens.ProcessLogScreen — view-log)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/why_callout.dart';
import '../../../core/utils/format.dart';
import '../application/providers.dart';
import '../data/process_log.dart';
import 'widgets/detail_header.dart';
import 'widgets/log_param.dart';

/// Tela de detalhe de um log de processo. Usada por: router (/log/:id).
class ProcessLogScreen extends ConsumerWidget {
  const ProcessLogScreen({super.key, required this.logId});

  final String logId;

  /// Carrega o log por id e delega a montagem do corpo. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final async = ref.watch(logByIdProvider(logId));
    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        bottom: false,
        child: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(
            child: Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
          ),
          data: (log) => log == null
              ? Center(
                  child: Text(
                    'Log não encontrado',
                    style: AppType.on(AppType.body, pit.text),
                  ),
                )
              : _content(log),
        ),
      ),
    );
  }

  /// Monta cabeçalho + seções roláveis do log. Usada por: [build].
  Widget _content(ProcessLog log) {
    final params = log.params.entries.toList();
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        DetailHeader(
          kicker: log.type,
          title: log.title,
          lead: formatDayMonth(log.date),
        ),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (params.isNotEmpty) ...[
                const SectionHeader(label: 'Parâmetros'),
                Wrap(
                  spacing: AppSpacing.xxxl,
                  runSpacing: AppSpacing.lg,
                  children: [
                    for (final p in params)
                      LogParamCell(label: p.key, value: p.value),
                  ],
                ),
              ],
              if (log.timeline.isNotEmpty) ...[
                const SectionHeader(label: 'Linha do tempo'),
                for (var i = 0; i < log.timeline.length; i++)
                  LogStepRow(
                    event: log.timeline[i],
                    showDivider: i != log.timeline.length - 1,
                  ),
              ],
              if (log.note.isNotEmpty) ...[
                const SectionHeader(label: 'Nota'),
                WhyCallout(text: log.note, label: 'Nota'),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
