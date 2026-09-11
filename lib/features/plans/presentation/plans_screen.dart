// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/plans_screen.dart
// O QUÊ:     Aba Plano: cabeçalho compartilhado (marca + título 'Plano' + data de
//            hoje + anel de macros com legenda + linha 'Restam N kcal'/'Editar
//            metas') e, abaixo, sub-abas "Cardápio" (refeições) e "Progresso"
//            (peso + aderência). Alterna por setState.
// USA:       core/widgets (Masthead, PitadaTabs, PitadaScaffold), theme/*,
//            utils/format, plan_providers, goal_sheet, MenuView e ProgressView.
// USADO POR: core/router/router.dart (branch /plans).
// SPEC:      specs/features/plans/progress.yaml (navegacao) e plans.yaml (PlansScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/layout/masthead.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../core/widgets/tabs/pitada_tabs.dart';
import '../application/plan_providers.dart';
import 'sheets/plan/goal_sheet.dart';
import 'sheets/plan/plan_add_sheet.dart';
import 'widgets/meal/menu_view.dart';
import 'widgets/meal/day_summary_view.dart';
import 'widgets/progress/progress_view.dart';

/// Tela principal de Plano com cabeçalho compartilhado + sub-abas. Usada por: router (/plans).
class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  /// Sub-aba ativa: 0 = Cardápio (refeições), 1 = Progresso (peso + aderência).
  int _tab = 0;

  /// Monta o topo fixo (marca + resumo do dia + sub-abas) e o corpo da sub-aba
  /// ativa. O resumo (kcal + macros) é o mesmo nas duas abas. Usada por: router.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return PitadaScaffold(
      background: pit.tabBg(2),
      top: Column(
        children: [
          const Masthead(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.titleGap,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plano',
                        style: AppType.on(AppType.screenTitle, pit.text),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        formatTodayLabel(DateTime.now()),
                        style: AppType.on(AppType.bodySm, pit.muted),
                      ),
                    ],
                  ),
                ),
                PitadaIconButton(
                  icon: AppIcons.calendarPattern,
                  filled: true,
                  size: AppSpacing.iconButtonSm,
                  onPressed: () => showPlanAddSheet(context),
                ),
              ],
            ),
          ),
          _daySummary(),
          _goalsRow(),
          Align(
            alignment: Alignment.centerLeft,
            child: PitadaTabs(
              tabs: const ['Cardápio', 'Progresso'],
              selected: _tab,
              onSelect: (i) => setState(() => _tab = i),
            ),
          ),
        ],
      ),
      child: _tab == 0 ? const MenuView() : const ProgressView(),
    );
  }

  /// Resumo do dia (anel de macros interativo + legenda), fixo entre o título
  /// e as sub-abas (é o 1º conteúdo abaixo do título). Usada por: [build].
  Widget _daySummary() {
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: DaySummaryView(
        goalKcal: plan.dailyKcalGoal,
        proteinGoal: plan.proteinGoal,
        carbGoal: plan.carbGoal,
        fatGoal: plan.fatGoal,
        totals: totals,
      ),
    );
  }

  /// Linha sob o anel: 'Restam N kcal' à esquerda e 'Editar metas' à direita
  /// (abre o sheet de metas diárias). Usada por: [build].
  Widget _goalsRow() {
    final pit = context.pit;
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    final left = plan.dailyKcalGoal - totals.kcal;
    final label = left >= 0
        ? 'Restam ${formatKcal(left)} kcal'
        : '${formatKcal(-left)} kcal acima';
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppType.on(AppType.bodySm, pit.muted)),
          ),
          GestureDetector(
            onTap: () => showGoalSheet(context, plan: plan),
            behavior: HitTestBehavior.opaque,
            child: Text(
              'Editar metas',
              style: AppType.on(AppType.bodySm, pit.text2),
            ),
          ),
        ],
      ),
    );
  }
}
