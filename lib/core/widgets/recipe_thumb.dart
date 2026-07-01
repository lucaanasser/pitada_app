// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/recipe_thumb.dart
// O QUÊ:     Miniatura editorial de receita — quadrado colorido com ícone de prato.
// USA:       theme/colors (cores hero), theme/spacing (raio).
// USADO POR: recipes_screen, meal pickers (Planos), qualquer lista de receitas.
// SPEC:      specs/components/atoms.yaml (RecipeThumb)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/spacing.dart';

/// Quadrado colorido (hero_color) com um ícone claro no centro — placeholder de foto.
/// Usada por: RecipeRow e seletores de receita.
class RecipeThumb extends StatelessWidget {
  const RecipeThumb({
    super.key,
    required this.color,
    this.size = 54,
    this.icon = Icons.restaurant_menu,
    this.radius = AppSpacing.radiusMd,
  });

  final Color color;
  final double size;
  final IconData icon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppSpacing.br(radius),
      ),
      child: Icon(
        icon,
        size: size * 0.4,
        color: Colors.white.withValues(alpha: 0.42),
      ),
    );
  }
}
