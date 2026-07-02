// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_view_provider.dart
// O QUÊ:     Modo de exibição da lista de receitas (card grande / 2 colunas / lista).
// USA:       flutter_riverpod (StateProvider).
// USADO POR: recipes_screen (renderização) e RecipeViewToggle (troca).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: alternador de layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Como a lista de receitas é mostrada.
/// single = 1 card grande por linha · grid = 2 colunas · list = linha-filete.
enum RecipeView { single, grid, list }

/// Modo atual de exibição. Padrão: card grande (single).
/// Usada por: recipes_screen. Trocar via `ref.read(recipeViewProvider.notifier).state`.
final recipeViewProvider =
    StateProvider<RecipeView>((ref) => RecipeView.single);
