// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista, tipografia pura (título + meta +
//            maestria + seta) — sem miniatura: o app não é catálogo.
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (HairlineRow),
//            recipe_meta_text (linha de meta), Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../data/models/recipe/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista. [mastery] é a maestria
/// ("nunca fiz" / "fiz 2×" / "domino"), somada à meta em uma única linha.
/// Usada por: RecipeListView.
class RecipeRow extends StatelessWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
    this.mastery,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;
  final String? mastery;

  /// Monta a linha (título + meta·maestria + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final hasMastery = mastery != null && mastery!.isNotEmpty;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: mastery == 'nunca fiz'
          ? _EmptySlot(color: pit.line2)
          : _PhotoStamp(recipeId: recipe.id, border: pit.border),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        hasMastery
            ? '${recipeMetaText(recipe)}  ·  $mastery'
            : recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}

const _kSlotSize = 56.0;

class _PhotoStamp extends StatelessWidget {
  const _PhotoStamp({required this.recipeId, required this.border});

  final String recipeId;
  final Color border;

  @override
  Widget build(BuildContext context) {
    final seed = recipeId.codeUnits.fold(0, (a, b) => a + b);
    final angle = (seed % 7 - 3) * pi / 180;
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: _kSlotSize,
        height: _kSlotSize,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: border, width: AppSpacing.borderStrong),
        ),
        child: Image.asset(
          'assets/images/mock_dish_${seed % 4 + 1}.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  const _EmptySlot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kSlotSize,
      height: _kSlotSize,
      child: CustomPaint(painter: _DashedSlotPainter(color: color)),
    );
  }
}

class _DashedSlotPainter extends CustomPainter {
  const _DashedSlotPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const dash = 5.0, gap = 4.5;
    final source = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(AppSpacing.radiusLg),
        ),
      );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.borderStrong
      ..color = color;
    for (final metric in source.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedSlotPainter old) => old.color != color;
}
