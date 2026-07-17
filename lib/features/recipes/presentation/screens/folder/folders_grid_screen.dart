// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/folder/folders_grid_screen.dart
// O QUÊ:     Todas as pastas em grade 2 colunas — a fileira horizontal da aba
//            Receitas só mostra as primeiras; aqui dá pra ver (e abrir) todas,
//            e também criar uma nova (ícone + no topo).
// USA:       recipes_providers, FolderCard, core/widgets (EmptyState),
//            core/theme (AppIcons, AppSpacing, AppType), core/utils/app_log,
//            go_router.
// USADO POR: core/router (/folders), via o ícone "ver todas" da RecipesScreen.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../application/recipes_providers.dart';
import '../../widgets/folder/folder_card.dart';

/// Tela com todas as pastas em grade. Usada por: router (/folders).
class FoldersGridScreen extends ConsumerWidget {
  const FoldersGridScreen({super.key});

  /// Observa pastas + receitas e monta a grade. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _top(context, pit),
            Expanded(
              child: folders.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: AppSpacing.xl),
                      child: EmptyState(
                        title: 'Nenhuma pasta ainda',
                        message: 'Crie uma pasta na aba Receitas.',
                        icon: AppIcons.folder,
                      ),
                    )
                  : GridView.builder(
                      padding: AppSpacing.screenH.copyWith(
                        top: AppSpacing.md,
                        bottom: AppSpacing.xl,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: folders.length,
                      itemBuilder: (context, i) {
                        final f = folders[i];
                        return FolderCard(
                          folder: f,
                          count: recipes
                              .where((r) => r.folderIds.contains(f.id))
                              .length,
                          onTap: () => context.push('/folder/${f.id}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Linha do topo: voltar + rótulo PASTAS + adicionar. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Padding(
      padding:
          AppSpacing.screenH.copyWith(top: AppSpacing.md, bottom: AppSpacing.md),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Icon(AppIcons.back, size: 22, color: pit.text),
            ),
          ),
          Expanded(
            child: Text('PASTAS', style: AppType.on(AppType.label, pit.muted)),
          ),
          PitadaIconButton(
            icon: AppIcons.add,
            filled: true,
            size: AppSpacing.iconButtonSm,
            // TODO(pitada): abrir o editor de pasta quando ele existir.
            onPressed: () =>
                AppLog.i('recipes', 'criar pasta — editor no próximo passo'),
          ),
        ],
      ),
    );
  }
}
