// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_detail_bar.dart
// O QUÊ:     Barra inferior fixa do detalhe (Cozinhar + adicionar à lista/plano).
// USA:       core/widgets/pitada_button, theme/*.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: barra inferior)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/pitada_button.dart';

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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(
            top: BorderSide(color: AppColors.line, width: AppSpacing.hair)),
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
                  icon: Icons.local_fire_department_outlined,
                  onPressed: onCook),
            ),
            const SizedBox(width: AppSpacing.md),
            _iconBtn(Icons.add_shopping_cart_outlined, onAddToList),
            const SizedBox(width: AppSpacing.md),
            _iconBtn(Icons.event_note_outlined, onAddToPlan),
          ],
        ),
      ),
    );
  }

  /// Botão quadrado de ícone (.btn-ic) da barra. Usada por: [build].
  Widget _iconBtn(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.button,
        height: AppSpacing.button,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.line2),
        ),
        child: Icon(icon, size: 19, color: AppColors.text),
      ),
    );
  }
}
