// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_detail_body.dart
// O QUÊ:     Corpo rolável do detalhe (galeria + seções) + barra fixa. Cada campo é
//            editável por gesto (Editable) via RecipeQuickEdit; o lápis abre o editor
//            inteiro. Extraído do RecipeDetailScreen (limite de 200 linhas).
// USA:       core/widgets (Editable, NutritionCard, PitadaTag, SectionHeader), theme,
//            utils/format, recipe_quick_edit, widgets do detalhe, go_router.
// USADO POR: recipe_detail_screen (_body, já com a versão resolvida).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: edicao_inline)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/editable.dart';
import '../../../../core/widgets/nutrition_card.dart';
import '../../../../core/widgets/pitada_tag.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/recipe.dart';
import '../recipe_quick_edit.dart';
import 'ingredient_row.dart';
import 'recipe_detail_bar.dart';
import 'recipe_gallery.dart';
import 'recipe_meta.dart';
import 'step_tile.dart';

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
                  children: _sections(context, qe),
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

  /// As seções, de cima para baixo, cada campo com seu gesto de edição inline.
  /// Usada por: [build].
  List<Widget> _sections(BuildContext context, RecipeQuickEdit qe) {
    final pit = context.pit;
    final r = recipe;
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Editable(
              onEdit: () => qe.title(r),
              child:
                  Text(r.title, style: AppType.on(AppType.display, pit.text)),
            ),
          ),
          if (versionTag != null) ...[
            const SizedBox(width: AppSpacing.md),
            versionTag!,
          ],
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      Editable(
        onEdit: () => qe.kcal(r),
        child: Text(
          '${formatKcal(r.kcal)} kcal',
          style: AppType.on(AppType.numeralLg, AppColors.accent),
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      RecipeMeta(
        recipe: r,
        onEditServings: () => qe.servings(r),
        onEditTime: () => qe.time(r),
        onEditDifficulty: () => qe.difficulty(r),
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
      const SectionHeader(label: 'Ingredientes'),
      for (var i = 0; i < r.ingredients.length; i++)
        IngredientRow(
          ingredient: r.ingredients[i],
          showDivider: i != r.ingredients.length - 1,
          onEdit: () => qe.ingredient(r, i),
        ),
      const SectionHeader(label: 'Modo de preparo'),
      for (var i = 0; i < r.steps.length; i++)
        StepTile(
          number: i + 1,
          step: r.steps[i],
          showDivider: i != r.steps.length - 1,
          onEdit: () => qe.step(r, i),
        ),
      if (r.techniques.isNotEmpty) ...[
        const SectionHeader(label: 'Técnicas desta receita'),
        Editable(
          onEdit: () => qe.techniques(r),
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final t in r.techniques)
                PitadaTag(
                  label: t,
                  color: pit.card('plum'),
                  icon: AppIcons.technique,
                ),
            ],
          ),
        ),
      ],
      const SectionHeader(label: 'Anotações & ajustes'),
      Editable(onEdit: () => qe.notes(r), child: _notes(pit)),
    ];
  }

  /// Texto das anotações (ou placeholder quando vazio). Usada por: [_sections].
  Widget _notes(PitadaColors pit) {
    final has = recipe.notes != null && recipe.notes!.trim().isNotEmpty;
    return Text(
      has ? recipe.notes! : 'Sem anotações ainda.',
      style: AppType.on(AppType.tip, has ? pit.text2 : pit.faint),
    );
  }
}
