// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/jug_chart.dart
// O QUÊ:     A jarra medidora da coleção na linguagem das pastas: massas
//            chapadas SEM contorno — vidro em line2, líquido accent com onda,
//            marcações como barrinhas recortadas na cor do fundo.
// USA:       core/theme (AppColors, PitadaColors).
// USADO POR: collection_chart (gráfico-herói da aba Receitas).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: collection_chart)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';

/// Jarra medidora com o líquido na fração [fraction] (0..1).
/// Usada por: CollectionChart.
class JugChart extends StatelessWidget {
  const JugChart({super.key, required this.fraction, this.size = 96});

  final double fraction;
  final double size;

  /// Monta o CustomPaint com as cores do tema ativo. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _JugPainter(
          fraction: fraction.clamp(0.0, 1.0),
          glassColor: pit.line2,
          markColor: pit.bg,
          liquidColor: AppColors.accent,
        ),
      ),
    );
  }
}

/// Pinta a jarra como as pastas: massas preenchidas sem contorno, na ordem
/// alça → corpo → líquido (recortado) → marcações. Geometria autoral no grid
/// 256. Usada por: [JugChart].
class _JugPainter extends CustomPainter {
  const _JugPainter({
    required this.fraction,
    required this.glassColor,
    required this.markColor,
    required this.liquidColor,
  });

  final double fraction;
  final Color glassColor;
  final Color markColor;
  final Color liquidColor;

  /// Desenha alça, corpo, líquido e marcações, nessa ordem. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 256;
    final body = _bodyPath(k);
    final glass = Paint()..color = glassColor;

    canvas.drawPath(_handlePath(k), glass);
    canvas.drawPath(body, glass);
    if (fraction > 0) {
      canvas.save();
      canvas.clipPath(body);
      canvas.drawPath(_liquidPath(k), Paint()..color = liquidColor);
      canvas.restore();
    }
    _drawMarks(canvas, k);
  }

  /// Silhueta fechada do corpo: bico curvo, paredes afuniladas, fundo redondo.
  /// Usada por: [paint].
  Path _bodyPath(double k) => Path()
    ..moveTo(52 * k, 48 * k)
    ..cubicTo(56 * k, 68 * k, 64 * k, 84 * k, 78 * k, 90 * k)
    ..lineTo(86 * k, 196 * k)
    ..quadraticBezierTo(87 * k, 218 * k, 108 * k, 218 * k)
    ..lineTo(142 * k, 218 * k)
    ..quadraticBezierTo(163 * k, 218 * k, 164 * k, 196 * k)
    ..lineTo(170 * k, 78 * k)
    ..quadraticBezierTo(170 * k, 64 * k, 156 * k, 62 * k)
    ..lineTo(100 * k, 54 * k)
    ..quadraticBezierTo(72 * k, 51 * k, 52 * k, 48 * k)
    ..close();

  /// Alça: anel preenchido (contorno externo menos furo interno, even-odd).
  /// Usada por: [paint].
  Path _handlePath(double k) => Path()
    ..fillType = PathFillType.evenOdd
    ..moveTo(166 * k, 90 * k)
    ..cubicTo(202 * k, 88 * k, 218 * k, 108 * k, 216 * k, 132 * k)
    ..cubicTo(214 * k, 158 * k, 196 * k, 172 * k, 164 * k, 168 * k)
    ..lineTo(166 * k, 144 * k)
    ..cubicTo(186 * k, 148 * k, 194 * k, 140 * k, 195 * k, 129 * k)
    ..cubicTo(196 * k, 115 * k, 188 * k, 108 * k, 165 * k, 110 * k)
    ..close();

  /// Bloco de líquido com onda suave no topo, na altura da fração.
  /// Usada por: [paint].
  Path _liquidPath(double k) {
    final yl = (210 - fraction * (210 - 80)) * k;
    return Path()
      ..moveTo(66 * k, yl + 3 * k)
      ..cubicTo(96 * k, yl - 5 * k, 124 * k, yl + 7 * k, 152 * k, yl - 1 * k)
      ..lineTo(180 * k, yl - 3 * k)
      ..lineTo(182 * k, 230 * k)
      ..lineTo(62 * k, 230 * k)
      ..close();
  }

  /// Três barrinhas de medida (longa/curta/longa) recortadas na cor do fundo,
  /// como as linhas dos papéis das pastas. Usada por: [paint].
  void _drawMarks(Canvas canvas, double k) {
    final mark = Paint()..color = markColor;
    for (final (y, w) in const [(101.0, 36.0), (129.0, 20.0), (157.0, 36.0)]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(96 * k, y * k, w * k, 10 * k),
          Radius.circular(5 * k),
        ),
        mark,
      );
    }
  }

  /// Repinta quando fração ou cores mudam. Usada por: framework.
  @override
  bool shouldRepaint(_JugPainter old) =>
      old.fraction != fraction ||
      old.glassColor != glassColor ||
      old.markColor != markColor ||
      old.liquidColor != liquidColor;
}
