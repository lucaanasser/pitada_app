// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/option_tabs.dart
// O QUÊ:     Fita de abas-pasta das opções de uma refeição: delega ao FolderTabs
//            (UX único de abas-pasta do app) e empilha o corpo da opção ativa
//            logo abaixo. Rótulo vazio cai em "Opção N". A ativa usa surf2 e
//            funde no MealOptionPanel.
// USA:       theme/pitada_colors, core/widgets (FolderTabs), data/meal_option.
// USADO POR: MealCard (envolve o MealOptionPanel).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MealOptionTabs)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/widgets/tabs/folder_tabs.dart';
import '../../../data/models/meal_option.dart';

/// Fita de abas das opções sobre o [panel] da opção ativa. Tocar numa aba =>
/// [onChoose]; segurar/duplo-clique na ativa => [onRename]; aba "+" => [onAdd].
/// [active] é o índice da aba em destaque. Usada por: MealCard.
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

  /// Empilha a fita de abas (largura cheia) sobre o corpo — a aba ativa e o
  /// corpo têm a mesma cor, sem emenda. Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FolderTabs(
          tabs: [
            for (var i = 0; i < options.length; i++)
              FolderTab(
                label:
                    options[i].name.isEmpty ? 'Opção ${i + 1}' : options[i].name,
                onEdit: () => onRename(i),
              ),
          ],
          active: active,
          surface: context.pit.surf2,
          onSelect: onChoose,
          onAdd: onAdd,
        ),
        panel,
      ],
    );
  }
}
