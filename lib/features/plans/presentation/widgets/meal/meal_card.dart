// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/meal_card.dart
// O QUÊ:     Seção de uma refeição DIRETO no fundo da aba (sem caixa): cabeçalho
//            (nome + 'Meta N kcal' + lápis) sobre a pasta de opções
//            (MealOptionTabs + MealOptionPanel) e o link 'Comparar opções'.
// USA:       theme/*, data/meal, plan_providers, sheets, option_tabs,
//            option_panel, go_router.
// USADO POR: plans_screen (uma seção por refeição do plano).
// SPEC:      specs/features/plans/plans.yaml (MealCard, MealHeaderRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../application/plan_providers.dart';
import '../../../data/models/meal.dart';
import '../../sheets/plan/add_option_sheet.dart';
import '../../sheets/plan/compare_options_sheet.dart';
import '../../sheets/plan/meal_sheet.dart';
import '../../sheets/plan/option_name_sheet.dart';
import 'option_panel.dart';
import 'option_tabs.dart';

/// Seção de uma refeição: cabeçalho (nome + meta) sobre a pasta de opções.
/// A aba ativa é a opção escolhida; tocar noutra a escolhe. Usada por: plans_screen.
class MealCard extends ConsumerWidget {
  const MealCard({super.key, required this.meal, required this.index});

  final Meal meal;

  /// Posição da refeição na lista — usada pelo arrastar-para-reordenar.
  final int index;

  /// Monta o cabeçalho + a pasta de opções (ou o atalho de adicionar) + o link
  /// de comparar. Usada por: plans_screen.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MealHeaderRow(meal: meal, index: index),
          const SizedBox(height: AppSpacing.md),
          if (meal.options.isEmpty)
            _addOption(context)
          else
            _folder(context, ref),
          if (meal.options.length >= 2) ...[
            const SizedBox(height: AppSpacing.lg),
            _compare(context),
          ],
        ],
      ),
    );
  }

  /// Fita de abas + corpo da opção ativa (índice = opção escolhida, ou a 1ª).
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
        onAddItem: () => showAddOptionSheet(context, meal: meal),
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

  /// Link 'Comparar opções ->' abaixo da pasta (só com 2+ opções).
  /// Usada por: [build].
  Widget _compare(BuildContext context) {
    return GestureDetector(
      onTap: () => showCompareOptionsSheet(context, meal: meal),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Comparar opções',
            style: AppType.on(AppType.bodySm, AppColors.accent2),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(AppIcons.forward, size: 15, color: AppColors.accent2),
        ],
      ),
    );
  }
}

/// Cabeçalho da refeição: nome (toca -> editar; segurar -> arrastar/reordenar)
/// + 'Meta N kcal' + lápis à direita (toca -> editar). Usada por: MealCard.
class MealHeaderRow extends StatelessWidget {
  const MealHeaderRow({super.key, required this.meal, required this.index});

  final Meal meal;

  /// Posição da refeição na lista — informa o ReorderableListView ao segurar o nome.
  final int index;

  /// Monta a linha do cabeçalho (nome + meta + lápis). Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Row(
      children: [
        Expanded(
          child: ReorderableDelayedDragStartListener(
            index: index,
            child: GestureDetector(
              onTap: () => showMealSheet(context, meal: meal),
              behavior: HitTestBehavior.opaque,
              child: Text(
                meal.name,
                style: AppType.on(AppType.title, pit.text),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => showMealSheet(context, meal: meal),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                'Meta ${formatKcal(meal.kcalGoal)} kcal',
                style: AppType.on(AppType.caption, pit.muted),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(AppIcons.edit, size: 14, color: pit.muted),
            ],
          ),
        ),
      ],
    );
  }
}
