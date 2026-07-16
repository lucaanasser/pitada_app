// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_view_toggle.dart
// O QUÊ:     Alternador de layout da lista (card grande / 2 colunas / lista).
//            Sem moldura: uma "gota" accent desliza sob o ícone ativo, espichando
//            no caminho e assentando com springzinho (efeito molenga/líquido).
// USA:       core/theme (AppIcons, AppColors, PitadaColors), recipe_view_provider.
// USADO POR: recipes_screen (cabeçalho da lista).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: alternador de layout)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../application/recipe_view_provider.dart';

/// Três ícones (single/grid/list) sem moldura; uma gota accent molenga escorrega
/// sob o ativo. Usada por: recipes_screen.
class RecipeViewToggle extends StatefulWidget {
  const RecipeViewToggle({
    super.key,
    required this.value,
    required this.onSelect,
  });

  final RecipeView value;
  final ValueChanged<RecipeView> onSelect;

  @override
  State<RecipeViewToggle> createState() => _RecipeViewToggleState();
}

class _RecipeViewToggleState extends State<RecipeViewToggle>
    with SingleTickerProviderStateMixin {
  /// Opções na ordem em que aparecem (índice casa com o alinhamento da gota).
  static const _opts = [RecipeView.single, RecipeView.grid, RecipeView.list];
  static const double _cellW = 38;
  static const double _cellH = 30;
  static const Duration _duration = Duration(milliseconds: 420);
  static const Curve _slide = Curves.easeOutBack;

  late final AnimationController _c;
  late double _fromX;
  late double _toX;

  /// Alinhamento horizontal (-1, 0, 1) que mira o centro da célula de [v].
  double _xFor(RecipeView v) => _opts.indexOf(v).toDouble() - 1;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: _duration, value: 1);
    _fromX = _toX = _xFor(widget.value);
  }

  /// Ao trocar de aba, parte da posição ATUAL (mesmo em pleno voo) rumo à nova
  /// e reinicia a animação — sem pulo se o usuário troca rápido.
  @override
  void didUpdateWidget(RecipeViewToggle old) {
    super.didUpdateWidget(old);
    if (old.value == widget.value) return;
    _fromX = _currentX();
    _toX = _xFor(widget.value);
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  /// Posição interpolada agora, seguindo a curva-mola. Usada por: [didUpdateWidget].
  double _currentX() => _fromX + (_toX - _fromX) * _slide.transform(_c.value);

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return SizedBox(
      width: _cellW * _opts.length,
      height: _cellH,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(animation: _c, builder: (_, __) => _drop()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final v in _opts) _btn(pit, _iconFor(v), v),
            ],
          ),
        ],
      ),
    );
  }

  /// A gota: escorrega (easeOutBack) e, no meio do trajeto, estica na horizontal
  /// e achata na vertical (squash-stretch), voltando a redonda ao assentar.
  /// Usada por: [build].
  Widget _drop() {
    final t = _c.value;
    final x = _fromX + (_toX - _fromX) * _slide.transform(t);
    final moving = (_toX - _fromX).abs() > 0.001;
    final pulse = moving ? math.sin(math.pi * t) : 0.0;
    return Align(
      alignment: Alignment(x, 0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scaleByDouble(1 + 0.24 * pulse, 1 - 0.13 * pulse, 1, 1),
        child: Container(
          width: _cellW,
          height: _cellH,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: AppSpacing.br(AppSpacing.radiusPill),
          ),
        ),
      ),
    );
  }

  /// Ícone tocável; a cor anima de muted p/ accent em sincronia com a gota.
  /// Usada por: [build].
  Widget _btn(PitadaColors pit, IconData icon, RecipeView v) {
    final active = v == widget.value;
    return GestureDetector(
      onTap: () => widget.onSelect(v),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _cellW,
        height: _cellH,
        child: TweenAnimationBuilder<Color?>(
          duration: _duration,
          curve: Curves.easeOut,
          tween: ColorTween(end: active ? AppColors.accent : pit.muted),
          builder: (_, color, __) => Icon(icon, size: 17, color: color),
        ),
      ),
    );
  }

  /// Ícone de cada modo de exibição. Usada por: [build].
  IconData _iconFor(RecipeView v) => switch (v) {
        RecipeView.single => AppIcons.viewSingle,
        RecipeView.grid => AppIcons.viewGrid,
        RecipeView.list => AppIcons.viewList,
      };
}
