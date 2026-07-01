// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/folder_screen.dart
// O QUÊ:     Tela de uma pasta: título + contagem + lista de RecipeRow + adicionar.
//            Deriva a pasta e suas receitas de foldersProvider/recipesProvider.
// USA:       recipes_providers, RecipeRow, core/widgets (PitadaScaffold, EmptyState,
//            PitadaIconButton), theme/*, go_router (navegação para o detalhe).
// USADO POR: core/router (/folder/:id).
// SPEC:      specs/features/recipes.yaml (FolderScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../application/recipes_providers.dart';
import 'widgets/recipe_row.dart';

/// Tela de uma pasta de receitas. Usada por: router (/folder/:id).
class FolderScreen extends ConsumerWidget {
  const FolderScreen({super.key, required this.folderId});

  final String folderId;

  /// Monta topo fixo + lista rolável (ou EmptyState). Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
    final matches = folders.where((f) => f.id == folderId).toList();
    final inFolder =
        recipes.where((r) => r.folderIds.contains(folderId)).toList();
    final name = matches.isEmpty ? 'Pasta' : matches.first.name;

    return PitadaScaffold(
      top: _header(context, name),
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          if (inFolder.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxxl),
              child: EmptyState(
                title: 'Pasta vazia',
                message: 'Adicione receitas a esta pasta.',
                icon: AppIcons.folder,
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.gutter,
                AppSpacing.md,
                AppSpacing.gutter,
                AppSpacing.sm,
              ),
              child: Text(
                '${inFolder.length} receita${inFolder.length == 1 ? '' : 's'}',
                style: AppType.on(AppType.caption, AppColors.muted),
              ),
            ),
            Padding(
              padding: AppSpacing.screenH,
              child: Column(
                children: [
                  for (var i = 0; i < inFolder.length; i++)
                    RecipeRow(
                      recipe: inFolder[i],
                      showDivider: i != inFolder.length - 1,
                      onTap: () => context.push('/recipe/${inFolder[i].id}'),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Cabeçalho: seta voltar + nome da pasta + botão adicionar receita. Usada por: [build].
  Widget _header(BuildContext context, String name) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.md,
          AppSpacing.gutter,
          AppSpacing.lg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(right: AppSpacing.md),
                child: Icon(AppIcons.back, size: 22, color: AppColors.text),
              ),
            ),
            Expanded(child: Text(name, style: AppType.screenTitle)),
            PitadaIconButton(
              icon: AppIcons.add,
              // Mock: seletor de receitas fora da pasta virá com o repositório de escrita.
              onPressed: () =>
                  AppLog.i('recipes', 'adicionar receita à pasta: $folderId'),
            ),
          ],
        ),
      ),
    );
  }
}
