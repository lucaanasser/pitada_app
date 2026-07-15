// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/fuel_bar.dart
// O QUÊ:     Barra de progresso fina (combustível do dia) — % da meta atingida.
// USA:       theme/colors, theme/spacing.
// USADO POR: plans_screen (resumo do dia).
// SPEC:      specs/components/atoms.yaml (FuelBar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';

/// Barra de combustível: preenche [progress] (0..1). [over] pinta de terracota.
/// Usada por: plans_screen.
class FuelBar extends StatelessWidget {
  const FuelBar({super.key, required this.progress, this.over = false});

  final double progress;
  final bool over;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: context.pit.surf2,
        borderRadius: AppSpacing.br(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: over ? AppColors.accent2 : AppColors.sage,
            borderRadius: AppSpacing.br(4),
          ),
        ),
      ),
    );
  }
}
