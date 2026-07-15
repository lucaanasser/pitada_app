// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder_card.dart
// O QUÊ:     Card de pasta: pastel com aba suave, papéis off-white saindo de
//            dentro (0–3, conforme o conteúdo) e nome + contagem no bolso.
//            Toque encolhe o card e "levanta" os papéis.
// USA:       core/theme (PitadaColors, AppColors, AppSpacing, AppType),
//            folder_painter (pintura), data/folder (Folder).
// USADO POR: folders_grid (aba Pastas de recipes_screen).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/folder.dart';
import 'folder_painter.dart';

/// Card de pasta com papéis animados no press. Usada por: folders_grid.
class FolderCard extends StatefulWidget {
  const FolderCard({
    super.key,
    required this.folder,
    required this.count,
    this.onTap,
  });

  final Folder folder;
  final int count;
  final VoidCallback? onTap;

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  bool _pressed = false; // microinteração: encolhe o card e sobe os papéis

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final label = widget.count == 1 ? '1 receita' : '${widget.count} receitas';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: AspectRatio(
          aspectRatio: 1.45,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: _pressed ? 6 : 0),
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOut,
            builder: (context, lift, child) => CustomPaint(
              painter: FolderPainter(
                pastel: pit.card(widget.folder.heroColor),
                paper: AppColors.surfLight,
                paperBack: AppColors.surf2Light,
                paperLine: AppColors.lineLight,
                shadow: AppColors.shadow,
                count: widget.count,
                lift: lift,
              ),
              child: child,
            ),
            // nome + contagem sobre o bolso frontal
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.folder.name,
                      // fonte compacta + até 2 linhas: nome longo quebra antes
                      // de cair no "..." (ver typography titleXs).
                      style: AppType.on(AppType.titleXs, pit.text),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      label,
                      style: AppType.on(AppType.captionSm, pit.text2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
