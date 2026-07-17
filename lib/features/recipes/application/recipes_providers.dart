// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipes_providers.dart
// O QUÊ:     Providers Riverpod da feature Receitas (lista, pastas, filtro, detalhe).
// USA:       recipe_repository (contrato), seed_recipe_repository (default
//            offline), recipe.dart, folder.dart, riverpod.
// USADO POR: recipes_screen, recipe_detail_screen (camada de apresentação).
// SPEC:      specs/features/recipes.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/folder.dart';
import '../data/models/recipe/recipe.dart';
import '../data/repositories/recipe/recipe_repository.dart';
import '../data/repositories/recipe/seed_recipe_repository.dart';

/// Instância do repositório. Default = seed em memória (preview no PC);
/// main.dart sobrescreve com SupabaseRecipesRepository quando há chaves.
/// Usada por: os providers abaixo.
final recipesRepositoryProvider =
    Provider<RecipesRepository>((ref) => const SeedRecipesRepository());

/// Todas as receitas do usuário. Usada por: recipes_screen (via filtro) e Planos.
final recipesProvider = FutureProvider<List<Recipe>>((ref) {
  return ref.watch(recipesRepositoryProvider).fetchRecipes();
});

/// Pastas (capítulos). Usada por: PitadaTabs (aba Pastas) em recipes_screen.
final foldersProvider = FutureProvider<List<Folder>>((ref) {
  return ref.watch(recipesRepositoryProvider).fetchFolders();
});

/// Uma receita por id, para a tela de detalhe. Usada por: recipe_detail_screen.
final recipeByIdProvider = FutureProvider.family<Recipe?, String>((ref, id) {
  return ref.watch(recipesRepositoryProvider).fetchById(id);
});

/// Todas as versões de um grupo (v1..vN, asc). Usada por: RecipeDetailScreen (seletor).
final recipeVersionGroupProvider =
    FutureProvider.family<List<Recipe>, String>((ref, groupId) {
  return ref.watch(recipesRepositoryProvider).fetchVersionGroup(groupId);
});

/// Versão atualmente vista no detalhe (número), por grupo. null = definitiva.
/// Estado de UI puro (não persiste): trocar aqui troca a tela inteira da receita.
/// Usada por: RecipeDetailScreen, RecipeVersionSheet.
final selectedRecipeVersionProvider =
    StateProvider.family<int?, String>((ref, groupId) => null);

/// Controller de edição inline: salva uma receita alterada e refaz as telas.
/// Presentation nunca fala com o repositório direto — passa por aqui.
/// Usada por: recipeEditControllerProvider.
class RecipeEditController {
  const RecipeEditController(this._ref);

  final Ref _ref;

  /// Cria uma receita NOVA (ex.: importada) e refaz a lista. Devolve o id gerado.
  /// Usada por: import_sheet (salvar o preview importado).
  Future<String> create(Recipe recipe) async {
    final id = await _ref.read(recipesRepositoryProvider).createRecipe(recipe);
    _ref.invalidate(recipesProvider);
    return id;
  }

  /// Persiste [recipe] e invalida os providers dependentes, para a edição aparecer na
  /// hora. [asNewVersion]=false sobrescreve no lugar; true cria uma nova versão (a tela
  /// passa a mostrar o seletor). Usada por: sheets de edição inline (RecipeQuickEdit).
  Future<void> save(Recipe recipe, {bool asNewVersion = false}) async {
    final repo = _ref.read(recipesRepositoryProvider);
    if (asNewVersion) {
      await repo.saveAsNewVersion(recipe);
      final canonicalId = recipe.versionGroupId ?? recipe.id;
      _ref.invalidate(recipeByIdProvider(canonicalId));
      _ref.invalidate(recipeVersionGroupProvider(canonicalId));
      _ref.invalidate(
        selectedRecipeVersionProvider(canonicalId),
      );
      _ref.invalidate(recipesProvider);
      return;
    }
    await repo.updateRecipe(recipe);
    _ref.invalidate(recipeByIdProvider(recipe.id));
    _ref.invalidate(recipesProvider);
    final groupId = recipe.versionGroupId;
    if (groupId != null) _ref.invalidate(recipeVersionGroupProvider(groupId));
  }
}

/// Instância do controller de edição inline. Usada por: RecipeQuickEdit (detalhe).
final recipeEditControllerProvider =
    Provider<RecipeEditController>(RecipeEditController.new);
