// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/grocery_list_view.dart
// O QUÊ:     Aba Compras: 'Meus carrinhos' + abas-pasta (CartTabBar) e o
//            card-pasta do carrinho ativo — CartHeader fixo, miolo ROLÁVEL
//            (categorias em destaque + GroceryRow + 'Adicionar ingrediente') e
//            rodapé fixo ('N itens restantes' + 'Concluir compra').
// USA:       providers, cart_tab_bar, cart_header, grocery_row, add_item_sheet,
//            core/widgets (HairlineRow, PitadaButton, EmptyState), theme/*.
// USADO POR: groceries_screen (corpo da aba Compras).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen.compras)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/layout/empty_state.dart';
import '../../application/providers.dart';
import '../../data/grocery_list.dart';
import '../add_item_sheet.dart';
import 'cart_header.dart';
import 'cart_tab_bar.dart';
import 'grocery_row.dart';

/// Corpo da aba Compras: abas de carrinho + card-pasta com o miolo rolável.
/// Usada por: groceries_screen.
class GroceryListView extends ConsumerWidget {
  const GroceryListView({super.key});

  /// Monta rótulo, abas e o card do carrinho ativo (só o miolo rola).
  /// Usada por: groceries_screen (aba 0).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final lists = ref.watch(groceryListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    final activeIsFirst = lists.indexWhere((l) => l.id == activeId) <= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.screenH.copyWith(top: AppSpacing.xl),
          child: Text(
            'Meus carrinhos',
            style: AppType.on(AppType.bodyLg, pit.text),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const CartTabBar(),
        Expanded(child: _card(context, ref, pit, activeIsFirst)),
      ],
    );
  }

  /// O card-pasta: emenda na aba ativa (canto reto quando ela é a primeira),
  /// cabeçalho e rodapé fixos, miolo rolável. Usada por: [build].
  Widget _card(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    bool activeIsFirst,
  ) {
    final list = ref.watch(activeListProvider);
    final shown = ref.watch(activeListItemsProvider);
    final remaining = shown.where((i) => !i.checked).length;
    const radius = Radius.circular(AppSpacing.radiusCard);
    return Container(
      margin: EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        MediaQuery.paddingOf(context).bottom + AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: BorderRadius.only(
          topLeft: activeIsFirst ? Radius.zero : radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Column(
        children: [
          const CartHeader(),
          Expanded(
            child: shown.isEmpty
                ? EmptyState(
                    title:
                        list.items.isNotEmpty ? 'Nada a comprar' : 'Lista vazia',
                    message: list.items.isNotEmpty
                        ? 'Tudo o que esta lista pede já está na despensa.'
                        : 'Adicione receitas ao plano para gerar a lista.',
                    icon: AppIcons.basket,
                  )
                : _body(context, ref, pit),
          ),
          if (shown.isNotEmpty) _footer(context, ref, pit, list, remaining),
        ],
      ),
    );
  }

  /// Miolo rolável: categorias em destaque, linhas e 'Adicionar ingrediente'.
  /// Usada por: [_card].
  Widget _body(BuildContext context, WidgetRef ref, PitadaColors pit) {
    final list = ref.watch(activeListProvider);
    final grouped = ref.watch(listByCategoryProvider);
    final coverage = ref.watch(pantryCoverageProvider);
    final categories = grouped.keys.toList();
    return ListView(
      key: ValueKey(list.id),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      children: [
        for (var c = 0; c < categories.length; c++) ...[
          Padding(
            padding: EdgeInsets.only(
              top: c == 0 ? AppSpacing.lg : AppSpacing.xxl,
            ),
            child: Text(
              categories[c],
              style: AppType.on(AppType.titleSm, pit.text),
            ),
          ),
          for (var i = 0; i < grouped[categories[c]]!.length; i++)
            GroceryRow(
              item: grouped[categories[c]]![i],
              coverage: coverage[grouped[categories[c]]![i].id],
              showDivider: i != grouped[categories[c]]!.length - 1,
              onToggle: () => ref
                  .read(groceryListsProvider.notifier)
                  .toggleItem(list.id, grouped[categories[c]]![i].id),
            ),
        ],
        HairlineRow(
          showDivider: false,
          onTap: () => showAddItemSheet(context, ref),
          leading: const Icon(AppIcons.add, size: 18, color: AppColors.accent),
          title: Text(
            'Adicionar ingrediente',
            style: AppType.on(AppType.body, AppColors.accent),
          ),
        ),
      ],
    );
  }

  /// Rodapé fixo do card: filete, 'N itens restantes' e 'Concluir compra'.
  /// Usada por: [_card].
  Widget _footer(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    GroceryList list,
    int remaining,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: pit.line, width: AppSpacing.hair),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$remaining ${remaining == 1 ? 'item restante' : 'itens restantes'}',
            style: AppType.on(AppType.title, pit.text),
          ),
          const SizedBox(height: AppSpacing.lg),
          PitadaButton(
            label: 'Concluir compra',
            onPressed: () {
              ref.read(groceryListsProvider.notifier).checkAll(list.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Guardado na despensa')),
              );
            },
          ),
        ],
      ),
    );
  }

}
