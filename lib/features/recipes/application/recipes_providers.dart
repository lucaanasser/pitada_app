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

/// Índice da pasta selecionada (0 = 'Todas'). Usada por: recipes_screen.
final selectedFolderProvider = StateProvider<int>((ref) => 0);

/// Receitas já filtradas pela pasta atual. Usada por: recipes_screen.
/// Índice 0 mostra tudo; os demais casam com foldersProvider (deslocado de 1).
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
  final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
  final index = ref.watch(selectedFolderProvider);
  if (index <= 0 || index > folders.length) return recipes;
  final folderId = folders[index - 1].id;
  return recipes.where((r) => r.folderIds.contains(folderId)).toList();
});

/// Uma receita por id, para a tela de detalhe. Usada por: recipe_detail_screen.
final recipeByIdProvider = FutureProvider.family<Recipe?, String>((ref, id) {
  return ref.watch(recipesRepositoryProvider).fetchById(id);
});
