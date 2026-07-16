// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/layout/section_header.dart
// O QUÊ:     Rótulo de seção em versalete + filete fino (.shead), com ação opcional.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: recipe_detail, learning, shopping, plans — em toda seção de conteúdo.
// SPEC:      specs/components/section_header.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Cabeçalho de seção: [label] em versalete + filete que preenche a largura,
/// com [action] opcional à direita. Usada por: telas de detalhe e listas.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    this.action,
    this.onAction,
    this.topGap = AppSpacing.xxxl,
  });

  final String label;
  final String? action;
  final VoidCallback? onAction;
  final double topGap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topGap, bottom: AppSpacing.md),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: AppType.on(AppType.label, context.pit.muted),
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(child: Divider(height: AppSpacing.hair)),
          if (action != null) ...[
            const SizedBox(width: AppSpacing.md),
            GestureDetector(
              onTap: onAction,
              child: Text(
                action!,
                style: AppType.on(AppType.caption, AppColors.accent),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
