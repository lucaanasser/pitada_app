// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_ingredients_section.dart
// O QUÊ:     Seção "Ingredientes" do detalhe: cabeçalho (+ action "usar
//            subreceita") e, por componente, subcabeçalho (com selo quando
//            vinculado) + IngredientRow editável por gesto.
// USA:       core/widgets/section_header, recipe_component_header,
//            items/ingredient_row, Recipe, recipe_quick_edit,
//            sub_recipe_providers (uso), go_router.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (componentes_na_tela) +
//            specs/features/sub_recipes.yaml (ui.no_prato)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../application/sub_recipe/sub_recipe_providers.dart';
import '../../../../data/models/recipe/recipe.dart';
import '../../../recipe_quick_edit.dart';
import '../items/ingredient_row.dart';
import 'recipe_component_header.dart';

/// Seção de ingredientes por componente, na mesma rolagem (seção, nunca aba).
/// [factor] reescala a EXIBIÇÃO das quantidades (porções vistas / base);
/// componente LOCAL edita a receita, VINCULADO edita a subreceita (propaga).
/// Usada por: RecipeDetailBody.
class RecipeIngredientsSection extends ConsumerWidget {
  const RecipeIngredientsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
    this.factor = 1,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;
  final num factor;

  /// Monta o cabeçalho e as linhas de cada componente. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage =
        ref.watch(subRecipeUsageProvider).valueOrNull ?? const <String, int>{};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          label: 'Ingredientes',
          accent: true,
          action: '+ subreceita',
          onAction: () => quickEdit.linkSubRecipe(recipe),
        ),
        for (var c = 0; c < recipe.components.length; c++) ...[
          _header(context, c, usage),
          for (var i = 0; i < recipe.components[c].ingredients.length; i++)
            IngredientRow(
              ingredient: recipe.components[c].ingredients[i].scaled(factor),
              showDivider: i != recipe.components[c].ingredients.length - 1,
              onEdit: recipe.components[c].isLinked
                  ? () => quickEdit.subIngredient(
                        recipe.components[c].subRecipeId!,
                        i,
                      )
                  : () => quickEdit.ingredient(recipe, c, i),
            ),
        ],
      ],
    );
  }

  /// Subcabeçalho do componente [c]: selo de vínculo quando vinculado, nada
  /// quando implícito (receita simples). Usada por: [build].
  Widget _header(BuildContext context, int c, Map<String, int> usage) {
    final comp = recipe.components[c];
    if (comp.isLinked) {
      return RecipeComponentHeader(
        name: comp.name ?? 'Subreceita',
        linkScale: comp.scale,
        linkUsedBy: usage[comp.subRecipeId] ?? 0,
        onOpen: () => context.push('/sub-recipe/${comp.subRecipeId}'),
        onEdit: () => quickEdit.componentActions(recipe, c),
      );
    }
    if (comp.name == null) return const SizedBox.shrink();
    return RecipeComponentHeader(
      name: comp.name!,
      onEdit: () => quickEdit.componentActions(recipe, c),
    );
  }
}
