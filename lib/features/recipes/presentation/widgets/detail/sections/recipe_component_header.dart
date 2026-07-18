// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_component_header.dart
// O QUÊ:     Subcabeçalho de componente (massa/cobertura) dentro de uma seção do
//            detalhe — versalete cinza + filete, aninhado abaixo do cabeçalho.
// USA:       core/widgets/section_header, core/theme (AppSpacing).
// USADO POR: recipe_ingredients_section, recipe_steps_section, recipe_edit_screen,
//            import_preview.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: componentes_na_tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/widgets/layout/section_header.dart';

/// Nome do componente como subcabeçalho versalete com filete dentro da seção
/// (seção, nunca aba: tudo na mesma rolagem). Usada por: seções de ingredientes
/// e passos.
class RecipeComponentHeader extends StatelessWidget {
  const RecipeComponentHeader({super.key, required this.name});

  final String name;

  /// Monta o nome via SectionHeader, com respiro reduzido por ser aninhado.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return SectionHeader(label: name, topGap: AppSpacing.lg);
  }
}
