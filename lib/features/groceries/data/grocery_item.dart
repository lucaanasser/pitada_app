// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/data/shopping_item.dart
// O QUÊ:     Modelo de um item da lista de compras (somado por unidade humana).
// USA:       nada (modelo imutável puro, const constructor).
// USADO POR: shopping_seed, shopping_repository, shopping_providers e a tela Compras.
// SPEC:      specs/features/shopping.yaml (data.models.ShoppingItem)
// ─────────────────────────────────────────────────────────────────────────────

/// Um item da lista de compras. Quantidade na unidade humana (2 un, 500 g);
/// grama é só referência. `checked` marca "já comprei". Imutável.
/// Usada por: shopping_repository (lista somada) e ShoppingListRow (rótulo).
class ShoppingItem {
  final String id;
  final String name;
  final String category;
  final num humanQty;
  final String humanUnit;
  final num? grams;
  final bool checked;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.humanQty,
    required this.humanUnit,
    this.grams,
    this.checked = false,
  });

  /// Cópia com `checked` alternado/definido. Usada por: shoppingListProvider
  /// ao marcar/desmarcar um item comprado (mantém o resto imutável).
  ShoppingItem copyWith({bool? checked}) => ShoppingItem(
        id: id,
        name: name,
        category: category,
        humanQty: humanQty,
        humanUnit: humanUnit,
        grams: grams,
        checked: checked ?? this.checked,
      );
}
