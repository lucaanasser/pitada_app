// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/sheet_grip.dart
// O QUÊ:     "Grip" no topo de bottom sheets — barrinha 36x5 centralizada.
// USA:       theme/colors (line2), theme/spacing (margem/raio).
// USADO POR: import_sheet e cook_chat_sheet (topo das sheets da feature).
// SPEC:      specs/features/recipes.yaml (sheets: grip padrão)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';

/// Barrinha de arrasto do bottom sheet, centralizada com margem vertical.
/// Usada por: import_sheet e cook_chat_sheet.
class SheetGrip extends StatelessWidget {
  const SheetGrip({super.key});

  /// Desenha o grip 36x5 com raio 3. Usada por: framework.
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
