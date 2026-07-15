// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/edit_step_row.dart
// O QUÊ:     Passo editável: número em serifa + textarea multilinha + remover.
// USA:       theme/*, RecipeStep (modelo). Preserva a dica 'Por quê' existente.
// USADO POR: recipe_edit_screen e import_preview (editor de passos).
// SPEC:      specs/features/recipes.yaml (EditStepEditor)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/recipe_step.dart';

/// Linha de edição de um passo. Notifica [onChanged] a cada tecla (mantendo a
/// [tip] original) e [onRemove] na lixeira. Usada por: editores de passos.
class EditStepRow extends StatefulWidget {
  const EditStepRow({
    super.key,
    required this.number,
    required this.step,
    required this.onChanged,
    required this.onRemove,
  });

  final int number;
  final RecipeStep step;
  final ValueChanged<RecipeStep> onChanged;
  final VoidCallback onRemove;

  @override
  State<EditStepRow> createState() => _EditStepRowState();
}

class _EditStepRowState extends State<EditStepRow> {
  late final TextEditingController _text;

  /// Cria o controller a partir do texto inicial do passo. Usada por: framework.
  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: widget.step.text);
  }

  /// Libera o controller. Usada por: framework.
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  /// Monta número + textarea + botão remover. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md - 2),
              child: Text('${widget.number}', style: AppType.numeralLg),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: pit.surf2,
                borderRadius: AppSpacing.br(AppSpacing.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md - 2,
              ),
              child: TextField(
                controller: _text,
                onChanged: (v) =>
                    widget.onChanged(RecipeStep(text: v, tip: widget.step.tip)),
                maxLines: null,
                minLines: 2,
                style: AppType.on(AppType.body, pit.text2),
                cursorColor: AppColors.accent,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: 'Descreva o passo',
                  hintStyle: AppType.on(AppType.body, pit.faint),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onRemove,
            icon: Icon(AppIcons.close, size: 18, color: pit.faint),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}
