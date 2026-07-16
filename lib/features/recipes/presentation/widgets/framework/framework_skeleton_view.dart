// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_skeleton_view.dart
// O QUÊ:     O esqueleto de um framework: passos genéricos numerados (sem
//            quantidades), os slots como lacunas e as regras aprendidas.
// USA:       core/theme, framework_slot_pill, Framework.
// USADO POR: framework_detail_screen.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/framework.dart';
import 'framework_slot_pill.dart';

/// Esqueleto + slots + regras de um framework, em forma de planta baixa.
/// Usada por: FrameworkDetailScreen.
class FrameworkSkeletonView extends StatelessWidget {
  const FrameworkSkeletonView({super.key, required this.framework});

  final Framework framework;

  /// Monta os passos numerados, as lacunas e as regras. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < framework.skeleton.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: Text(
                    '${i + 1}',
                    style: AppType.on(AppType.numeralSm, AppColors.accent),
                  ),
                ),
                Expanded(
                  child: Text(
                    framework.skeleton[i],
                    style: AppType.on(AppType.body, pit.text),
                  ),
                ),
              ],
            ),
          ),
        if (framework.slots.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text('O QUE VARIA', style: AppType.on(AppType.label, pit.muted)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final s in framework.slots) FrameworkSlotPill(label: s),
            ],
          ),
        ],
        if (framework.rules.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Text('REGRAS', style: AppType.on(AppType.label, pit.muted)),
          const SizedBox(height: AppSpacing.sm),
          for (final rule in framework.rules)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('—  ', style: AppType.on(AppType.body, pit.muted)),
                  Expanded(
                    child: Text(rule, style: AppType.on(AppType.body, pit.text2)),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}
