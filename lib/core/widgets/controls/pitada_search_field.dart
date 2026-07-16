// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/controls/pitada_search_field.dart
// O QUÊ:     Campo de busca padrão (.search) — lupa + texto sobre superfície.
// USA:       theme/colors, theme/pitada_colors, theme/spacing, theme/typography, theme/app_icons.
// USADO POR: recipes_screen, food_search_sheet (planos), import_source_grid (receitas).
// SPEC:      specs/components/controls/pitada_search_field.yaml
// ─────────────────────────────────────────────────────────────────────────────
import '../../theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Campo de busca com aparência do protótipo. Chama [onChanged] a cada tecla.
/// Usada por: recipes_screen, food_search_sheet, import_source_grid.
class PitadaSearchField extends StatelessWidget {
  const PitadaSearchField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      height: AppSpacing.searchBar,
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Icon(AppIcons.search, size: 18, color: pit.muted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppType.on(AppType.body, pit.text),
              cursorColor: AppColors.accent,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hint,
                hintStyle: AppType.on(AppType.body, pit.faint),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
