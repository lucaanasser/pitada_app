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
      leading: _BowlStamp(
        mastery: mastery,
        fillColor: pit.card(recipe.heroColor),
        borderColor: mastery == null || mastery == 'nunca fiz'
            ? pit.line2
            : pit.border,
      ),
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

class _BowlStamp extends StatelessWidget {
  const _BowlStamp({
    required this.mastery,
    required this.fillColor,
    required this.borderColor,
  });

  final String? mastery;
  final Color fillColor;
  final Color borderColor;

  double get _fraction {
    if (mastery == 'domino') return 1.0;
    final n = int.tryParse(
          RegExp(r'fiz (\d+)').firstMatch(mastery ?? '')?.group(1) ?? '',
        ) ??
        0;
    if (n == 0) return 0;
    final level = n / (n + 3);
    return level > 0.75 ? 0.75 : level;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kSlotSize,
      height: _kSlotSize,
      child: CustomPaint(
        painter: _BowlPainter(
          fraction: _fraction,
          fillColor: fillColor,
          borderColor: borderColor,
          dashed: _fraction == 0,
        ),
      ),
    );
  }
}

class _BowlPainter extends CustomPainter {
  const _BowlPainter({
    required this.fraction,
    required this.fillColor,
    required this.borderColor,
    required this.dashed,
  });

  final double fraction;
  final Color fillColor;
  final Color borderColor;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width * 0.78,
      height: size.height * 0.54,
    );
    final bowl = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: const Radius.circular(5),
          topRight: const Radius.circular(5),
          bottomLeft: Radius.circular(rect.width / 2),
          bottomRight: Radius.circular(rect.width / 2),
        ),
      );

    if (fraction > 0) {
      canvas.save();
      canvas.clipPath(bowl);
      canvas.drawRect(
        Rect.fromLTRB(
          rect.left,
          rect.bottom - rect.height * fraction,
          rect.right,
          rect.bottom,
        ),
        Paint()..color = fillColor,
      );
      canvas.restore();
    }

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.borderStrong
      ..strokeCap = StrokeCap.round
      ..color = borderColor;
    if (!dashed) {
      canvas.drawPath(bowl, stroke);
      return;
    }
    const dash = 5.0, gap = 4.5;
    for (final metric in bowl.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + dash), stroke);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_BowlPainter old) =>
      old.fraction != fraction ||
      old.fillColor != fillColor ||
      old.borderColor != borderColor ||
      old.dashed != dashed;
}
