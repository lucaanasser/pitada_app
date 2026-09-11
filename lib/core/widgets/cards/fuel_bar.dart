// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/cards/fuel_bar.dart
// O QUÊ:     Barra de progresso fina — % da meta (Plano) ou da compra (Ingredientes).
// USA:       theme/colors, theme/spacing.
// USADO POR: plans_screen (resumo do dia) e cart_header (progresso da compra).
// SPEC:      specs/components/cards/fuel_bar.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Barra de combustível: preenche [progress] (0..1) na cor [color] (padrão
/// sage); [over] pinta de terracota e vence o [color]. [height] engrossa o
/// trilho (8 no card de compras). Usada por: plans_screen, cart_header.
class FuelBar extends StatelessWidget {
  const FuelBar({
    super.key,
    required this.progress,
    this.over = false,
    this.color,
    this.height = 6,
  });

  final double progress;
  final bool over;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.pit.surf2,
        borderRadius: AppSpacing.br(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: over ? AppColors.accent2 : (color ?? AppColors.sage),
            borderRadius: AppSpacing.br(4),
          ),
        ),
      ),
    );
  }
}
