// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folders_grid.dart
// O QUÊ:     Grade 2 colunas da aba Pastas: um FolderCard por pasta (com nº de
//            receitas) + card fantasma "Nova pasta" no fim.
// USA:       core/theme (AppIcons, PitadaColors), core/utils/app_log,
//            recipes_providers (pastas + receitas), folder_card, go_router.
// USADO POR: recipes_screen (aba Pastas).
// SPEC:      specs/features/recipes.yaml (FoldersGrid)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../application/recipes_providers.dart';
import 'folder_card.dart';

/// Proporção largura/altura dos cards de pasta (silhueta da pasta, como o
/// FolderCard). Usada por: [_NewFolderCard] para alinhar com os cards reais.
const _kFolderAspect = 1.45;

/// Grade de pastas em 2 colunas (linhas manuais, pois o pai é um ListView).
/// Usada por: recipes_screen (aba Pastas).
class FoldersGrid extends ConsumerWidget {
  const FoldersGrid({super.key});

  /// Observa pastas + receitas e monta as linhas da grade. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];

    final cells = <Widget>[
      for (final f in folders)
        FolderCard(
          folder: f,
          count: recipes.where((r) => r.folderIds.contains(f.id)).length,
          onTap: () => context.push('/folder/${f.id}'),
        ),
      const _NewFolderCard(),
    ];

    final rows = <Widget>[];
    for (var i = 0; i < cells.length; i += 2) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: cells[i]),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: i + 1 < cells.length ? cells[i + 1] : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

/// Card fantasma "Nova pasta": contorno 2px discreto, sem preenchimento —
/// convite a criar a próxima pasta. Usada por: [FoldersGrid].
class _NewFolderCard extends StatelessWidget {
  const _NewFolderCard();

  /// Monta o contorno com ícone + rótulo centralizados. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // TODO(pitada): abrir o editor de pasta quando ele existir.
      onTap: () => AppLog.i('recipes', 'criar pasta — editor no próximo passo'),
      child: AspectRatio(
        aspectRatio: _kFolderAspect,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppSpacing.br(AppSpacing.radiusCard),
            border:
                Border.all(color: pit.line2, width: AppSpacing.borderStrong),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.add, size: 22, color: pit.muted),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Nova pasta',
                style: AppType.on(AppType.caption, pit.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
