// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder/folder_color_picker.dart
// O QUÊ:     Bolinhas com as 7 cores de card p/ escolher o hero de uma pasta; a
//            selecionada ganha um anel de tinta (soft neo-brutalismo, flat).
// USA:       core/theme (AppColors.cardLight keys, PitadaColors.card, AppSpacing).
// USADO POR: folder_edit_sheet (campo COR do editor de pasta).
// SPEC:      specs/features/recipes.yaml (aba_pastas.editor_de_pasta)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';

/// Seletor das cores de pasta (os heros de card): toca p/ escolher; a ativa fica
/// com anel de tinta. Usada por: FolderEditSheet.
class FolderColorPicker extends StatelessWidget {
  const FolderColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  /// Monta as bolinhas das cores disponíveis em Wrap. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        for (final hero in AppColors.cardLight.keys)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(hero),
            child: Container(
              width: AppSpacing.iconButton,
              height: AppSpacing.iconButton,
              decoration: BoxDecoration(
                color: pit.card(hero),
                shape: BoxShape.circle,
                border: Border.all(
                  color: hero == value ? pit.border : Colors.transparent,
                  width: AppSpacing.borderAccent,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
