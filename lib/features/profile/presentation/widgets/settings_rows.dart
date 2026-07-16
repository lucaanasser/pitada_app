// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/settings_rows.dart
// O QUÊ:     Linhas de configuração reutilizadas na SettingsScreen: toggle flat
//            com borda (SettingsSwitchRow), stepper − valor + (SettingsStepperRow)
//            e link com chevron (SettingsLinkRow). Tudo flat, sem sombra.
// USA:       core/theme (context.pit, AppSpacing, AppType, AppIcons),
//            core/widgets (hairline_row, pitada_toggle).
// USADO POR: SettingsScreen (seções Cozinha / Notificações / Sobre).
// SPEC:      specs/features/profile.yaml (components_da_feature.SettingsRows)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/controls/pitada_toggle.dart';

/// Linha com toggle liga/desliga. A linha inteira é tocável.
/// Usada por: SettingsScreen (dicas de técnica, notificações).
class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      onTap: () => onChanged(!value),
      title: Text(title, style: AppType.on(AppType.body, pit.text)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: AppType.on(AppType.caption, pit.muted)),
      trailing: PitadaToggle(value: value),
    );
  }
}

/// Linha com stepper numérico (− valor +) limitado a [min]..[max].
/// Usada por: SettingsScreen (porções padrão).
class SettingsStepperRow extends StatelessWidget {
  const SettingsStepperRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.min = 1,
    this.max = 8,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      title: Text(title, style: AppType.on(AppType.body, pit.text)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: AppType.on(AppType.caption, pit.muted)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: AppIcons.remove,
            enabled: value > min,
            onTap: () => onChanged(value - 1),
          ),
          SizedBox(
            width: AppSpacing.xxxl,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: AppType.on(AppType.numeralSm, pit.text),
            ),
          ),
          _StepButton(
            icon: AppIcons.add,
            enabled: value < max,
            onTap: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

/// Botãozinho redondo do stepper; desabilitado fica esmaecido e inerte.
/// Usada por: [SettingsStepperRow].
class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? pit.border : pit.line2,
            width: AppSpacing.hair,
          ),
        ),
        child: Icon(icon, size: 15, color: enabled ? pit.text : pit.faint),
      ),
    );
  }
}

/// Linha de navegação/ação com chevron à direita.
/// Usada por: SettingsScreen (guia, exportar etc.).
class SettingsLinkRow extends StatelessWidget {
  const SettingsLinkRow({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      onTap: onTap,
      title: Text(title, style: AppType.on(AppType.body, pit.text)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: AppType.on(AppType.caption, pit.muted)),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.muted),
    );
  }
}
