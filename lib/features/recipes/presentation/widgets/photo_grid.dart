// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/photo_grid.dart
// O QUÊ:     Grade de fotos do editor: miniaturas (RecipeThumb) + tile "adicionar".
// USA:       core/widgets/recipe_thumb, theme/*. Câmera/galeria viram service depois.
// USADO POR: recipe_edit_screen (grade de fotos da receita).
// SPEC:      specs/features/recipes.yaml (EditPhotoStrip)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/recipe_thumb.dart';

/// Grade horizontal de fotos (mock): [count] placeholders coloridos com [heroColor]
/// + um tile "＋ Adicionar" que chama [onAdd]. Usada por: recipe_edit_screen.
class PhotoGrid extends StatelessWidget {
  const PhotoGrid({
    super.key,
    required this.count,
    required this.heroColor,
    required this.onAdd,
  });

  final int count;
  final String heroColor;
  final VoidCallback onAdd;

  static const double _tile = 92;

  /// Monta a faixa rolável de miniaturas + o tile de adicionar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _tile,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          for (var i = 0; i < count; i++)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: RecipeThumb(
                color: AppColors.heroOf(heroColor),
                size: _tile,
                radius: AppSpacing.radiusLg,
                icon: AppIcons.photo,
              ),
            ),
          _addTile(context.pit),
        ],
      ),
    );
  }

  /// Tile tracejado "adicionar foto" (mock: só incrementa). Usada por: [build].
  Widget _addTile(PitadaColors pit) {
    return GestureDetector(
      onTap: onAdd,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _tile,
        height: _tile,
        decoration: BoxDecoration(
          color: pit.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: pit.line2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.add, size: 22, color: pit.muted),
            const SizedBox(height: AppSpacing.xs),
            Text('Foto', style: AppType.on(AppType.captionSm, pit.muted)),
          ],
        ),
      ),
    );
  }
}
