// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_steps_section.dart
// O QUÊ:     Seção "Modo de preparo" do detalhe: cabeçalho + um StepTile numerado
//            por passo, cada um editável por gesto.
// USA:       core/widgets/section_header, items/step_tile, Recipe, recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../data/models/recipe.dart';
import '../../../recipe_quick_edit.dart';
import '../items/step_tile.dart';

/// Seção do modo de preparo: cabeçalho + passos numerados com dica opcional.
/// Usada por: RecipeDetailBody.
class RecipeStepsSection extends StatelessWidget {
  const RecipeStepsSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho e a lista de passos numerados. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Modo de preparo'),
        for (var i = 0; i < recipe.steps.length; i++)
          StepTile(
            number: i + 1,
            step: recipe.steps[i],
            showDivider: i != recipe.steps.length - 1,
            onEdit: () => quickEdit.step(recipe, i),
          ),
      ],
    );
  }
}
