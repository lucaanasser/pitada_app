// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/section_editor.dart
// O QUÊ:     Editor de uma seção da ficha (rótulo + conteúdo) e o campo de texto
//            padronizado do formulário de edição.
// USA:       theme/*, core/widgets (SectionHeader não; usa filete próprio).
// USADO POR: LessonEditScreen.
// SPEC:      specs/features/learning.yaml (LessonEditScreen "editor de Seções")
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Campo de texto padronizado do editor: rótulo em versalete + caixa com filete.
/// [maxLines] > 1 vira textarea. Usada por: LessonEditScreen e [SectionEditor].
class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;

  /// Renderiza rótulo + caixa de entrada. Usada por: o formulário de edição.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppType.label),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md - 1,
          ),
          decoration: BoxDecoration(
            color: AppColors.surf,
            borderRadius: AppSpacing.br(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.line2, width: AppSpacing.hair),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: AppType.body,
            cursorColor: AppColors.accent,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle: AppType.on(AppType.body, AppColors.faint),
            ),
          ),
        ),
      ],
    );
  }
}

/// Editor de uma seção: campo de rótulo + textarea de conteúdo + botão remover.
/// Usada por: LessonEditScreen (lista de seções editáveis).
class SectionEditor extends StatelessWidget {
  const SectionEditor({
    super.key,
    required this.labelController,
    required this.bodyController,
    required this.onRemove,
  });

  final TextEditingController labelController;
  final TextEditingController bodyController;
  final VoidCallback onRemove;

  /// Renderiza os dois campos e a ação de remover. Usada por: LessonEditScreen.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditField(
            label: 'Rótulo da seção',
            controller: labelController,
            hint: 'Ex.: Os pontos-chave',
          ),
          const SizedBox(height: AppSpacing.md),
          EditField(
            label: 'Conteúdo',
            controller: bodyController,
            hint: 'Uma linha por item',
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  AppIcons.removeCircle,
                  size: 15,
                  color: AppColors.muted,
                ),
                const SizedBox(width: AppSpacing.xs + 2),
                Text(
                  'Remover seção',
                  style: AppType.on(AppType.caption, AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
