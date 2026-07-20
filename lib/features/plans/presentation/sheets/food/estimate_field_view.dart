// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/food/estimate_field_view.dart
// O QUÊ:     Campo de texto padrão do sheet de estimativa (fundo surf2, borda
//            line2, foco accent). Variante numérica p/ ajustar kcal.
// USA:       theme/* (colors, pitada_colors, spacing, typography).
// USADO POR: EstimateInputView (linguagem natural) e EstimateResultView (kcal).
// SPEC:      specs/features/plans/progress.yaml (sheets: showEstimateFoodSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Campo de texto do sheet de estimativa. [numeric] restringe a dígitos e usa
/// AppType.numeral (ajuste de kcal). Usada por: EstimateInputView e
/// EstimateResultView.
class EstimateFieldView extends StatelessWidget {
  const EstimateFieldView({
    super.key,
    required this.controller,
    required this.hint,
    this.numeric = false,
    this.suffixText,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final bool numeric;
  final String? suffixText;
  final ValueChanged<String>? onSubmitted;

  /// Desenha o TextField com a decoração padrão do sheet. Usada por: os modos.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return TextField(
      controller: controller,
      autofocus: true,
      keyboardType: numeric ? TextInputType.number : null,
      inputFormatters:
          numeric ? [FilteringTextInputFormatter.digitsOnly] : null,
      textInputAction: numeric ? null : TextInputAction.done,
      onSubmitted: onSubmitted,
      style: AppType.on(numeric ? AppType.numeral : AppType.body, pit.text),
      cursorColor: AppColors.accent,
      decoration: _deco(pit),
    );
  }

  /// Decoração padrão (hint, fundo surf2, bordas line2/accent). Usada por: [build].
  InputDecoration _deco(PitadaColors pit) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppType.on(AppType.body, pit.faint),
      suffixText: suffixText,
      filled: true,
      fillColor: pit.surf2,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        borderSide: BorderSide(color: pit.line2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        borderSide: BorderSide(color: pit.line2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.accentLine),
      ),
    );
  }
}
