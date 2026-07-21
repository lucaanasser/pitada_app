// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_list_view.dart
// O QUÊ:     Renderiza a lista de receitas como filetes, cada item com maestria
//            ("nunca fiz → fiz N× → domino").
// USA:       recipe_list_providers (maestria), recipe_row, go_router.
// USADO POR: recipes_screen (tab Receitas).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/recipe_list_providers.dart';
import '../../../application/recipe_providers.dart';
import '../../../data/models/folder.dart';
import '../../../data/models/recipe/recipe.dart';
import 'recipe_row.dart';

/// Lista de receitas em filetes, com maestria por item.
/// Usada por: recipes_screen.
class RecipeListView extends ConsumerWidget {
  const RecipeListView({super.key, required this.recipes});

  final List<Recipe> recipes;

  /// Monta os filetes com maestria. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider).valueOrNull ?? const <Folder>[];
    return Column(
      children: [
        for (var i = 0; i < recipes.length; i++)
          RecipeRow(
            recipe: recipes[i],
            mastery: ref.watch(recipeMasteryProvider(recipes[i].id)),
            cooks: ref.watch(recipeCooksProvider(recipes[i].id)),
            folderHero: _folderHeroOf(recipes[i], folders),
            showDivider: i != recipes.length - 1,
            onTap: () => context.push('/recipe/${recipes[i].id}'),
          ),
      ],
    );
  }

  String? _folderHeroOf(Recipe recipe, List<Folder> folders) {
    for (final id in recipe.folderIds) {
      for (final f in folders) {
        if (f.id == id) return f.heroColor;
      }
    }
    return null;
  }
}
