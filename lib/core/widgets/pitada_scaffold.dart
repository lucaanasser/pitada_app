// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_scaffold.dart
// O QUÊ:     Casca padrão de uma aba: topo fixo (masthead/thead) + conteúdo rolável.
// USA:       theme/colors (fundo bg).
// USADO POR: todas as telas de aba (recipes/learning/plans/shopping/home).
// SPEC:      specs/components/atoms.yaml (PitadaScaffold)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// Estrutura de aba: [top] fica fixo no alto; [child] ocupa o resto (rolável).
/// Usada por: as telas principais de cada aba.
class PitadaScaffold extends StatelessWidget {
  const PitadaScaffold({super.key, required this.child, this.top});

  final Widget child;
  final Widget? top;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bg,
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
