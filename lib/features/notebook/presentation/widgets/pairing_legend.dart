// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/pairing_legend.dart
// O QUÊ:     Legenda de níveis de harmonização (adoro/testei/clássico) e o mapa
//            de cor por nível usado pelos chips do detalhe.
// USA:       theme/colors, theme/spacing, theme/typography, PairingRating.
// USADO POR: PairingDetailScreen.
// SPEC:      specs/features/notebook.yaml (PairingDetailScreen "legenda"/chips por nível)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/repertoire.dart';

/// Cor do contorno/ponto por nível de confiança de uma combinação.
/// adoro = accent2; testei = sage; clássico = line2 (por tema). Usada por: PairingDetailScreen.
Color pairingColor(PitadaColors pit, PairingRating rating) => switch (rating) {
      PairingRating.adoro => AppColors.accent2,
      PairingRating.testei => AppColors.sage,
      PairingRating.classico => pit.line2,
    };

/// Legenda horizontal (ponto colorido + rótulo) dos três níveis de harmonização.
/// Usada por: PairingDetailScreen (abaixo do título).
class PairingLegend extends StatelessWidget {
  const PairingLegend({super.key});

  /// Renderiza os três itens da legenda lado a lado. Usada por: PairingDetailScreen.
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: [
        _LegendItem(rating: PairingRating.adoro, label: 'Adoro'),
        _LegendItem(rating: PairingRating.testei, label: 'Testei'),
        _LegendItem(rating: PairingRating.classico, label: 'Clássico'),
      ],
    );
  }
}

/// Um item da legenda: ponto na cor do nível + rótulo. Usada por: [PairingLegend].
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.rating, required this.label});

  final PairingRating rating;
  final String label;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSpacing.sm + 2,
          height: AppSpacing.sm + 2,
          decoration: BoxDecoration(
            color: pairingColor(pit, rating),
            borderRadius: AppSpacing.br(AppSpacing.radiusPill),
          ),
        ),
        const SizedBox(width: AppSpacing.sm - 2),
        Text(label, style: AppType.on(AppType.caption, pit.text2)),
      ],
    );
  }
}
