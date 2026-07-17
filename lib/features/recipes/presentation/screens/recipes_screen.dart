// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/recipes_screen.dart
// O QUÊ:     Aba Receitas: header → capas de pasta (nova pasta e ver todas
//            entram como capas fantasma na própria fileira) → busca (com os
//            filtros colapsados atrás do ícone) → duas tabs — Receitas (lista
//            com maestria e memória do caderno) e Frameworks (as plantas baixas
//            que a pessoa constrói das próprias receitas).
// USA:       core/theme, core/widgets (PitadaTabs, EmptyState),
//            recipe_list_providers, framework_providers, RecipeSearchField,
//            RecipeFilterPanel, FolderCoverRow, RecipeListView,
//            FrameworksTabView, go_router.
// USADO POR: core/router/router.dart (branch /recipes).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/layout/empty_state.dart';
import '../../../../core/widgets/layout/masthead.dart';
import '../../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/tabs/pitada_tabs.dart';
import '../../application/framework_providers.dart';
import '../../application/recipe_list_providers.dart';
import '../../application/recipes_providers.dart';
import '../../data/models/recipe/recipe.dart';
import '../sheets/import_sheet.dart';
import '../widgets/folder/folder_cover_row.dart';
import '../widgets/framework/frameworks_tab_view.dart';
import '../widgets/list/recipe_filter_panel.dart';
import '../widgets/list/recipe_list_view.dart';
import '../widgets/list/recipe_search_field.dart';

/// Tela principal da aba Receitas (busca + pastas + tabs). Usada por: router (/recipes).
class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  /// Observa busca/tab/receitas e monta o corpo da aba. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final tab = ref.watch(recipesTabIndexProvider);
    final filtersOpen = ref.watch(recipeFiltersOpenProvider);

    return PitadaScaffold(
      background: pit.tabBg(0),
      top: const Masthead(),
      child: ListView(
        padding: tabListPadding(context),
        children: [
          _header(context, pit),
          const SizedBox(height: AppSpacing.xxl),
          const FolderCoverRow(),
          const SizedBox(height: AppSpacing.xxl),
          Padding(
            padding: AppSpacing.screenH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RecipeSearchField(
                  hint: 'Buscar receita ou ingrediente',
                  onChanged: (q) =>
                      ref.read(recipeSearchQueryProvider.notifier).state = q,
                  onToggleFilters: tab == 0
                      ? () => ref
                          .read(recipeFiltersOpenProvider.notifier)
                          .update((open) => !open)
                      : null,
                  filtersOpen: filtersOpen,
                  filtersActive: ref.watch(recipeFiltersProvider).isActive,
                ),
                if (tab == 0 && filtersOpen) const RecipeFilterPanel(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          PitadaTabs(
            tabs: const ['Receitas', 'Frameworks'],
            selected: tab,
            onSelect: (i) =>
                ref.read(recipesTabIndexProvider.notifier).state = i,
          ),
          Padding(
            padding: AppSpacing.screenH,
            child: tab == 0 ? _recipesTab(ref) : const FrameworksTabView(),
          ),
        ],
      ),
    );
  }

  /// Corpo da tab Receitas: lista com maestria/memória ou estado vazio.
  /// Usada por: [build].
  Widget _recipesTab(WidgetRef ref) {
    final all = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
    final recipes = ref.watch(filteredRecipesProvider);
    if (all.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xl),
        child: EmptyState(
          title: 'Nenhuma receita ainda',
          message: 'Crie ou importe uma receita no botão +',
          icon: AppIcons.notebook,
        ),
      );
    }
    if (recipes.isEmpty) {
      final filtered = ref.watch(recipeFiltersProvider).activeAxes > 0;
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xl),
        child: EmptyState(
          title: 'Nada por aqui',
          message: filtered
              ? 'Nenhuma receita passa por esses filtros'
              : 'Tente outra busca',
          icon: filtered ? AppIcons.tune : AppIcons.search,
        ),
      );
    }
    return RecipeListView(recipes: recipes);
  }

  /// Cabeçalho da aba: título grande + botão de importar. Usada por: [build].
  Widget _header(BuildContext context, PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.titleGap,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              'Receitas',
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
          ),
          PitadaIconButton(
            icon: AppIcons.add,
            filled: true,
            size: AppSpacing.iconButtonSm,
            onPressed: () => showImportSheet(context),
          ),
        ],
      ),
    );
  }
}
