// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_tab_bar.dart
// O QUÊ:     Barra inferior ancorada (largura total, rente à base) com borda grossa
//            no topo. Item ativo em accent com ícone preenchido. Flat, sem sombra.
// USA:       core/theme (AppColors accent, PitadaColors via context.pit), spacing, typography.
// USADO POR: core/router/app_shell.dart.
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Descreve uma aba: [icon] (inativo) + [activeIcon] (preenchido, ativo) + rótulo.
class PitadaTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const PitadaTab(this.icon, this.activeIcon, this.label);
}

/// Barra inferior ancorada: destaca [currentIndex] em accent e chama [onSelect].
/// Usada por: app_shell.dart (shell das 5 abas).
class PitadaTabBar extends StatelessWidget {
  const PitadaTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onSelect,
  });

  final List<PitadaTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      decoration: BoxDecoration(
        color: pit.surf,
        border: Border(
          top: BorderSide(color: pit.border, width: AppSpacing.borderStrong),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: AppSpacing.sm + 2),
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: _item(pit, tabs[i], i == currentIndex,
                      () => onSelect(i)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Um item: ícone (preenchido se ativo) + rótulo, colorido conforme ativo.
  /// Usada por: [build].
  Widget _item(
      PitadaColors pit, PitadaTab tab, bool active, VoidCallback onTap) {
    final color = active ? AppColors.accent : pit.muted;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(active ? tab.activeIcon : tab.icon, size: 24, color: color),
          const SizedBox(height: 5),
          Text(
            tab.label,
            style: AppType.on(AppType.captionSm, active ? AppColors.accent : pit.faint),
          ),
        ],
      ),
    );
  }
}
