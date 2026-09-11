// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/meal/macro_ring_painter.dart
// O QUÊ:     Anéis concêntricos de macro (CustomPaint, sem lib externa). Arco
//            sempre em cor cheia sobre trilho NEUTRO; o anel selecionado ganha
//            traço mais grosso e trilho mais visível. Flat: sem sombra/gradiente.
// USA:       material (Canvas), dart:math (arco).
// USADO POR: DaySummaryView (resumo do dia como anel de macros).
// SPEC:      specs/features/plans/plans.yaml (widgets_da_feature: MacroRingPainter)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Dado de um anel: rótulo, valor atual, meta, cor e unidade. Imutável.
/// Usada por: DaySummaryView (monta a lista) e MacroRingPainter (pinta).
class MacroRing {
  final String label;
  final num value;
  final num goal;
  final Color color;
  final String unit;

  const MacroRing({
    required this.label,
    required this.value,
    required this.goal,
    required this.color,
    required this.unit,
  });

  /// Fração preenchida (0..1), limitada em 1. Usada por: MacroRingPainter e o centro.
  double get fraction =>
      goal <= 0 ? 0 : (value / goal).clamp(0.0, 1.0).toDouble();
}

/// Pinta anéis concêntricos (índice 0 = mais externo) com arco em cor cheia
/// sobre trilho neutro: [track] no anel [selected] (traço mais grosso), [trackDim]
/// nos demais (traço mais fino). A geometria (traço, raio, furo) é estática p/
/// o toque e o centro reusarem. Usada por: DaySummaryView.
class MacroRingPainter extends CustomPainter {
  MacroRingPainter({
    required this.rings,
    required this.selected,
    required this.track,
    required this.trackDim,
  });

  final List<MacroRing> rings;
  final int selected;
  final Color track;
  final Color trackDim;

  static const double _strokeF = 0.045;
  static const double _gapF = 0.026;
  static const double _selExtra = 3;
  static const double _dimF = 0.78;

  /// Espessura base do traço (px) para um quadrado de lado [side]. Usada por: paint, ringAtOffset.
  static double strokeOf(double side) => side * _strokeF;

  /// Raio do anel [i] (0 = externo) num quadrado de lado [side]. Fonte única da
  /// geometria — pintura e detecção de toque partem daqui. Usada por: paint, ringAtOffset.
  static double radiusOf(double side, int i) {
    final stroke = strokeOf(side);
    final outer = side / 2 - (stroke + _selExtra) / 2;
    return outer - i * (stroke + side * _gapF);
  }

  /// Raio do furo central livre de anéis num quadrado de lado [side] — limite
  /// do conteúdo do centro (nada pode vazar). Usada por: DaySummaryView.
  static double holeRadius(double side, int count) =>
      radiusOf(side, count - 1) - (strokeOf(side) + _selExtra) / 2 - 2;

  /// Índice do anel sob o ponto [p] num quadrado de lado [side] (ou null se o
  /// toque cair fora das faixas). Usada por: DaySummaryView (tocar no anel seleciona).
  static int? ringAtOffset(Offset p, double side, int count) {
    final center = Offset(side / 2, side / 2);
    final d = (p - center).distance;
    final tol = strokeOf(side) / 2 + side * _gapF / 2;
    var best = -1;
    var bestDelta = double.infinity;
    for (var i = 0; i < count; i++) {
      final delta = (d - radiusOf(side, i)).abs();
      if (delta < bestDelta) {
        bestDelta = delta;
        best = i;
      }
    }
    return bestDelta <= tol ? best : null;
  }

  /// Pinta trilho neutro + arco cheio de cada anel, do externo ao interno.
  /// Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final center = size.center(Offset.zero);
    final stroke = strokeOf(side);
    for (var i = 0; i < rings.length; i++) {
      final ring = rings[i];
      final sel = i == selected;
      final r = radiusOf(side, i);
      final w = sel ? stroke + _selExtra : stroke * _dimF;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = w
          ..color = sel ? track : trackDim,
      );
      if (ring.fraction <= 0) continue;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        -math.pi / 2,
        2 * math.pi * ring.fraction,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = w
          ..color = ring.color,
      );
    }
  }

  @override
  bool shouldRepaint(MacroRingPainter old) =>
      old.selected != selected ||
      old.rings != rings ||
      old.track != track ||
      old.trackDim != trackDim;
}
