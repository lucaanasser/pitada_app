// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/sub_recipe/unify_candidate_row.dart
// O QUÊ:     Linha de candidata à unificação: check + receita/componente +
//            diffs e fator de escala sugerido.
// USA:       unify_service (UnifyCandidate), core/widgets (HairlineRow,
//            CheckItem), core/utils/scaling (formatFactor), core/theme.
// USADO POR: unify_screen.
// SPEC:      specs/features/sub_recipes.yaml (unificacao.tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/scaling.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/controls/check_item.dart';
import '../../../application/sub_recipe/unify_service.dart';

/// Linha de candidata com seleção; [last] esconde o filete final.
/// Usada por: UnifyScreen.
class UnifyCandidateRow extends StatelessWidget {
  const UnifyCandidateRow({
    super.key,
    required this.candidate,
    required this.checked,
    required this.last,
    required this.onToggle,
  });

  final UnifyCandidate candidate;
  final bool checked;
  final bool last;
  final VoidCallback onToggle;

  /// Monta o HairlineRow com check, título e diffs/escala. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final details = [
      if (candidate.suggestedScale != 1)
        '≈${formatFactor(candidate.suggestedScale)}',
      ...candidate.diffs,
    ];
    return HairlineRow(
      showDivider: !last,
      onTap: onToggle,
      leading: CheckItem(
        checked: checked,
        onChanged: (_) => onToggle(),
        shape: CheckShape.square,
      ),
      title: Text(
        '${candidate.recipeTitle} · ${candidate.component.name}',
        style: AppType.on(AppType.body, pit.text),
      ),
      subtitle: Text(
        details.isEmpty ? 'idêntica' : details.join(' · '),
        style: AppType.on(AppType.caption, pit.muted),
      ),
    );
  }
}
