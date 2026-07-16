// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/cards/why_callout.dart
// O QUÊ:     Callout 'Por quê' de técnica dentro de um passo (borda-esquerda accent).
// USA:       theme/colors, theme/pitada_colors, theme/spacing, theme/typography.
// USADO POR: recipe_detail (passos) e cook_mode.
// SPEC:      specs/components/cards/why_callout.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Bloco de explicação de técnica: rótulo em versalete + texto em itálico.
/// Usada por: passos da receita que têm uma dica de técnica.
class WhyCallout extends StatelessWidget {
  const WhyCallout({super.key, required this.text, this.label = 'Por quê'});

  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md - 1),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md + 2,
        vertical: AppSpacing.md - 1,
      ),
      decoration: const BoxDecoration(
        color: AppColors.accentSoft,
        border: Border(
          left: BorderSide(
            color: AppColors.accentLine,
            width: AppSpacing.borderAccent,
          ),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSpacing.radiusMd),
          bottomRight: Radius.circular(AppSpacing.radiusMd),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppType.on(AppType.label, AppColors.accent)
                .copyWith(fontSize: 9.5),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(text, style: AppType.on(AppType.tip, pit.text2)),
        ],
      ),
    );
  }
}
