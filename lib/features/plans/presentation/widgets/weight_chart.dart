// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/weight_chart.dart
// O QUÊ:     Gráfico de linha do peso ao longo do tempo (CustomPaint, sem lib
//            externa). Flat: linha accent + pontos, sem gradiente/sombra. y
//            auto-escala com folga; x igualmente espaçado pela ordem das pesagens.
// USA:       theme/colors, theme/pitada_colors, theme/spacing, weight_entry.
// USADO POR: WeightSection.
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: WeightChart)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/weight_entry.dart';

/// Altura fixa do gráfico de peso. Usada por: [WeightChart].
const double _kChartHeight = 150;

/// Gráfico de linha do peso. Precisa de >=2 pesagens; com menos, mostra uma dica.
/// Usada por: WeightSection.
class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.entries});

  final List<WeightEntry> entries;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    if (entries.length < 2) {
      return SizedBox(
        height: _kChartHeight,
        child: Center(
          child: Text(
            'Registre ao menos duas pesagens para ver a linha do progresso.',
            style: AppType.on(AppType.caption, pit.muted),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SizedBox(
      height: _kChartHeight,
      width: double.infinity,
      child: CustomPaint(
        painter: _WeightPainter(
          entries: entries,
          line: AppColors.accent,
          baseline: pit.line,
        ),
      ),
    );
  }
}

/// Pinta a linha + os pontos do peso, com folga vertical e baseline discreta.
/// Usada por: [WeightChart].
class _WeightPainter extends CustomPainter {
  _WeightPainter({
    required this.entries,
    required this.line,
    required this.baseline,
  });

  final List<WeightEntry> entries;
  final Color line;
  final Color baseline;

  @override
  void paint(Canvas canvas, Size size) {
    const inset = AppSpacing.md; // margem p/ os pontos não colarem na borda
    final left = inset, right = size.width - inset;
    final top = inset, bottom = size.height - inset;

    // Escala vertical com folga (10% do intervalo, mín. 0.5 kg) p/ a linha respirar.
    var minKg = entries.first.kg, maxKg = entries.first.kg;
    for (final e in entries) {
      if (e.kg < minKg) minKg = e.kg;
      if (e.kg > maxKg) maxKg = e.kg;
    }
    final span = maxKg - minKg;
    final pad = span < 0.01 ? 0.5 : span * 0.1;
    final lo = minKg - pad, hi = maxKg + pad;

    // Converte cada pesagem em ponto (x igualmente espaçado; y invertido).
    final points = <Offset>[];
    for (var i = 0; i < entries.length; i++) {
      final tx = entries.length == 1 ? 0.5 : i / (entries.length - 1);
      final ty = (entries[i].kg - lo) / (hi - lo);
      points.add(
        Offset(left + tx * (right - left), bottom - ty * (bottom - top)),
      );
    }

    // Baseline discreta no rodapé (sem grade cheia — mantém o visual limpo).
    canvas.drawLine(
      Offset(left, bottom),
      Offset(right, bottom),
      Paint()
        ..color = baseline
        ..strokeWidth = AppSpacing.hair,
    );

    // Linha do peso.
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppSpacing.borderAccent
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Pontos.
    final dot = Paint()..color = line;
    for (final p in points) {
      canvas.drawCircle(p, 3, dot);
    }
  }

  @override
  bool shouldRepaint(_WeightPainter old) =>
      old.entries != entries || old.line != line || old.baseline != baseline;
}
