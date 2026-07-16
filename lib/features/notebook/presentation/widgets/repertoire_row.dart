// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/repertoire_row.dart
// O QUÊ:     Linha do Repertório: nome + detalhe pequeno à esquerda, valor à direita.
// USA:       core/widgets (HairlineRow), theme/*.
// USADO POR: RepertoireScreen (rácios e substituições).
// SPEC:      specs/features/notebook.yaml (RepertoireRow "nome + detalhe / valor")
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';

/// Uma proporção/substituição como linha de lista: nome forte + [detail] discreto
/// à esquerda e [value] em serifa (destaque) à direita.
/// Usada por: RepertoireScreen para rácios e substituições.
class RepertoireRow extends StatelessWidget {
  const RepertoireRow({
    super.key,
    required this.name,
    required this.value,
    this.detail = '',
    this.showDivider = true,
  });

  final String name;
  final String value;
  final String detail;
  final bool showDivider;

  /// Monta a linha com título/subtítulo à esquerda e valor à direita.
  /// Usada por: RepertoireScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      title: Text(name, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: detail.isEmpty
          ? null
          : Text(detail, style: AppType.on(AppType.caption, pit.muted)),
      trailing:
          Text(value, style: AppType.on(AppType.numeralSm, AppColors.accent2)),
    );
  }
}
