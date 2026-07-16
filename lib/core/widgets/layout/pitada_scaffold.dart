// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/layout/pitada_scaffold.dart
// O QUÊ:     Casca padrão de uma aba: topo fixo (masthead/thead) + conteúdo rolável.
//            Aceita fundo customizado (ex.: pastel da aba via pit.tabBg).
//            Inclui tabListPadding — padding inferior padrão das listas de aba.
// USA:       theme/colors (fundo bg padrão), theme/spacing (respiro do padding).
// USADO POR: todas as telas de aba (recipes/learning/plans/shopping/home).
// SPEC:      specs/components/atoms.yaml (PitadaScaffold)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Padding inferior padrão das listas de aba: [respiro] + inset do sistema.
/// Com o shell em extendBody, o inset inclui a altura da pílula flutuante —
/// sem ele o fim da lista ficaria escondido sob a barra.
/// Usada por: ListViews das telas de aba (recipes, learning, plans, shopping,
/// profile).
EdgeInsets tabListPadding(BuildContext context,
    {double respiro = AppSpacing.xxl}) {
  return EdgeInsets.only(
      bottom: respiro + MediaQuery.paddingOf(context).bottom);
}

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
      color: background ?? context.pit.bg,
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
