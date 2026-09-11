// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/option_panel.dart
// O QUÊ:     Corpo da pasta da opção ativa (abaixo da fita de abas): pratos com
//            marca-página de receita (linkado) ou bolinha (avulso) + porção,
//            linha '+ Receita ou alimento' e rodapé (total + encaixe + P/C/G).
//            Sem borda: cor chapada, raio só nos cantos de baixo (abas no topo).
// USA:       theme/*, utils/format, core/widgets (HairlineRow), data/meal_option,
//            recipes (RecipeMark + Mastery — o mesmo marca-página da lista).
// USADO POR: MealCard (via MealOptionTabs).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MealOptionPanel)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../recipes/application/recipe_filters.dart';
import '../../../../recipes/presentation/widgets/list/recipe_row.dart';
import '../../../data/models/meal_option.dart';

/// Corpo da pasta: pratos (ícone + nome + porção + kcal + chevron), linha de
/// adicionar e rodapé com total/encaixe/macros. [onTapDish] só dispara em pratos
/// linkados (abre a receita); [onAddItem] abre o fluxo de adicionar.
/// Usada por: MealCard.
class MealOptionPanel extends StatelessWidget {
  const MealOptionPanel({
    super.key,
    required this.option,
    this.onTapDish,
    this.onAddItem,
  });

  final MealOption option;
  final ValueChanged<int>? onTapDish;
  final VoidCallback? onAddItem;

  /// Largura do slot do ícone à esquerda (alinha marca-página e bolinha).
  static const double _leadW = 40;

  /// Monta o corpo (pratos + adicionar + rodapé), sem borda. Usada por: MealCard.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: pit.surf2,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppSpacing.radiusCard),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < option.items.length; i++) _dish(context, i),
          _addRow(context),
          const SizedBox(height: AppSpacing.lg),
          _footer(pit),
        ],
      ),
    );
  }

  /// Um prato: marca-página (linkado) ou bolinha (avulso) + nome + porção +
  /// kcal + chevron. Toque só nos linkados (abre a receita). Usada por: [build].
  Widget _dish(BuildContext context, int i) {
    final pit = context.pit;
    final item = option.items[i];
    return HairlineRow(
      onTap: item.linked ? () => onTapDish?.call(i) : null,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      leading: _leading(pit, item),
      title: Text(
        item.name,
        style: AppType.on(AppType.body, pit.text)
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: item.portion == null
          ? null
          : Text(item.portion!, style: AppType.on(AppType.caption, pit.muted)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${formatKcal(item.kcal)} kcal',
            style: AppType.on(AppType.titleXs, pit.text),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(AppIcons.chevron, size: 15, color: pit.faint),
        ],
      ),
    );
  }

  /// Ícone do prato: o MESMO marca-página da lista de Receitas quando linkado;
  /// bolinha neutra quando avulso. Usada por: [_dish].
  Widget _leading(PitadaColors pit, MealOptionItem item) {
    if (item.linked) {
      return const RecipeMark(mastery: Mastery.some, versions: 1);
    }
    return SizedBox(
      width: _leadW,
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: pit.muted, shape: BoxShape.circle),
        ),
      ),
    );
  }

  /// Linha '+ Receita ou alimento' (accent) que abre o fluxo de adicionar.
  /// Usada por: [build].
  Widget _addRow(BuildContext context) {
    return HairlineRow(
      onTap: onAddItem,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      leading: const SizedBox(
        width: _leadW,
        child: Center(
          child: Icon(AppIcons.add, size: 18, color: AppColors.accent),
        ),
      ),
      title: Text(
        'Receita ou alimento',
        style: AppType.on(AppType.body, AppColors.accent)
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Rodapé: total kcal grande + encaixe na meta + linha P/C/G (valores claros,
  /// letras muted). Usada por: [build].
  Widget _footer(PitadaColors pit) {
    num protein = 0, carb = 0, fat = 0;
    for (final it in option.items) {
      protein += it.protein;
      carb += it.carb;
      fat += it.fat;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${formatKcal(option.totalKcal)} kcal',
              style: AppType.on(AppType.numeralLg, pit.text),
            ),
            const Spacer(),
            Text(
              option.fits ? 'Dentro da meta' : '${option.fitLabel} kcal',
              style: AppType.on(
                AppType.bodySm,
                option.fits ? AppColors.sage : AppColors.accent2,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text.rich(
          TextSpan(
            style: AppType.on(AppType.caption, pit.muted),
            children: [
              const TextSpan(text: 'P '),
              TextSpan(
                text: formatMacro(protein),
                style: AppType.on(AppType.caption, pit.text),
              ),
              const TextSpan(text: '  ·  C '),
              TextSpan(
                text: formatMacro(carb),
                style: AppType.on(AppType.caption, pit.text),
              ),
              const TextSpan(text: '  ·  G '),
              TextSpan(
                text: formatMacro(fat),
                style: AppType.on(AppType.caption, pit.text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
