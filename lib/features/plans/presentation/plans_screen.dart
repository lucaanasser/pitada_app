// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/plans_screen.dart
// O QUÊ:     Aba Planos: plano ativo, resumo do dia, seletor de dias e refeições.
// USA:       core/widgets, plans_providers, os widgets/sheets da feature, theme/*.
// USADO POR: core/router/router.dart (branch /plans).
// SPEC:      specs/features/plans.yaml (PlansScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../application/plans_providers.dart';
import '../data/plan.dart';
import 'meal_sheet.dart';
import 'widgets/day_selector.dart';
import 'widgets/day_summary.dart';
import 'widgets/meal_card.dart';

/// Tela principal de Planos. Usada por: router (/plans).
class PlansScreen extends ConsumerWidget {
  const PlansScreen({super.key});

  /// Monta a aba inteira (plano, resumo, dias, refeições). Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(planControllerProvider);
    final totals = ref.watch(dayTotalsProvider);
    return PitadaScaffold(
      top: const Masthead(),
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.lg,
            ),
            child: _planHeader(plan),
          ),
          Padding(
            padding: AppSpacing.screenH,
            child: DaySummaryCard(goalKcal: plan.dailyKcalGoal, totals: totals),
          ),
          const SizedBox(height: AppSpacing.xl),
          const DaySelector(),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: AppSpacing.screenH,
            child: Column(
              children: [
                for (final meal in plan.meals) MealCard(meal: meal),
                const SizedBox(height: AppSpacing.xs),
                PitadaButton(
                  label: 'Adicionar refeição',
                  icon: Icons.add,
                  variant: PitadaButtonVariant.outline,
                  onPressed: () => showMealSheet(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Cabeçalho do plano: nome + meta/dia + ícone de configuração. Usada por: [build].
  Widget _planHeader(Plan plan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(plan.name, style: AppType.screenTitle),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${formatKcal(plan.dailyKcalGoal)} kcal por dia',
                style: AppType.on(AppType.caption, AppColors.muted),
              ),
            ],
          ),
        ),
        const PitadaIconButton(icon: Icons.tune),
      ],
    );
  }
}
