// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_detail_bar.dart
// O QUÊ:     Barra inferior fixa do detalhe (Cozinhar + adicionar à lista/plano).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets/pitada_button, spacing.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: barra inferior)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/controls/pitada_button.dart';

/// Barra de ações do detalhe: botão principal Cozinhar + dois ícones.
/// Usada por: recipe_detail_screen. Callbacks ainda são placeholders (próximo passo).
class RecipeDetailBar extends StatelessWidget {
  const RecipeDetailBar({
    super.key,
    required this.onCook,
    this.onAddToList,
    this.onAddToPlan,
  });

  final VoidCallback onCook;
  final VoidCallback? onAddToList;
  final VoidCallback? onAddToPlan;

  /// Monta o botão Cozinhar + os dois ícones sobre o filete. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      decoration: BoxDecoration(
        color: pit.bg,
        border: Border(
          top: BorderSide(color: pit.line, width: AppSpacing.hair),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.lg,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: PitadaButton(
                label: 'Cozinhar',
                icon: AppIcons.cook,
                onPressed: onCook,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            _iconBtn(pit, AppIcons.addToList, onAddToList),
            const SizedBox(width: AppSpacing.md),
            _iconBtn(pit, AppIcons.addToPlan, onAddToPlan),
          ],
        ),
      ),
    );
  }

  /// Botão quadrado de ícone com borda "chunky". Usada por: [build].
  Widget _iconBtn(PitadaColors pit, IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.button,
        height: AppSpacing.button,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
        ),
        child: Icon(icon, size: 19, color: pit.text),
      ),
    );
  }
}
