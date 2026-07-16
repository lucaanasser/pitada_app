// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_toggle.dart
// O QUÊ:     Toggle liga/desliga flat do app: pílula com borda, botão que desliza,
//            accent quando ligado. Átomo visual único (promovido do profile).
// USA:       theme/colors (AppColors.accent), theme/pitada_colors, theme/spacing.
// USADO POR: SettingsSwitchRow (profile) e QuickEditSheet (recipes: "nova versão").
// SPEC:      specs/components/pitada_toggle.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';

/// Toggle flat liga/desliga. Com [onChanged] é tocável sozinho; sem ele fica
/// só-visual (o widget em volta trata o toque). Usada por: settings, sheets.
class PitadaToggle extends StatelessWidget {
  const PitadaToggle({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  /// Monta a pílula com o botão deslizante; interativa quando há [onChanged].
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final pill = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 44,
      height: 26,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? AppColors.accent : pit.surf2,
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: value ? AppColors.text : pit.faint,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
    if (onChanged == null) return pill;
    return GestureDetector(
      onTap: () => onChanged!(!value),
      behavior: HitTestBehavior.opaque,
      child: pill,
    );
  }
}
