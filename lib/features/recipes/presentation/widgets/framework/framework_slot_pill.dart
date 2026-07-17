// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_slot_pill.dart
// O QUÊ:     A "lacuna" visível de um framework: pílula vazia de contorno
//            tracejado no olhar (borda + texto muted), marcando o que varia.
// USA:       core/theme (PitadaColors, AppSpacing, AppType).
// USADO POR: framework_skeleton_view.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Pílula de slot: um espaço em branco nomeado ("proteína", "líquido") na
/// planta baixa do framework. Usada por: FrameworkSkeletonView.
class FrameworkSlotPill extends StatelessWidget {
  const FrameworkSlotPill({super.key, required this.label});

  final String label;

  /// Monta a pílula de contorno com o nome do slot. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: pit.line2, width: AppSpacing.borderStrong),
      ),
      child: Text(label, style: AppType.on(AppType.captionSm, pit.muted)),
    );
  }
}
