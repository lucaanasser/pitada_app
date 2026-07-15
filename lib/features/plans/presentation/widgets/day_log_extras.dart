// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_log_extras.dart
// O QUÊ:     Seção "Comeu algo fora do plano?" do sheet de registrar dia:
//            linhas de extras (nome/porção/kcal + remover) e o link de adicionar.
// USA:       theme/*, core/widgets/hairline_row, data/day_log (ExtraEntry).
// USADO POR: log_day_sheet (corpo da lista).
// SPEC:      specs/features/plans_progress.yaml (showLogDaySheet.widgets_extraidos)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../data/day_log.dart';

/// Extras do dia em edição: título + linhas + "+ Adicionar". Usada por: LogDaySheet.
class DayLogExtrasSection extends StatelessWidget {
  const DayLogExtrasSection({
    super.key,
    required this.extras,
    required this.onAdd,
    required this.onRemove,
  });

  final List<ExtraEntry> extras;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  /// Monta título, linhas de extras e o link de adicionar. Usada por: LogDaySheet.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comeu algo fora do plano?',
          style: AppType.on(AppType.titleSm, pit.text),
        ),
        for (var i = 0; i < extras.length; i++) _extraRow(pit, i),
        HairlineRow(
          showDivider: false,
          title: Text(
            '+ Adicionar algo fora do plano',
            style: AppType.on(AppType.body, AppColors.accent),
          ),
          onTap: onAdd,
        ),
      ],
    );
  }

  /// Uma linha de extra (nome/porção + kcal + remover). Usada por: [build].
  Widget _extraRow(PitadaColors pit, int i) {
    final e = extras[i];
    return HairlineRow(
      title: Text(e.name, style: AppType.on(AppType.body, pit.text)),
      subtitle: e.portion.isEmpty
          ? null
          : Text(e.portion, style: AppType.on(AppType.caption, pit.muted)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${e.kcal} kcal', style: AppType.on(AppType.caption, pit.muted)),
          const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: () => onRemove(i),
            behavior: HitTestBehavior.opaque,
            child: Icon(AppIcons.close, size: 18, color: pit.muted),
          ),
        ],
      ),
    );
  }
}
