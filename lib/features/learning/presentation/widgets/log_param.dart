// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/log_param.dart
// O QUÊ:     Peças de um log de processo: parâmetro (valor grande + rótulo) e
//            evento da linha do tempo (momento + texto).
// USA:       core/widgets (HairlineRow), theme/*, ProcessLog (LogEvent).
// USADO POR: ProcessLogScreen (Parâmetros e Linha do tempo).
// SPEC:      specs/features/learning.yaml (ProcessLogScreen "Parâmetros"/"Linha do tempo")
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../data/process_log.dart';

/// Um parâmetro do processo: valor em serifa grande sobre o rótulo em versalete.
/// Usada por: ProcessLogScreen (grade de parâmetros).
class LogParamCell extends StatelessWidget {
  const LogParamCell({super.key, required this.label, required this.value});

  final String label;
  final String value;

  /// Renderiza valor + rótulo empilhados. Usada por: a grade de parâmetros.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppType.on(AppType.numeral, AppColors.accent)),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label.toUpperCase(),
          style: AppType.on(AppType.label, context.pit.muted),
        ),
      ],
    );
  }
}

/// Um evento da linha do tempo: momento (versalete) + descrição do que ocorreu.
/// Usada por: ProcessLogScreen (linha do tempo).
class LogStepRow extends StatelessWidget {
  const LogStepRow({super.key, required this.event, this.showDivider = true});

  final LogEvent event;
  final bool showDivider;

  /// Renderiza um evento como linha de lista com filete. Usada por: ProcessLogScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      crossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        event.date.toUpperCase(),
        style: AppType.on(AppType.label, pit.muted),
      ),
      subtitle: Text(event.text, style: AppType.on(AppType.body, pit.text2)),
    );
  }
}
