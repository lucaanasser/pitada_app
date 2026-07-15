// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/data/shopping_repository.dart
// O QUÊ:     Fonte das listas de compras (várias, com itens crus) e da despensa.
//            Hoje em memória (seed).
// USA:       shopping_list.dart, pantry_item.dart, shopping_seed.dart, app_log.
// USADO POR: shopping_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/shopping.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'pantry_item.dart';
import 'shopping_list.dart';
import 'shopping_seed.dart';

/// Repositório de compras. Implementação atual serve os dados de exemplo.
/// Usada por: shopping_providers. Trocar por versão Supabase mantém a mesma API.
class ShoppingRepository {
  const ShoppingRepository();

  /// Listas de compras (itens crus, sem descontar a despensa).
  /// Usada por: shoppingListsProvider (estado inicial).
  List<ShoppingList> fetchLists() {
    AppLog.d('shopping', 'carregando listas de compras (seed)');
    return kSeedLists;
  }

  /// Itens da despensa (o que já tenho). Usada por: pantryProvider.
  Future<List<PantryItem>> fetchPantry() async {
    AppLog.d('shopping', 'carregando despensa (seed)');
    return kSeedPantry;
  }
}
