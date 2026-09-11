// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_list_view.dart
// O QUÊ:     Renderiza a lista de receitas como filetes, cada item com o
//            marca-página de maestria à esquerda.
// USA:       recipe_row, go_router.
// USADO POR: recipes_screen (tab Receitas).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/recipe/recipe.dart';
import 'recipe_row.dart';

/// Lista de receitas em filetes, com o marca-página por item.
/// Usada por: recipes_screen.
class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key, required this.recipes});

  final List<Recipe> recipes;

  /// Monta os filetes de receita. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < recipes.length; i++)
          RecipeRow(
            recipe: recipes[i],
            showDivider: i != recipes.length - 1,
            onTap: () => context.push('/recipe/${recipes[i].id}'),
          ),
      ],
    );
  }
}
