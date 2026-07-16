// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/plans_screen.dart
// O QUÊ:     Aba Plano: cabeçalho compartilhado (marca + título 'Plano' + resumo do
//            dia em kcal + macros) e, logo abaixo, sub-abas "Cardápio" (refeições) e
//            "Progresso" (peso + aderência). Título e DaySummary são fixos nas duas
//            sub-abas; o switcher fica logo abaixo dos macros. Alterna por setState.
// USA:       core/widgets (Masthead, PitadaTabs, PitadaScaffold), theme/*,
//            plans_providers (DaySummary), CardapioView e ProgressView.
// USADO POR: core/router/router.dart (branch /plans).
// SPEC:      specs/features/plans_progress.yaml (navegacao) e plans.yaml (PlansScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/pitada_tabs.dart';
import '../application/plans_providers.dart';
import 'plan_add_sheet.dart';
import 'widgets/cardapio_view.dart';
import 'widgets/day_summary.dart';
import 'widgets/progress_view.dart';

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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'Plano',
                    style: AppType.on(AppType.screenTitle, pit.text),
                  ),
                ),
                PitadaIconButton(
                  icon: AppIcons.add,
                  filled: true,
                  size: AppSpacing.iconButtonSm,
                  onPressed: () => showPlanAddSheet(context),
                ),
              ],
            ),
          ),
          _daySummary(),
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
      child: _tab == 0 ? const CardapioView() : const ProgressView(),
    );
  }

  /// Resumo do dia (kcal grande + status + FuelBar + macros), fixo entre o título
  /// e as sub-abas (é o 1º conteúdo abaixo do título). Usada por: [build].
  Widget _daySummary() {
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.xl,
      ),
      child: DaySummary(goalKcal: plan.dailyKcalGoal, totals: totals),
    );
  }
}
