// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista (miniatura pastel + título + meta +
//            maestria + memória do caderno + seta).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (HairlineRow,
//            RecipeThumb outlined), recipe_meta_text (linha de meta), Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/cards/recipe_thumb.dart';
import '../../../data/models/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista. [mastery] é a linha de maestria
/// ("nunca fiz" / "fiz 2×" / "domino") e [memory] a anotação da última vez
/// ("última vez: faltou ácido"). Usada por: RecipeListView.
class RecipeRow extends StatelessWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
    this.mastery,
    this.memory,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;
  final String? mastery;
  final String? memory;

  /// Monta a linha (miniatura + título + meta + maestria + memória + seta).
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final hasMastery = mastery != null && mastery!.isNotEmpty;
    final hasMemory = memory != null && memory!.isNotEmpty;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(color: pit.card(recipe.heroColor), outlined: true),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hasMastery
                ? '${recipeMetaText(recipe)}  ·  $mastery'
                : recipeMetaText(recipe),
            style: AppType.on(AppType.caption, pit.muted),
          ),
          if (hasMemory)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                memory!,
                style: AppType.on(AppType.captionSm, pit.text2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}
