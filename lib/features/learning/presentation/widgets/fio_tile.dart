// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/fio_tile.dart
// O QUÊ:     Item do fio cronológico do hub do Caderno: data + trilho de tinta
//            + tag do tipo (Diário/Nota/Versão/Log) + título + excerto de 1 linha.
// USA:       core/theme (pitada_colors, spacing, typography), core/widgets
//            (PitadaTag, PitadaChip), go_router (abrir detalhe), FioEntry.
// USADO POR: hub do Caderno (seção "Fio" da LearningScreen).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/pitada_chip.dart';
import '../../../../core/widgets/pitada_tag.dart';
import '../../data/fio_entry.dart';

/// Meses pt-BR abreviados para a coluna de data do fio.
const _months = [
  'JAN',
  'FEV',
  'MAR',
  'ABR',
  'MAI',
  'JUN',
  'JUL',
  'AGO',
  'SET',
  'OUT',
  'NOV',
  'DEZ',
];

/// Rótulo e hero pastel de cada tipo de captura do fio.
/// Usada por: [FioTile] (tag colorida do item).
({String label, String hero}) _kindStyle(FioKind kind) => switch (kind) {
      FioKind.diary => (label: 'Diário', hero: 'moss'),
      FioKind.note => (label: 'Nota', hero: 'ochre'),
      FioKind.version => (label: 'Versão', hero: 'teal'),
      FioKind.log => (label: 'Log', hero: 'plum'),
    };

/// Um item do fio: coluna de data, trilho vertical de tinta que costura os
/// itens e o conteúdo (tag do tipo, título, excerto). Toque abre o detalhe.
/// Usada por: hub do Caderno (lista do fio).
class FioTile extends StatelessWidget {
  const FioTile({super.key, required this.entry, this.isLast = false});

  final FioEntry entry;
  final bool isLast;

  /// Monta data + trilho + conteúdo e navega para [FioEntry.route] no toque.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final style = _kindStyle(entry.kind);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(entry.route),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.date.day}',
                    style: AppType.on(AppType.numeralSm, pit.text),
                  ),
                  Text(
                    _months[entry.date.month - 1],
                    style: AppType.on(AppType.captionSm, pit.muted),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 14,
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(top: AppSpacing.xs),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pit.isDark ? AppColors.accent : pit.border,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Center(
                        child: Container(
                          width: AppSpacing.borderStrong,
                          color: pit.line2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PitadaTag(
                          label: style.label,
                          color: pit.card(style.hero),
                        ),
                        if (entry.tag != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          PitadaChip(label: entry.tag!),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      entry.title,
                      style: AppType.on(AppType.titleSm, pit.text),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      entry.excerpt,
                      style: AppType.on(AppType.bodySm, pit.text2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
