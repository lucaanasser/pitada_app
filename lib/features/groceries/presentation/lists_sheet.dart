// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/lists_sheet.dart
// O QUÊ:     Sheet "Minhas listas": troca a lista ativa e dá acesso a criar uma
//            nova. Devolve true quando a pessoa pediu lista nova (o chamador
//            dispara createAndSelectList — o sheet já fechou).
// USA:       theme/*, core/widgets (HairlineRow, SheetGrip, pitada_sheet),
//            shopping_providers (listas + ativa).
// USADO POR: ListHeaderRow (título com caret da aba Lista).
// SPEC:      specs/features/groceries.yaml (sheets.showListsSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_sheet.dart';
import '../../../core/widgets/sheet_grip.dart';
import '../application/providers.dart';
import '../data/grocery_list.dart';

/// Abre o sheet de listas. true = pediu nova lista (chamador cria).
/// Usada por: ListHeaderRow.
Future<bool?> showListsSheet(BuildContext context) {
  return showPitadaSheet<bool>(
    context,
    builder: (_) => const _ListsSheet(),
  );
}

/// Conteúdo do sheet: uma linha por lista + "+ Nova lista". Usada por: showListsSheet.
class _ListsSheet extends ConsumerWidget {
  const _ListsSheet();

  /// Monta as linhas de troca e o atalho de criar. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final lists = ref.watch(groceryListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Text('Minhas listas', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < lists.length; i++)
            _listRow(context, ref, pit, lists[i], lists[i].id == activeId),
          HairlineRow(
            showDivider: false,
            title: Text(
              '+ Nova lista',
              style: AppType.on(AppType.body, AppColors.accent),
            ),
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  /// Linha de uma lista: nome + resumo; tocar torna ativa e fecha. Usada por: [build].
  Widget _listRow(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    GroceryList list,
    bool active,
  ) {
    final n = list.items.length;
    final pantry =
        list.usePantry ? 'desconta a despensa' : 'não desconta a despensa';
    return HairlineRow(
      title: Text(list.name, style: AppType.on(AppType.body, pit.text)),
      subtitle: Text(
        '$n ${n == 1 ? 'item' : 'itens'} · $pantry',
        style: AppType.on(AppType.captionSm, pit.muted),
      ),
      trailing: active
          ? const Icon(AppIcons.check, size: 18, color: AppColors.accent)
          : null,
      onTap: () {
        ref.read(activeListIdProvider.notifier).state = list.id;
        Navigator.of(context).pop();
      },
    );
  }
}
