// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/cards/hairline_row.dart
// O QUÊ:     Linha de lista genérica separada por filete inferior (sem card).
// USA:       theme/colors, theme/spacing. É a base de quase toda lista do app.
// USADO POR: recipes, learning, shopping, plans, home (listas em geral).
// SPEC:      specs/components/hairline_row.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Linha de lista com [leading]/[title]/[subtitle]/[trailing] e filete embaixo.
/// [title] é obrigatório (Widget livre). Usada por: todas as listas do app.
class HairlineRow extends StatelessWidget {
  const HairlineRow({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
    this.gap = AppSpacing.lg,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget title;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;
  final double gap;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: pit.line, width: AppSpacing.hair),
                ),
              )
            : null,
        padding: padding,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (leading != null) ...[leading!, SizedBox(width: gap)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[SizedBox(width: gap), trailing!],
          ],
        ),
      ),
    );
  }
}
