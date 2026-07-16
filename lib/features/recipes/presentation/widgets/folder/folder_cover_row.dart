// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder/folder_cover_row.dart
// O QUÊ:     Linha horizontal de capas de pasta na aba Receitas (lista única):
//            um FolderCard compacto por pasta + capa fantasma "Nova pasta".
//            Pasta é prateleira do usuário, não aba rival.
// USA:       recipes_providers (pastas + receitas), folder_card, core/theme,
//            core/utils/app_log, go_router.
// USADO POR: recipes_screen (seção Pastas).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../application/recipes_providers.dart';
import 'folder_card.dart';

/// Largura de cada capa na linha (altura sai da proporção do FolderCard).
/// Usada por: [FolderCoverRow].
const _kCoverWidth = 148.0;

/// Capas de pasta roláveis na horizontal. Usada por: recipes_screen.
class FolderCoverRow extends ConsumerWidget {
  const FolderCoverRow({super.key});

  /// Observa pastas + receitas e monta a fileira de capas. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.screenH,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final f in folders)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: SizedBox(
                width: _kCoverWidth,
                child: FolderCard(
                  folder: f,
                  count:
                      recipes.where((r) => r.folderIds.contains(f.id)).length,
                  onTap: () => context.push('/folder/${f.id}'),
                ),
              ),
            ),
          const SizedBox(width: _kCoverWidth, child: _NewFolderCover()),
        ],
      ),
    );
  }
}

/// Capa fantasma "Nova pasta": contorno discreto, convite a criar a próxima.
/// Usada por: [FolderCoverRow].
class _NewFolderCover extends StatelessWidget {
  const _NewFolderCover();

  /// Monta o contorno com ícone + rótulo centralizados. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // TODO(pitada): abrir o editor de pasta quando ele existir.
      onTap: () => AppLog.i('recipes', 'criar pasta — editor no próximo passo'),
      child: AspectRatio(
        aspectRatio: 1.18,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppSpacing.br(AppSpacing.radiusCard),
            border:
                Border.all(color: pit.line2, width: AppSpacing.borderStrong),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.add, size: 20, color: pit.muted),
              const SizedBox(height: AppSpacing.xs),
              Text('Nova pasta', style: AppType.on(AppType.caption, pit.muted)),
            ],
          ),
        ),
      ),
    );
  }
}
