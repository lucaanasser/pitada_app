// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/cardapio_view.dart
// O QUÊ:     Corpo da sub-aba "Cardápio": só a lista reordenável de refeições do
//            plano + botão de adicionar refeição. É lista (o que se pretende comer),
//            não log. O resumo do dia (kcal + macros) e as abas ficam no cabeçalho
//            compartilhado da PlansScreen, acima; o log fica em "Progresso".
// USA:       core/widgets, plans_providers, MealCard, meal_sheet, theme/*.
// USADO POR: plans_screen (sub-aba 0).
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: CardapioView)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../../../core/widgets/pitada_scaffold.dart';
import '../../application/plans_providers.dart';
import '../meal_sheet.dart';
import 'meal_card.dart';

/// Sub-aba "Cardápio": refeições reordenáveis do plano ativo. Usada por: PlansScreen.
class CardapioView extends ConsumerWidget {
  const CardapioView({super.key});

  /// Monta a lista de refeições + adicionar (sem título nem resumo, que vivem no
  /// cabeçalho da PlansScreen). Usada por: PlansScreen.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(planControllerProvider);
    return ListView(
      padding: tabListPadding(context),
      children: [
        const SizedBox(height: AppSpacing.md),
        ReorderableListView(
          // Embutida no ListView: não rola sozinha, encolhe ao conteúdo.
          // Sem pega padrão (usamos a do MealHeaderRow) e proxy flat (sem sombra).
          padding: AppSpacing.screenH,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          proxyDecorator: _dragProxy,
          onReorderItem: (oldIndex, newIndex) => ref
              .read(planControllerProvider.notifier)
              .reorderMeals(oldIndex, newIndex),
          children: [
            for (var i = 0; i < plan.meals.length; i++)
              MealCard(
                key: ValueKey(plan.meals[i].id),
                meal: plan.meals[i],
                index: i,
              ),
          ],
        ),
        Padding(
          padding: AppSpacing.screenH,
          child: PitadaButton(
            label: 'Adicionar refeição',
            icon: AppIcons.add,
            variant: PitadaButtonVariant.outline,
            onPressed: () => showMealSheet(context),
          ),
        ),
      ],
    );
  }

  /// Enquanto arrasta: mantém o card chapado (sem elevação/sombra). Usada por: [build].
  Widget _dragProxy(Widget child, int index, Animation<double> animation) {
    return Material(color: Colors.transparent, child: child);
  }
}
