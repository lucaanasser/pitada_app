// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/header/recipe_title_view.dart
// O QUÊ:     Título da receita + marcador de versão opcional + kcal em destaque.
//            Título e kcal editáveis por gesto (Editable).
// USA:       core/theme (AppColors, PitadaColors), utils/format, Editable, Recipe,
//            recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: titulo_com_versao)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../../../core/utils/format.dart';
import '../../../../../../core/widgets/controls/editable.dart';
import '../../../../data/models/recipe.dart';
import '../../../recipe_quick_edit.dart';

/// Linha do título (com [versionTag] quando a receita tem versões) + kcal.
/// Usada por: RecipeDetailBody.
class RecipeTitleView extends StatelessWidget {
  const RecipeTitleView({
    super.key,
    required this.recipe,
    required this.quickEdit,
    this.versionTag,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;
  final Widget? versionTag;

  /// Monta título editável + tag de versão + kcal editável. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Editable(
                onEdit: () => quickEdit.title(recipe),
                child: Text(
                  recipe.title,
                  style: AppType.on(AppType.display, pit.text),
                ),
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
          onEdit: () => quickEdit.kcal(recipe),
          child: Text(
            '${formatKcal(recipe.kcal)} kcal',
            style: AppType.on(AppType.numeralLg, AppColors.accent),
          ),
        ),
      ],
    );
  }
}
