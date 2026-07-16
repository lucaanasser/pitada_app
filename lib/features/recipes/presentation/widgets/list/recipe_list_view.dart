// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_list_view.dart
// O QUÊ:     Renderiza a lista de receitas nos 3 modos (filete / card / grade),
//            cada item com a linha de posse ("v3 sua · feita 2×").
// USA:       recipe_list_providers (posse), recipe_view_provider (modo),
//            recipe_card, recipe_row, core/theme (AppSpacing), go_router.
// USADO POR: recipes_screen (corpo da lista).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../application/recipe_list_providers.dart';
import '../../../application/recipe_view_provider.dart';
import '../../../data/models/recipe.dart';
import 'recipe_card.dart';
import 'recipe_row.dart';

/// Lista de receitas no modo escolhido, com posse por item.
/// Usada por: recipes_screen.
class RecipeListView extends ConsumerWidget {
  const RecipeListView({super.key, required this.recipes, required this.view});

  final List<Recipe> recipes;
  final RecipeView view;

  /// Monta filete/card/grade conforme [view]. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String owns(Recipe r) => ref.watch(recipeOwnershipProvider(r.id));
    Widget card(Recipe r, {bool compact = false}) => RecipeCard(
          recipe: r,
          compact: compact,
          ownership: owns(r),
          onTap: () => context.push('/recipe/${r.id}'),
        );

    switch (view) {
      case RecipeView.list:
        return Column(
          children: [
            for (var i = 0; i < recipes.length; i++)
              RecipeRow(
                recipe: recipes[i],
                ownership: owns(recipes[i]),
                showDivider: i != recipes.length - 1,
                onTap: () => context.push('/recipe/${recipes[i].id}'),
              ),
          ],
        );
      case RecipeView.single:
        return Column(
          children: [
            for (final r in recipes)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: card(r),
              ),
          ],
        );
      case RecipeView.grid:
        return Column(
          children: [
            for (var i = 0; i < recipes.length; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: card(recipes[i], compact: true)),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: i + 1 < recipes.length
                          ? card(recipes[i + 1], compact: true)
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
          ],
        );
    }
  }
}
