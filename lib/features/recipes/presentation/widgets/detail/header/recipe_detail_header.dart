// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/header/recipe_detail_header.dart
// O QUÊ:     Cabeçalho de identidade da receita: voltar + rótulo do framework
//            (clicável, accent) ou "RECEITA" (muted, inerte) + lápis (editor).
// USA:       core/theme (AppIcons, AppColors, PitadaColors), framework_providers,
//            go_router.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: cabecalho_identidade)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/app_icons.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../application/framework_providers.dart';

/// Linha do topo do detalhe: a receita se anuncia pelo framework de que ela é
/// instância (o conhecimento que transfere). Usada por: RecipeDetailBody.
class RecipeDetailHeader extends ConsumerWidget {
  const RecipeDetailHeader({super.key, required this.recipeId});

  final String recipeId;

  /// Monta voltar + rótulo (framework em accent ou RECEITA em muted) + lápis.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final frameworks = ref.watch(frameworksForRecipeProvider(recipeId));
    final framework = frameworks.isEmpty ? null : frameworks.first;
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: GestureDetector(
            onTap: framework == null
                ? null
                : () => context.push('/framework/${framework.id}'),
            behavior: HitTestBehavior.opaque,
            child: Text(
              (framework?.name ?? 'Receita').toUpperCase(),
              style: AppType.on(
                AppType.label,
                framework == null ? pit.muted : AppColors.accent,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => context.push('/recipe/$recipeId/edit'),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.edit, size: 20, color: pit.muted),
        ),
      ],
    );
  }
}
