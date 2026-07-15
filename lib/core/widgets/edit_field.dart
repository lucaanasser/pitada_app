// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/edit_field.dart
// O QUÊ:     Família de campos de formulário (rótulo em versalete + conteúdo
//            sobre surf2): texto, stepper numérico ou trailing livre.
// USA:       theme/*, pitada_button (PitadaIconButton) para o stepper.
// USADO POR: recipe_edit_screen, import_preview, quick_edit_sheet (Receitas) e
//            sign_in_screen (Auth). Promovido de features/recipes p/ reuso.
// SPEC:      specs/components/edit_field.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import 'pitada_button.dart';

/// Campo de texto do editor: rótulo acima, TextField sobre surf2. [maxLines] nulo
/// (com [minLines]) vira textarea. [style] troca o AppType do texto digitado
/// (ex.: AppType.numeral no código OTP) — a cor segue vindo de pit.text.
/// Usada por: recipe_edit_screen, import_preview, QuickEditSheet, SignInScreen.
class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.style,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextStyle? style;

  /// Monta o rótulo + caixa de texto. Usada por: [EditFieldShell.build].
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return EditFieldShell(
      label: label,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        autofocus: autofocus,
        style: AppType.on(style ?? AppType.body, pit.text),
        cursorColor: AppColors.accent,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppType.on(AppType.body, pit.faint),
        ),
      ),
    );
  }
}

/// Campo numérico com stepper − N + (porções, tempo). O número usa AppType.numeral.
/// Usada por: recipe_edit_screen (Porções, Tempo) e import_preview.
class EditStepperField extends StatelessWidget {
  const EditStepperField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.suffix,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final String? suffix;

  /// Monta o rótulo + botões de − / + em torno do número. Usada por: [build] das telas.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return EditFieldShell(
      label: label,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PitadaIconButton(
            icon: AppIcons.remove,
            size: AppSpacing.iconButton - 6,
            onPressed: value > min ? () => onChanged(value - 1) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              suffix == null ? '$value' : '$value $suffix',
              style: AppType.on(AppType.numeral, pit.text),
            ),
          ),
          PitadaIconButton(
            icon: AppIcons.add,
            size: AppSpacing.iconButton - 6,
            onPressed: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

/// Casca visual comum dos campos: rótulo em versalete acima do [child] sobre surf2.
/// Usada por: EditTextField, EditStepperField e o campo de pasta (trailing livre).
class EditFieldShell extends StatelessWidget {
  const EditFieldShell({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  /// Desenha o container arredondado com rótulo + conteúdo. Usada por: campos do editor.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppType.on(AppType.label, pit.muted),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: pit.surf2,
              borderRadius: AppSpacing.br(AppSpacing.radiusMd),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
