// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/app_shell.dart
// O QUÊ:     Casca de navegação com as 5 abas (mantém o estado de cada aba).
//            Fundo tingido com o pastel da aba atual — o dock flutua sem emenda.
//            Ao trocar de aba, o conteúdo entra deslizando (direção conforme a
//            posição relativa da aba) via _SlideTabView.
// USA:       go_router (StatefulNavigationShell), core/theme/app_icons,
//            core/theme/pitada_colors (pit.tabBg), core/widgets/pitada_tab_bar.
// USADO POR: core/router/router.dart (StatefulShellRoute).
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_icons.dart';
import '../theme/pitada_colors.dart';
import '../widgets/pitada_tab_bar.dart';

/// As 5 abas do app, na ordem da barra inferior. Ícone regular (inativo) + fill
/// (ativo). Perfil substitui a antiga aba Home (comunidade, abandonada).
const kPitadaTabs = <PitadaTab>[
  PitadaTab(AppIcons.recipes, AppIcons.recipesFill, 'Receitas'),
  PitadaTab(AppIcons.learning, AppIcons.learningFill, 'Caderno'),
  PitadaTab(AppIcons.plans, AppIcons.plansFill, 'Plano'),
  PitadaTab(AppIcons.ingredients, AppIcons.ingredientsFill, 'Ingredientes'),
  PitadaTab(AppIcons.profile, AppIcons.profileFill, 'Perfil'),
];

/// Envolve as abas: mostra o conteúdo da aba atual + o dock flutuante.
/// Usada por: router.dart. [shell] é fornecido pelo StatefulShellRoute.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pit.tabBg(shell.currentIndex),
      // O corpo se estende atrás da barra: o conteúdo rola por baixo da pílula
      // (flutuação de verdade). As listas de aba compensam via tabListPadding.
      extendBody: true,
      body: _SlideTabView(index: shell.currentIndex, child: shell),
      bottomNavigationBar: PitadaTabBar(
        tabs: kPitadaTabs,
        currentIndex: shell.currentIndex,
        onSelect: _goBranch,
      ),
    );
  }

  /// Troca de aba preservando o estado da pilha de cada uma. Usada por: o dock.
  void _goBranch(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }
}

/// Faz a aba entrar deslizando ao trocar de [index]: pela direita se a nova aba
/// está à direita da anterior, pela esquerda se está à esquerda. O [child] (o
/// StatefulNavigationShell / IndexedStack) segue por baixo, então o estado de
/// cada aba é preservado — só o quadro de entrada desliza. Usada por: [AppShell].
class _SlideTabView extends StatefulWidget {
  const _SlideTabView({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<_SlideTabView> createState() => _SlideTabViewState();
}

class _SlideTabViewState extends State<_SlideTabView>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 300);
  static const Curve _curve = Curves.easeOutCubic;

  late final AnimationController _c;
  double _dir = 0; // -1 = entra pela esquerda; 1 = entra pela direita

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: _duration, value: 1);
  }

  /// Ao mudar de aba, define a direção pela posição relativa e roda a entrada.
  @override
  void didUpdateWidget(_SlideTabView old) {
    super.didUpdateWidget(old);
    if (old.index == widget.index) return;
    _dir = widget.index > old.index ? 1 : -1;
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  /// Desliza o [child] de ±1 (fração da largura) até 0. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (_, child) {
        final dx = _dir * (1 - _curve.transform(_c.value));
        return FractionalTranslation(translation: Offset(dx, 0), child: child);
      },
    );
  }
}
