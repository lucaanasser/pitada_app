// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/cook/cook_feedback_options.dart
// O QUÊ:     Opções exclusivas de feedback pós-preparo (Salgado/Cru/Seco/Perfeito),
//            como HairlineRow com CheckItem — só uma marcada por vez.
// USA:       core/widgets (HairlineRow, CheckItem), theme/*.
// USADO POR: cook_chat_sheet.
// SPEC:      specs/features/recipes.yaml (SHEET-COOKCHAT: CookFeedbackOptions)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/check_item.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';

/// Lista de escolhas exclusivas de feedback. [selected] é o índice marcado (ou -1);
/// [onSelect] devolve o índice tocado. Usada por: cook_chat_sheet.
class CookFeedbackOptions extends StatelessWidget {
  const CookFeedbackOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final int selected;
  final ValueChanged<int> onSelect;

  /// Monta uma HairlineRow por opção com um CheckItem circular. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      children: [
        for (var i = 0; i < options.length; i++)
          HairlineRow(
            onTap: () => onSelect(i),
            showDivider: i != options.length - 1,
            title: Text(options[i], style: AppType.on(AppType.body, pit.text)),
            trailing: CheckItem(
              checked: selected == i,
              onChanged: (_) => onSelect(i),
            ),
          ),
      ],
    );
  }
}
