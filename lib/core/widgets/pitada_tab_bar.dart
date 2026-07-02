// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_tab_bar.dart
// O QUÊ:     Barra inferior ancorada "pílula de tinta": item ativo ganha cápsula
//            pastel da própria aba (pit.tabBg) com borda tinta — legenda cromática.
//            Todos os itens mantêm ícone + rótulo. Flat, sem sombra.
// USA:       core/theme (PitadaColors via context.pit), spacing, typography.
// USADO POR: core/router/app_shell.dart.
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Descreve uma aba: [icon] (inativo) + [activeIcon] (preenchido, ativo) + rótulo.
/// Usada por: app_shell.dart (lista das 5 abas).
class PitadaTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const PitadaTab(this.icon, this.activeIcon, this.label);
}

/// Barra inferior ancorada: destaca [currentIndex] com cápsula pastel da aba
/// (pit.tabBg) e chama [onSelect]. Usada por: app_shell.dart (shell das 5 abas).
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
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: _item(
                    pit,
                    tabs[i],
                    i,
                    i == currentIndex,
                    () => onSelect(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Um item: cápsula pastel animada em volta do ícone (ativa) + rótulo sempre
  /// visível. Usada por: [build].
  Widget _item(
    PitadaColors pit,
    PitadaTab tab,
    int index,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cápsula do ícone: pastel da própria aba quando ativa. A borda existe
          // sempre (transparente inativa) para o layout não pular.
          AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xs + 1,
            ),
            decoration: BoxDecoration(
              borderRadius: AppSpacing.br(AppSpacing.radiusPill),
              color: active ? pit.tabBg(index) : Colors.transparent,
              // Anel de tinta no claro; no escuro a tinta some no fundo,
              // então o anel vira accent (regra dos elementos de tinta).
              border: Border.all(
                width: AppSpacing.borderStrong,
                color: !active
                    ? Colors.transparent
                    : (pit.isDark ? AppColors.accent : pit.border),
              ),
            ),
            child: Icon(
              active ? tab.activeIcon : tab.icon,
              size: 22,
              color: active ? pit.text : pit.muted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tab.label,
            style: active
                ? AppType.on(AppType.captionSm, pit.text)
                    .copyWith(fontWeight: FontWeight.w600)
                : AppType.on(AppType.captionSm, pit.faint),
          ),
        ],
      ),
    );
  }
}
