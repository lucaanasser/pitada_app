// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/application/shopping_providers.dart
// O QUÊ:     Providers Riverpod de Compras (lista com toggle, despensa, agrupadores).
// USA:       shopping_repository, shopping_item, pantry_item, shopping_seed, riverpod.
// USADO POR: shopping_screen e seus widgets (camada de apresentação).
// SPEC:      specs/features/shopping.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pantry_item.dart';
import '../data/shopping_item.dart';
import '../data/shopping_repository.dart';
import '../data/shopping_seed.dart';

/// Instância do repositório. Usada por: os providers abaixo.
final shoppingRepositoryProvider =
    Provider<ShoppingRepository>((ref) => const ShoppingRepository());

/// Estado da lista de compras — permite alternar `checked` de cada item.
/// Usada por: shoppingListProvider (não use direto na UI).
class ShoppingListNotifier extends StateNotifier<List<ShoppingItem>> {
  ShoppingListNotifier(super.initial);

  /// Alterna o `checked` do item de dado id. Usada por: CheckItem em ShoppingListRow.
  void toggle(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(checked: !item.checked) else item,
    ];
  }

  /// Marca todos como comprados. Usada por: botão "Comprei tudo".
  void checkAll() {
    state = [for (final item in state) item.copyWith(checked: true)];
  }
}

/// Lista de compras (mutável quanto ao `checked`). Semeada com kSeedShopping.
/// Usada por: shopping_screen e listByCategoryProvider.
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItem>>(
  (ref) => ShoppingListNotifier(kSeedShopping),
);

/// Itens da despensa (o que já tenho). Usada por: shopping_screen (aba Despensa).
final pantryProvider = FutureProvider<List<PantryItem>>((ref) {
  return ref.watch(shoppingRepositoryProvider).fetchPantry();
});

/// Lista de compras agrupada por categoria, na ordem canônica das categorias.
/// Usada por: shopping_screen para render de SectionHeader + linhas por seção.
final listByCategoryProvider = Provider<Map<String, List<ShoppingItem>>>((ref) {
  final items = ref.watch(shoppingListProvider);
  return _groupByCategory(items, (i) => i.category);
});

/// Despensa agrupada por categoria (vazia enquanto carrega). Usada por: shopping_screen.
final pantryByCategoryProvider = Provider<Map<String, List<PantryItem>>>((ref) {
  final items = ref.watch(pantryProvider).valueOrNull ?? const <PantryItem>[];
  return _groupByCategory(items, (i) => i.category);
});

/// Agrupa itens por categoria preservando kShoppingCategories; some categorias vazias.
/// Usada por: os dois agrupadores acima (evita duplicar a lógica de agrupamento).
Map<String, List<T>> _groupByCategory<T>(
  List<T> items,
  String Function(T) category,
) {
  final grouped = <String, List<T>>{};
  for (final cat in kShoppingCategories) {
    final matches = items.where((i) => category(i) == cat).toList();
    if (matches.isNotEmpty) grouped[cat] = matches;
  }
  return grouped;
}
