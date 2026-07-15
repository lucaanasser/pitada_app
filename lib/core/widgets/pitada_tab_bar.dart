// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_tab_bar.dart
// O QUÊ:     "Pílula fantasma": dock flutuante minimalista, compacto e
//            centralizado, só ícones. Fundo surf + filete fino; o único ponto
//            de cor é o ícone ativo em accent — a barra não compete com o
//            conteúdo. Flat: sem sombra, sem degradê.
// USA:       core/theme (AppColors, PitadaColors via context.pit, spacing).
// USADO POR: core/router/app_shell.dart.
// SPEC:      specs/features/app_shell.yaml (tab_bar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';

/// Descreve uma aba: [icon] (inativo) + [activeIcon] (preenchido, ativo) + rótulo.
/// Usada por: app_shell.dart (lista das 5 abas).
class PitadaTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const PitadaTab(this.icon, this.activeIcon, this.label);
}

/// Pílula flutuante minimalista: destaca [currentIndex] só pela cor accent do
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
      // Respiro da pílula; embaixo, o inset de gesto vale quando for maior.
      minimum: const EdgeInsets.only(bottom: AppSpacing.md),
      // Row centralizador: tem altura intrínseca — nunca Center/alignment
      // direto no bottomNavigationBar, que recebem altura livre e esticariam
      // a barra pela tela inteira.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              color: pit.surf,
              borderRadius: AppSpacing.br(AppSpacing.radiusPill),
              // Filete fino de propósito (pedido do dono): a pílula precisa
              // ser leve e não competir com o conteúdo da tela.
              border: Border.all(color: pit.line2, width: AppSpacing.hair),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < tabs.length; i++)
                  _item(pit, tabs[i], i, i == currentIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Um item: só o ícone, com padding generoso como área de toque. Ativo =
  /// ícone preenchido em accent; inativo = regular em muted. A troca faz
  /// crossfade (cor "acende" suave em vez de pular). Usada por: [build].
  Widget _item(PitadaColors pit, PitadaTab tab, int index, bool active) {
    return GestureDetector(
      onTap: () => onSelect(index),
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        selected: active,
        label: tab.label,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: Icon(
              active ? tab.activeIcon : tab.icon,
              // A key faz o Switcher tratar ativo/inativo como widgets
              // distintos e animar o fade entre eles.
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
