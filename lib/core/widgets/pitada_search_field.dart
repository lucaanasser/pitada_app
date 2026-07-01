// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_search_field.dart
// O QUÊ:     Campo de busca padrão (.search) — lupa + texto sobre superfície.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: recipes_screen (buscar receita/ingrediente).
// SPEC:      specs/components/atoms.yaml (PitadaSearchField)
// ─────────────────────────────────────────────────────────────────────────────
import '../theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Campo de busca com aparência do protótipo. Chama [onChanged] a cada tecla.
/// Usada por: recipes_screen.
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
    return Container(
      height: AppSpacing.searchBar,
      decoration: BoxDecoration(
        color: AppColors.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          const Icon(AppIcons.search, size: 18, color: AppColors.muted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppType.body,
              cursorColor: AppColors.accent,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppType.on(AppType.body, AppColors.faint),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
