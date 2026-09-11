// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/option_tabs.dart
// O QUÊ:     Fita de abas de pasta das opções de uma refeição (como as abas
//            Ingredientes/Preparo/Histórico do detalhe da receita): abas de
//            largura igual preenchendo a fita, topo arredondado, sem borda.
//            A ativa tem a cor do corpo e funde com ele; inativas ficam muted.
//            Aba "+" estreita adiciona. Rótulo vazio cai em "Opção N".
// USA:       theme/*, core/widgets (Editable), data/meal_option.
// USADO POR: MealCard (envolve o MealOptionPanel).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MealOptionTabs)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/editable.dart';
import '../../../data/models/meal_option.dart';

/// Fita de abas das opções sobre o [panel] da opção ativa. Tocar numa aba =>
/// [onChoose] (escolhe a opção); segurar/duplo-clique na ativa => [onRename]; aba
/// "+" => [onAdd]. [active] é o índice da aba em destaque. Usada por: MealCard.
class MealOptionTabs extends StatelessWidget {
  const MealOptionTabs({
    super.key,
    required this.options,
    required this.active,
    required this.panel,
    required this.onChoose,
    required this.onRename,
    required this.onAdd,
  });

  final List<MealOption> options;
  final int active;
  final Widget panel;
  final ValueChanged<int> onChoose;
  final ValueChanged<int> onRename;
  final VoidCallback onAdd;

  /// Altura da fita e largura fixa da aba "+".
  static const double _tabH = 44;
  static const double _addW = 48;

  /// Empilha a fita de abas (largura cheia) sobre o corpo — a aba ativa e o
  /// corpo têm a mesma cor, sem emenda. Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _tabH,
          child: Row(
            children: [
              for (var i = 0; i < options.length; i++)
                Expanded(child: _tab(context, i)),
              _addTab(context),
            ],
          ),
        ),
        panel,
      ],
    );
  }

  /// Uma aba de opção: topo arredondado, cor do corpo quando ativa (funde),
  /// pit.surf e texto muted quando inativa. Usada por: [build].
  Widget _tab(BuildContext context, int i) {
    final pit = context.pit;
    final on = i == active;
    final label = options[i].name.isEmpty ? 'Opção ${i + 1}' : options[i].name;
    return GestureDetector(
      onTap: () => onChoose(i),
      behavior: HitTestBehavior.opaque,
      child: Editable(
        onEdit: on ? () => onRename(i) : null,
        child: Container(
          margin: const EdgeInsets.only(right: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? pit.surf2 : pit.surf,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppType.on(AppType.titleXs, on ? pit.text : pit.muted),
          ),
        ),
      ),
    );
  }

  /// Aba "+" estreita (inativa) que adiciona uma opção. Usada por: [build].
  Widget _addTab(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: onAdd,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _addW,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: pit.surf,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusMd),
          ),
        ),
        child: Icon(AppIcons.add, size: 17, color: pit.muted),
      ),
    );
  }
}
