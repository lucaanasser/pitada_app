// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/sub_recipe/sub_recipes_screen.dart
// O QUÊ:     Biblioteca de subreceitas: lista (nome + "em N receitas") que leva
//            ao detalhe. EmptyState didático quando vazia.
// USA:       sub_recipe_providers, core/widgets (HairlineRow, EmptyState),
//            core/theme, go_router.
// USADO POR: core/router (/sub-recipes) — via seletor "usar subreceita" e selos.
// SPEC:      specs/features/sub_recipes.yaml (ui.biblioteca)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../application/sub_recipe/sub_recipe_providers.dart';

/// Biblioteca de subreceitas compartilhadas. Usada por: router (/sub-recipes).
class SubRecipesScreen extends ConsumerWidget {
  const SubRecipesScreen({super.key});

  /// Observa a biblioteca + usos e monta a lista. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final subs = ref.watch(subRecipesProvider).valueOrNull ?? const [];
    final usage =
        ref.watch(subRecipeUsageProvider).valueOrNull ?? const <String, int>{};

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
            Text('Subreceitas', style: AppType.on(AppType.screenTitle, pit.text)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Blocos reutilizáveis: uma edição muda todas as receitas que usam.',
              style: AppType.on(AppType.caption, pit.muted),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (subs.isEmpty)
              const EmptyState(
                icon: AppIcons.link,
                title: 'Nenhuma subreceita',
                message: 'Segure o nome de um componente numa receita e '
                    'escolha "Tornar subreceita".',
              )
            else
              for (var i = 0; i < subs.length; i++)
                HairlineRow(
                  title: Text(
                    subs[i].name,
                    style: AppType.on(AppType.body, pit.text),
                  ),
                  subtitle: Text(
                    _usesLabel(usage[subs[i].id] ?? 0),
                    style: AppType.on(AppType.caption, pit.muted),
                  ),
                  trailing:
                      Icon(AppIcons.chevron, size: 20, color: pit.faint),
                  showDivider: i != subs.length - 1,
                  onTap: () => context.push('/sub-recipe/${subs[i].id}'),
                ),
          ],
        ),
      ),
    );
  }

  /// Linha do topo: voltar + rótulo SUBRECEITAS. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Text('SUBRECEITAS', style: AppType.on(AppType.label, AppColors.accent)),
      ],
    );
  }

  /// Rótulo "em N receitas" da linha. Usada por: [build].
  String _usesLabel(int uses) => switch (uses) {
        0 => 'ainda sem uso',
        1 => 'em 1 receita',
        _ => 'em $uses receitas',
      };
}
