// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipes_repository.dart
// O QUÊ:     CONTRATO do repositório de receitas/pastas. Impls: seed (preview) e
//            Supabase (online) — main.dart escolhe via override do provider.
// USA:       recipe.dart, folder.dart (modelos).
// USADO POR: recipes_providers (application), seed_recipes_repository,
//            supabase_recipes_repository. A UI nunca chama isto direto.
// SPEC:      specs/features/recipes.yaml (data.repository, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import 'folder.dart';
import 'recipe.dart';

/// Contrato da fonte de receitas. As duas implementações mantêm a MESMA
/// semântica de versões ("trocar tudo", ver spec). Usada por: recipes_providers.
abstract class RecipesRepository {
  /// Lista as receitas do usuário: só as DEFINITIVAS (uma por grupo de versões),
  /// para as listas não duplicarem. Usada por: recipesProvider.
  Future<List<Recipe>> fetchRecipes();

  /// Lista as pastas (capítulos). Usada por: foldersProvider.
  Future<List<Folder>> fetchFolders();

  /// Busca uma receita por id — INCLUI versões antigas. null quando não existe.
  /// Usada por: recipeByIdProvider (detalhe/cozinhar/editar).
  Future<Recipe?> fetchById(String id);

  /// Todas as versões de um grupo, ordenadas por version ascendente (v1..vN).
  /// Usada por: recipeVersionGroupProvider (seletor de versão).
  Future<List<Recipe>> fetchVersionGroup(String groupId);

  /// Grava uma edição da receita NO LUGAR (mesmo id, sem nova versão).
  /// Usada por: RecipeEditController.save (edição inline).
  Future<void> updateRecipe(Recipe recipe);

  /// Salva [edited] como NOVA versão: arquiva a definitiva atual como snapshot
  /// próprio (fora de listas/pastas) e promove [edited] no id canônico com
  /// version = max+1, herdando as pastas. Sem grupo ainda, o próprio id
  /// vira o grupo. Usada por: RecipeEditController.save (asNewVersion).
  Future<void> saveAsNewVersion(Recipe edited);
}
