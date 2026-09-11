// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/application/providers.dart
// O QUÊ:     Providers de Compras: os carrinhos (com ações), o ativo, os itens
//            exibidos (crus ou com a despensa descontada), a cobertura da
//            despensa por item e os agrupadores.
// USA:       repository, grocery_list, grocery_item, pantry_item,
//            list_seed (categorias), riverpod, app_log.
// USADO POR: grocery_list_view, cart_tab_bar, cart_header, grocery_row,
//            pantry_view, new_list_sheet, add_item_sheet (apresentação);
//            profile/overview_providers.
// SPEC:      specs/features/groceries.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/pantry_item.dart';
import '../data/grocery_item.dart';
import '../data/grocery_list.dart';
import '../data/repository.dart';
import '../data/list_seed.dart';

/// Instância do repositório. Usada por: os providers abaixo.
final groceriesRepositoryProvider =
    Provider<GroceriesRepository>((ref) => const GroceriesRepository());

/// Estado das listas de compras + ações (marcar item, criar lista, toggle da
/// despensa). Os itens ficam sempre CRUS; o desconto é só na exibição.
/// Usada por: groceryListsProvider (não use direto na UI).
class GroceryListsNotifier extends StateNotifier<List<GroceryList>> {
  GroceryListsNotifier(super.initial);

  /// Alterna o `checked` de um item da lista dada. Usada por: GroceryListView.
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

  /// Acrescenta um item manual ao fim da lista (entra cru, como tudo aqui).
  /// Usada por: showAddItemSheet ('Adicionar ingrediente' do card).
  void addItem(String listId, GroceryItem item) {
    state = [
      for (final l in state)
        if (l.id != listId) l else l.copyWith(items: [...l.items, item]),
    ];
    AppLog.i('groceries', 'item adicionado: ${item.name} ($listId)');
  }

  /// Liga/desliga o desconto da despensa na lista (o caso "feira" = desligado).
  /// Usada por: linha de toggle do CartHeader.
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

/// Id do carrinho ativo nas abas-pasta. Lê (não observa) as listas só para o
/// valor inicial — observar resetaria a seleção a cada mutação de item.
/// Usada por: CartTabBar, activeListProvider.
final activeListIdProvider = StateProvider<String>(
  (ref) => ref.read(groceryListsProvider).first.id,
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

/// Cobertura da despensa por item do carrinho ativo (id -> precisa/tem, na
/// unidade humana; casa nome+unidade como discountPantry). Vazio quando a
/// lista não desconta a despensa. Usada por: GroceryRow ('Precisa de X · tem Y').
final pantryCoverageProvider =
    Provider<Map<String, ({num need, num have})>>((ref) {
  final list = ref.watch(activeListProvider);
  if (!list.usePantry) return const {};
  final pantry = ref.watch(pantryProvider).valueOrNull ?? const <PantryItem>[];
  final have = <String, num>{
    for (final p in pantry)
      '${p.name.toLowerCase()}|${p.unit.toLowerCase()}': p.quantity,
  };
  final coverage = <String, ({num need, num have})>{};
  for (final item in list.items) {
    final key = '${item.name.toLowerCase()}|${item.humanUnit.toLowerCase()}';
    final stock = have[key] ?? 0;
    if (stock > 0) coverage[item.id] = (need: item.humanQty, have: stock);
  }
  return coverage;
});

/// Itens exibidos da lista ativa agrupados por categoria, na ordem canônica.
/// Usada por: GroceryListView (miolo do card, título + linhas por seção).
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
