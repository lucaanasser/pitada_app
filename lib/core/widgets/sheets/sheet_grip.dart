// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/sheets/sheet_grip.dart
// O QUÊ:     "Grip" padrão no topo de TODO bottom sheet (barrinha central).
//            Promovido de plans/ e recipes/ (havia duas cópias iguais).
// USA:       theme/pitada_colors, theme/spacing.
// USADO POR: sheets de plans, recipes (import/cook_chat) e shopping (nova lista).
// SPEC:      specs/components/atoms.yaml (SheetGrip)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Barrinha de arraste centralizada no topo de um bottom sheet.
/// Usada por: todos os sheets do app, logo antes do título.
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
          color: context.pit.line2,
          borderRadius: AppSpacing.br(3),
        ),
      ),
    );
  }
}
