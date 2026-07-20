// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/shared/edit_header_bar.dart
// O QUÊ:     Cabeçalho fixo de formulário do Caderno: Cancelar / título /
//            Salvar, com hairline inferior.
// USA:       theme/* (cores, tipografia, espaçamento), go_router (Cancelar).
// USADO POR: LessonEditScreen.
// SPEC:      specs/features/notebook.yaml (widgets.shared — EditHeaderBar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Cabeçalho de edição: "Cancelar" fecha a tela (pop), [title] ao centro e
/// "Salvar" chama [onSave]. Usada por: LessonEditScreen.
class EditHeaderBar extends StatelessWidget {
  const EditHeaderBar({super.key, required this.title, required this.onSave});

  final String title;
  final VoidCallback onSave;

  /// Monta a linha Cancelar / título / Salvar. Usada por: LessonEditScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: pit.line, width: AppSpacing.hair),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              'Cancelar',
              style: AppType.on(AppType.button, pit.muted),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppType.on(AppType.title, pit.text),
            ),
          ),
          GestureDetector(
            onTap: onSave,
            child: Text(
              'Salvar',
              style: AppType.on(AppType.button, AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}
