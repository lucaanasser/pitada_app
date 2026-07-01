// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_chip.dart
// O QUÊ:     Chip arredondado para harmonizações ('combina com') e técnicas linkáveis.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: recipe_detail (técnicas), lesson_detail (harmonizações), perfil.
// SPEC:      specs/components/pitada_chip.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Variações do chip. plain = contorno neutro; accent = contorno/texto terracota.
enum PitadaChipVariant { plain, accent }

/// Chip/tag arredondada, opcionalmente com ícone e toque.
/// Usada por: técnicas da receita, pares de harmonização, badges do perfil.
class PitadaChip extends StatelessWidget {
  const PitadaChip({
    super.key,
    required this.label,
    this.icon,
    this.variant = PitadaChipVariant.plain,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final PitadaChipVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isAccent = variant == PitadaChipVariant.accent;
    final fg = isAccent ? AppColors.accent2 : AppColors.text2;
    final border = isAccent ? AppColors.accentLine : AppColors.line2;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: AppSpacing.br(AppSpacing.radiusPill),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: AppSpacing.xs + 2),
            ],
            Text(label, style: AppType.on(AppType.bodySm, fg)),
          ],
        ),
      ),
    );
  }
}
