// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_tab_bar.dart
// O QUÊ:     Barra inferior de navegação (.tabbar) — 5 abas com ícone + rótulo.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: core/router/app_shell.dart.
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Descreve uma aba da barra inferior (ícone + rótulo curto).
/// [raised] marca a aba central em destaque (.tb.home do protótipo): botão
/// circular elevado, sem rótulo.
class PitadaTab {
  final IconData icon;
  final String label;
  final bool raised;
  const PitadaTab(this.icon, this.label, {this.raised = false});
}

/// Barra inferior fixa: destaca [currentIndex] em terracota e chama [onSelect].
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
    // Altura mínima do protótipo (76), mas deixamos crescer com o inset inferior
    // (aparelhos com "home indicator") para nunca estourar o layout.
    return Container(
      constraints: const BoxConstraints(minHeight: AppSpacing.tabBar),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(
            top: BorderSide(color: AppColors.line, width: AppSpacing.hair)),
      ),
      padding: const EdgeInsets.only(
          top: 11, left: AppSpacing.sm, right: AppSpacing.sm),
      // clipBehavior none: o botão central elevado pode pintar acima da barra.
      clipBehavior: Clip.none,
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < tabs.length; i++)
              Expanded(
                child: tabs[i].raised
                    ? _raised(tabs[i], i == currentIndex, () => onSelect(i))
                    : _item(tabs[i], i == currentIndex, () => onSelect(i)),
              ),
          ],
        ),
      ),
    );
  }

  /// Botão central em destaque (.tb.home): círculo elevado, cor sólida, sem
  /// rótulo. Sem degradê/glow — respeita as proibições do design system.
  /// Usada por: [build] para a aba com `raised: true`.
  Widget _raised(PitadaTab tab, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Transform.translate(
        offset: const Offset(0, -18), // sobe acima da barra, como no protótipo
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          // Anel da cor do fundo separa o botão da barra (não é glow colorido).
          decoration: BoxDecoration(
            color: AppColors.bg,
            shape: BoxShape.circle,
            border: active
                ? Border.all(color: AppColors.accentLine, width: 2)
                : null,
          ),
          child: Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(tab.icon, size: 26, color: AppColors.onAccent),
          ),
        ),
      ),
    );
  }

  /// Um item da barra: ícone + rótulo, colorido conforme ativo. Usada por: [build].
  Widget _item(PitadaTab tab, bool active, VoidCallback onTap) {
    final color = active ? AppColors.accent : AppColors.faint;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tab.icon, size: 23, color: color),
          const SizedBox(height: 6),
          Text(tab.label, style: AppType.on(AppType.captionSm, color)),
        ],
      ),
    );
  }
}
