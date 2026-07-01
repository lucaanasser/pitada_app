// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_view_toggle.dart
// O QUÊ:     Alternador segmentado de layout da lista (card grande / 2 colunas / lista).
// USA:       core/theme (AppIcons, AppColors, PitadaColors), recipe_view_provider.
// USADO POR: recipes_screen (cabeçalho da lista).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: alternador de layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../application/recipe_view_provider.dart';

/// Três botões (single/grid/list); o ativo fica em accent. Usada por: recipes_screen.
class RecipeViewToggle extends StatelessWidget {
  const RecipeViewToggle({
    super.key,
    required this.value,
    required this.onSelect,
  });

  final RecipeView value;
  final ValueChanged<RecipeView> onSelect;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _btn(pit, AppIcons.viewSingle, RecipeView.single),
          _btn(pit, AppIcons.viewGrid, RecipeView.grid),
          _btn(pit, AppIcons.viewList, RecipeView.list),
        ],
      ),
    );
  }

  /// Um botão do alternador. Usada por: [build].
  Widget _btn(PitadaColors pit, IconData icon, RecipeView v) {
    final active = v == value;
    return GestureDetector(
      onTap: () => onSelect(v),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 2, vertical: 5),
        decoration: active
            ? BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: AppSpacing.br(AppSpacing.radiusPill),
              )
            : null,
        child: Icon(icon, size: 17, color: active ? AppColors.accent : pit.muted),
      ),
    );
  }
}
