// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder/folder_cover_row.dart
// O QUÊ:     Linha horizontal de capas de pasta na aba Receitas (lista única):
//            um FolderCard por pasta, o card de contorno "Nova pasta" no fim
//            e, depois dele, a seta solta "Ver todas" (sem card).
// USA:       recipe_providers (pastas + receitas), folder_card, folder_edit_sheet
//            (criar/editar), core/theme, go_router.
// USADO POR: recipes_screen (seção Pastas).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../application/recipe_providers.dart';
import '../../sheets/folder_edit_sheet.dart';
import 'folder_card.dart';
import 'folder_painter.dart';

/// Largura de cada capa na linha (altura sai da proporção do FolderCard).
/// Usada por: [FolderCoverRow].
const _kCoverWidth = 146.0;

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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  onLongPress: () => showFolderEditSheet(context, folder: f),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(right: folders.isEmpty ? 0 : AppSpacing.lg),
            child: const SizedBox(width: _kCoverWidth, child: _NewFolderCover()),
          ),
          if (folders.isNotEmpty) const _AllFoldersChevron(),
        ],
      ),
    );
  }
}

/// Seta "Ver todas" ao fim da fileira, alinhada ao "+" do card ao lado: o
/// corpo da pasta começa depois da aba (folderTabHeight) e ocupa o resto da
/// altura do card — a seta centraliza nesse intervalo, sem herdar a largura
/// de um card. Usada por: [FolderCoverRow].
class _AllFoldersChevron extends StatelessWidget {
  const _AllFoldersChevron();

  /// Monta a seta tocável que navega para /folders. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kCoverWidth / 1.4,
      child: Padding(
        padding: const EdgeInsets.only(top: folderTabHeight),
        child: Center(
          child: GestureDetector(
            onTap: () => context.push('/folders'),
            behavior: HitTestBehavior.opaque,
            child: Icon(AppIcons.chevron, size: 20, color: context.pit.muted),
          ),
        ),
      ),
    );
  }
}

/// Capa fantasma "Nova pasta": a MESMA silhueta de [FolderCard] (corpo + aba),
/// só que sem cor — apenas o traço — com o "+" centralizado. Usada por:
/// [FolderCoverRow].
class _NewFolderCover extends StatelessWidget {
  const _NewFolderCover();

  /// Monta a silhueta em contorno com o "+" centralizado no CORPO (abaixo da
  /// aba, folderTabHeight) — no card inteiro ele ficaria puxado p/ cima.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showFolderEditSheet(context),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: CustomPaint(
          painter: _FolderOutlinePainter(color: pit.line2),
          child: Padding(
            padding: const EdgeInsets.only(top: folderTabHeight),
            child: Center(
              child: Icon(AppIcons.add, size: 22, color: pit.muted),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pinta só o TRAÇO da silhueta da pasta (mesma geometria de [FolderPainter]),
/// sem preenchimento. Usada por: [_NewFolderCover].
class _FolderOutlinePainter extends CustomPainter {
  const _FolderOutlinePainter({required this.color});

  final Color color;

  /// Desenha o contorno da silhueta. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      folderSilhouette(size),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppSpacing.borderStrong,
    );
  }

  /// Repinta quando a cor mudar. Usada por: framework.
  @override
  bool shouldRepaint(_FolderOutlinePainter old) => old.color != color;
}
