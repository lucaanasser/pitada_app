// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/recipes_screen.dart
// O QUÊ:     Aba Receitas: header → rosca da coleção (cozinhadas vs salvas) →
//            capas de pasta (nova pasta e ver todas entram como capas fantasma
//            na própria fileira) → busca (com os filtros colapsados atrás do
//            ícone) → duas tabs — Receitas (lista com maestria e memória do
//            caderno) e Frameworks (as plantas baixas que a pessoa constrói
//            das próprias receitas).
// USA:       core/theme, core/widgets (PitadaTabs, EmptyState),
//            recipe_list_providers, framework_providers, CollectionChart,
//            RecipeSearchField, RecipeFilterPanel, FolderCoverRow,
//            RecipeListView, FrameworksTabView, go_router.
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
import '../../application/recipe_providers.dart';
import '../../data/models/recipe/recipe.dart';
import '../sheets/import_sheet.dart';
import '../widgets/collection_chart.dart';
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
          const Padding(
            padding: AppSpacing.screenH,
            child: CollectionChart(),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          PitadaTabs(
            tabs: const ['Receitas', 'Frameworks'],
            selected: tab,
            onSelect: (i) =>
                ref.read(recipesTabIndexProvider.notifier).state = i,
          ),
          if (tab == 0) ...[
            const SizedBox(height: AppSpacing.xl),
            const FolderCoverRow(),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: AppSpacing.screenH,
              child: _searchArea(ref, filtersOpen),
            ),
          ],
          Padding(
            padding: AppSpacing.screenH,
            child: tab == 0 ? _recipesTab(ref) : const FrameworksTabView(),
          ),
        ],
      ),
    );
  }

  Widget _searchArea(WidgetRef ref, bool filtersOpen) {
    final open = ref.watch(recipeSearchOpenProvider);
    if (!open) {
      return Consumer(
        builder: (context, ref, _) => GestureDetector(
          onTap: () => ref.read(recipeSearchOpenProvider.notifier).state = true,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                Icon(AppIcons.search, size: 18, color: context.pit.muted),
                const SizedBox(width: AppSpacing.md),
                Text(
                  'Buscar',
                  style: AppType.on(AppType.bodySm, context.pit.muted),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RecipeSearchField(
          hint: 'Buscar receita ou ingrediente',
          autofocus: true,
          onChanged: (q) =>
              ref.read(recipeSearchQueryProvider.notifier).state = q,
          onToggleFilters: () => ref
              .read(recipeFiltersOpenProvider.notifier)
              .update((open) => !open),
          onClose: () {
            ref.read(recipeSearchOpenProvider.notifier).state = false;
            ref.read(recipeSearchQueryProvider.notifier).state = '';
            ref.read(recipeFiltersOpenProvider.notifier).state = false;
          },
          filtersOpen: filtersOpen,
          filtersActive: ref.watch(recipeFiltersProvider).isActive,
        ),
        if (filtersOpen) const RecipeFilterPanel(),
      ],
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
          icon: AppIcons.journal,
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
