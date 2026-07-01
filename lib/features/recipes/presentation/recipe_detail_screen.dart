// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipe_detail_screen.dart
// O QUÊ:     Detalhe da receita: galeria grande, kcal, macros, ingredientes, passos.
// USA:       recipes_providers, widgets do detalhe, core/widgets, core/theme (pit).
// USADO POR: core/router/router.dart (/recipe/:id).
// SPEC:      specs/features/recipes.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/nutrition_card.dart';
import '../../../core/widgets/pitada_tag.dart';
import '../../../core/widgets/section_header.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import 'widgets/ingredient_row.dart';
import 'widgets/recipe_detail_bar.dart';
import 'widgets/recipe_gallery.dart';
import 'widgets/recipe_meta.dart';
import 'widgets/step_tile.dart';

/// Tela de detalhe de uma receita. Usada por: router (/recipe/:id).
class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  /// Observa a receita por id e monta carregando/erro/conteúdo. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(recipeByIdProvider(recipeId));
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent)),
        error: (e, _) =>
            Center(child: Text('Erro: $e', style: AppType.on(AppType.body, pit.text))),
        data: (recipe) => recipe == null
            ? Center(
                child: Text('Receita não encontrada',
                    style: AppType.on(AppType.body, pit.text)))
            : _content(context, recipe),
      ),
    );
  }

  /// Monta o corpo rolável + a barra fixa. Usada por: [build].
  Widget _content(BuildContext context, Recipe recipe) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              RecipeGallery(
                color: context.pit.card(recipe.heroColor),
                onBack: () => context.pop(),
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
                  children: _sections(context, recipe),
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

  /// As seções do detalhe, de cima para baixo. Usada por: [_content].
  List<Widget> _sections(BuildContext context, Recipe recipe) {
    final pit = context.pit;
    return [
      Text(recipe.title, style: AppType.on(AppType.display, pit.text)),
      const SizedBox(height: AppSpacing.sm),
      Text('${formatKcal(recipe.kcal)} kcal',
          style: AppType.on(AppType.numeralLg, AppColors.accent)),
      const SizedBox(height: AppSpacing.lg),
      RecipeMeta(recipe: recipe),
      const SizedBox(height: AppSpacing.xl),
      NutritionCard(
        protein: recipe.protein,
        carb: recipe.carb,
        fat: recipe.fat,
      ),
      const SectionHeader(label: 'Ingredientes'),
      for (var i = 0; i < recipe.ingredients.length; i++)
        IngredientRow(
          ingredient: recipe.ingredients[i],
          showDivider: i != recipe.ingredients.length - 1,
        ),
      const SectionHeader(label: 'Modo de preparo'),
      for (var i = 0; i < recipe.steps.length; i++)
        StepTile(
          number: i + 1,
          step: recipe.steps[i],
          showDivider: i != recipe.steps.length - 1,
        ),
      if (recipe.techniques.isNotEmpty) ...[
        const SectionHeader(label: 'Técnicas desta receita'),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final t in recipe.techniques)
              PitadaTag(
                  label: t, color: pit.card('plum'), icon: Icons.school_outlined),
          ],
        ),
      ],
      const SectionHeader(label: 'Anotações & ajustes'),
      Text(
        recipe.notes ?? 'Sem anotações ainda.',
        style: AppType.on(
            AppType.tip, recipe.notes == null ? pit.faint : pit.text2),
      ),
    ];
  }
}
