// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/framework/framework_detail_screen.dart
// O QUÊ:     Detalhe de um framework: nome, esqueleto (planta baixa), técnicas
//            como atributo sóbrio e as receitas instância (ponte de volta).
// USA:       framework_providers, recipe_list_providers (maestria/memória),
//            recipes_providers, framework_skeleton_view, RecipeRow, theme/*.
// USADO POR: core/router (/framework/:id).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../application/framework_providers.dart';
import '../../../application/recipe_list_providers.dart';
import '../../../application/recipes_providers.dart';
import '../../../data/models/recipe/recipe.dart';
import '../../widgets/framework/framework_skeleton_view.dart';
import '../../widgets/list/recipe_row.dart';

/// Tela de detalhe de um framework. Usada por: router (/framework/:id).
class FrameworkDetailScreen extends ConsumerWidget {
  const FrameworkDetailScreen({super.key, required this.frameworkId});

  final String frameworkId;

  /// Observa o framework e monta a planta baixa + instâncias. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final framework = ref.watch(frameworkByIdProvider(frameworkId)).valueOrNull;
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];

    if (framework == null) {
      return Scaffold(
        backgroundColor: pit.bg,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    final instances = [
      for (final r in recipes)
        if (framework.recipeIds.contains(r.id)) r,
    ];

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            _top(context, pit),
            const SizedBox(height: AppSpacing.lg),
            Text(
              framework.name,
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
            if (framework.techniques.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  'técnicas: ${framework.techniques.join(' · ').toLowerCase()}',
                  style: AppType.on(AppType.caption, pit.muted),
                ),
              ),
            const SectionHeader(label: 'Esqueleto', topGap: AppSpacing.xl),
            const SizedBox(height: AppSpacing.sm),
            FrameworkSkeletonView(framework: framework),
            if (instances.isNotEmpty) ...[
              const SectionHeader(
                label: 'Receitas que saem daqui',
                topGap: AppSpacing.xl,
              ),
              for (var i = 0; i < instances.length; i++)
                RecipeRow(
                  recipe: instances[i],
                  mastery: ref.watch(recipeMasteryProvider(instances[i].id)),
                  showDivider: i != instances.length - 1,
                  onTap: () => context.push('/recipe/${instances[i].id}'),
                ),
            ],
          ],
        ),
      ),
    );
  }

  /// Linha do topo: voltar + rótulo FRAMEWORK. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Text('FRAMEWORK', style: AppType.on(AppType.label, AppColors.accent)),
      ],
    );
  }
}
