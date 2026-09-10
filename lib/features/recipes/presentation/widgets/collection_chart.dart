// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/collection_chart.dart
// O QUÊ:     O jarro da coleção — jarra medidora que enche com "N de M receitas
//            cozinhadas" no topo da aba Receitas. Espelho anti-acúmulo: o
//            líquido só sobe e a parte vazia é convite ("esperando estreia"),
//            nunca dívida. HOJE com dados mockados (só frontend).
// USA:       core/theme (AppColors, PitadaColors, AppSpacing, AppType),
//            jug_chart (a jarra desenhada).
// USADO POR: recipes_screen (topo da aba).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: collection_chart)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/recipe_list_providers.dart';
import '../../application/recipe_providers.dart';
import '../../data/models/recipe/recipe.dart';
import 'jug_chart.dart';

// TODO(pitada): ligar cooked/total ao diário real (hoje é mock de frontend).

/// Jarro "N de M receitas cozinhadas" com linha-convite para as dormentes.
/// Usada por: RecipesScreen.
class CollectionChart extends ConsumerWidget {
  const CollectionChart({super.key, this.cooked = 12, this.total = 40});

  final int cooked;
  final int total;

  /// Monta jarro + números + convite. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final debut = _debutOf(ref);
    return Row(
      children: [
        JugChart(fraction: total == 0 ? 0 : cooked / total),
        const SizedBox(width: AppSpacing.xl),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$cooked',
                    style: AppType.on(AppType.numeralLg, pit.text),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'de $total',
                    style: AppType.on(AppType.caption, pit.muted),
                  ),
                ],
              ),
              Text(
                'receitas cozinhadas',
                style: AppType.on(AppType.body, pit.text),
              ),
              if (debut != null) ...[
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: () => context.push('/recipe/${debut.id}'),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'que tal estrear ${debut.title}?',
                          style: AppType.on(AppType.bodySm, AppColors.accent),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        AppIcons.chevron,
                        size: 14,
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Recipe? _debutOf(WidgetRef ref) {
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
    final dormant = [
      for (final r in recipes)
        if (ref.watch(recipeMasteryProvider(r.id)) == 'nunca fiz') r,
    ];
    if (dormant.isEmpty) return null;
    final now = DateTime.now();
    return dormant[(now.year * 366 + now.month * 31 + now.day) % dormant.length];
  }
}
