// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/folder_tabs.dart
// O QUÊ:     Fita de abas-pasta empilhadas: trapézios de cantos arredondados —
//            laterais EXTERNAS retas, INTERNAS anguladas — que dividem a largura
//            e se sobrepõem (esquerda na frente). Inativas recuadas (recess) e a
//            ativa à frente (surface, base funde no corpo). Sombra pequena na
//            sobreposição p/ profundidade — exceção pontual ao flat, como a pasta.
// USA:       theme/* (tokens, AppColors.shadow), core/widgets (Editable).
// USADO POR: MealOptionTabs (cardápio), CartTabBar (compras).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import '../controls/editable.dart';

/// Altura fixa da fita de abas-pasta. Usada por: quem encosta o corpo abaixo.
const double folderTabsHeight = 40;

/// Quanto cada aba encobre a vizinha da direita. Usada por: [FolderTabs].
const double _overlap = AppSpacing.xl;

/// Recuo horizontal da lateral angulada no topo (trapézio). Usada por: pintura.
const double _slant = 9;

/// Recuo vertical (topo) das abas inativas. Usada por: [FolderTabs].
const double _drop = 3;

/// Raio de arredondamento dos cantos superiores. Usada por: pintura.
const double _round = 8;

/// Largura da aba '+' estreita. Usada por: [FolderTabs].
const double _addWidth = 46;

/// Uma aba: rótulo e [onEdit] opcional (só dispara quando ativa). Usada por: [FolderTabs].
class FolderTab {
  const FolderTab({required this.label, this.onEdit});
  final String label;
  final VoidCallback? onEdit;
}

/// Fita de abas-pasta (trapézios) empilhadas: [tabs] dividem a largura e se
/// sobrepõem, [active] à frente e toque => [onSelect]; [onAdd] mostra a aba '+'.
/// [surface] é a cor da ativa/corpo (default pit.surf); [recess] o tom das
/// inativas (default pit.bg).
class FolderTabs extends StatelessWidget {
  const FolderTabs({
    super.key,
    required this.tabs,
    required this.active,
    required this.onSelect,
    this.onAdd,
    this.surface,
    this.recess,
  });

  final List<FolderTab> tabs;
  final int active;
  final ValueChanged<int> onSelect;
  final VoidCallback? onAdd;
  final Color? surface;
  final Color? recess;

  /// Empilha a pintura das silhuetas (na ordem de profundidade) sob os rótulos
  /// toca-veis, posicionados aba a aba. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final n = tabs.length;
    if (n == 0) return const SizedBox(height: folderTabsHeight);
    final hasAdd = onAdd != null;
    final act = active.clamp(0, n - 1);
    return SizedBox(
      height: folderTabsHeight,
      child: LayoutBuilder(
        builder: (context, c) {
          final slot = (c.maxWidth - (hasAdd ? _addWidth : 0)) / n;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _FolderStackPainter(
                    fill: surface ?? pit.surf,
                    recess: recess ?? pit.bg,
                    line: pit.line,
                    count: n,
                    active: act,
                    hasAdd: hasAdd,
                  ),
                ),
              ),
              for (var i = 0; i < n; i++)
                if (i != act)
                  _slot(i * slot, slot, _drop, () => onSelect(i),
                      _label(context, i, false)),
              if (hasAdd)
                _slot(n * slot, _addWidth, _drop, onAdd,
                    Icon(AppIcons.add, size: 16, color: pit.muted)),
              _slot(act * slot, slot, 0, () => onSelect(act),
                  _label(context, act, true)),
            ],
          );
        },
      ),
    );
  }

  /// Fatia posicionada e toca-vel, recuada por [top], centralizando [child]. Usada por: [build].
  Widget _slot(double left, double width, double top, VoidCallback? onTap,
      Widget child) {
    return Positioned(
      left: left,
      width: width,
      top: top,
      height: folderTabsHeight - top,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: child,
        ),
      ),
    );
  }

  /// Rótulo da aba [i]: pit.text quando ativa (editável se houver onEdit), muted
  /// quando não. Usada por: [build].
  Widget _label(BuildContext context, int i, bool on) {
    final pit = context.pit;
    return Editable(
      onEdit: on ? tabs[i].onEdit : null,
      child: Text(
        tabs[i].label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppType.on(AppType.titleXs, on ? pit.text : pit.muted),
      ),
    );
  }
}

