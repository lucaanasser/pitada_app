// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/plans_screen.dart
// O QUÊ:     Aba Plano: cabeçalho (marca + título + data + resumo do dia) e
//            sub-abas "Cardápio"/"Progresso". Ao rolar o corpo, o resumo COLAPSA
//            do anel (DaySummaryView) p/ barras de macro (MacroLinesView), pra
//            liberar altura das refeições. Sub-aba e colapso via setState.
// USA:       core/widgets, theme/*, utils/format, plan_providers, goal_sheet,
//            DaySummaryView, MacroLinesView, dayMacroRings, MenuView, ProgressView.
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
import 'widgets/meal/macro_lines_view.dart';
import 'widgets/meal/macro_ring_painter.dart';
import 'widgets/progress/progress_view.dart';

/// Tela principal de Plano com cabeçalho compartilhado + sub-abas. Usada por: router (/plans).
class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  /// Limiares de scroll: rolou além de [_ringAt] o anel vira barras; além de
  /// [_titleAt] o título 'Plano' recolhe. Snap de [_dur] nos dois.
  static const double _ringAt = 24;
  static const double _titleAt = 132;
  static const Duration _dur = Duration(milliseconds: 220);

  /// Sub-aba ativa: 0 = Cardápio (refeições), 1 = Progresso (peso + aderência).
  int _tab = 0;

  /// Anel recolhido em barras de macro (rolou além de [_ringAt]).
  bool _collapsed = false;

  /// Título 'Plano' recolhido, liberando mais altura (rolou além de [_titleAt]).
  bool _titleHidden = false;

  /// Recolhe o cabeçalho em dois estágios pelos limiares de scroll; só reconstrói
  /// na virada (sem spam por frame). Usada por: [build].
  bool _onScroll(ScrollNotification n) {
    if (n.metrics.axis != Axis.vertical) return false;
    final p = n.metrics.pixels;
    if ((p > _ringAt) != _collapsed || (p > _titleAt) != _titleHidden) {
      setState(() {
        _collapsed = p > _ringAt;
        _titleHidden = p > _titleAt;
      });
    }
    return false;
  }

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
          AnimatedCrossFade(
            duration: _dur,
            sizeCurve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            crossFadeState: _titleHidden
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _titleRow(pit),
            secondChild: const SizedBox(width: double.infinity),
          ),
          _summary(),
          Align(
            alignment: Alignment.centerLeft,
            child: PitadaTabs(
              tabs: const ['Cardápio', 'Progresso'],
              selected: _tab,
              onSelect: (i) => setState(() {
                _tab = i;
                _collapsed = false;
                _titleHidden = false;
              }),
            ),
          ),
        ],
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: _tab == 0 ? const MenuView() : const ProgressView(),
      ),
    );
  }

  /// Título fixo do topo: 'Plano' + 'Hoje, D mmm' + botão '+' (showPlanAddSheet).
  /// Recolhe ao rolar (2º estágio). Usada por: [build].
  Widget _titleRow(PitadaColors pit) {
    return Padding(
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
                Text('Plano', style: AppType.on(AppType.screenTitle, pit.text)),
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
    );
  }

  /// Resumo do dia que colapsa no scroll: anel + legenda + 'Restam/Editar metas'
  /// em repouso; barras de macro (MacroLinesView) ao rolar. Snap animado ~220ms.
  /// Usada por: [build].
  Widget _summary() {
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    final rings = dayMacroRings(
      kcal: totals.kcal,
      goalKcal: plan.dailyKcalGoal,
      protein: totals.protein,
      proteinGoal: plan.proteinGoal,
      carb: totals.carb,
      carbGoal: plan.carbGoal,
      fat: totals.fat,
      fatGoal: plan.fatGoal,
    );
    return Padding(
      padding: AppSpacing.screenH,
      child: AnimatedCrossFade(
        duration: _dur,
        sizeCurve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        crossFadeState:
            _collapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        firstChild: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DaySummaryView(rings: rings),
            const SizedBox(height: AppSpacing.lg),
            _goalsRow(),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
        secondChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: MacroLinesView(rings: rings),
        ),
      ),
    );
  }

  /// Linha sob o anel: 'Restam N kcal' à esquerda e 'Editar metas' (showGoalSheet)
  /// à direita. Usada por: [_summary].
  Widget _goalsRow() {
    final pit = context.pit;
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    final left = plan.dailyKcalGoal - totals.kcal;
    final label = left >= 0
        ? 'Restam ${formatKcal(left)} kcal'
        : '${formatKcal(-left)} kcal acima';
    return Row(
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
    );
  }
}
