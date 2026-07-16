// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_row.dart
// O QUÊ:     Linha de receita na lista (miniatura pastel + título + meta + seta).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (HairlineRow,
//            RecipeThumb outlined), recipe_meta_text (linha de meta), Recipe.
// USADO POR: recipes_screen, folder_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/cards/recipe_thumb.dart';
import '../../data/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista. Usada por: recipes_screen.
class RecipeRow extends StatelessWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha (miniatura + título + meta + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(color: pit.card(recipe.heroColor), outlined: true),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}
