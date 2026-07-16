// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/repository.dart
// O QUÊ:     Fonte das listas de compras (várias, com itens crus) e da despensa.
//            Hoje em memória (seed).
// USA:       grocery_list.dart, pantry_item.dart, seed.dart, app_log.
// USADO POR: providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/groceries.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'pantry_item.dart';
import 'grocery_list.dart';
import 'seed.dart';

/// Repositório de compras. Implementação atual serve os dados de exemplo.
/// Usada por: providers. Trocar por versão Supabase mantém a mesma API.
class GroceriesRepository {
  const GroceriesRepository();

  /// Listas de compras (itens crus, sem descontar a despensa).
  /// Usada por: groceryListsProvider (estado inicial).
  List<GroceryList> fetchLists() {
    AppLog.d('groceries', 'carregando listas de compras (seed)');
    return kSeedLists;
  }

  /// Itens da despensa (o que já tenho). Usada por: pantryProvider.
  Future<List<PantryItem>> fetchPantry() async {
    AppLog.d('groceries', 'carregando despensa (seed)');
    return kSeedPantry;
  }
}
