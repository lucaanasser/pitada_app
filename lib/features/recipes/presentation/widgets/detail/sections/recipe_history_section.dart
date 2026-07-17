// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_history_section.dart
// O QUÊ:     Seção "Histórico" do detalhe: uma linha por versão (desc) com a
//            nota "o que mudou" do Caderno + link p/ o histórico completo.
//            Sem grupo de versões, mostra "V1 · sem histórico ainda".
// USA:       core (theme, SectionHeader), recipes_providers (grupo),
//            notebook/providers (versionForRecipeProvider — notas), go_router.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: historico)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/app_icons.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../../../core/widgets/layout/section_header.dart';
import '../../../../../notebook/application/providers.dart';
import '../../../../application/recipes_providers.dart';
import '../../../../data/models/recipe/recipe.dart';

/// Histórico da receita como seção de primeira classe: a versão é o ritual de
/// virar dono, então ela mora na página — não só atrás do tag "V3".
/// Usada por: RecipeDetailBody.
class RecipeHistorySection extends ConsumerWidget {
  const RecipeHistorySection({super.key, required this.recipe});

  final Recipe recipe;

  /// Monta as linhas de versão (desc) com a nota do Caderno. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final groupId = recipe.versionGroupId;
    final group = groupId == null
        ? const <Recipe>[]
        : ref.watch(recipeVersionGroupProvider(groupId)).valueOrNull ??
            const <Recipe>[];

    if (group.length < 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'Histórico'),
          Text(
            'V1 · sem histórico ainda. Cozinhe, ajuste e salve como nova '
            'versão — é assim que a receita vira sua.',
            style: AppType.on(AppType.tip, pit.faint),
          ),
        ],
      );
    }

    final definitivaId = group.last.id;
    final changelog =
        ref.watch(versionForRecipeProvider(definitivaId)).valueOrNull;
    String? noteFor(int version) {
      if (changelog == null) return null;
      for (final step in changelog.timeline) {
        if (step.label.toLowerCase() == 'v$version') return step.change;
      }
      return null;
    }

    final desc = group.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'Histórico'),
        for (var i = 0; i < desc.length; i++)
          _versionLine(
            pit,
            version: desc[i].version,
            isCurrent: desc[i].version == group.last.version,
            note: noteFor(desc[i].version),
            showDivider: i != desc.length - 1,
          ),
        if (changelog != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => context.push('/versions/${changelog.id}'),
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    AppIcons.history,
                    size: 17,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Ver histórico completo',
                    style: AppType.on(AppType.bodySm, AppColors.accent),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// Uma linha do histórico: "V{n}" + nota sóbria, com filete entre linhas.
  /// Usada por: [build].
  Widget _versionLine(
    PitadaColors pit, {
    required int version,
    required bool isCurrent,
    required String? note,
    required bool showDivider,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: pit.line, width: AppSpacing.hair),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 42,
            child: Text(
              'V$version',
              style: AppType.on(
                AppType.numeralSm,
                isCurrent ? AppColors.accent : pit.muted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              note ?? (isCurrent ? 'versão atual' : 'sem nota'),
              style: AppType.on(
                AppType.bodySm,
                note == null ? pit.faint : pit.text2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
