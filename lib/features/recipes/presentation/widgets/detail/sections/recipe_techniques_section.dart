// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_techniques_section.dart
// O QUÊ:     Seção "Técnicas desta receita": cabeçalho + uma PitadaTag por técnica.
//            Some quando a receita não tem técnicas.
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (PitadaTag,
//            SectionHeader, Editable), Recipe, recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_icons.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/widgets/controls/editable.dart';
import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../../../core/widgets/tags/pitada_tag.dart';
import '../../../../data/models/recipe.dart';
import '../../../recipe_quick_edit.dart';

/// Seção das técnicas em tags coloridas; editável por gesto. Vazia quando a
/// receita não tem técnicas. Usada por: RecipeDetailBody.
class RecipeTechniquesSection extends StatelessWidget {
  const RecipeTechniquesSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta cabeçalho + tags, ou nada quando não há técnicas. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    if (recipe.techniques.isEmpty) return const SizedBox.shrink();
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Técnicas desta receita'),
        Editable(
          onEdit: () => quickEdit.techniques(recipe),
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final t in recipe.techniques)
                PitadaTag(
                  label: t,
                  color: pit.card('plum'),
                  icon: AppIcons.technique,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
