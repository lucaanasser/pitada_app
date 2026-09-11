// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/grocery_list.dart
// O QUÊ:     Modelo de uma lista de compras nomeada (a pessoa pode ter várias) e
//            o desconto da despensa NA EXIBIÇÃO (as quantidades gravadas são cruas).
// USA:       grocery_item.dart, pantry_item.dart.
// USADO POR: seed, repository, providers, cart_tab_bar, grocery_list_view.
// SPEC:      specs/features/groceries.yaml (data.models.GroceryList, regra_de_soma)
// ─────────────────────────────────────────────────────────────────────────────
import 'pantry_item.dart';
import 'grocery_item.dart';

/// Um carrinho de compras: nome + itens CRUS (somados por unidade, sem subtrair
/// a despensa). `label` é o rótulo curto da aba-pasta ('Semana'); `name` é o
/// título do card ('Compras da semana'). `usePantry` decide se a exibição
/// desconta a despensa — desligado é o caso "feira": longe de casa, a lista
/// aparece completa. Imutável.
/// Usada por: groceryListsProvider, CartTabBar, GroceryListView.
class GroceryList {
  final String id;
  final String name;
  final String? label;
  final bool usePantry;
  final List<GroceryItem> items;

  const GroceryList({
    required this.id,
    required this.name,
    this.label,
    this.usePantry = true,
    this.items = const [],
  });

  /// Rótulo da aba-pasta do carrinho (curto quando há label). Usada por: CartTabBar.
  String get tabLabel => label ?? name;

  /// Cópia com campos trocados (imutável). Usada por: GroceryListsNotifier.
  GroceryList copyWith({
    String? name,
    bool? usePantry,
    List<GroceryItem>? items,
  }) =>
      GroceryList(
        id: id,
        name: name ?? this.name,
        label: label,
        usePantry: usePantry ?? this.usePantry,
        items: items ?? this.items,
      );
}

/// Desconta a despensa de itens crus para EXIBIÇÃO — mesma regra de
/// units.subtractPantry (casa por nome+unidade, nunca negativa, item zerado
/// some), mas preserva id/categoria/checked e escala a grama de referência
/// proporcionalmente. O desconto nunca é gravado na lista.
/// Usada por: activeListItemsProvider (quando usePantry).
List<GroceryItem> discountPantry(
  List<GroceryItem> items,
  List<PantryItem> pantry,
) {
  final have = <String, num>{
    for (final p in pantry)
      '${p.name.toLowerCase()}|${p.unit.toLowerCase()}': p.quantity,
  };
  final result = <GroceryItem>[];
  for (final it in items) {
    final key = '${it.name.toLowerCase()}|${it.humanUnit.toLowerCase()}';
    final remaining = it.humanQty - (have[key] ?? 0);
    if (remaining <= 0) continue;
    result.add(
      GroceryItem(
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
