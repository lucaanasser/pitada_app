// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/versions_screen.dart
// O QUÊ:     Tela "Versões de receita": lista de receitas que têm histórico (RecipeVersion).
// USA:       learning_providers (versionsProvider), VersionRow, DetailHeader, core/widgets.
// USADO POR: core/router/router.dart (/learning/versions).
// SPEC:      specs/features/notebook.yaml (screens.VersionsScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../application/providers.dart';
import '../data/recipe_version.dart';
import 'widgets/detail_header.dart';
import 'widgets/version_row.dart';

/// Lista de receitas com versões. Usada por: router (/learning/versions).
class VersionsScreen extends ConsumerWidget {
  const VersionsScreen({super.key});

  /// Monta cabeçalho + lista de históricos de versão. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final async = ref.watch(versionsProvider);
    return PitadaScaffold(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const DetailHeader(
            kicker: 'Prática',
            title: 'Versões de receita',
            lead: 'Cada receita que você foi ajustando ao longo do tempo.',
          ),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxxl),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child:
                  Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
            ),
            data: (versions) => _list(context, versions),
          ),
        ],
      ),
    );
  }

  /// Renderiza a lista de históricos ou um estado vazio. Usada por: [build].
  Widget _list(BuildContext context, List<RecipeVersion> versions) {
    if (versions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Nenhuma versão ainda',
          message: 'Ajuste uma receita para começar um histórico.',
          icon: AppIcons.history,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Column(
        children: [
          for (var i = 0; i < versions.length; i++)
            VersionRow(
              version: versions[i],
              showDivider: i != versions.length - 1,
              onTap: () => context.push('/versions/${versions[i].id}'),
            ),
        ],
      ),
    );
  }
}
