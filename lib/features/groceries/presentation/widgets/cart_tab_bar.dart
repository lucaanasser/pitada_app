// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/cart_tab_bar.dart
// O QUÊ:     Abas-pasta dos carrinhos: delega a fita ao FolderTabs (UX único de
//            abas-pasta do app). Os carrinhos dividem a largura do card; a '+'
//            cria um novo. A ativa usa o surf do card e emenda nele.
// USA:       providers (carrinhos + ativo), new_list_sheet (createAndSelectList),
//            core/widgets (FolderTabs), theme/pitada_colors.
// USADO POR: grocery_list_view (o topo do card-pasta).
// SPEC:      specs/features/groceries.yaml (screens.compras: CartTabBar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/tabs/folder_tabs.dart';
import '../../application/providers.dart';
import '../new_list_sheet.dart';

/// Fita de abas-pasta: os carrinhos dividem a largura; '+' cria um novo.
/// Usada por: grocery_list_view.
class CartTabBar extends ConsumerWidget {
  const CartTabBar({super.key});

  /// Monta as abas na largura do card; tocar troca o carrinho ativo.
  /// Usada por: grocery_list_view.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(groceryListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    final active = lists.indexWhere((l) => l.id == activeId);
    return Padding(
      padding: AppSpacing.screenH,
      child: FolderTabs(
        tabs: [for (final l in lists) FolderTab(label: l.tabLabel)],
        active: active < 0 ? 0 : active,
        surface: context.pit.surf,
        onSelect: (i) =>
            ref.read(activeListIdProvider.notifier).state = lists[i].id,
        onAdd: () => createAndSelectList(context, ref),
      ),
    );
  }
}
