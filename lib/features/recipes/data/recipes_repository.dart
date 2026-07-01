// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipes_repository.dart
// O QUÊ:     Fonte de receitas/pastas. Hoje em memória (seed); depois, Supabase.
// USA:       recipe.dart, folder.dart, recipes_seed.dart, core/utils/app_log.
// USADO POR: recipes_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/recipes.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'folder.dart';
import 'recipe.dart';
import 'recipes_seed.dart';

/// Repositório de receitas. Implementação atual serve os dados de exemplo.
/// Usada por: recipes_providers. Trocar por versão Supabase mantém a mesma API.
class RecipesRepository {
  const RecipesRepository();

  /// Lista todas as receitas do usuário. Usada por: recipesProvider.
  Future<List<Recipe>> fetchRecipes() async {
    AppLog.d('recipes', 'carregando receitas (seed)');
    return kSeedRecipes;
  }

  /// Lista as pastas (capítulos). Usada por: foldersProvider.
  Future<List<Folder>> fetchFolders() async => kSeedFolders;

  /// Busca uma receita por id (ou null se não achar). Usada por: recipeByIdProvider.
  Future<Recipe?> fetchById(String id) async {
    for (final r in kSeedRecipes) {
      if (r.id == id) return r;
    }
    AppLog.w('recipes', 'receita não encontrada: $id');
    return null;
  }
}
