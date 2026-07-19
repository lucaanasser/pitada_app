// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_steps_section.dart
// O QUÊ:     Seção "Modo de preparo" do detalhe: cabeçalho + por componente
//            (subcabeçalho, com selo quando vinculado) um StepTile com
//            numeração CONTÍNUA.
// USA:       core/widgets/section_header, recipe_component_header,
//            items/step_tile, Recipe, recipe_quick_edit,
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
import '../items/step_tile.dart';
import 'recipe_component_header.dart';

/// Seção do modo de preparo por componente; a numeração dos passos segue
/// contínua entre componentes (fila reta). Passo de componente VINCULADO edita
/// a subreceita (propaga). Usada por: RecipeDetailBody.
class RecipeStepsSection extends ConsumerWidget {
  const RecipeStepsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho e os passos de cada componente. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage =
        ref.watch(subRecipeUsageProvider).valueOrNull ?? const <String, int>{};
    final children = <Widget>[
      const SectionHeader(label: 'Modo de preparo', accent: true),
    ];
    var number = 0;
    for (var c = 0; c < recipe.components.length; c++) {
      final comp = recipe.components[c];
      final header = _header(context, c, usage);
      if (header != null) children.add(header);
      for (var i = 0; i < comp.steps.length; i++) {
        number++;
        final n = number;
        children.add(
          StepTile(
            number: n,
            step: comp.steps[i],
            showDivider: i != comp.steps.length - 1,
            onEdit: comp.isLinked
                ? () => quickEdit.subStep(comp.subRecipeId!, i, number: n)
                : () => quickEdit.step(recipe, c, i, number: n),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  /// Subcabeçalho do componente [c] (selo quando vinculado); null quando
  /// implícito. Usada por: [build].
  Widget? _header(BuildContext context, int c, Map<String, int> usage) {
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
    if (comp.name == null) return null;
    return RecipeComponentHeader(
      name: comp.name!,
      onEdit: () => quickEdit.componentActions(recipe, c),
    );
  }
}
