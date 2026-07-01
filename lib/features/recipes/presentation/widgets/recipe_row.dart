// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_row.dart
// O QUÊ:     Linha de receita na lista (miniatura + título + meta + seta).
// USA:       core/widgets (HairlineRow, RecipeThumb), theme/*, utils/format, Recipe.
// USADO POR: recipes_screen, folder_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: RecipeRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/recipe_thumb.dart';
import '../../../../core/utils/format.dart';
import '../../data/recipe.dart';

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
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(color: AppColors.heroOf(recipe.heroColor)),
      title: Text(recipe.title, style: AppType.titleSm),
      subtitle:
          Text(_meta(), style: AppType.on(AppType.caption, AppColors.muted)),
      trailing:
          const Icon(Icons.chevron_right, size: 16, color: AppColors.faint),
    );
  }

  /// Monta a linha de meta 'tempo · kcal · dificuldade'. Usada por: [build].
  String _meta() {
    final parts = <String>[
      if (recipe.timeMinutes != null) formatMinutes(recipe.timeMinutes),
      '${formatKcal(recipe.kcal)} kcal',
      if (recipe.difficulty != null) recipe.difficulty!,
    ];
    return parts.join('  ·  ');
  }
}
