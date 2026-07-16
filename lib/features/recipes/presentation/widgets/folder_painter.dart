// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder_painter.dart
// O QUÊ:     Pintura do card de pasta: fundo com aba (curva S suave), papéis
//            off-white em pilha saindo da pasta e bolso frontal com sombra
//            pequena (profundidade funcional — exceção pontual ao flat).
// USA:       core/theme (AppSpacing p/ raios e traço; cores vêm prontas do card).
// USADO POR: folder_card (CustomPaint).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';

/// Posições dos papéis por quantidade (esqFrac, topoFrac, ângulo rad).
/// Menos receitas = menos papéis; teto 3 para não ficar lotado.
/// Usada por: [FolderPainter.paint].
const _paperLayouts = <List<(double, double, double)>>[
  [],
  [(.28, .12, -.03)],
  [(.11, .11, -.08), (.43, .08, .07)],
  [(.06, .11, -.10), (.46, .07, .09), (.24, .15, -.02)],
];

/// Pinta a pasta inteira: fundo + papéis + bolso — SEM contorno (referência é
/// limpa; a separação vem da cor e da sombra pequena). O último papel da pilha
/// é o mais claro; [lift] sobe os papéis no press (0..6 px).
/// Usada por: FolderCard.
class FolderPainter extends CustomPainter {
  const FolderPainter({
    required this.pastel,
    required this.paper,
    required this.paperBack,
    required this.paperLine,
    required this.shadow,
    required this.count,
    this.lift = 0,
  });

  final Color pastel;
  final Color paper;
  final Color paperBack;
  final Color paperLine;
  final Color shadow;
  final int count;
  final double lift;

  /// Desenha fundo → papéis → bolso, nessa ordem. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final back = _backPath(w, h, 0);
    canvas.drawPath(back, Paint()..color = pastel);

    for (final (j, spec) in _paperLayouts[count.clamp(0, 3)].indexed) {
      final isFront = j == _paperLayouts[count.clamp(0, 3)].length - 1;
      _paper(canvas, size, spec, isFront);
    }

    final pocket = RRect.fromLTRBAndCorners(
      0,
      h * 0.50,
      w,
      h,
      bottomLeft: const Radius.circular(AppSpacing.radiusCard),
      bottomRight: const Radius.circular(AppSpacing.radiusCard),
    );
    canvas.save();
    canvas.translate(0, -2.5);
    canvas.drawRRect(
      pocket,
      Paint()
        ..color = shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.restore();
    canvas.drawRRect(pocket, Paint()..color = pastel);
  }

  /// Silhueta do fundo: aba no topo-esquerdo com curva S + corpo de cantos
  /// generosos (radiusCard, a cara do app). Usada por: [paint].
  Path _backPath(double w, double h, double i) {
    final tabW = w * 0.36;
    const tabH = 22.0;
    const s = 14.0;
    const rTab = AppSpacing.radiusMd;
    const rBody = AppSpacing.radiusCard;
    return Path()
      ..moveTo(i, h - i - rBody)
      ..lineTo(i, i + rTab)
      ..arcToPoint(Offset(i + rTab, i), radius: const Radius.circular(rTab))
      ..lineTo(i + tabW - s, i)
      ..cubicTo(i + tabW, i, i + tabW, i + tabH, i + tabW + s, i + tabH)
      ..lineTo(w - i - rBody, i + tabH)
      ..arcToPoint(
        Offset(w - i, i + tabH + rBody),
        radius: const Radius.circular(rBody),
      )
      ..lineTo(w - i, h - i - rBody)
      ..arcToPoint(
        Offset(w - i - rBody, h - i),
        radius: const Radius.circular(rBody),
      )
      ..lineTo(i + rBody, h - i)
      ..arcToPoint(
        Offset(i, h - i - rBody),
        radius: const Radius.circular(rBody),
      )
      ..close();
  }

  /// Um papel da pilha: folha off-white grande, levemente girada, com sombra
  /// curta e 2 "linhas de texto" — parece sair de dentro da pasta.
  /// Usada por: [paint].
  void _paper(
    Canvas canvas,
    Size size,
    (double, double, double) spec,
    bool isFront,
  ) {
    final (leftFrac, topFrac, angle) = spec;
    final pw = size.width * 0.50, ph = size.height * 0.55;
    canvas.save();
    canvas.translate(
      size.width * leftFrac + pw / 2,
      size.height * topFrac + ph / 2 - lift,
    );
    canvas.rotate(angle);
    final rect = Rect.fromCenter(center: Offset.zero, width: pw, height: ph);
    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(AppSpacing.radiusMd),
    );
    canvas.drawShadow(Path()..addRRect(rrect), shadow, 3, false);
    canvas.drawRRect(rrect, Paint()..color = isFront ? paper : paperBack);
    for (final (k, lineW) in [pw * .52, pw * .36].indexed) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            rect.left + AppSpacing.md,
            rect.top + AppSpacing.md + k * 9,
            lineW,
            3.5,
          ),
          const Radius.circular(AppSpacing.radiusPill),
        ),
        Paint()..color = paperLine,
      );
    }
    canvas.restore();
  }

  /// Repinta quando cor, contagem ou elevação mudarem. Usada por: framework.
  @override
  bool shouldRepaint(FolderPainter old) =>
      old.pastel != pastel || old.count != count || old.lift != lift;
}
