// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/ingredient_row.dart
// O QUÊ:     Linha de ingrediente: nome + grama em destaque + unidade humana menor.
// USA:       core/widgets/hairline_row, theme/*, utils/format, Ingredient.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: IngredientRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../data/ingredient.dart';

/// Ingrediente como linha: grama grande (base) + unidade humana pequena (ref.).
/// Usada por: recipe_detail_screen.
class IngredientRow extends StatelessWidget {
  const IngredientRow(
      {super.key, required this.ingredient, this.showDivider = true});

  final Ingredient ingredient;
  final bool showDivider;

  /// Monta a linha: nome + gramas em destaque + unidade humana. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return HairlineRow(
      showDivider: showDivider,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.symmetric(vertical: 14),
      title: Text(ingredient.name, style: AppType.body),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formatGrams(ingredient.grams), style: AppType.numeral),
          if (ingredient.humanQty != null)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                formatHuman(ingredient.humanQty, ingredient.humanUnit),
                style: AppType.on(AppType.captionSm, AppColors.muted),
              ),
            ),
        ],
      ),
    );
  }
}
