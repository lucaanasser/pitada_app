// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/expiry_tag.dart
// O QUÊ:     Tag de validade em contorno, sem ícone (discreta). Avisa perto de vencer.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: shopping (despensa) — status de validade de cada item.
// SPEC:      specs/components/expiry_tag.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Tag textual de validade. [urgent] = terracota; senão = neutra ('soon').
/// Usada por: itens da despensa.
class ExpiryTag extends StatelessWidget {
  const ExpiryTag({super.key, required this.label, this.urgent = false});

  final String label;
  final bool urgent;

  /// Cria a tag a partir de uma data: urgente (<=2 dias), 'soon' (<=5) ou null.
  /// Devolve null quando ainda está longe de vencer. Usada por: PantryItemRow.
  static ExpiryTag? fromDate(DateTime? expires, {DateTime? now}) {
    if (expires == null) return null;
    final ref = now ?? DateTime.now();
    final days =
        expires.difference(DateTime(ref.year, ref.month, ref.day)).inDays;
    if (days > 5) return null;
    if (days <= 0) return const ExpiryTag(label: 'vence hoje', urgent: true);
    if (days == 1) return const ExpiryTag(label: 'vence amanhã', urgent: true);
    if (days <= 2) return ExpiryTag(label: 'vence em $days dias', urgent: true);
    return ExpiryTag(label: 'vence em $days dias');
  }

  @override
  Widget build(BuildContext context) {
    final fg = urgent ? AppColors.accent2 : AppColors.muted;
    final border = urgent ? AppColors.accentLine : AppColors.line2;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm + 1, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.br(AppSpacing.radiusSm),
        border: Border.all(color: border),
      ),
      child: Text(label, style: AppType.on(AppType.captionSm, fg)),
    );
  }
}
