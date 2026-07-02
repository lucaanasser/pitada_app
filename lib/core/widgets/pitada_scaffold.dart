// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_scaffold.dart
// O QUÊ:     Casca padrão de uma aba: topo fixo (masthead/thead) + conteúdo rolável.
//            Aceita fundo customizado (ex.: pastel da aba via pit.tabBg).
// USA:       theme/colors (fundo bg padrão).
// USADO POR: todas as telas de aba (recipes/learning/plans/shopping/home).
// SPEC:      specs/components/atoms.yaml (PitadaScaffold)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// Estrutura de aba: [top] fica fixo no alto; [child] ocupa o resto (rolável).
/// [background] permite tingir a aba (ex.: `context.pit.tabBg(1)` no Caderno).
/// Usada por: as telas principais de cada aba.
class PitadaScaffold extends StatelessWidget {
  const PitadaScaffold({
    super.key,
    required this.child,
    this.top,
    this.background,
  });

  final Widget child;
  final Widget? top;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background ?? AppColors.bg,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (top != null) top!,
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
