// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista (miniatura pastel + título + meta +
//            maestria + seta). Uma linha só de subtítulo — sem ruído.
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (HairlineRow,
//            RecipeThumb outlined), recipe_meta_text (linha de meta), Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/cards/recipe_thumb.dart';
import '../../../data/models/recipe/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista. [mastery] é a maestria
/// ("nunca fiz" / "fiz 2×" / "domino"), somada à meta em uma única linha.
/// Usada por: RecipeListView.
class RecipeRow extends StatelessWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
    this.mastery,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;
  final String? mastery;

  /// Monta a linha (miniatura + título + meta·maestria + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final hasMastery = mastery != null && mastery!.isNotEmpty;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(
        color: pit.card(recipe.heroColor),
        outlined: true,
        size: 72,
        radius: AppSpacing.radiusLg,
      ),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        hasMastery
            ? '${recipeMetaText(recipe)}  ·  $mastery'
            : recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}
