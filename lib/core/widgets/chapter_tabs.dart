// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/chapter_tabs.dart
// O QUÊ:     Abas de capítulo em serifa, roláveis, com filete terracota no ativo.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: recipes_screen (pastas: Todas, Marinadas, Jantares...).
// SPEC:      specs/components/chapter_tabs.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Abas de capítulo (Cormorant). [selected] fica realçado com filete accent.
/// Usada por: recipes_screen para filtrar por pasta.
class ChapterTabs extends StatelessWidget {
  const ChapterTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelect,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xs,
        AppSpacing.gutter,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Padding(
              padding: EdgeInsets.only(
                  right: i == tabs.length - 1 ? 0 : AppSpacing.xxl),
              child: _Tab(
                label: tabs[i],
                active: i == selected,
                onTap: () => onSelect(i),
              ),
            ),
        ],
      ),
    );
  }
}

/// Uma aba de capítulo com filete inferior quando ativa. Usada por: [ChapterTabs].
class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppType.on(
              AppType.titleSm,
              active ? AppColors.text : AppColors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: AppSpacing.borderAccent,
            width: 26,
            decoration: BoxDecoration(
              color: active ? AppColors.accent : Colors.transparent,
              borderRadius: AppSpacing.br(AppSpacing.borderAccent),
            ),
          ),
        ],
      ),
    );
  }
}
