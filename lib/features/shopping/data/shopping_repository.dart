// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/data/shopping_repository.dart
// O QUÊ:     Fonte da lista de compras e da despensa. Hoje em memória (seed).
// USA:       shopping_item.dart, pantry_item.dart, shopping_seed.dart, app_log.
// USADO POR: shopping_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/shopping.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'pantry_item.dart';
import 'shopping_item.dart';
import 'shopping_seed.dart';

/// Repositório de compras. Implementação atual serve os dados de exemplo.
/// Usada por: shopping_providers. Trocar por versão Supabase mantém a mesma API.
class ShoppingRepository {
  const ShoppingRepository();

  /// Lista de compras já somada/subtraída. Usada por: shoppingListProvider (estado inicial).
  Future<List<ShoppingItem>> fetchShoppingList() async {
    AppLog.d('shopping', 'carregando lista de compras (seed)');
    return kSeedShopping;
  }

  /// Itens da despensa (o que já tenho). Usada por: pantryProvider.
  Future<List<PantryItem>> fetchPantry() async {
    AppLog.d('shopping', 'carregando despensa (seed)');
    return kSeedPantry;
  }
}
