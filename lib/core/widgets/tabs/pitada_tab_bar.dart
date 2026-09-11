// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/pitada_tab_bar.dart
// O QUÊ:     Dock das abas: só os ícones ancorados no rodapé, sem faixa nem
//            filete — o fundo é o próprio pastel da aba, então a barra não rouba
//            área da tela. O único ponto de cor é o ícone ativo em accent. Flat.
// USA:       core/theme (AppColors, PitadaColors via context.pit, spacing).
// USADO POR: core/router/app_shell.dart.
// SPEC:      specs/components/tabs/pitada_tab_bar.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Descreve uma aba: [icon] (inativo) + [activeIcon] (preenchido, ativo) + rótulo.
/// Usada por: app_shell.dart (lista das 5 abas).
class PitadaTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const PitadaTab(this.icon, this.activeIcon, this.label);
}

/// Barra ancorada minimalista: destaca [currentIndex] só pela cor accent do
/// ícone preenchido e chama [onSelect]. Sem rótulos visíveis — Semantics
/// preserva a acessibilidade. Usada por: app_shell.dart.
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
    return SafeArea(
      top: false,
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(child: _item(pit, tabs[i], i, i == currentIndex)),
        ],
      ),
    );
  }

  /// Um item: só o ícone, centralizado numa célula de largura igual cuja altura
  /// vem do padding vertical (barra enxuta, discreta) e que é toda a área de
  /// toque. Ativo = ícone preenchido em accent; inativo = regular em muted. A
  /// troca faz crossfade (cor "acende" suave em vez de pular). Usada por: [build].
  Widget _item(PitadaColors pit, PitadaTab tab, int index, bool active) {
    return GestureDetector(
      onTap: () => onSelect(index),
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        selected: active,
        label: tab.label,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: Icon(
              active ? tab.activeIcon : tab.icon,
              key: ValueKey(active),
              size: 22,
              color: active ? AppColors.accent : pit.muted,
            ),
          ),
        ),
      ),
    );
  }
}
