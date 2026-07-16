// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/version_step_tile.dart
// O QUÊ:     Nó da linha do tempo de versões (marcador + label vX + tag def. + mudança).
// USA:       core/widgets (PitadaChip), theme/*, VersionStep. Sem lógica externa.
// USADO POR: VersionHistoryScreen.
// SPEC:      specs/features/learning.yaml (VersionHistoryScreen: VersionStep v/tag/nota)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/pitada_chip.dart';
import '../../data/recipe_version.dart';

/// Um passo da linha do tempo: coluna com marcador + fio, e o texto da mudança.
/// [definitive] marca a versão final. Usada por: VersionHistoryScreen.
class VersionStepTile extends StatelessWidget {
  const VersionStepTile({
    super.key,
    required this.step,
    this.definitive = false,
    this.isLast = false,
  });

  final VersionStep step;
  final bool definitive;
  final bool isLast;

  /// Desenha o marcador, o fio vertical e o conteúdo do passo. Usada por: VersionHistory.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rail(pit),
          const SizedBox(width: AppSpacing.lg),
          Expanded(child: _body(pit)),
        ],
      ),
    );
  }

  /// Coluna do marcador (bolinha accent) e do fio até o próximo passo.
  /// Usada por: [build].
  Widget _rail(PitadaColors pit) {
    return Column(
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: definitive ? AppColors.accent : pit.surf,
            border: Border.all(
              color: AppColors.accent,
              width: AppSpacing.borderThick,
            ),
          ),
        ),
        if (!isLast)
          Expanded(
            child: VerticalDivider(width: AppSpacing.hair, color: pit.line2),
          ),
      ],
    );
  }

  /// Conteúdo do passo: label vX + tag "definitiva" opcional + texto da mudança.
  /// Usada por: [build].
  Widget _body(PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(step.label, style: AppType.on(AppType.numeralSm, pit.text)),
              if (definitive) ...[
                const SizedBox(width: AppSpacing.md),
                const PitadaChip(
                  label: 'Definitiva',
                  variant: PitadaChipVariant.accent,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(step.change, style: AppType.on(AppType.body, pit.text2)),
        ],
      ),
    );
  }
}
