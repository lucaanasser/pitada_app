// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_card.dart
// O QUÊ:     Card "planta baixa" de um framework: sem foto — nome, slots como
//            lacunas visíveis e a contagem de passos/receitas. Cara de diagrama,
//            não de prato: é estrutura, não comida.
// USA:       core/theme (AppIcons, AppColors, PitadaColors, AppSpacing, AppType),
//            framework_slot_pill, Framework.
// USADO POR: frameworks_tab_view.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/framework.dart';
import 'framework_slot_pill.dart';

/// Um framework como card de planta baixa. Usada por: FrameworksTabView.
class FrameworkCard extends StatelessWidget {
  const FrameworkCard({super.key, required this.framework, this.onTap});

  final Framework framework;
  final VoidCallback? onTap;

  /// Monta o card (kicker + nome + slots + contagens). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final steps = framework.skeleton.length;
    final uses = framework.recipeIds.length;
    final meta = [
      '$steps ${steps == 1 ? 'passo' : 'passos'}',
      '$uses ${uses == 1 ? 'receita' : 'receitas'}',
    ].join('  ·  ');
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: pit.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusCard),
          border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'FRAMEWORK',
                    style: AppType.on(AppType.label, AppColors.accent),
                  ),
                ),
                Icon(AppIcons.framework, size: 18, color: pit.muted),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              framework.name,
              style: AppType.on(AppType.title, pit.text),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (framework.slots.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final s in framework.slots) FrameworkSlotPill(label: s),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Text(meta, style: AppType.on(AppType.caption, pit.text2)),
          ],
        ),
      ),
    );
  }
}
