// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/meal_card.dart
// O QUÊ:     Cartão de uma refeição: cabeçalho editável + fita de abas das opções
//            (MealOptionTabs sobre MealOptionPanel) ou, se vazia, "Adicionar opção".
// USA:       theme/*, data/meal, plan_providers, sheets, option_tabs, option_panel, go_router.
// USADO POR: plans_screen (um card por refeição do plano).
// SPEC:      specs/features/plans/plans.yaml (MealCard, MealHeaderRow)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../application/plan_providers.dart';
import '../../../data/models/meal.dart';
import '../../sheets/plan/add_option_sheet.dart';
import '../../sheets/plan/meal_sheet.dart';
import '../../sheets/plan/option_name_sheet.dart';
import 'option_panel.dart';
import 'option_tabs.dart';

/// Cartão de uma refeição: cabeçalho (nome + meta) e as opções como abas de pasta.
/// A aba ativa é a opção escolhida; tocar noutra a escolhe. Usada por: plans_screen.
class MealCard extends ConsumerWidget {
  const MealCard({super.key, required this.meal, required this.index});

  final Meal meal;

  /// Posição da refeição na lista — usada pela pega de arrastar (reordenar).
  final int index;

  /// Monta o cabeçalho + as abas/painel das opções (ou o atalho de adicionar).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MealHeaderRow(meal: meal, index: index),
          const SizedBox(height: AppSpacing.md),
          if (meal.options.isEmpty)
            _addOption(context)
          else
            _folder(context, ref),
        ],
      ),
    );
  }

  /// Fita de abas + painel da opção ativa (índice = opção escolhida, ou a 1ª).
  /// Usada por: [build].
  Widget _folder(BuildContext context, WidgetRef ref) {
    final chosen = meal.options.indexWhere((o) => o.chosen);
    final active = chosen >= 0 ? chosen : 0;
    return MealOptionTabs(
      options: meal.options,
      active: active,
      onChoose: (i) =>
          ref.read(planControllerProvider.notifier).chooseOption(meal.id, i),
      onRename: (i) => showOptionNameSheet(
        context,
        mealId: meal.id,
        optionIndex: i,
        currentName: meal.options[i].name,
      ),
      onAdd: () => showAddOptionSheet(context, meal: meal),
      panel: MealOptionPanel(
        option: meal.options[active],
        onTapDish: (di) {
          final id = meal.options[active].items[di].recipeId;
          if (id != null) context.push('/recipe/$id');
        },
      ),
    );
  }

  /// Atalho "Adicionar opção" para refeições ainda sem opções. Usada por: [build].
  Widget _addOption(BuildContext context) {
    return GestureDetector(
      onTap: () => showAddOptionSheet(context, meal: meal),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            const Icon(AppIcons.add, size: 17, color: AppColors.accent),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Adicionar opção',
              style: AppType.on(AppType.caption, AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cabeçalho da refeição: nome (toca → editar) + lápis + meta em kcal + pega de arrastar.
/// Usada por: MealCard. Tocar no nome abre showMealSheet; a pega reordena a refeição.
class MealHeaderRow extends StatelessWidget {
  const MealHeaderRow({super.key, required this.meal, required this.index});

  final Meal meal;

  /// Posição da refeição na lista — a pega de arrastar a informa ao ReorderableListView.
  final int index;

  /// Monta a linha do cabeçalho editável + meta + pega de arrastar. Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => showMealSheet(context, meal: meal),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    meal.name,
                    style: AppType.on(AppType.title, pit.text),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(AppIcons.edit, size: 15, color: pit.faint),
              ],
            ),
          ),
        ),
        Text(
          'meta ${formatKcal(meal.kcalGoal)} kcal',
          style: AppType.on(AppType.caption, pit.muted),
        ),
        const SizedBox(width: AppSpacing.sm),
        ReorderableDragStartListener(
          index: index,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Icon(AppIcons.dragHandle, size: 18, color: pit.faint),
          ),
        ),
      ],
    );
  }
}
