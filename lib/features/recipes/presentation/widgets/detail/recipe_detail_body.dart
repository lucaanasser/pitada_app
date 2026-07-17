// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/recipe_detail_body.dart
// O QUÊ:     Compositor do detalhe da receita: cabeçalho de identidade + seções
//            (cada uma um widget próprio) numa rolagem + barra fixa de ações.
// USA:       core (theme, NutritionCard), recipe_quick_edit, widgets do detalhe
//            (header/, sections/), go_router.
// USADO POR: recipe_detail_screen (_body, já com a versão resolvida).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/cards/nutrition_card.dart';
import '../../../data/models/recipe/recipe.dart';
import '../../recipe_quick_edit.dart';
import 'header/recipe_detail_header.dart';
import 'header/recipe_meta.dart';
import 'header/recipe_title_view.dart';
import 'recipe_detail_bar.dart';
import 'sections/recipe_ingredients_section.dart';
import 'sections/recipe_notes_section.dart';
import 'sections/recipe_steps_section.dart';
import 'sections/recipe_techniques_section.dart';

/// Corpo do detalhe da receita já resolvida (versão escolhida). [versionTag] é o
/// marcador "V3" ao lado do título (só quando há versões). Usada por: RecipeDetailScreen.
class RecipeDetailBody extends ConsumerWidget {
  const RecipeDetailBody({super.key, required this.recipe, this.versionTag});

  final Recipe recipe;
  final Widget? versionTag;

  /// Monta o cabeçalho + seções na rolagem e a barra fixa. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qe = RecipeQuickEdit(context, ref);
    final r = recipe;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.gutter,
                AppSpacing.md,
                AppSpacing.gutter,
                AppSpacing.xl,
              ),
              children: [
                RecipeDetailHeader(recipeId: r.id),
                const SizedBox(height: AppSpacing.lg),
                RecipeTitleView(recipe: r, quickEdit: qe, versionTag: versionTag),
                const SizedBox(height: AppSpacing.lg),
                RecipeMeta(
                  recipe: r,
                  onEditServings: () => qe.servings(r),
                  onEditTime: () => qe.time(r),
                ),
                const SizedBox(height: AppSpacing.xl),
                NutritionCard(
                  protein: r.protein,
                  carb: r.carb,
                  fat: r.fat,
                  onEditProtein: () => qe.macro(r, RecipeMacro.protein),
                  onEditFat: () => qe.macro(r, RecipeMacro.fat),
                  onEditCarb: () => qe.macro(r, RecipeMacro.carb),
                ),
                RecipeIngredientsSection(recipe: r, quickEdit: qe),
                RecipeStepsSection(recipe: r, quickEdit: qe),
                RecipeTechniquesSection(recipe: r, quickEdit: qe),
                RecipeNotesSection(recipe: r, quickEdit: qe),
              ],
            ),
          ),
          RecipeDetailBar(
            onCook: () => context.push('/recipe/${r.id}/cook'),
          ),
        ],
      ),
    );
  }
}
