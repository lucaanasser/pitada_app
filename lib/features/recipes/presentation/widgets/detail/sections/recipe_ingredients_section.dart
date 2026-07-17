// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_ingredients_section.dart
// O QUÊ:     Seção "Ingredientes" do detalhe: cabeçalho + por componente
//            (subcabeçalho quando nomeado) uma IngredientRow editável por gesto.
// USA:       core/widgets/section_header, recipe_component_header,
//            items/ingredient_row, Recipe, recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: componentes_na_tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../data/models/recipe.dart';
import '../../../recipe_quick_edit.dart';
import '../items/ingredient_row.dart';
import 'recipe_component_header.dart';

/// Seção de ingredientes por componente, na mesma rolagem (seção, nunca aba).
/// Usada por: RecipeDetailBody.
class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho e as linhas de cada componente. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Ingredientes'),
        for (var c = 0; c < recipe.components.length; c++) ...[
          if (recipe.components[c].name != null)
            RecipeComponentHeader(name: recipe.components[c].name!),
          for (var i = 0; i < recipe.components[c].ingredients.length; i++)
            IngredientRow(
              ingredient: recipe.components[c].ingredients[i],
              showDivider: i != recipe.components[c].ingredients.length - 1,
              onEdit: () => quickEdit.ingredient(recipe, c, i),
            ),
        ],
      ],
    );
  }
}
