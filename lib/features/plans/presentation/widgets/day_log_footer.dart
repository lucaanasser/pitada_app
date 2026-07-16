// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_log_footer.dart
// O QUÊ:     Rodapé fixo do sheet de registrar dia: total do dia vs meta
//            (colorido quando estoura) + botão "Salvar dia".
// USA:       theme/*, core/widgets/pitada_button.
// USADO POR: log_day_sheet (abaixo da lista).
// SPEC:      specs/features/plans_progress.yaml (showLogDaySheet.widgets_extraidos)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/controls/pitada_button.dart';

/// Rodapé do LogDaySheet: total vs meta + salvar. Usada por: LogDaySheet.
class DayLogFooter extends StatelessWidget {
  const DayLogFooter({
    super.key,
    required this.total,
    required this.goal,
    required this.onSave,
  });

  final int total;
  final int goal;
  final VoidCallback onSave;

  /// Monta a linha de total e o botão de salvar. Usada por: LogDaySheet.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final over = total > goal;
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        top: AppSpacing.md,
        bottom: AppSpacing.md + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: pit.line, width: AppSpacing.hair),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Total do dia', style: AppType.on(AppType.body, pit.text2)),
              const Spacer(),
              Text(
                '$total / $goal kcal',
                style: AppType.on(
                  AppType.numeralSm,
                  over ? AppColors.accent2 : pit.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          PitadaButton(label: 'Salvar dia', onPressed: onSave),
        ],
      ),
    );
  }
}
