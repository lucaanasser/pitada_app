// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_gallery.dart
// O QUÊ:     Cabeçalho-galeria da receita: bloco de cor grande (lugar da foto) +
//            botões flutuantes. Maior que antes; a foto real preenche este bloco.
// USA:       core/theme/pitada_colors, core/theme/spacing.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: galeria)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';

/// Topo do detalhe: bloco colorido grande (placeholder de foto) + voltar/editar/favoritar.
/// Usada por: recipe_detail_screen.
class RecipeGallery extends StatelessWidget {
  const RecipeGallery({
    super.key,
    required this.color,
    required this.onBack,
    this.onEdit,
    this.onFavorite,
  });

  final Color color; // cor pastel do bloco (context.pit.card(heroColor))
  final VoidCallback onBack;
  final VoidCallback? onEdit;
  final VoidCallback? onFavorite;

  /// Monta o bloco colorido grande + botões flutuantes de ação. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(color: pit.border, width: AppSpacing.borderStrong),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.restaurant,
                size: 72,
                color: (pit.isDark ? pit.text : pit.border)
                    .withValues(alpha: 0.32),
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
                  _RoundBtn(icon: Icons.arrow_back, onTap: onBack, pit: pit),
                  const Spacer(),
                  _RoundBtn(icon: Icons.edit_outlined, onTap: onEdit, pit: pit),
                  const SizedBox(width: AppSpacing.sm),
                  _RoundBtn(
                      icon: Icons.favorite_border,
                      onTap: onFavorite,
                      pit: pit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Botão redondo com borda sobre o bloco (voltar/editar/favoritar). Usada por: [RecipeGallery].
class _RoundBtn extends StatelessWidget {
  const _RoundBtn({required this.icon, this.onTap, required this.pit});
  final IconData icon;
  final VoidCallback? onTap;
  final PitadaColors pit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.iconButton,
        height: AppSpacing.iconButton,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pit.surf,
          border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
        ),
        child: Icon(icon, size: 19, color: pit.text),
      ),
    );
  }
}
