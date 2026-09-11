// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/grocery_row.dart
// O QUÊ:     Linha de um item do carrinho: CheckItem verde (círculo) + nome +
//            quantidade humana; quando a despensa cobre parte do item, mostra
//            'Precisa de X · tem Y' embaixo do nome. Comprado fica apagado.
// USA:       HairlineRow, CheckItem, utils/format, theme/*.
// USADO POR: grocery_list_view (miolo do card, dentro das categorias).
// SPEC:      specs/features/groceries.yaml (screens.compras: GroceryRow)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/controls/check_item.dart';
import '../../data/grocery_item.dart';

/// Linha do carrinho com marcação de comprado e a cobertura da despensa.
/// [coverage] é o par precisa/tem vindo do pantryCoverageProvider (ou null).
/// Usada por: grocery_list_view.
class GroceryRow extends StatelessWidget {
  const GroceryRow({
    super.key,
    required this.item,
    required this.showDivider,
    required this.onToggle,
    this.coverage,
  });

  final GroceryItem item;
  final bool showDivider;
  final VoidCallback onToggle;
  final ({num need, num have})? coverage;

  /// Monta o filete com check, nome (+ cobertura) e quantidade. Usada por:
  /// grocery_list_view.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final done = item.checked;
    return HairlineRow(
      showDivider: showDivider,
      onTap: onToggle,
      leading: CheckItem(
        checked: done,
        shape: CheckShape.circle,
        color: AppColors.sage,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        item.name,
        style: AppType.on(AppType.body, done ? pit.muted : pit.text),
      ),
      subtitle: coverage == null
          ? null
          : Text(
              'Precisa de ${formatHuman(coverage!.need, item.humanUnit)}'
              ' · tem ${formatHuman(coverage!.have, item.humanUnit)}',
              style: AppType.on(AppType.bodySm, pit.muted),
            ),
      trailing: Text(
        formatHuman(item.humanQty, item.humanUnit),
        style: AppType.on(AppType.numeralSm, done ? pit.muted : pit.text),
      ),
    );
  }
}
