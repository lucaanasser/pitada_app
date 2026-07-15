// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/today_section.dart
// O QUÊ:     Destaque da sub-aba Progresso: o dia de HOJE foi registrado? Card
//            com CTA (sem registro) ou resumo do log (kcal vs meta + contagens
//            + editar), e a sequência de dias registrando logo abaixo.
// USA:       theme/*, utils/format, core/widgets (PitadaButton/IconButton),
//            day_log_providers (todayLog/streak), plans_providers (meta),
//            log_day_sheet.
// USADO POR: ProgressView (seção 'Hoje').
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: TodaySection)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../application/day_log_providers.dart';
import '../../application/plans_providers.dart';
import '../../data/day_log.dart';
import '../log_day_sheet.dart';

/// Seção 'Hoje': card de registro do dia (CTA ou resumo) + sequência.
/// Usada por: ProgressView.
class TodaySection extends ConsumerWidget {
  const TodaySection({super.key});

  /// Monta o card no estado certo e a linha de sequência. Usada por: ProgressView.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final log = ref.watch(todayLogProvider);
    final goal = ref.watch(planControllerProvider).dailyKcalGoal;
    final streak = ref.watch(logStreakProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.br(AppSpacing.radiusCard),
            border:
                Border.all(color: pit.border, width: AppSpacing.borderStrong),
          ),
          child: log == null
              ? _empty(context, pit)
              : _logged(context, pit, log, goal),
        ),
        if (streak >= 2) ...[
          const SizedBox(height: AppSpacing.md),
          _streak(pit, streak),
        ],
      ],
    );
  }

  /// Estado sem registro: convite + botão primário (o CTA da aba). Usada por: [build].
  Widget _empty(BuildContext context, PitadaColors pit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hoje ainda não tem registro',
          style: AppType.on(AppType.titleSm, pit.text),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Leva menos de um minuto: confirme as refeições e '
          'adicione o que saiu do plano.',
          style: AppType.on(AppType.bodySm, pit.muted),
        ),
        const SizedBox(height: AppSpacing.lg),
        PitadaButton(
          label: 'Registrar dia',
          icon: AppIcons.logDay,
          onPressed: () => showLogDaySheet(context),
        ),
      ],
    );
  }

  /// Estado registrado: kcal vs meta + status + contagens + editar. Usada por: [build].
  Widget _logged(BuildContext context, PitadaColors pit, DayLog log, int goal) {
    final over = log.kcal > goal;
    final diff = (goal - log.kcal).abs();
    final status = over
        ? 'Acima da meta · $diff kcal a mais'
        : 'Dentro da meta · sobram $diff kcal';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${formatKcal(log.kcal)} kcal',
                    style: AppType.on(AppType.numeralLg, pit.text),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '/ ${formatKcal(goal)}',
                    style: AppType.on(AppType.numeralSm, pit.muted),
                  ),
                ],
              ),
            ),
            PitadaIconButton(
              icon: AppIcons.edit,
              onPressed: () => showLogDaySheet(context),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          status,
          style: AppType.on(
            AppType.caption,
            over ? AppColors.accent2 : AppColors.sage,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(_counts(log), style: AppType.on(AppType.caption, pit.muted)),
      ],
    );
  }

  /// Linha 'N refeições feitas · N puladas · N extras' do log. Usada por: [_logged].
  String _counts(DayLog log) {
    final done =
        log.meals.where((m) => !m.skipped && m.optionId != null).length;
    final skipped = log.skippedCount;
    final extras = log.extras.length;
    final parts = [
      '$done ${done == 1 ? 'refeição feita' : 'refeições feitas'}',
      if (skipped > 0) '$skipped ${skipped == 1 ? 'pulada' : 'puladas'}',
      if (extras > 0) '$extras ${extras == 1 ? 'extra' : 'extras'}',
    ];
    return parts.join(' · ');
  }

  /// Sequência de dias registrando (métrica em texto sóbrio, nunca pílula).
  /// Usada por: [build].
  Widget _streak(PitadaColors pit, int streak) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('$streak', style: AppType.on(AppType.numeralSm, AppColors.sage)),
        const SizedBox(width: AppSpacing.xs + 2),
        Text(
          'dias seguidos registrando',
          style: AppType.on(AppType.bodySm, pit.text2),
        ),
      ],
    );
  }
}