/// Ponto a distância [_round] de [a] rumo a [b] (arredonda cantos). Usada por: [_corner].
Offset _toward(Offset a, Offset b) {
  final v = b - a;
  final len = v.distance;
  final t = len <= _round ? 0.5 : _round / len;
  return Offset(a.dx + v.dx * t, a.dy + v.dy * t);
}

/// Arredonda o canto [corner] (entre [from] e [to]) com uma bézier. Usada por: [_tabPath].
void _corner(Path path, Offset from, Offset corner, Offset to) {
  final p1 = _toward(corner, from), p2 = _toward(corner, to);
  path
    ..lineTo(p1.dx, p1.dy)
    ..quadraticBezierTo(corner.dx, corner.dy, p2.dx, p2.dy);
}

/// Silhueta de uma aba: trapézio com lateral angulada quando [la]/[ra] (senão
/// reta, borda externa), cantos superiores arredondados e base aberta (fecha só
/// no preenchimento). Usada por: [_FolderStackPainter].
Path _tabPath(double l, double r, double top, double h, bool la, bool ra) {
  final bl = Offset(l, h), br = Offset(r, h);
  final tl = Offset(la ? l + _slant : l, top);
  final tr = Offset(ra ? r - _slant : r, top);
  final path = Path()..moveTo(bl.dx, bl.dy);
  _corner(path, bl, tl, tr);
  _corner(path, tl, tr, br);
  return path..lineTo(br.dx, br.dy);
}

/// Pinta as silhuetas do fundo p/ frente: '+', inativas (esquerda na frente) e a
/// ativa por cima, cada uma com uma sombra curta na sobreposição. Usada por: [FolderTabs].
class _FolderStackPainter extends CustomPainter {
  const _FolderStackPainter({
    required this.fill,
    required this.recess,
    required this.line,
    required this.count,
    required this.active,
    required this.hasAdd,
  });

  final Color fill, recess, line;
  final int count, active;
  final bool hasAdd;

  /// Desenha uma aba: sombra curta deslocada p/ a direita → preenchimento opaco →
  /// contorno (sem a base). Usada por: [paint].
  void _tab(Canvas canvas, double l, double r, double top, Color color, bool la,
      bool ra, Paint stroke) {
    final path = _tabPath(l, r, top, folderTabsHeight, la, ra);
    canvas.save();
    canvas.translate(2, 1);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.restore();
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(path, stroke);
  }

  /// Desenha '+' → inativas (direita p/ esquerda) → ativa levantada — recortando
  /// na altura da fita p/ a sombra não vazar sob o corpo. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final w = size.width;
    final slot = (w - (hasAdd ? _addWidth : 0)) / count;
    final stroke = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.hair;
    final cap = hasAdd ? count * slot : w;
    double right(int i) {
      final base = (i + 1) * slot + _overlap;
      return base < cap ? base : cap;
    }

    bool ra(int i) => i != count - 1 || hasAdd;
    if (hasAdd) {
      _tab(canvas, count * slot, w, _drop, recess, true, false, stroke);
    }
    for (var i = count - 1; i >= 0; i--) {
      if (i == active) continue;
      _tab(canvas, i * slot, right(i), _drop, recess, i != 0, ra(i), stroke);
    }
    _tab(canvas, active * slot, right(active), 0, fill, active != 0, ra(active),
        stroke);
  }

  /// Repinta quando cor, contagem ou aba ativa mudarem. Usada por: framework.
  @override
  bool shouldRepaint(_FolderStackPainter o) =>
      o.fill != fill ||
      o.recess != recess ||
      o.line != line ||
      o.count != count ||
      o.active != active ||
      o.hasAdd != hasAdd;
}
