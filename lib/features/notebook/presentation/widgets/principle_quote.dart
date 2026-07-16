// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/principle_quote.dart
// O QUÊ:     Princípio de uma técnica: citação (AppType.quote) com filete accent
//            à esquerda — o "por que" central da ficha.
// USA:       theme/* (cores, espaços, AppType.quote).
// USADO POR: LessonDetailScreen (cabeçalho das técnicas).
// SPEC:      specs/features/notebook.yaml (LessonDetailScreen.technique -> quote)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Citação de princípio com barra accent à esquerda. Usada por: técnicas (detalhe).
class PrincipleQuote extends StatelessWidget {
  const PrincipleQuote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: AppSpacing.lg),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.accent,
            width: AppSpacing.borderAccent,
          ),
        ),
      ),
      child: Text(text, style: AppType.on(AppType.quote, context.pit.text)),
    );
  }
}
