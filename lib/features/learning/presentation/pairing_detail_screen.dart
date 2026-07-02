// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/pairing_detail_screen.dart
// O QUÊ:     Detalhe de uma harmonização: ingrediente, legenda de níveis, nuvem de
//            combinações coloridas por nível e "Aplica em" (receita ligada).
// USA:       learning_providers, core/widgets, widgets locais, go_router, theme/*.
// USADO POR: core/router (/pairing/:id).
// SPEC:      specs/features/learning.yaml (screens.PairingDetailScreen — view-harm-item)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/section_header.dart';
import '../application/learning_providers.dart';
import '../data/repertoire.dart';
import 'widgets/detail_header.dart';
import 'widgets/pairing_legend.dart';

/// Tela de detalhe de uma harmonização. Usada por: router (/pairing/:id).
class PairingDetailScreen extends ConsumerWidget {
  const PairingDetailScreen({super.key, required this.pairingId});

  final String pairingId;

  /// Carrega a harmonização por id e delega a montagem do corpo. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pairingByIdProvider(pairingId));
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        bottom: false,
        child: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(child: Text('Erro: $e', style: AppType.body)),
          data: (pairing) => pairing == null
              ? const Center(
                  child:
                      Text('Harmonização não encontrada', style: AppType.body),
                )
              : _content(context, pairing),
        ),
      ),
    );
  }

  /// Monta cabeçalho, legenda, nuvem de combinações e "Aplica em". Usada por: [build].
  Widget _content(BuildContext context, Pairing pairing) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        DetailHeader(kicker: 'Harmonização', title: pairing.ingredient),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const PairingLegend(),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                spacing: AppSpacing.sm + 1,
                runSpacing: AppSpacing.sm + 1,
                children: [
                  for (final item in pairing.items) _PairChip(item: item),
                ],
              ),
              if (pairing.recipeIds.isNotEmpty) ...[
                const SectionHeader(label: 'Aplica em'),
                _applies(context, pairing),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Link para uma receita que usa a harmonização. Usada por: [_content].
  Widget _applies(BuildContext context, Pairing pairing) {
    return GestureDetector(
      onTap: () => context.push('/recipe/${pairing.recipeIds.first}'),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          const Icon(AppIcons.dish, size: 16, color: AppColors.accent),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Uma receita com ${pairing.ingredient.toLowerCase()}',
              style: AppType.on(AppType.body, AppColors.accent),
            ),
          ),
          const Icon(AppIcons.chevron, size: 16, color: AppColors.faint),
        ],
      ),
    );
  }
}

/// Chip de combinação: ponto + nome, contorno na cor do nível. Usada por: [PairingDetailScreen].
class _PairChip extends StatelessWidget {
  const _PairChip({required this.item});

  final PairingItem item;

  @override
  Widget build(BuildContext context) {
    final color = pairingColor(item.rating);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpacing.sm - 1,
            height: AppSpacing.sm - 1,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppSpacing.br(AppSpacing.radiusPill),
            ),
          ),
          const SizedBox(width: AppSpacing.sm - 2),
          Text(item.name, style: AppType.on(AppType.bodySm, AppColors.text2)),
        ],
      ),
    );
  }
}
