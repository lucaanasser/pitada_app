// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/tabs/pitada_tabs.dart
// O QUÊ:     Abas de texto reutilizáveis do app (fonte única). O sublinhado
//            terracota desliza entre as abas, ajusta a largura à palavra ativa e
//            estica bem de leve no meio do trajeto (molejo sutil). Substitui
//            ChapterTabs e SegTabs — todas as telas usam este widget.
// USA:       theme/colors (accent), theme/pitada_colors (context.pit),
//            theme/spacing, theme/typography.
// USADO POR: recipes_screen, groceries_screen, plans_screen, lesson_cards_screen.
// SPEC:      specs/components/tabs/pitada_tabs.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Abas de texto roláveis: [selected] em cor text, demais em muted; um único
/// sublinhado accent desliza (com molejo leve) e cobre exatamente a palavra ativa.
/// Usada por: recipes/groceries/notebook/plans — toda aba de nível de tela.
class PitadaTabs extends StatefulWidget {
  const PitadaTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelect,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  State<PitadaTabs> createState() => _PitadaTabsState();
}

class _PitadaTabsState extends State<PitadaTabs>
    with SingleTickerProviderStateMixin {
  /// Espaço entre uma aba e a seguinte (também separa os sublinhados).
  static const double _gap = AppSpacing.xxl;
  static const Duration _duration = Duration(milliseconds: 360);
  static const Curve _curve = Curves.easeOutCubic;
  static const double _stretch = 10;

  late final AnimationController _c;
  List<double> _lefts = const [];
  List<double> _widths = const [];
  double _fromLeft = 0;
  double _fromWidth = 0;
  late int _toIndex;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: _duration, value: 1);
    _toIndex = widget.selected;
  }

  /// Ao trocar de aba, parte da geometria ATUAL (mesmo em pleno voo) rumo à nova.
  @override
  void didUpdateWidget(PitadaTabs old) {
    super.didUpdateWidget(old);
    if (old.selected == widget.selected) return;
    if (_lefts.isNotEmpty) {
      final t = _curve.transform(_c.value);
      final i = _toIndex.clamp(0, _lefts.length - 1);
      _fromLeft = _lerp(_fromLeft, _lefts[i], t);
      _fromWidth = _lerp(_fromWidth, _widths[i], t);
    }
    _toIndex = widget.selected;
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  /// Mede a largura do rótulo no estilo real (peso/tamanho iguais em ativo e
  /// inativo — só a cor muda). Usada por: [build] para dimensionar o sublinhado.
  double _measure(String label, TextScaler scaler, TextDirection dir) {
    final tp = TextPainter(
      text: TextSpan(text: label, style: AppType.titleSm),
      textDirection: dir,
      textScaler: scaler,
      maxLines: 1,
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final scaler = MediaQuery.textScalerOf(context);
    final dir = Directionality.of(context);
    final widths = [for (final t in widget.tabs) _measure(t, scaler, dir)];
    final lefts = <double>[];
    var x = 0.0;
    for (final w in widths) {
      lefts.add(x);
      x += w + _gap;
    }
    _widths = widths;
    _lefts = lefts;
    final toIndex = _toIndex.clamp(0, widths.length - 1);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xs,
        AppSpacing.gutter,
        AppSpacing.sm,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              for (var i = 0; i < widget.tabs.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    right: i == widget.tabs.length - 1 ? 0 : _gap,
                  ),
                  child: _label(pit, i),
                ),
            ],
          ),
          AnimatedBuilder(
            animation: _c,
            builder: (_, __) => _underline(toIndex),
          ),
        ],
      ),
    );
  }

  /// Sublinhado único que desliza até a aba de destino e a cobre, com molejo
  /// sutil. Usada por: [build].
  Widget _underline(int toIndex) {
    final t = _curve.transform(_c.value);
    final left = _lerp(_fromLeft, _lefts[toIndex], t);
    final width = _lerp(_fromWidth, _widths[toIndex], t);
    final moving = (_lefts[toIndex] - _fromLeft).abs() > 0.5 ||
        (_widths[toIndex] - _fromWidth).abs() > 0.5;
    final p = _c.value;
    final ext = moving ? _stretch * math.sin(2 * math.pi * p) * (1 - p) : 0.0;
    return Positioned(
      bottom: 0,
      left: left - ext / 2,
      width: width + ext,
      height: AppSpacing.borderAccent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: AppSpacing.br(AppSpacing.borderAccent),
        ),
      ),
    );
  }

  /// Rótulo tocável de uma aba, com cor animada (text/muted) e espaço embaixo
  /// para o sublinhado. Usada por: [build].
  Widget _label(PitadaColors pit, int i) {
    return GestureDetector(
      onTap: () => widget.onSelect(i),
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        selected: i == widget.selected,
        child: AnimatedDefaultTextStyle(
          duration: _duration,
          curve: _curve,
          style: AppType.on(
            AppType.titleSm,
            i == widget.selected ? pit.text : pit.muted,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.sm + AppSpacing.borderAccent,
            ),
            child: Text(widget.tabs[i]),
          ),
        ),
      ),
    );
  }
}
