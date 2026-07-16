// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/application/providers.dart
// O QUÊ:     Providers de Compras: as listas (com ações), a lista ativa, os itens
//            exibidos (crus ou com a despensa descontada) e os agrupadores.
// USA:       shopping_repository, shopping_list, shopping_item, pantry_item,
//            shopping_seed (categorias), riverpod, app_log.
// USADO POR: shopping_screen e seus widgets (camada de apresentação).
// SPEC:      specs/features/groceries.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/pantry_item.dart';
import '../data/grocery_item.dart';
import '../data/grocery_list.dart';
import '../data/repository.dart';
import '../data/seed.dart';

/// Instância do repositório. Usada por: os providers abaixo.
final groceriesRepositoryProvider =
    Provider<GroceriesRepository>((ref) => const GroceriesRepository());

/// Estado das listas de compras + ações (marcar item, criar lista, toggle da
/// despensa). Os itens ficam sempre CRUS; o desconto é só na exibição.
/// Usada por: groceryListsProvider (não use direto na UI).
class GroceryListsNotifier extends StateNotifier<List<GroceryList>> {
  GroceryListsNotifier(super.initial);

  /// Alterna o `checked` de um item da lista dada. Usada por: GroceryListRow.
  void toggleItem(String listId, String itemId) {
    state = [
      for (final l in state)
        if (l.id != listId)
          l
        else
          l.copyWith(
            items: [
              for (final i in l.items)
                if (i.id == itemId) i.copyWith(checked: !i.checked) else i,
            ],
          ),
    ];
  }

  /// Marca todos os itens da lista como comprados. Usada por: "Comprei tudo".
  void checkAll(String listId) {
    state = [
      for (final l in state)
        if (l.id != listId)
          l
        else
          l.copyWith(
            items: [
              for (final i in l.items) i.copyWith(checked: true),
            ],
          ),
    ];
  }

  /// Cria uma lista vazia (desconta a despensa por padrão) e devolve o id.
  /// Usada por: createAndSelectList (new_list_sheet).
  String addList(String name) {
    final id = 'list-${DateTime.now().millisecondsSinceEpoch}';
    state = [...state, GroceryList(id: id, name: name)];
    AppLog.i('groceries', 'lista criada: $name ($id)');
    return id;
  }

  /// Liga/desliga o desconto da despensa na lista (o caso "praia" = desligado).
  /// Usada por: linha de toggle da GroceryListView.
  void togglePantry(String listId) {
    state = [
      for (final l in state)
        if (l.id != listId) l else l.copyWith(usePantry: !l.usePantry),
    ];
    AppLog.i('groceries', 'toggle despensa: $listId');
  }
}

/// As listas de compras (semeadas do repositório). Usada por: ListsSheet,
/// activeListProvider.
final groceryListsProvider =
    StateNotifierProvider<GroceryListsNotifier, List<GroceryList>>(
  (ref) =>
      GroceryListsNotifier(ref.watch(groceriesRepositoryProvider).fetchLists()),
);

/// Id da lista selecionada no sheet de listas. Usada por: ListsSheet, activeListProvider.
final activeListIdProvider = StateProvider<String>(
  (ref) => ref.watch(groceryListsProvider).first.id,
);

/// A lista ativa (fallback: primeira, se o id não existir mais).
/// Usada por: GroceryListView (toggle/ações), activeListItemsProvider.
final activeListProvider = Provider<GroceryList>((ref) {
  final lists = ref.watch(groceryListsProvider);
  final id = ref.watch(activeListIdProvider);
  return lists.firstWhere((l) => l.id == id, orElse: () => lists.first);
});

/// Itens EXIBIDOS da lista ativa: crus, ou com a despensa descontada quando
/// usePantry (nunca gravamos o desconto). Usada por: listByCategoryProvider.
final activeListItemsProvider = Provider<List<GroceryItem>>((ref) {
  final list = ref.watch(activeListProvider);
  if (!list.usePantry) return list.items;
  final pantry = ref.watch(pantryProvider).valueOrNull ?? const <PantryItem>[];
  return discountPantry(list.items, pantry);
});

/// Itens da despensa (o que já tenho). Usada por: PantryView, activeListItems.
final pantryProvider = FutureProvider<List<PantryItem>>((ref) {
  return ref.watch(groceriesRepositoryProvider).fetchPantry();
});

/// Itens exibidos da lista ativa agrupados por categoria, na ordem canônica.
/// Usada por: GroceryListView (SectionHeader + linhas por seção).
final listByCategoryProvider = Provider<Map<String, List<GroceryItem>>>((ref) {
  final items = ref.watch(activeListItemsProvider);
  return _groupByCategory(items, (i) => i.category);
});

/// Despensa agrupada por categoria (vazia enquanto carrega). Usada por: PantryView.
final pantryByCategoryProvider = Provider<Map<String, List<PantryItem>>>((ref) {
  final items = ref.watch(pantryProvider).valueOrNull ?? const <PantryItem>[];
  return _groupByCategory(items, (i) => i.category);
});

/// Agrupa itens por categoria preservando kGroceryCategories; some categorias vazias.
/// Usada por: os dois agrupadores acima (evita duplicar a lógica de agrupamento).
Map<String, List<T>> _groupByCategory<T>(
  List<T> items,
  String Function(T) category,
) {
  final grouped = <String, List<T>>{};
  for (final cat in kGroceryCategories) {
    final matches = items.where((i) => category(i) == cat).toList();
    if (matches.isNotEmpty) grouped[cat] = matches;
  }
  return grouped;
}
