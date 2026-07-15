// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/presentation/widgets/list_header.dart
// O QUÊ:     Cabeçalho da lista ativa: nome em Space Grotesk + caret (toca ->
//            sheet de listas) e a contagem de itens em texto sóbrio. SEM chips —
//            cápsula é só para tag (regra do dono).
// USA:       theme/*, shopping_providers (lista ativa + itens exibidos),
//            lists_sheet, new_list_sheet (createAndSelectList).
// USADO POR: ShoppingListView (topo da aba Lista).
// SPEC:      specs/features/shopping.yaml (screens.lista: ListHeaderRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/shopping_providers.dart';
import '../lists_sheet.dart';
import '../new_list_sheet.dart';

/// Título-seletor da lista ativa (nome + caret) com contagem à direita.
/// Usada por: ShoppingListView.
class ListHeaderRow extends ConsumerWidget {
  const ListHeaderRow({super.key});

  /// Monta o nome tocável e a contagem de itens exibidos. Usada por: ShoppingListView.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final list = ref.watch(activeListProvider);
    final shown = ref.watch(activeListItemsProvider).length;
    return Padding(
      padding: AppSpacing.screenH,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _openSheet(context, ref),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Text(list.name, style: AppType.on(AppType.titleSm, pit.text)),
                const SizedBox(width: AppSpacing.sm),
                Icon(AppIcons.expand, size: 16, color: pit.muted),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '$shown ${shown == 1 ? 'item' : 'itens'}',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ],
      ),
    );
  }

  /// Abre o sheet de listas; se pediu nova, cai no fluxo padrão de criar.
  /// Usada por: [build].
  Future<void> _openSheet(BuildContext context, WidgetRef ref) async {
    final wantsNew = await showListsSheet(context);
    if (wantsNew == true && context.mounted) {
      await createAndSelectList(context, ref);
    }
  }
}
