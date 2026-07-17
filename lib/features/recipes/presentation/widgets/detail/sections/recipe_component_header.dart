// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_component_header.dart
// O QUÊ:     Subcabeçalho de componente (massa/cobertura) dentro de uma seção do
//            detalhe — menor que o SectionHeader, sem filete.
// USA:       core/theme (AppType, PitadaColors, AppSpacing).
// USADO POR: recipe_ingredients_section, recipe_steps_section, recipe_edit_screen,
//            import_preview.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: componentes_na_tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';

/// Nome do componente como subcabeçalho sóbrio dentro da seção (seção, nunca
/// aba: tudo na mesma rolagem). Usada por: seções de ingredientes e passos.
class RecipeComponentHeader extends StatelessWidget {
  const RecipeComponentHeader({super.key, required this.name});

  final String name;

  /// Monta o nome em titleSm, com respiro acima. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.xs,
      ),
      child: Text(name, style: AppType.on(AppType.titleSm, context.pit.text)),
    );
  }
}
