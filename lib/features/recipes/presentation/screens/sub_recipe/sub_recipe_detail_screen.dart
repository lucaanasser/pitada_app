// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/sub_recipe/sub_recipe_detail_screen.dart
// O QUÊ:     Detalhe de uma subreceita na biblioteca: nome (renomear por gesto),
//            aviso de propagação, ingredientes (valores BASE) e passos —
//            edição inline por gesto; toda edição propaga.
// USA:       sub_recipe_providers, recipe_quick_edit (SubRecipeEdit),
//            IngredientRow, StepTile, core/widgets, core/theme, go_router.
// USADO POR: core/router (/sub-recipe/:id) — via selo no detalhe da receita.
// SPEC:      specs/features/sub_recipes.yaml (ui.biblioteca)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/editable.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../application/sub_recipe/sub_recipe_providers.dart';
import '../../recipe_quick_edit.dart';
import '../../widgets/detail/items/ingredient_row.dart';
import '../../widgets/detail/items/step_tile.dart';

/// Detalhe editável de uma subreceita. Usada por: router (/sub-recipe/:id).
class SubRecipeDetailScreen extends ConsumerWidget {
  const SubRecipeDetailScreen({super.key, required this.subRecipeId});

  final String subRecipeId;

  /// Observa a subreceita + usos e monta as seções editáveis. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final sub = ref.watch(subRecipeByIdProvider(subRecipeId)).valueOrNull;
    final uses = (ref.watch(subRecipeUsageProvider).valueOrNull ??
            const <String, int>{})[subRecipeId] ??
        0;

    if (sub == null) {
      return Scaffold(
        backgroundColor: pit.bg,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    final qe = RecipeQuickEdit(context, ref);

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            _top(context, pit),
            const SizedBox(height: AppSpacing.lg),
            Editable(
              onEdit: () => qe.subName(sub),
              child: Text(
                sub.name,
                style: AppType.on(AppType.screenTitle, pit.text),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _spreadNote(uses),
              style: AppType.on(AppType.caption, pit.muted),
            ),
            const SectionHeader(label: 'Ingredientes', accent: true),
            for (var i = 0; i < sub.ingredients.length; i++)
              IngredientRow(
                ingredient: sub.ingredients[i],
                showDivider: i != sub.ingredients.length - 1,
                onEdit: () => qe.subIngredient(subRecipeId, i),
              ),
            const SectionHeader(label: 'Modo de preparo', accent: true),
            for (var i = 0; i < sub.steps.length; i++)
              StepTile(
                number: i + 1,
                step: sub.steps[i],
                showDivider: i != sub.steps.length - 1,
                onEdit: () => qe.subStep(subRecipeId, i, number: i + 1),
              ),
          ],
        ),
      ),
    );
  }

  /// Linha do topo: voltar + rótulo SUBRECEITA. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Text('SUBRECEITA', style: AppType.on(AppType.label, AppColors.accent)),
      ],
    );
  }

  /// Aviso de propagação sob o nome. Usada por: [build].
  String _spreadNote(int uses) => switch (uses) {
        0 => 'Ainda não vinculada a nenhuma receita.',
        1 => 'Usada em 1 receita.',
        _ => 'Usada em $uses receitas — editar aqui muda em todas.',
      };
}
