// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/collection_chart.dart
// O QUÊ:     A rosca da coleção — anel "N de M receitas cozinhadas" no topo da
//            aba Receitas. Espelho anti-acúmulo: a parte cheia só sobe e a
//            parte vazia é convite ("esperando estreia"), nunca dívida.
//            HOJE com dados mockados (só frontend).
// USA:       core/theme (AppColors, PitadaColors, AppSpacing, AppType).
// USADO POR: recipes_screen (topo da aba).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: collection_chart)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

// TODO(pitada): ligar cooked/total ao diário real (hoje é mock de frontend).

/// Rosca "N de M receitas cozinhadas" com linha-convite para as dormentes.
/// Usada por: RecipesScreen.
class CollectionChart extends StatelessWidget {
  const CollectionChart({super.key, this.cooked = 12, this.total = 40});

  final int cooked;
  final int total;

  /// Monta anel + números + convite. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final waiting = total - cooked;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: CustomPaint(
              painter: _RingPainter(
                fraction: total == 0 ? 0 : cooked / total,
                arcColor: AppColors.accent,
                trackColor: pit.line2,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$cooked de $total',
                  style: AppType.on(AppType.title, pit.text),
                ),
                const SizedBox(height: 2),
                Text(
                  'receitas cozinhadas',
                  style: AppType.on(AppType.bodySm, pit.text2),
                ),
                if (waiting > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '$waiting esperando estreia',
                    style: AppType.on(AppType.caption, pit.muted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pinta o anel: trilho completo + arco da fração cozinhada, flat e sem sombra.
/// Usada por: CollectionChart.
class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.fraction,
    required this.arcColor,
    required this.trackColor,
  });

  final double fraction;
  final Color arcColor;
  final Color trackColor;

  /// Desenha trilho e arco a partir do topo. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 10.0;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);
    if (fraction <= 0) return;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = arcColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * fraction.clamp(0.0, 1.0),
      false,
      arc,
    );
  }

  /// Repinta quando fração ou cores mudam. Usada por: framework.
  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction ||
      old.arcColor != arcColor ||
      old.trackColor != trackColor;
}
