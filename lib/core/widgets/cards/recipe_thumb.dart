// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/cards/recipe_thumb.dart
// O QUÊ:     Miniatura de receita — quadrado colorido com ícone. [outlined] é o
//            modo pastel neo-brutalista (borda tinta + ícone na tinta do tema).
// USA:       core/theme/app_icons (ícone padrão), theme/pitada_colors (tinta),
//            theme/spacing (raio/borda).
// USADO POR: recipes (RecipeRow, FrameworkRow), plans (add_option_sheet),
//            meal pickers, listas do Caderno (modo legado, cor cheia).
// SPEC:      specs/components/cards/recipe_thumb.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/app_icons.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Quadrado colorido (hero_color) com ícone no centro — placeholder de foto.
/// [outlined] = pastel + borda tinta (soft neo-brutalismo); false = cor cheia legada.
/// Usada por: RecipeRow, FrameworkRow e seletores de receita.
class RecipeThumb extends StatelessWidget {
  const RecipeThumb({
    super.key,
    required this.color,
    this.size = 54,
    this.icon = AppIcons.dish,
    this.radius = AppSpacing.radiusMd,
    this.outlined = false,
  });

  final Color color;
  final double size;
  final IconData icon;
  final double radius;
  final bool outlined;

  /// Monta o quadrado; em [outlined] o ícone usa a tinta do tema (o branco fixo
  /// sumiria sobre pastel no tema claro). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppSpacing.br(radius),
        border: outlined
            ? Border.all(color: pit.border, width: AppSpacing.borderStrong)
            : null,
      ),
      child: Icon(
        icon,
        size: size * 0.4,
        color: outlined
            ? (pit.isDark ? pit.text : pit.border).withValues(alpha: 0.35)
            : Colors.white.withValues(alpha: 0.42),
      ),
    );
  }
}
