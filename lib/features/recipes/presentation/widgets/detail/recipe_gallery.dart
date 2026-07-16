// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/recipe_gallery.dart
// O QUÊ:     Cabeçalho-galeria da receita: bloco de cor grande (lugar da foto) +
//            botões flutuantes. Maior que antes; a foto real preenche este bloco.
// USA:       core/theme/app_icons, core/theme/pitada_colors, core/theme/spacing.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: galeria)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';

/// Topo do detalhe: bloco colorido grande (placeholder de foto) + voltar/editar.
/// Usada por: recipe_detail_screen.
class RecipeGallery extends StatelessWidget {
  const RecipeGallery({
    super.key,
    required this.color,
    required this.onBack,
    this.onEdit,
  });

  final Color color;
  final VoidCallback onBack;
  final VoidCallback? onEdit;

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
                AppIcons.dish,
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
                  _RoundBtn(icon: AppIcons.back, onTap: onBack, pit: pit),
                  const Spacer(),
                  _RoundBtn(icon: AppIcons.edit, onTap: onEdit, pit: pit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Botão redondo com borda sobre o bloco (voltar/editar). Usada por: [RecipeGallery].
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
