// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/lesson/key_point.dart
// O QUÊ:     Item de lista numerada do Caderno: número em serifa (accent) + texto.
// USA:       theme/* (AppType.numeralSm, cores, espaços).
// USADO POR: LessonDetailScreen (pontos-chave de técnica, "cuidados" de guia).
// SPEC:      specs/features/notebook.yaml (LessonSection render: keys)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Um ponto-chave numerado: [number] em Cormorant/accent à esquerda, [text] ao lado.
/// Usada por: as seções "keys" das fichas (pontos-chave, cuidados).
class KeyPoint extends StatelessWidget {
  const KeyPoint({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
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
          Expanded(
              child: Text(text,
                  style: AppType.on(AppType.body, context.pit.text))),
        ],
      ),
    );
  }
}
