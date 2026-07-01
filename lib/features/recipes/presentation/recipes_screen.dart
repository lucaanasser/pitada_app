// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipes_screen.dart
// O QUÊ:     Aba Receitas: marca, busca, abas de pasta, alternador de layout e lista
//            (card grande / 2 colunas / lista-filete).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets, recipes_providers,
//            recipe_view_provider, RecipeCard/RecipeRow/RecipeViewToggle, go_router.
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
import '../../../core/widgets/chapter_tabs.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/pitada_search_field.dart';
import '../application/recipe_view_provider.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import 'import_sheet.dart';
import 'widgets/recipe_card.dart';
import 'widgets/recipe_row.dart';
import 'widgets/recipe_view_toggle.dart';

/// Tela principal da aba Receitas. Usada por: router (/recipes).
class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  /// Observa filtro/pastas/modo e monta marca + busca + abas + lista. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(filteredRecipesProvider);
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final selected = ref.watch(selectedFolderProvider);
    final view = ref.watch(recipeViewProvider);
    final tabs = ['Todas', ...folders.map((f) => f.name)];

    return PitadaScaffold(
      top: const Masthead(),
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          _header(context),
          const Padding(
            padding: AppSpacing.screenH,
            child: PitadaSearchField(hint: 'Buscar receita ou ingrediente'),
          ),
          const SizedBox(height: AppSpacing.xl),
          ChapterTabs(
            tabs: tabs,
            selected: selected,
            onSelect: (i) =>
                ref.read(selectedFolderProvider.notifier).state = i,
          ),
          if (recipes.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxxl),
              child: EmptyState(
                title: 'Nada nesta pasta',
                message: 'Importe uma receita ou escolha outra pasta.',
                icon: AppIcons.notebook,
              ),
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
                      style: AppType.on(AppType.caption, context.pit.muted),
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
          rows.add(Padding(
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
          ));
        }
        return Column(children: rows);
    }
  }

  /// Cabeçalho da aba: título grande + botões de perfil e importar.
  /// Usada por: [build].
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Expanded(child: Text('Receitas', style: AppType.screenTitle)),
          PitadaIconButton(
            icon: AppIcons.profile,
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: AppSpacing.sm),
          PitadaIconButton(
            icon: AppIcons.add,
            onPressed: () => showImportSheet(context),
          ),
        ],
      ),
    );
  }
}
