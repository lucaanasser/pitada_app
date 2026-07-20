// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/sheets/recipe_version_sheet.dart
// O QUÊ:     Bottom sheet "Versões" — lista as versões da receita (mais recente
//            primeiro) com a nota "o que mudou"; escolher troca a tela inteira.
// USA:       core/widgets (pitada_sheet, sheet_grip), widgets/detail/version_row
//            (linha do seletor), theme/*, recipe_providers (grupo + seleção),
//            notebook/providers (versionForRecipeProvider — notas),
//            notebook/recipe_version (modelo), go_router, app_log.
// USADO POR: recipe_detail_screen (tocar na RecipeVersionTag do título).
// SPEC:      specs/features/recipes.yaml (sheets.RecipeVersionSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../notebook/application/providers.dart';
import '../../../notebook/data/models/activity/recipe_version.dart';
import '../../application/recipe_providers.dart';
import '../widgets/detail/version_row.dart';

/// Abre o seletor de versões da receita. [definitivaId] busca a nota "o que mudou"
/// no Caderno (fonte única). Usada por: RecipeDetailScreen.
void showRecipeVersionSheet(
  BuildContext context, {
  required String groupId,
  required String definitivaId,
}) {
  showPitadaSheet<void>(
    context,
    builder: (_) => _RecipeVersionSheet(
      groupId: groupId,
      definitivaId: definitivaId,
      rootContext: context,
    ),
  );
}

/// Conteúdo do sheet: grip + "Versões" + uma linha por versão + link p/ histórico.
/// Usada por: [showRecipeVersionSheet].
class _RecipeVersionSheet extends ConsumerWidget {
  const _RecipeVersionSheet({
    required this.groupId,
    required this.definitivaId,
    required this.rootContext,
  });

  final String groupId;
  final String definitivaId;

  /// Contexto da TELA (fora do sheet) — sobrevive ao pop, usado no push do histórico.
  final BuildContext rootContext;

  /// Monta o conteúdo do sheet (versões desc + rodapé). Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final group =
        ref.watch(recipeVersionGroupProvider(groupId)).valueOrNull ?? [];
    final changelog =
        ref.watch(versionForRecipeProvider(definitivaId)).valueOrNull;
    if (group.isEmpty) return const SizedBox.shrink();

    final maxVersion = group.last.version;
    final selected =
        ref.watch(selectedRecipeVersionProvider(groupId)) ?? maxVersion;
    final desc = group.reversed.toList();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.md,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetGrip(),
            Text('Versões', style: AppType.on(AppType.title, pit.text)),
            const SizedBox(height: AppSpacing.md),
            for (final r in desc)
              VersionRow(
                version: r.version,
                isCurrent: r.version == maxVersion,
                isSelected: r.version == selected,
                note: _noteFor(changelog, r.version),
                onTap: () => _select(context, ref, r.version),
              ),
            if (changelog != null) ...[
              const SizedBox(height: AppSpacing.md),
              _HistoryLink(onTap: () => _openHistory(context, changelog.id)),
            ],
          ],
        ),
      ),
    );
  }

  /// Nota "o que mudou" da versão N, vinda do Caderno (label 'vN'). Usada por: [build].
  String? _noteFor(RecipeVersion? changelog, int version) {
    if (changelog == null) return null;
    for (final step in changelog.timeline) {
      if (step.label.toLowerCase() == 'v$version') return step.change;
    }
    return null;
  }

  /// Fixa a versão escolhida (troca a tela) e fecha o sheet. Usada por: linha.
  void _select(BuildContext context, WidgetRef ref, int version) {
    ref.read(selectedRecipeVersionProvider(groupId).notifier).state = version;
    AppLog.i('recipes', 'versão selecionada: $groupId v$version');
    Navigator.of(context).pop();
  }

  /// Fecha o sheet e abre a linha do tempo completa no Caderno. Usada por: rodapé.
  void _openHistory(BuildContext context, String versionId) {
    Navigator.of(context).pop();
    rootContext.push('/versions/$versionId');
  }
}

/// Rodapé "Ver histórico completo" → abre a linha do tempo no Caderno.
/// Usada por: [_RecipeVersionSheet].
class _HistoryLink extends StatelessWidget {
  const _HistoryLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              const Icon(AppIcons.history, size: 17, color: AppColors.accent),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Ver histórico completo',
                style: AppType.on(AppType.bodySm, AppColors.accent),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(AppIcons.chevron, size: 15, color: AppColors.accent),
            ],
          ),
        ),
      ),
    );
  }
}
