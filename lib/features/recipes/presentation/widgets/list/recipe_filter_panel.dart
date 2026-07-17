// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_filter_panel.dart
// O QUÊ:     Painel de filtros da aba Receitas — eixos (maestria, tempo, kcal) e
//            ordem da lista em texto com filete accent, revelado pelo ícone da
//            barra de busca.
// USA:       core/theme, FilterOptionRow, recipe_filters, recipe_list_providers.
// USADO POR: recipes_screen (abaixo da RecipeSearchField).
// SPEC:      specs/features/recipes.yaml (screens.RecipesScreen.filtros)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../application/recipe_filters.dart';
import '../../../application/recipe_list_providers.dart';
import 'filter_option_row.dart';

/// Filtros e ordem da lista em texto; some quando colapsado.
/// Usada por: recipes_screen.
class RecipeFilterPanel extends ConsumerWidget {
  const RecipeFilterPanel({super.key});

  /// Monta os eixos, a ordem e o "Limpar". Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(recipeFiltersProvider);
    final notifier = ref.read(recipeFiltersProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterOptionRow(
            label: 'MAESTRIA',
            options: [
              for (final m in Mastery.values)
                FilterOption(
                  label: masteryLabel(m),
                  selected: filters.mastery.contains(m),
                  onTap: () => notifier.state =
                      filters.copyWith(mastery: _toggle(filters.mastery, m)),
                ),
            ],
          ),
          FilterOptionRow(
            label: 'TEMPO',
            options: [
              for (final t in TimeRange.values)
                FilterOption(
                  label: timeRangeLabel(t),
                  selected: filters.time.contains(t),
                  onTap: () => notifier.state =
                      filters.copyWith(time: _toggle(filters.time, t)),
                ),
            ],
          ),
          FilterOptionRow(
            label: 'CALORIAS',
            options: [
              for (final k in KcalRange.values)
                FilterOption(
                  label: kcalRangeLabel(k),
                  selected: filters.kcal.contains(k),
                  onTap: () => notifier.state =
                      filters.copyWith(kcal: _toggle(filters.kcal, k)),
                ),
            ],
          ),
          FilterOptionRow(
            label: 'ORDENAR POR',
            options: [
              for (final s in RecipeSort.values)
                FilterOption(
                  label: recipeSortLabel(s),
                  selected: filters.sort == s,
                  onTap: () => notifier.state = filters.copyWith(sort: s),
                ),
            ],
          ),
          if (filters.isActive)
            GestureDetector(
              onTap: () => notifier.state = const RecipeFilters(),
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Limpar filtros',
                style: AppType.on(AppType.bodySm, AppColors.accent2),
              ),
            ),
        ],
      ),
    );
  }

  /// Liga ou desliga um valor dentro de um eixo. Usada por: [build].
  Set<T> _toggle<T>(Set<T> current, T value) => current.contains(value)
      ? ({...current}..remove(value))
      : {...current, value};
}
