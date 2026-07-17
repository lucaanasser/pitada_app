// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_ingredients_section.dart
// O QUÊ:     Seção "Ingredientes" do detalhe: cabeçalho + uma IngredientRow por
//            ingrediente, cada uma editável por gesto.
// USA:       core/widgets/section_header, items/ingredient_row, Recipe,
//            recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../data/models/recipe.dart';
import '../../../recipe_quick_edit.dart';
import '../items/ingredient_row.dart';

/// Seção de ingredientes: cabeçalho + linhas com grama grande e unidade humana.
/// Usada por: RecipeDetailBody.
class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho e a lista de linhas de ingrediente. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Ingredientes'),
        for (var i = 0; i < recipe.ingredients.length; i++)
          IngredientRow(
            ingredient: recipe.ingredients[i],
            showDivider: i != recipe.ingredients.length - 1,
            onEdit: () => quickEdit.ingredient(recipe, i),
          ),
      ],
    );
  }
}
