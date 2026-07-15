// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/editable.dart
// O QUÊ:     Envolve um conteúdo tornando-o editável por GESTO: segurar (long-press)
//            ou clique duplo dispara onEdit — abre a edição só daquele campo.
// USA:       flutter/services (HapticFeedback) para o retorno tátil do toque longo.
// USADO POR: recipe_detail_screen, recipe_meta, nutrition_card, ingredient_row,
//            step_tile (edição inline de cada campo da receita).
// SPEC:      specs/components/editable.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Torna [child] editável por gesto: segurar OU clique duplo chama [onEdit].
/// É o oposto do lápis (que abre o editor inteiro): aqui edita-se só este campo.
/// Se [onEdit] for nulo, apenas repassa o [child] (sem gesto). Usada por: detalhe.
class Editable extends StatelessWidget {
  const Editable({super.key, required this.child, this.onEdit});

  final Widget child;
  final VoidCallback? onEdit;

  /// Monta o detector de gestos (segurar/duplo-clique) em torno do conteúdo.
  /// Toque longo dá um retorno tátil leve. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    if (onEdit == null) return child;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: onEdit,
      onLongPress: () {
        HapticFeedback.selectionClick();
        onEdit!();
      },
      child: child,
    );
  }
}
