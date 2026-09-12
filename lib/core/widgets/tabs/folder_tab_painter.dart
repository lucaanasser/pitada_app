// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/folder_tab_painter.dart  (part de folder_tabs.dart)
// O QUÊ:     Pintura das silhuetas da fita de abas-pasta: trapézio de cantos
//            arredondados com filete côncavo na base (a lateral deságua na base
//            sem quina), sombra curta na emenda, véu nas abas de trás e o
//            preenchimento da ativa sobrepintando o corpo (emenda sem linha).
// USA:       tokens já importados por folder_tabs.dart (AppColors, AppSpacing).
// USADO POR: FolderTabs (CustomPaint).
// ─────────────────────────────────────────────────────────────────────────────
part of 'folder_tabs.dart';

/// Arredonda o canto [c] (vindo de [a], indo a [b]) com uma bézier. Usada por: [_tabPath].
void _corner(Path path, Offset a, Offset c, Offset b) {
  Offset at(Offset o) {
    final v = o - c;
    return c + v * (v.distance <= _round ? 0.5 : _round / v.distance);
  }

  final p1 = at(a), p2 = at(b);
  path
    ..lineTo(p1.dx, p1.dy)
    ..quadraticBezierTo(c.dx, c.dy, p2.dx, p2.dy);
}

/// Silhueta de uma aba: trapézio com lateral angulada quando [la]/[ra] (senão
/// reta), cantos superiores arredondados e, nas laterais anguladas, um filete
/// côncavo desaguando na base [h] (aberta). Usada por: [_FolderStackPainter].
Path _tabPath(double l, double r, double top, double h, bool la, bool ra) {
  final t = _fillet / (h - top);
  final path = Path()..moveTo(la ? l - _fillet : l, h);
  if (la) path.quadraticBezierTo(l, h, l + _slant * t, h - _fillet);
  final bl = Offset(l, h), br = Offset(r, h);
  final tl = Offset(la ? l + _slant : l, top);
  final tr = Offset(ra ? r - _slant : r, top);
  _corner(path, bl, tl, tr);
  _corner(path, tl, tr, br);
  if (ra) {
    path
      ..lineTo(r - _slant * t, h - _fillet)
      ..quadraticBezierTo(r, h, r + _fillet, h);
  } else {
    path.lineTo(r, h);
  }
  return path;
}

/// Pinta as silhuetas do fundo p/ frente: '+', abas de trás (esquerda na frente,
/// mesma cor + véu de sombra + contorno) e a ativa por cima, sem contorno e com
/// o preenchimento vazando 1.5px sob o corpo (emenda contínua). Usada por: [FolderTabs].
class _FolderStackPainter extends CustomPainter {
  const _FolderStackPainter({
    required this.fill,
    required this.line,
    required this.count,
    required this.active,
    required this.hasAdd,
  });

  final Color fill, line;
  final int count, active;
  final bool hasAdd;

  /// Uma aba: sombra da emenda (recortada na fita) → cor do corpo (sem recorte,
  /// emenda no corpo) → véu + contorno se de trás. Usada por: [paint].
  void _tab(Canvas canvas, Size size, double l, double r, double top,
      bool front, bool la, bool ra, Paint stroke) {
    final path = _tabPath(l, r, top, folderTabsHeight + 1.5, la, ra);
    final strip = Offset.zero & size;
    canvas.save();
    canvas.clipRect(strip, doAntiAlias: false);
    canvas.save();
    canvas.translate(2.5, 1);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
    );
    canvas.restore();
    canvas.restore();
    canvas.drawPath(path, Paint()..color = fill);
    if (!front) {
      canvas.save();
      canvas.clipRect(strip, doAntiAlias: false);
      canvas.drawPath(
          path, Paint()..color = AppColors.shadow.withValues(alpha: 0.18));
      canvas.drawPath(path, stroke);
      canvas.restore();
    }
  }

  /// Desenha '+' → abas de trás (direita p/ esquerda) → ativa levantada. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final span = size.width - _endGap;
    final slot = (span - (hasAdd ? _addWidth : 0)) / count;
    final stroke = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.hair;
    double right(int i) => ((i + 1) * slot + _overlap).clamp(0.0, span);
    if (hasAdd) {
      _tab(canvas, size, count * slot, span, _drop, false, true, true, stroke);
    }
    for (var i = count - 1; i >= 0; i--) {
      if (i == active) continue;
      _tab(canvas, size, i * slot, right(i), _drop, false, i != 0, true, stroke);
    }
    _tab(canvas, size, active * slot, right(active), 0, true, active != 0, true,
        stroke);
  }

  /// Repinta quando cor, contagem ou aba ativa mudarem. Usada por: framework.
  @override
  bool shouldRepaint(_FolderStackPainter o) =>
      o.fill != fill ||
      o.line != line ||
      o.count != count ||
      o.active != active ||
      o.hasAdd != hasAdd;
}
