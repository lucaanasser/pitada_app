// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/data/shopping_list.dart
// O QUÊ:     Modelo de uma lista de compras nomeada (a pessoa pode ter várias) e
//            o desconto da despensa NA EXIBIÇÃO (as quantidades gravadas são cruas).
// USA:       shopping_item.dart, pantry_item.dart.
// USADO POR: shopping_seed, shopping_repository, shopping_providers, ListsSheet.
// SPEC:      specs/features/shopping.yaml (data.models.ShoppingList, regra_de_soma)
// ─────────────────────────────────────────────────────────────────────────────
import 'pantry_item.dart';
import 'shopping_item.dart';

/// Uma lista de compras: nome + itens CRUS (somados por unidade, sem subtrair a
/// despensa). `usePantry` decide se a exibição desconta a despensa — desligado
/// é o caso "praia": longe de casa, a lista aparece completa. Imutável.
/// Usada por: shoppingListsProvider, ListsSheet, ShoppingListView.
class ShoppingList {
  final String id;
  final String name;
  final bool usePantry;
  final List<ShoppingItem> items;

  const ShoppingList({
    required this.id,
    required this.name,
    this.usePantry = true,
    this.items = const [],
  });

  /// Cópia com campos trocados (imutável). Usada por: ShoppingListsNotifier.
  ShoppingList copyWith({
    String? name,
    bool? usePantry,
    List<ShoppingItem>? items,
  }) =>
      ShoppingList(
        id: id,
        name: name ?? this.name,
        usePantry: usePantry ?? this.usePantry,
        items: items ?? this.items,
      );
}

/// Desconta a despensa de itens crus para EXIBIÇÃO — mesma regra de
/// units.subtractPantry (casa por nome+unidade, nunca negativa, item zerado
/// some), mas preserva id/categoria/checked e escala a grama de referência
/// proporcionalmente. O desconto nunca é gravado na lista.
/// Usada por: activeListItemsProvider (quando usePantry).
List<ShoppingItem> discountPantry(
  List<ShoppingItem> items,
  List<PantryItem> pantry,
) {
  final have = <String, num>{
    for (final p in pantry)
      '${p.name.toLowerCase()}|${p.unit.toLowerCase()}': p.quantity,
  };
  final result = <ShoppingItem>[];
  for (final it in items) {
    final key = '${it.name.toLowerCase()}|${it.humanUnit.toLowerCase()}';
    final remaining = it.humanQty - (have[key] ?? 0);
    if (remaining <= 0) continue;
    result.add(
      ShoppingItem(
        id: it.id,
        name: it.name,
        category: it.category,
        humanQty: remaining,
        humanUnit: it.humanUnit,
        grams: it.grams == null ? null : it.grams! * (remaining / it.humanQty),
        checked: it.checked,
      ),
    );
  }
  return result;
}
