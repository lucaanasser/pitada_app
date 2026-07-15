// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/paper_fly.dart
// O QUÊ:     Peças da animação da pasta aberta: PaperFly (papel que voa da boca
//            da pasta até seu slot na grade, e volta no reverse), FolderMotion
//            (coreografia: intervalos de ida/volta e vetor slot→boca) e
//            BottomOpenClipper (recorte aberto embaixo para o papel em voo
//            passar por trás da faixa da pasta).
// USA:       flutter/widgets (Transform, Opacity, CurvedAnimation),
//            core/theme/spacing (medidas da grade p/ o vetor de voo).
// USADO POR: folder_screen (grade de papéis animada pela rota).
// SPEC:      specs/features/recipes.yaml (FolderScreen.animacao)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../../core/theme/spacing.dart';

/// Papel saindo da pasta: parte da boca da faixa ([delta]), levemente girado
/// ([angle]) e menor, e chega reto no seu slot da grade; quando [animation]
/// reverte (pop da rota), volta para dentro pelo trecho [reverseInterval].
/// Usada por: FolderScreen (grade).
class PaperFly extends StatelessWidget {
  const PaperFly({
    super.key,
    required this.animation,
    required this.interval,
    required this.reverseInterval,
    required this.delta,
    required this.angle,
    required this.child,
  });

  final Animation<double> animation;
  final Interval interval; // trecho da rota no abrir (forward)
  final Interval reverseInterval; // trecho da rota no fechar (reverse)
  final Offset delta; // slot → boca da pasta
  final double angle; // torto dentro da pasta, reto na grade

  final Widget child;

  /// Interpola posição/rotação/escala pelo trecho ativo. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: interval,
      reverseCurve: reverseInterval,
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        final v = curved.value;
        return Opacity(
          // Gate curto (primeiros ~12%): evita pop de 1 frame perto da boca.
          // A oclusão real é a faixa da pasta, sempre sólida (ver FolderScreen).
          opacity: (v * 8).clamp(0, 1).toDouble(),
          child: Transform.translate(
            offset: delta * (1 - v),
            child: Transform.rotate(
              angle: angle * (1 - v),
              child: Transform.scale(scale: 0.72 + 0.28 * v, child: child),
            ),
          ),
        );
      },
    );
  }
}

/// Coreografia da pasta aberta: em que trecho da rota cada papel voa (ida e
/// volta) e qual o vetor do slot até a boca da pasta. Centraliza os números
/// para a tela só compor. Usada por: FolderScreen.
class FolderMotion {
  const FolderMotion._();

  /// Proporção do RecipeCard compacto na grade (largura/altura).
  static const cardAspect = 0.72;

  /// Abrir: papel [i] sai DEPOIS da faixa assentar (12%) e escalonado por
  /// índice — quanto mais fundo na pasta, mais tarde ele sai.
  /// Usada por: FolderScreen._grid.
  static Interval flyOut(int i) {
    final start = 0.12 + math.min(i * 0.045, 0.3);
    return Interval(
      start,
      math.min(start + 0.5, 1),
      curve: Curves.easeOutCubic,
    );
  }

  /// Fechar (t 1→0): mais fundo volta primeiro; todos dentro até 15% da rota,
  /// deixando o final só para a faixa deslizar p/ baixo. easeOutCubic lido ao
  /// contrário = papel deixa o slot devagar e ACELERA mergulhando na boca.
  /// Usada por: FolderScreen._grid.
  static Interval flyBack(int i) {
    final end = math.min(0.6 + i * 0.05, 0.95);
    return Interval(
      math.max(end - 0.45, 0.15),
      end,
      curve: Curves.easeOutCubic,
    );
  }

  /// Vetor do slot do papel [i] até a boca da pasta (rodapé, centro) — o
  /// trajeto do voo. Fundo o bastante para o papel sumir atrás da faixa.
  /// Usada por: FolderScreen._grid.
  static Offset delta(int i, Size area) {
    const gap = AppSpacing.md;
    final cw = (area.width - 2 * AppSpacing.gutter - gap) / 2;
    final ch = cw / cardAspect;
    final col = i % 2, row = i ~/ 2;
    final slot = Offset(
      AppSpacing.gutter + cw / 2 + col * (cw + gap),
      AppSpacing.md + ch / 2 + row * (ch + gap),
    );
    final mouth = Offset(area.width / 2, area.height + ch * 0.55);
    return mouth - slot;
  }
}

/// Recorte aberto embaixo: corta o conteúdo no topo (scroll limpo) mas deixa
/// os papéis em voo aparecerem abaixo da grade, atrás da faixa da pasta.
/// Usada por: FolderScreen (ClipRect da grade).
class BottomOpenClipper extends CustomClipper<Rect> {
  const BottomOpenClipper();

  /// Estende o recorte bem além da base da grade. Usada por: framework.
  @override
  Rect getClip(Size size) => Rect.fromLTRB(0, 0, size.width, size.height + 600);

  /// O recorte é fixo. Usada por: framework.
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
