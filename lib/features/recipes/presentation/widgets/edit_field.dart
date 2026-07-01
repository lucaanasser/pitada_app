// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/edit_field.dart
// O QUÊ:     Linha de campo do editor (rótulo em versalete + conteúdo à direita):
//            texto, stepper numérico ou trailing livre, sobre superfície surf2.
// USA:       theme/*, core/widgets/pitada_button (PitadaIconButton) para o stepper.
// USADO POR: recipe_edit_screen, import_preview (campos nome/porções/tempo/pasta).
// SPEC:      specs/features/recipes.yaml (RecipeEditScreen: EditFieldRow)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/pitada_button.dart';

/// Campo de texto do editor: rótulo acima, TextField sobre surf2.
/// Usada por: recipe_edit_screen (Nome) e import_preview.
class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;

  /// Monta o rótulo + caixa de texto. Usada por: [EditFieldShell.build].
  @override
  Widget build(BuildContext context) {
    return EditFieldShell(
      label: label,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: AppType.body,
        cursorColor: AppColors.accent,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppType.on(AppType.body, AppColors.faint),
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
              style: AppType.numeral,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AppType.label),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surf2,
              borderRadius: AppSpacing.br(AppSpacing.radiusMd),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
