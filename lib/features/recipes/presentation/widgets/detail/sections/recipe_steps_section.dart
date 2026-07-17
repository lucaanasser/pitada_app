// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_steps_section.dart
// O QUÊ:     Seção "Modo de preparo" do detalhe: cabeçalho + por componente
//            (subcabeçalho quando nomeado) um StepTile com numeração CONTÍNUA.
// USA:       core/widgets/section_header, recipe_component_header,
//            items/step_tile, Recipe, recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: componentes_na_tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../data/models/recipe/recipe.dart';
import '../../../recipe_quick_edit.dart';
import '../items/step_tile.dart';
import 'recipe_component_header.dart';

/// Seção do modo de preparo por componente; a numeração dos passos segue
/// contínua entre componentes (fila reta). Usada por: RecipeDetailBody.
class RecipeStepsSection extends StatelessWidget {
  const RecipeStepsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho e os passos de cada componente. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[const SectionHeader(label: 'Modo de preparo')];
    var number = 0;
    for (var c = 0; c < recipe.components.length; c++) {
      final comp = recipe.components[c];
      if (comp.name != null) {
        children.add(RecipeComponentHeader(name: comp.name!));
      }
      for (var i = 0; i < comp.steps.length; i++) {
        number++;
        final n = number;
        children.add(
          StepTile(
            number: n,
            step: comp.steps[i],
            showDivider: i != comp.steps.length - 1,
            onEdit: () => quickEdit.step(recipe, c, i, number: n),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
