// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/presentation/widgets/shopping_list_view.dart
// O QUÊ:     Aba Lista: legenda, grupos por categoria (CheckItem + qtd) e "Comprei tudo".
// USA:       shopping_providers, category_group, core/widgets (HairlineRow, CheckItem,
//            PitadaButton, EmptyState), utils/format, theme/*.
// USADO POR: shopping_screen (corpo da aba Lista).
// SPEC:      specs/features/shopping.yaml (screens.ShoppingScreen.lista)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/check_item.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../application/shopping_providers.dart';
import '../../data/shopping_item.dart';
import 'category_group.dart';

/// Corpo da aba Lista: legenda de contexto, grupos por categoria e botão final.
/// A quantidade já vem somada por unidade e subtraída da despensa (ver providers).
/// Usada por: shopping_screen.
class ShoppingListView extends ConsumerWidget {
  const ShoppingListView({super.key});

  /// Renderiza a lista agrupada ou um EmptyState quando não há nada a comprar.
  /// Usada por: shopping_screen (aba 0).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = ref.watch(listByCategoryProvider);

    if (grouped.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Lista vazia',
          message: 'Adicione receitas ao plano para gerar a lista de compras.',
          icon: AppIcons.basket,
        ),
      );
    }

    final categories = grouped.keys.toList();
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        _legend(),
        for (var c = 0; c < categories.length; c++)
          CategoryGroup(
            label: categories[c],
            topGap: c == 0 ? AppSpacing.xl : AppSpacing.xxxl,
            children: [
              for (var i = 0; i < grouped[categories[c]]!.length; i++)
                _ShoppingRow(
                  item: grouped[categories[c]]![i],
                  showDivider: i != grouped[categories[c]]!.length - 1,
                  onToggle: () => ref
                      .read(shoppingListProvider.notifier)
                      .toggle(grouped[categories[c]]![i].id),
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.xxxl,
            AppSpacing.gutter,
            0,
          ),
          child: PitadaButton(
            label: 'Comprei tudo',
            icon: AppIcons.check,
            onPressed: () {
              ref.read(shoppingListProvider.notifier).checkAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Guardado na despensa')),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Legenda que explica como a quantidade foi calculada. Usada por: [build].
  Widget _legend() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Text(
        'Somado por unidade · já descontamos o que há na despensa',
        style: AppType.on(AppType.caption, AppColors.muted),
      ),
    );
  }
}

/// Uma linha da lista: CheckItem (círculo) + nome + quantidade somada e grama menor.
/// Usada por: [ShoppingListView].
class _ShoppingRow extends StatelessWidget {
  const _ShoppingRow({
    required this.item,
    required this.showDivider,
    required this.onToggle,
  });

  final ShoppingItem item;
  final bool showDivider;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final done = item.checked;
    final nameStyle = done
        ? AppType.on(AppType.body, AppColors.muted)
            .copyWith(decoration: TextDecoration.lineThrough)
        : AppType.body;
    return HairlineRow(
      showDivider: showDivider,
      onTap: onToggle,
      leading: CheckItem(
        checked: done,
        shape: CheckShape.circle,
        onChanged: (_) => onToggle(),
      ),
      title: Text(item.name, style: nameStyle),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatHuman(item.humanQty, item.humanUnit),
            style: AppType.numeral,
          ),
          if (item.grams != null && item.humanUnit != 'g')
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                formatGrams(item.grams),
                style: AppType.on(AppType.captionSm, AppColors.muted),
              ),
            ),
        ],
      ),
    );
  }
}
