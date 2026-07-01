// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/version_history_screen.dart
// O QUÊ:     Detalhe do histórico: título (receita) + link p/ receita + linha do tempo.
// USA:       learning_providers (versionByIdProvider), DetailHeader, RecipeLinkRow,
//            VersionStepTile, SectionHeader, core/widgets, theme/*.
// USADO POR: core/router/router.dart (/versions/:id).
// SPEC:      specs/features/learning.yaml (screens.VersionHistoryScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/section_header.dart';
import '../application/learning_providers.dart';
import '../data/recipe_version.dart';
import 'widgets/detail_header.dart';
import 'widgets/recipe_link_row.dart';
import 'widgets/version_step_tile.dart';

/// Tela do histórico de versões de uma receita. Usada por: router (/versions/:id).
class VersionHistoryScreen extends ConsumerWidget {
  const VersionHistoryScreen({super.key, required this.versionId});

  final String versionId;

  /// Resolve o histórico por id e renderiza o corpo (ou estado de erro). Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(versionByIdProvider(versionId));
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        bottom: false,
        child: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(child: Text('Erro: $e', style: AppType.body)),
          data: (version) => version == null
              ? const Center(
                  child: Text('Histórico não encontrado', style: AppType.body))
              : _content(version),
        ),
      ),
    );
  }

  /// Monta a lista rolável: cabeçalho, link da receita e linha do tempo. Usada por: [build].
  Widget _content(RecipeVersion version) {
    final steps = version.timeline;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        DetailHeader(kicker: 'Versões', title: version.recipeName),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              RecipeLinkRow(recipeId: version.recipeId, showDivider: false),
              if (steps.isNotEmpty) ...[
                const SectionHeader(label: 'Linha do tempo'),
                for (var i = 0; i < steps.length; i++)
                  VersionStepTile(
                    step: steps[i],
                    definitive: i == steps.length - 1,
                    isLast: i == steps.length - 1,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
