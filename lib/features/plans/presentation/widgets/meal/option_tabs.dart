// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/option_tabs.dart
// O QUÊ:     Fita de abas estilo pasta das opções de uma refeição, sobre o painel
//            da opção ativa. A aba ativa (opção escolhida) conecta-se ao painel
//            (mesmo surf2, sem filete embaixo) e leva o selo "Hoje"; as demais ficam
//            fechadas/muted. Aba "+" adiciona. Rótulo livre (cai em "Opção N").
// USA:       theme/*, core/widgets (Editable, PitadaTag), data/meal_option.
// USADO POR: MealCard (envolve o MealOptionPanel).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MealOptionTabs)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/editable.dart';
import '../../../../../core/widgets/tags/pitada_tag.dart';
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

  /// Altura da aba e quanto ela avança sobre o painel (esconde o filete do topo).
  static const double _tabH = 40;
  static const double _overlap = 4;

  /// Empilha o painel (recuado p/ caber as abas) e a fita de abas por cima.
  /// Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: _tabH - _overlap),
          child: panel,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < options.length; i++) _tab(context, i),
              _addTab(context),
            ],
          ),
        ),
      ],
    );
  }

  /// Uma aba de opção. Ativa: surf2 + sem filete embaixo (conecta ao painel) +
  /// selo "Hoje" se escolhida; inativa: fechada e muted. Usada por: [build].
  Widget _tab(BuildContext context, int i) {
    final pit = context.pit;
    final option = options[i];
    final on = i == active;
    final label = option.name.isEmpty ? 'Opção ${i + 1}' : option.name;
    final side = BorderSide(color: pit.line2, width: AppSpacing.borderStrong);
    return GestureDetector(
      onTap: () => onChoose(i),
      behavior: HitTestBehavior.opaque,
      child: Editable(
        onEdit: on ? () => onRename(i) : null,
        child: Container(
          height: _tabH,
          margin: const EdgeInsets.only(right: AppSpacing.xs),
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: _overlap,
          ),
          decoration: BoxDecoration(
            color: on ? pit.surf2 : pit.surf,
            border: Border(
              top: side,
              left: side,
              right: side,
              bottom: on ? BorderSide.none : side,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppType.on(AppType.titleXs, on ? pit.text : pit.muted),
              ),
              if (option.chosen) ...[
                const SizedBox(width: AppSpacing.sm),
                const PitadaTag(label: 'Hoje', color: AppColors.sage),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Aba "+" (fechada) que adiciona uma opção. Usada por: [build].
  Widget _addTab(BuildContext context) {
    final pit = context.pit;
    final side = BorderSide(color: pit.line2, width: AppSpacing.borderStrong);
    return GestureDetector(
      onTap: onAdd,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: _tabH,
        padding: const EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: _overlap,
        ),
        decoration: BoxDecoration(
          color: pit.surf,
          border: Border(top: side, left: side, right: side, bottom: side),
        ),
        child: Center(child: Icon(AppIcons.add, size: 17, color: pit.muted)),
      ),
    );
  }
}
