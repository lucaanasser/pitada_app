// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipes_providers.dart
// O QUÊ:     Providers Riverpod da feature Receitas (lista, pastas, filtro, detalhe).
// USA:       recipes_repository, recipe.dart, folder.dart, riverpod.
// USADO POR: recipes_screen, recipe_detail_screen (camada de apresentação).
// SPEC:      specs/features/recipes.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/folder.dart';
import '../data/recipe.dart';
import '../data/recipes_repository.dart';

/// Instância do repositório. Usada por: os providers abaixo.
final recipesRepositoryProvider =
    Provider<RecipesRepository>((ref) => const RecipesRepository());

/// Todas as receitas do usuário. Usada por: recipes_screen (via filtro) e Planos.
final recipesProvider = FutureProvider<List<Recipe>>((ref) {
  return ref.watch(recipesRepositoryProvider).fetchRecipes();
});

/// Pastas (capítulos). Usada por: ChapterTabs em recipes_screen.
final foldersProvider = FutureProvider<List<Folder>>((ref) {
  return ref.watch(recipesRepositoryProvider).fetchFolders();
});

/// As 4 abas fixas da tela de Receitas. Usada por: recipes_screen (ChapterTabs).
enum RecipesTab { mine, saved, folders, favorites }

/// Aba selecionada em Receitas (0 = Minhas Receitas). Usada por: recipes_screen.
final selectedRecipesTabProvider = StateProvider<int>((ref) => 0);

/// Receitas da aba atual. Pastas (aba 2) não filtra receitas — mostra FolderCards.
/// "Minhas" = criadas à mão; "Salvas" = importadas de fora (fonte != manual);
/// persistir essa distinção no banco vem com o backend. Usada por: recipes_screen.
final recipesForTabProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
  final tab = RecipesTab.values[ref.watch(selectedRecipesTabProvider)];
  return switch (tab) {
    RecipesTab.mine =>
      recipes.where((r) => r.source == RecipeSource.manual).toList(),
    RecipesTab.saved =>
      recipes.where((r) => r.source != RecipeSource.manual).toList(),
    RecipesTab.folders => recipes,
    RecipesTab.favorites => recipes.where((r) => r.favorite).toList(),
  };
});

/// Uma receita por id, para a tela de detalhe. Usada por: recipe_detail_screen.
final recipeByIdProvider = FutureProvider.family<Recipe?, String>((ref, id) {
  return ref.watch(recipesRepositoryProvider).fetchById(id);
});
