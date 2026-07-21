// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista, tipografia pura (título + meta +
//            maestria + seta) — sem miniatura: o app não é catálogo.
// USA:       core/theme (AppIcons, PitadaColors), core/widgets (HairlineRow),
//            recipe_meta_text (linha de meta), Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
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
    this.cooks = 0,
    this.folderHero,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;
  final String? mastery;
  final int cooks;
  final String? folderHero;

  /// Monta a linha (título + meta·maestria + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: _UtensilPotStamp(
        utensils: mastery == 'domino' ? 3 : (cooks > 3 ? 3 : cooks),
        mastered: mastery == 'domino',
        fillColor: folderHero != null ? pit.card(folderHero!) : pit.line2,
        borderColor: cooks == 0 && mastery != 'domino' ? pit.line2 : pit.muted,
      ),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}

const _kSlotSize = 56.0;

class _UtensilPotStamp extends StatelessWidget {
  const _UtensilPotStamp({
    required this.utensils,
    required this.mastered,
    required this.fillColor,
    required this.borderColor,
  });

  final int utensils;
  final bool mastered;
  final Color fillColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kSlotSize,
      height: _kSlotSize,
      child: CustomPaint(
        painter: _UtensilPotPainter(
          utensils: utensils,
          filled: mastered,
          fillColor: fillColor,
          borderColor: borderColor,
          dashed: utensils == 0 && !mastered,
        ),
      ),
    );
  }
}

class _UtensilPotPainter extends CustomPainter {
  const _UtensilPotPainter({
    required this.utensils,
    required this.filled,
    required this.fillColor,
    required this.borderColor,
    required this.dashed,
  });

  final int utensils;
  final bool filled;
  final Color fillColor;
  final Color borderColor;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    const potTop = 28.0, potBottom = 50.0, potHalf = 11.0;
    final pot = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(cx - potHalf, potTop, cx + potHalf, potBottom),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
          bottomLeft: const Radius.circular(7),
          bottomRight: const Radius.circular(7),
        ),
      );

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.borderStrong
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    if (dashed) {
      const dash = 5.0, gap = 4.5;
      for (final metric in pot.computeMetrics()) {
        var d = 0.0;
        while (d < metric.length) {
          canvas.drawPath(metric.extractPath(d, d + dash), stroke);
          d += dash + gap;
        }
      }
      return;
    }

    const specs = [(-6.0, -0.34), (0.0, 0.04), (6.0, 0.38)];
    for (var i = 0; i < utensils; i++) {
      final (baseDx, angle) = specs[i];
      canvas.save();
      canvas.translate(cx + baseDx, potTop + 1);
      canvas.rotate(angle);
      canvas.drawLine(Offset.zero, const Offset(0, -14), stroke);
      switch (i) {
        case 0:
          canvas.drawOval(
            Rect.fromCenter(
              center: const Offset(0, -17),
              width: 7,
              height: 9,
            ),
            Paint()..color = borderColor,
          );
        case 1:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: const Offset(0, -17),
                width: 7,
                height: 9,
              ),
              const Radius.circular(3),
            ),
            Paint()..color = borderColor,
          );
        case 2:
          canvas.drawOval(
            Rect.fromCenter(
              center: const Offset(0, -18),
              width: 7,
              height: 11,
            ),
            stroke,
          );
      }
      canvas.restore();
    }

    if (filled) {
      canvas.drawPath(pot, Paint()..color = fillColor);
    }
    canvas.drawPath(pot, stroke);
  }

  @override
  bool shouldRepaint(_UtensilPotPainter old) =>
      old.utensils != utensils ||
      old.filled != filled ||
      old.fillColor != fillColor ||
      old.borderColor != borderColor ||
      old.dashed != dashed;
}
