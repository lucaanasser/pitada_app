// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_tag.dart
// O QUÊ:     Tag/pill colorida (fundo pastel + borda tinta + texto), opcional ícone.
//            É a "tag coloridinha" das referências. Reage ao tema (claro/escuro).
// USA:       theme/pitada_colors (borda/texto do tema), theme/spacing, theme/typography.
// USADO POR: card de receita, meta do detalhe (porções/tempo/nível), técnicas.
// SPEC:      specs/components/pitada_tag.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Pílula colorida: [color] é o fundo pastel; borda e texto vêm do tema.
/// Usada por: qualquer meta curta que mereça cor (nota, tempo, dificuldade...).
class PitadaTag extends StatelessWidget {
  const PitadaTag({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: pit.text),
            const SizedBox(width: AppSpacing.xs + 1),
          ],
          Text(
            label,
            style: AppType.on(AppType.bodySm, pit.text)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
