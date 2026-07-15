// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/note_take.dart
// O QUÊ:     Item numerado de "O que fica" (numeral em serifa + texto do aprendizado).
// USA:       theme/* (AppType.numeralSm, AppSpacing). Sem dependências externas.
// USADO POR: NoteDetailScreen (lista de takeaways).
// SPEC:      specs/features/learning.yaml (NoteDetailScreen: "O que fica" -> takes numeradas)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Um aprendizado numerado: [number] em serifa (accent) + [text] em corpo.
/// Usada por: NoteDetailScreen para renderizar cada takeaway.
class NoteTake extends StatelessWidget {
  const NoteTake({
    super.key,
    required this.number,
    required this.text,
    this.showDivider = true,
  });

  final int number;
  final String text;
  final bool showDivider;

  /// Monta a linha "N + texto" com filete inferior. Usada por: NoteDetailScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: pit.line,
                  width: AppSpacing.hair,
                ),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSpacing.xxl,
            child: Text(
              '$number',
              style: AppType.on(AppType.numeralSm, AppColors.accent),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
              child: Text(text, style: AppType.on(AppType.body, pit.text))),
        ],
      ),
    );
  }
}
