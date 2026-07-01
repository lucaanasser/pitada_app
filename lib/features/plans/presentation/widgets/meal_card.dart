// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal_card.dart
// O QUÊ:     Cartão de uma refeição: cabeçalho editável + OptionCards + adicionar opção.
// USA:       theme/*, core/widgets (OptionCard), data/meal, plans_providers, sheets, go_router.
// USADO POR: plans_screen (um card por refeição do plano).
// SPEC:      specs/features/plans.yaml (MealCard, MealHeaderRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/option_card.dart';
import '../../application/plans_providers.dart';
import '../../data/meal.dart';
import '../add_option_sheet.dart';
import '../meal_sheet.dart';

/// Cartão de uma refeição: cabeçalho (nome + meta), opções e "Adicionar opção".
/// Tocar numa opção a escolhe; prato linkado abre a receita. Usada por: plans_screen.
class MealCard extends ConsumerWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  /// Monta o cabeçalho + a lista de OptionCards + a ação de adicionar opção.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MealHeaderRow(meal: meal),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < meal.options.length; i++)
            _option(context, ref, i),
          _addOption(context),
        ],
      ),
    );
  }

  /// Renderiza a opção [i] como OptionCard, ligando escolha e pratos linkados.
  /// Usada por: [build].
  Widget _option(BuildContext context, WidgetRef ref, int i) {
    final option = meal.options[i];
    final dishes = [
      for (final item in option.items)
        OptionDish(name: item.name, kcal: item.kcal, linked: item.linked),
    ];
    return OptionCard(
      name: 'Opção ${i + 1}',
      dishes: dishes,
      chosen: option.chosen,
      fits: option.fits,
      fitLabel: option.fitLabel,
      onChoose: () =>
          ref.read(planControllerProvider.notifier).chooseOption(meal.id, i),
      onTapDish: (di) {
        final id = option.items[di].recipeId;
        if (id != null) context.push('/recipe/$id');
      },
    );
  }

  /// Linha/botão "Adicionar opção" que abre o seletor de receitas. Usada por: [build].
  Widget _addOption(BuildContext context) {
    return GestureDetector(
      onTap: () => showAddOptionSheet(context, meal: meal),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            const Icon(Icons.add, size: 17, color: AppColors.accent),
            const SizedBox(width: AppSpacing.sm),
            Text('Adicionar opção',
                style: AppType.on(AppType.caption, AppColors.accent)),
          ],
        ),
      ),
    );
  }
}

/// Cabeçalho da refeição: nome (toca → editar) + lápis + meta em kcal.
/// Usada por: MealCard. Tocar abre showMealSheet no modo edição.
class MealHeaderRow extends StatelessWidget {
  const MealHeaderRow({super.key, required this.meal});

  final Meal meal;

  /// Monta a linha do cabeçalho editável. Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showMealSheet(context, meal: meal),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Text(meal.name, style: AppType.title),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.edit_outlined, size: 15, color: AppColors.faint),
          const Spacer(),
          Text(
            'meta ${formatKcal(meal.kcalGoal)} kcal',
            style: AppType.on(AppType.caption, AppColors.muted),
          ),
        ],
      ),
    );
  }
}
