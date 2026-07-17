// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_notes_section.dart
// O QUÊ:     Seção "Anotações & ajustes": texto das anotações (ou placeholder),
//            editável por gesto.
// USA:       core/theme (PitadaColors), core/widgets (SectionHeader, Editable),
//            Recipe, recipe_quick_edit.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../../../core/widgets/controls/editable.dart';
import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../data/models/recipe/recipe.dart';
import '../../../recipe_quick_edit.dart';

/// Seção de anotações da receita, com placeholder quando vazia. Usada por:
/// RecipeDetailBody.
class RecipeNotesSection extends StatelessWidget {
  const RecipeNotesSection({
    super.key,
    required this.recipe,
    required this.quickEdit,
  });

  final Recipe recipe;
  final RecipeQuickEdit quickEdit;

  /// Monta o cabeçalho + texto (ou placeholder). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final has = recipe.notes != null && recipe.notes!.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Anotações & ajustes'),
        Editable(
          onEdit: () => quickEdit.notes(recipe),
          child: Text(
            has ? recipe.notes! : 'Sem anotações ainda.',
            style: AppType.on(AppType.tip, has ? pit.text2 : pit.faint),
          ),
        ),
      ],
    );
  }
}
