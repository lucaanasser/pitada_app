// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipes_screen.dart
// O QUÊ:     Aba Receitas: marca, busca, 2 abas fixas (Minhas / Pastas),
//            alternador de layout e lista (card / 2 colunas / filete).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets, recipes_providers,
//            recipe_view_provider, RecipeCard/RecipeRow/RecipeViewToggle,
//            FoldersGrid (aba Pastas), go_router.
// USADO POR: core/router/router.dart (branch /recipes).
// SPEC:      specs/features/recipes.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/pitada_tabs.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/pitada_search_field.dart';
import '../application/recipe_view_provider.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import 'import_sheet.dart';
import 'widgets/folders_grid.dart';
import 'widgets/recipe_card.dart';
import 'widgets/recipe_row.dart';
import 'widgets/recipe_view_toggle.dart';

/// Rótulos das 2 abas fixas (índice casa com RecipesTab). Usada por: [RecipesScreen].
const _kTabs = ['Minhas Receitas', 'Pastas'];

/// Tela principal da aba Receitas. Usada por: router (/recipes).
class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  /// Observa aba/receitas/modo e monta marca + busca + abas + conteúdo.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final tab = ref.watch(selectedRecipesTabProvider);
    final recipes = ref.watch(recipesForTabProvider);
    final view = ref.watch(recipeViewProvider);

    return PitadaScaffold(
      background: pit.tabBg(0),
      top: const Masthead(),
      child: ListView(
        padding: tabListPadding(context),
        children: [
          _header(context, pit),
          const Padding(
            padding: AppSpacing.screenH,
            child: PitadaSearchField(hint: 'Buscar receita ou ingrediente'),
          ),
          const SizedBox(height: AppSpacing.xl),
          PitadaTabs(
            tabs: _kTabs,
            selected: tab,
            onSelect: (i) =>
                ref.read(selectedRecipesTabProvider.notifier).state = i,
          ),
          if (tab == RecipesTab.folders.index) ...[
            const SizedBox(height: AppSpacing.lg),
            const Padding(padding: AppSpacing.screenH, child: FoldersGrid()),
          ] else if (recipes.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxxl),
              child: _empty(tab),
            )
          else ...[
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: AppSpacing.screenH,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${recipes.length} ${recipes.length == 1 ? 'receita' : 'receitas'}',
                      style: AppType.on(AppType.caption, pit.muted),
                    ),
                  ),
                  RecipeViewToggle(
                    value: view,
                    onSelect: (v) =>
                        ref.read(recipeViewProvider.notifier).state = v,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: AppSpacing.screenH,
              child: _list(context, recipes, view),
            ),
          ],
        ],
      ),
    );
  }

  /// EmptyState da aba "Minhas Receitas" (a aba Pastas tem grade própria).
  /// Usada por: [build].
  Widget _empty(int tab) {
    return const EmptyState(
      title: 'Nenhuma receita ainda',
      message: 'Crie ou importe uma receita no botão +',
      icon: AppIcons.notebook,
    );
  }

  /// Renderiza a lista conforme o modo escolhido. Usada por: [build].
  Widget _list(BuildContext context, List<Recipe> recipes, RecipeView view) {
    switch (view) {
      case RecipeView.list:
        return Column(
          children: [
            for (var i = 0; i < recipes.length; i++)
              RecipeRow(
                recipe: recipes[i],
                showDivider: i != recipes.length - 1,
                onTap: () => context.push('/recipe/${recipes[i].id}'),
              ),
          ],
        );
      case RecipeView.single:
        return Column(
          children: [
            for (final r in recipes)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: RecipeCard(
                  recipe: r,
                  onTap: () => context.push('/recipe/${r.id}'),
                ),
              ),
          ],
        );
      case RecipeView.grid:
        final rows = <Widget>[];
        for (var i = 0; i < recipes.length; i += 2) {
          rows.add(
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RecipeCard(
                      recipe: recipes[i],
                      compact: true,
                      onTap: () => context.push('/recipe/${recipes[i].id}'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: i + 1 < recipes.length
                        ? RecipeCard(
                            recipe: recipes[i + 1],
                            compact: true,
                            onTap: () =>
                                context.push('/recipe/${recipes[i + 1].id}'),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(children: rows);
    }
  }

  /// Cabeçalho da aba: título grande + botão de importar. (O perfil saiu daqui:
  /// agora é aba própria na barra.) Usada por: [build].
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
