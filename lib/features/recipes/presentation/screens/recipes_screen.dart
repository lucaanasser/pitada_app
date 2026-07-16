// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/recipes_screen.dart
// O QUÊ:     Aba Receitas em lista ÚNICA: contexto vivo no topo, busca real
//            (título/ingrediente), capas de pasta, lentes, lista com linha de
//            posse e o repertório de técnicas no rodapé.
// USA:       core/theme, core/widgets, recipes_providers, recipe_list_providers,
//            recipe_view_provider, ContextStrip, FolderCoverRow, LensChipRow,
//            RecipeListView, go_router.
// USADO POR: core/router/router.dart (branch /recipes).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/layout/empty_state.dart';
import '../../../../core/widgets/layout/masthead.dart';
import '../../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../../core/widgets/layout/section_header.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/controls/pitada_search_field.dart';
import '../../application/recipe_list_providers.dart';
import '../../application/recipe_view_provider.dart';
import '../../application/recipes_providers.dart';
import '../../data/models/recipe.dart';
import '../sheets/import_sheet.dart';
import '../widgets/folder/folder_cover_row.dart';
import '../widgets/home/context_strip.dart';
import '../widgets/list/lens_chip_row.dart';
import '../widgets/list/recipe_list_view.dart';
import '../widgets/list/recipe_view_toggle.dart';

/// Tela principal da aba Receitas (lista única). Usada por: router (/recipes).
class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  /// Observa busca/lente/receitas e monta o corpo da aba. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final all = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
    final recipes = ref.watch(filteredRecipesProvider);
    final view = ref.watch(recipeViewProvider);

    return PitadaScaffold(
      background: pit.tabBg(0),
      top: const Masthead(),
      child: ListView(
        padding: tabListPadding(context),
        children: [
          _header(context, pit),
          const Padding(padding: AppSpacing.screenH, child: ContextStrip()),
          Padding(
            padding: AppSpacing.screenH,
            child: PitadaSearchField(
              hint: 'Buscar receita ou ingrediente',
              onChanged: (q) =>
                  ref.read(recipeSearchQueryProvider.notifier).state = q,
            ),
          ),
          const Padding(
            padding: AppSpacing.screenH,
            child: SectionHeader(label: 'Pastas', topGap: AppSpacing.xl),
          ),
          const FolderCoverRow(),
          const SizedBox(height: AppSpacing.xl),
          const LensChipRow(),
          const SizedBox(height: AppSpacing.lg),
          if (all.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxl),
              child: EmptyState(
                title: 'Nenhuma receita ainda',
                message: 'Crie ou importe uma receita no botão +',
                icon: AppIcons.notebook,
              ),
            )
          else if (recipes.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxl),
              child: EmptyState(
                title: 'Nada por aqui',
                message: 'Tente outra busca ou troque a lente',
                icon: AppIcons.search,
              ),
            )
          else ...[
            Padding(
              padding: AppSpacing.screenH,
              child: _countRow(ref, pit, recipes.length, view),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: AppSpacing.screenH,
              child: RecipeListView(recipes: recipes, view: view),
            ),
          ],
          _repertoire(context, ref, pit),
        ],
      ),
    );
  }

  /// Linha "N receitas" + alternador de layout. Usada por: [build].
  Widget _countRow(
    WidgetRef ref,
    PitadaColors pit,
    int count,
    RecipeView view,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$count ${count == 1 ? 'receita' : 'receitas'}',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ),
        RecipeViewToggle(
          value: view,
          onSelect: (v) => ref.read(recipeViewProvider.notifier).state = v,
        ),
      ],
    );
  }

  /// Rodapé discreto do repertório: técnicas usadas de verdade — número sem
  /// teto, que só sobe. Toca e abre as Fichas. Usada por: [build].
  Widget _repertoire(BuildContext context, WidgetRef ref, PitadaColors pit) {
    final count = ref.watch(techniqueRepertoireProvider);
    if (count == 0) return const SizedBox.shrink();
    final label = count == 1
        ? '1 técnica no seu repertório'
        : '$count técnicas no seu repertório';
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xl,
        AppSpacing.gutter,
        0,
      ),
      child: GestureDetector(
        onTap: () => context.push('/learning/cards'),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.technique, size: 14, color: pit.muted),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppType.on(AppType.caption, pit.muted)),
          ],
        ),
      ),
    );
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
