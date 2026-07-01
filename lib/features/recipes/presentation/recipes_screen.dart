// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipes_screen.dart
// O QUÊ:     Aba Receitas: marca, busca, abas de pasta e lista de receitas.
// USA:       core/widgets (Masthead, PitadaScaffold, SearchField, ChapterTabs...),
//            recipes_providers, RecipeRow, go_router (navegação).
// USADO POR: core/router/router.dart (branch /recipes).
// SPEC:      specs/features/recipes.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/chapter_tabs.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/pitada_search_field.dart';
import '../application/recipes_providers.dart';
import 'import_sheet.dart';
import 'widgets/recipe_row.dart';

/// Tela principal da aba Receitas. Usada por: router (/recipes).
class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  /// Observa filtro/pastas e monta marca + busca + abas + lista. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(filteredRecipesProvider);
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final selected = ref.watch(selectedFolderProvider);
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
                icon: Icons.menu_book_outlined,
              ),
            )
          else
            Padding(
              padding: AppSpacing.screenH,
              child: Column(
                children: [
                  for (var i = 0; i < recipes.length; i++)
                    RecipeRow(
                      recipe: recipes[i],
                      showDivider: i != recipes.length - 1,
                      onTap: () => context.push('/recipe/${recipes[i].id}'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
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
            icon: Icons.person_outline,
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: AppSpacing.sm),
          PitadaIconButton(
            icon: Icons.add,
            onPressed: () => showImportSheet(context),
          ),
        ],
      ),
    );
  }
}
