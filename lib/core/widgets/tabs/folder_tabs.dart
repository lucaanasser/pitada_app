// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/folder_tabs.dart
// O QUÊ:     Fita de abas-pasta empilhadas: trapézios de cantos arredondados —
//            laterais externas retas, internas anguladas — que dividem a largura
//            até um respiro antes do canto direito do card (visível e redondo).
//            Todas as abas têm a cor do corpo; as de trás descem ~3px e levam um
//            véu de sombra (plano de trás); a ativa vem à frente com a base
//            aberta, fundindo no corpo. Sombra curta nas emendas dá a profundidade.
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
const double _overlap = AppSpacing.md;

/// Recuo horizontal da lateral angulada no topo (trapézio). Usada por: pintura.
const double _slant = 9;

/// Recuo vertical (topo) das abas de trás. Usada por: [FolderTabs].
const double _drop = 3;

/// Raio de arredondamento dos cantos superiores. Usada por: pintura.
const double _round = 8;

/// Largura da aba '+' estreita. Usada por: [FolderTabs].
const double _addWidth = 46;

/// Respiro à direita até o canto do card (que aparece arredondado). Usada por: [FolderTabs].
const double _endGap = AppSpacing.xxxl;

/// Uma aba: rótulo e [onEdit] opcional (só dispara quando ativa). Usada por: [FolderTabs].
class FolderTab {
  const FolderTab({required this.label, this.onEdit});
  final String label;
  final VoidCallback? onEdit;
}

/// Fita de abas-pasta (trapézios) empilhadas: [tabs] dividem a largura e se
/// sobrepõem, [active] à frente e toque => [onSelect]; [onAdd] mostra a aba '+'.
/// [surface] é a cor de TODAS as abas e do corpo (default pit.surf).
class FolderTabs extends StatelessWidget {
  const FolderTabs({
    super.key,
    required this.tabs,
    required this.active,
    required this.onSelect,
    this.onAdd,
    this.surface,
  });

  final List<FolderTab> tabs;
  final int active;
  final ValueChanged<int> onSelect;
  final VoidCallback? onAdd;
  final Color? surface;

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
          final span = c.maxWidth - _endGap;
          final slot = (span - (hasAdd ? _addWidth : 0)) / n;
          final actR = ((act + 1) * slot + _overlap).clamp(0.0, span);
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _FolderStackPainter(
                    fill: surface ?? pit.surf,
                    line: pit.line,
                    count: n,
                    active: act,
                    hasAdd: hasAdd,
                  ),
                ),
              ),
              for (var i = 0; i < n; i++)
                if (i != act)
                  _slot(i * slot + (i == 0 ? 0 : _overlap), slot, _drop,
                      () => onSelect(i), _label(context, i, false)),
              if (hasAdd)
                _slot(n * slot + _overlap, _addWidth - _overlap, _drop, onAdd,
                    Icon(AppIcons.add, size: 16, color: pit.muted)),
              _slot(act * slot, actR - act * slot, 0, () => onSelect(act),
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
/// reta), cantos superiores arredondados e base aberta em [h]. Usada por: painter.
Path _tabPath(double l, double r, double top, double h, bool la, bool ra) {
  final bl = Offset(l, h), br = Offset(r, h);
  final tl = Offset(la ? l + _slant : l, top);
  final tr = Offset(ra ? r - _slant : r, top);
  final path = Path()..moveTo(bl.dx, bl.dy);
  _corner(path, bl, tl, tr);
  _corner(path, tl, tr, br);
  return path..lineTo(br.dx, br.dy);
}

/// Pinta as silhuetas do fundo p/ frente: '+', abas de trás (esquerda na frente,
/// mesma cor + véu de sombra) e a ativa por cima, cada uma com sombra curta na
/// emenda; recorta na fita p/ nada vazar sob o corpo. Usada por: [FolderTabs].
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

  /// Uma aba: sombra da emenda → cor do corpo → véu de sombra (se atrás) →
  /// contorno sem a base. Usada por: [paint].
  void _tab(Canvas canvas, double l, double r, double top, bool behind, bool la,
      bool ra, Paint stroke) {
    final path = _tabPath(l, r, top, folderTabsHeight + 1, la, ra);
    canvas.save();
    canvas.translate(2.5, 1);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
    );
    canvas.restore();
    canvas.drawPath(path, Paint()..color = fill);
    if (behind) {
      canvas.drawPath(
          path, Paint()..color = AppColors.shadow.withValues(alpha: 0.18));
    }
    canvas.drawPath(path, stroke);
  }

  /// Desenha '+' → abas de trás (direita p/ esquerda) → ativa levantada. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size, doAntiAlias: false);
    final span = size.width - _endGap;
    final slot = (span - (hasAdd ? _addWidth : 0)) / count;
    final stroke = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSpacing.hair;
    double right(int i) => ((i + 1) * slot + _overlap).clamp(0.0, span);
    if (hasAdd) _tab(canvas, count * slot, span, _drop, true, true, true, stroke);
    for (var i = count - 1; i >= 0; i--) {
      if (i == active) continue;
      _tab(canvas, i * slot, right(i), _drop, true, i != 0, true, stroke);
    }
    _tab(canvas, active * slot, right(active), 0, false, active != 0, true,
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
