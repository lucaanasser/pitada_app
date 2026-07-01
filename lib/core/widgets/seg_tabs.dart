// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/seg_tabs.dart
// O QUÊ:     Abas simples em Inter (.seg) com filete de base e sublinhado accent.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: learning_screen (categorias), shopping_screen (Lista/Despensa).
// SPEC:      specs/components/seg_tabs.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Abas de texto (não serifa) com filete de base contínuo. Ativo sublinhado accent.
/// Usada por: learning_screen e shopping_screen.
class SegTabs extends StatelessWidget {
  const SegTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelect,
    this.scrollable = false,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelect;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: scrollable ? MainAxisSize.min : MainAxisSize.max,
      children: [
        for (var i = 0; i < tabs.length; i++)
          Padding(
            padding: EdgeInsets.only(
              right: i == tabs.length - 1 ? 0 : AppSpacing.xxl,
            ),
            child: _SegTab(
              label: tabs[i],
              active: i == selected,
              onTap: () => onSelect(i),
            ),
          ),
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.line, width: AppSpacing.hair),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: scrollable
          ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: row)
          : row,
    );
  }
}

/// Uma aba de texto com sublinhado accent quando ativa. Usada por: [SegTabs].
class _SegTab extends StatelessWidget {
  const _SegTab({
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // IntrinsicWidth deixa a coluna do tamanho do texto; assim o sublinhado
    // (stretch) fica da largura da palavra — sem largura infinita (que quebrava
    // o hit test dentro de contexto de largura ilimitada).
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppType.on(
                  AppType.body,
                  active ? AppColors.text : AppColors.muted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                height: AppSpacing.borderAccent,
                color: active ? AppColors.accent : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
