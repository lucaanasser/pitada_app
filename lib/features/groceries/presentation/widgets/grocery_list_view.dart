// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/grocery_list_view.dart
// O QUÊ:     Aba Lista: cabeçalho da lista ativa (nome + caret), toggle
//            "descontar a despensa" em HairlineRow (o caso praia = desligado),
//            grupos por categoria e "Comprei tudo". Quantidades já derivadas.
// USA:       shopping_providers, list_header, category_group, core/widgets
//            (HairlineRow, CheckItem, PitadaButton, EmptyState), utils/format, theme/*.
// USADO POR: shopping_screen (corpo da aba Lista).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen.lista)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/check_item.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../../../core/widgets/pitada_scaffold.dart';
import '../../application/providers.dart';
import '../../data/grocery_item.dart';
import '../../data/grocery_list.dart';
import 'category_group.dart';
import 'list_header.dart';

/// Corpo da aba Lista: seletor de listas, toggle da despensa e itens agrupados.
/// Usada por: shopping_screen.
class GroceryListView extends ConsumerWidget {
  const GroceryListView({super.key});

  /// Renderiza o cabeçalho da lista, o toggle e a lista agrupada (ou EmptyState).
  /// Usada por: shopping_screen (aba 0).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final list = ref.watch(activeListProvider);
    final grouped = ref.watch(listByCategoryProvider);
    final categories = grouped.keys.toList();

    return ListView(
      padding: tabListPadding(context),
      children: [
        const Padding(
          padding: EdgeInsets.only(top: AppSpacing.md),
          child: ListHeaderRow(),
        ),
        _pantryToggle(pit, ref, list),
        if (grouped.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxxl),
            child: _empty(list),
          )
        else ...[
          for (var c = 0; c < categories.length; c++)
            CategoryGroup(
              label: categories[c],
              topGap: c == 0 ? AppSpacing.xl : AppSpacing.xxxl,
              children: [
                for (var i = 0; i < grouped[categories[c]]!.length; i++)
                  _GroceryRow(
                    item: grouped[categories[c]]![i],
                    showDivider: i != grouped[categories[c]]!.length - 1,
                    onToggle: () => ref
                        .read(groceryListsProvider.notifier)
                        .toggleItem(list.id, grouped[categories[c]]![i].id),
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
                ref.read(groceryListsProvider.notifier).checkAll(list.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Guardado na despensa')),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  /// Toggle "descontar a despensa" da lista ativa como HairlineRow (o subtítulo
  /// explica o estado; desligado = caso praia). Usada por: [build].
  Widget _pantryToggle(PitadaColors pit, WidgetRef ref, GroceryList list) {
    void flip() =>
        ref.read(groceryListsProvider.notifier).togglePantry(list.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        0,
      ),
      child: HairlineRow(
        showDivider: false,
        onTap: flip,
        title: Text(
          'Descontar a despensa',
          style: AppType.on(AppType.body, pit.text),
        ),
        subtitle: Text(
          list.usePantry
              ? 'O que já está na despensa sai da conta'
              : 'Mostrando tudo, sem descontar',
          style: AppType.on(AppType.captionSm, pit.muted),
        ),
        trailing: CheckItem(
          checked: list.usePantry,
          shape: CheckShape.square,
          onChanged: (_) => flip(),
        ),
      ),
    );
  }

  /// EmptyState da lista ativa: distingue lista sem itens de lista toda coberta
  /// pela despensa. Usada por: [build].
  Widget _empty(GroceryList list) {
    final covered = list.items.isNotEmpty;
    return EmptyState(
      title: covered ? 'Nada a comprar' : 'Lista vazia',
      message: covered
          ? 'Tudo o que esta lista pede já está na despensa.'
          : 'Adicione receitas ao plano para gerar a lista de compras.',
      icon: AppIcons.basket,
    );
  }
}

/// Uma linha da lista: CheckItem (círculo) + nome + quantidade somada e grama menor.
/// Usada por: [GroceryListView].
class _GroceryRow extends StatelessWidget {
  const _GroceryRow({
    required this.item,
    required this.showDivider,
    required this.onToggle,
  });

  final GroceryItem item;
  final bool showDivider;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final done = item.checked;
    final nameStyle = done
        ? AppType.on(AppType.body, pit.muted)
            .copyWith(decoration: TextDecoration.lineThrough)
        : AppType.on(AppType.body, pit.text);
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
            style: AppType.on(AppType.numeral, pit.text),
          ),
          if (item.grams != null && item.humanUnit != 'g')
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                formatGrams(item.grams),
                style: AppType.on(AppType.captionSm, pit.muted),
              ),
            ),
        ],
      ),
    );
  }
}
