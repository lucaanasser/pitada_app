// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_question_view.dart
// O QUÊ:     Uma pergunta do fluxo guiado de criação de framework: contexto das
//            receitas olhadas, pergunta, ajuda e o campo de resposta.
// USA:       core/theme, core/widgets (EditTextField), Recipe.
// USADO POR: framework_create_screen.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/edit_field.dart';
import '../../../data/models/recipe.dart';

/// Bloco de UMA pergunta socrática: quem responde escreve; a resposta vira o
/// esqueleto do framework. Usada por: FrameworkCreateScreen.
class FrameworkQuestionView extends StatelessWidget {
  const FrameworkQuestionView({
    super.key,
    required this.question,
    required this.helper,
    required this.controller,
    required this.hint,
    this.linked = const [],
    this.singleLine = false,
  });

  final String question;
  final String helper;
  final TextEditingController controller;
  final String hint;
  final List<Recipe> linked;
  final bool singleLine;

  /// Monta contexto + pergunta + ajuda + campo. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (linked.isNotEmpty) ...[
            Text(
              'Olhando para: ${[for (final r in linked) r.title].join(' · ')}',
              style: AppType.on(AppType.caption, AppColors.accent),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Text(question, style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.sm),
          Text(helper, style: AppType.on(AppType.bodySm, pit.muted)),
          const SizedBox(height: AppSpacing.xl),
          EditTextField(
            label: '',
            controller: controller,
            hint: hint,
            maxLines: singleLine ? 1 : null,
            minLines: singleLine ? 1 : 3,
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
