// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/recipe_detail_body.dart
// O QUÊ:     Compositor do detalhe da receita: monta a lista rolável (galeria +
//            seções, cada uma um widget próprio) e a barra fixa de ações.
// USA:       core (theme, NutritionCard), framework_providers, recipe_quick_edit,
//            widgets do detalhe (header/, sections/), go_router.
// USADO POR: recipe_detail_screen (_body, já com a versão resolvida).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/nutrition_card.dart';
import '../../../application/framework_providers.dart';
import '../../../data/models/recipe.dart';
import '../../recipe_quick_edit.dart';
import 'header/recipe_meta.dart';
import 'header/recipe_title_view.dart';
import 'recipe_detail_bar.dart';
import 'recipe_gallery.dart';
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

  /// Monta a lista rolável (galeria + seções) e a barra fixa. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qe = RecipeQuickEdit(context, ref);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              RecipeGallery(
                color: context.pit.card(recipe.heroColor),
                onBack: () => context.pop(),
                onEdit: () => context.push('/recipe/${recipe.id}/edit'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  AppSpacing.xl,
                  AppSpacing.gutter,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sections(context, ref, qe),
                ),
              ),
            ],
          ),
        ),
        RecipeDetailBar(
          onCook: () => context.push('/recipe/${recipe.id}/cook'),
        ),
      ],
    );
  }

  /// As seções, de cima para baixo; cada uma é um widget próprio. Usada por: [build].
  List<Widget> _sections(BuildContext context, WidgetRef ref, RecipeQuickEdit qe) {
    final r = recipe;
    final frameworks = ref.watch(frameworksForRecipeProvider(r.id));
    return [
      RecipeTitleView(recipe: r, quickEdit: qe, versionTag: versionTag),
      const SizedBox(height: AppSpacing.lg),
      RecipeMeta(
        recipe: r,
        onEditServings: () => qe.servings(r),
        onEditTime: () => qe.time(r),
      ),
      for (final f in frameworks)
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          child: GestureDetector(
            onTap: () => context.push('/framework/${f.id}'),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  AppIcons.framework,
                  size: 14,
                  color: AppColors.accent2,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'faz parte de: ${f.name}',
                    style: AppType.on(AppType.bodySm, AppColors.accent2),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
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
    ];
  }
}
