// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/ingredient_row.dart
// O QUÊ:     Linha de ingrediente: nome + grama em destaque + unidade humana menor.
// USA:       core/theme (PitadaColors), core/widgets/hairline_row, utils/format, Ingredient.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: IngredientRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/editable.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../data/ingredient.dart';

/// Ingrediente como linha: grama grande (base) + unidade humana pequena (ref.).
/// Editável por gesto ([onEdit]): segurar/duplo-clique abre a edição do ingrediente.
/// Usada por: recipe_detail_screen.
class IngredientRow extends StatelessWidget {
  const IngredientRow({
    super.key,
    required this.ingredient,
    this.showDivider = true,
    this.onEdit,
  });

  final Ingredient ingredient;
  final bool showDivider;
  final VoidCallback? onEdit;

  /// Monta a linha: nome + gramas em destaque + unidade humana. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Editable(
      onEdit: onEdit,
      child: HairlineRow(
        showDivider: showDivider,
        crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.symmetric(vertical: 14),
        title: Text(ingredient.name, style: AppType.on(AppType.body, pit.text)),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatGrams(ingredient.grams),
              style: AppType.on(AppType.numeral, pit.text),
            ),
            if (ingredient.humanQty != null)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  formatHuman(ingredient.humanQty, ingredient.humanUnit),
                  style: AppType.on(AppType.captionSm, pit.muted),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
