// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/sheet_grip.dart
// O QUÊ:     "Grip" padrão no topo dos bottom sheets de Planos (barrinha central).
// USA:       theme/colors, theme/spacing.
// USADO POR: meal_sheet, add_option_sheet (início do conteúdo do sheet).
// SPEC:      specs/features/plans.yaml (sheets começam com grip)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';

/// Barrinha de arraste centralizada no topo de um bottom sheet.
/// Usada por: os sheets de Planos, logo antes do título.
class SheetGrip extends StatelessWidget {
  const SheetGrip({super.key});

  /// Renderiza a barrinha 36x5 (line2) com margem vertical. Usada por: os sheets.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 5,
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.line2,
          borderRadius: AppSpacing.br(3),
        ),
      ),
    );
  }
}
