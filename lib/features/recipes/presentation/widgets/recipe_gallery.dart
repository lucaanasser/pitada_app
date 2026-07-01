// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_gallery.dart
// O QUÊ:     Cabeçalho-galeria da receita (área colorida + botões flutuantes).
// USA:       theme/colors, theme/spacing.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: galeria)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';

/// Topo do detalhe: retângulo colorido (placeholder de foto) + voltar/editar/favoritar.
/// Usada por: recipe_detail_screen.
class RecipeGallery extends StatelessWidget {
  const RecipeGallery({
    super.key,
    required this.color,
    required this.onBack,
    this.onEdit,
    this.onFavorite,
  });

  final Color color;
  final VoidCallback onBack;
  final VoidCallback? onEdit;
  final VoidCallback? onFavorite;

  /// Monta o retângulo colorido + botões flutuantes de ação. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: color,
              alignment: Alignment.center,
              child: Icon(
                Icons.photo_outlined,
                size: 60,
                color: AppColors.text.withValues(alpha: 0.22),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.sm,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  _RoundBtn(icon: Icons.arrow_back, onTap: onBack),
                  const Spacer(),
                  _RoundBtn(icon: Icons.edit_outlined, onTap: onEdit),
                  const SizedBox(width: AppSpacing.sm),
                  _RoundBtn(icon: Icons.favorite_border, onTap: onFavorite),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Botão redondo translúcido sobre a foto (.vback). Usada por: [RecipeGallery].
class _RoundBtn extends StatelessWidget {
  const _RoundBtn({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  /// Monta o botão redondo translúcido com o ícone. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.iconButton,
        height: AppSpacing.iconButton,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Véu escuro sobre a foto para o ícone contrastar; usa o fundo do app.
          color: AppColors.bg.withValues(alpha: 0.42),
        ),
        child: Icon(icon, size: 20, color: AppColors.text),
      ),
    );
  }
}
