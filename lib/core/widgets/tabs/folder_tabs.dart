// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/folder_tabs.dart
// O QUÊ:     Fita de abas-pasta empilhadas: trapézios de cantos arredondados —
//            laterais externas retas, internas anguladas — que dividem a largura
//            até um respiro antes do canto direito do card (visível e redondo).
//            Todas as abas têm a cor do corpo; as de trás descem ~3px e levam um
//            véu de sombra (plano de trás); a ativa vem à frente e deságua no
//            corpo por um filete côncavo na base, sem linha nem quina.
// USA:       theme/* (tokens, AppColors.shadow), core/widgets (Editable);
//            folder_tab_painter.dart (part) pinta as silhuetas.
// USADO POR: MealOptionTabs (cardápio), CartTabBar (compras).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import '../controls/editable.dart';

part 'folder_tab_painter.dart';

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

/// Raio do filete côncavo onde a lateral deságua na base. Usada por: pintura.
const double _fillet = 6;

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
            clipBehavior: Clip.none,
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
                _slot(n * slot, _addWidth, _drop, onAdd,
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
