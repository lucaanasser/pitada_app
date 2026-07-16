// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/pantry_item.dart
// O QUÊ:     Modelo de um item que já tenho na despensa (com validade opcional).
// USA:       nada (modelo imutável puro, const constructor).
// USADO POR: seed, repository, providers, grocery_list, pantry_view e
//            add_pantry_data (aba Ingredientes).
// SPEC:      specs/features/groceries.yaml (data.models.PantryItem)
// ─────────────────────────────────────────────────────────────────────────────

/// Um item da despensa: o que já tenho, com quantidade e validade opcional.
/// `low` sinaliza que está acabando. Sem `checked` — a Despensa não usa CheckItem.
/// Usada por: repository (despensa seed) e PantryView (rótulo + ExpiryTag).
class PantryItem {
  final String id;
  final String name;
  final String category;
  final num quantity;
  final String unit;
  final num? grams;
  final DateTime? expiresOn;
  final bool low;

  const PantryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    this.grams,
    this.expiresOn,
    this.low = false,
  });
}
