// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/capture_bar.dart
// O QUÊ:     Barra de captura do hub do Caderno: convite permanente de escrita
//            ("O que ficou de hoje?") + 3 chips de captura de 1 toque.
// USA:       core/theme (pit, ícones, tipos, espaçamento), core/widgets
//            (PitadaTag), caderno_providers (cozinha pendente), sheets rápidos
//            (diário/nota/add), go_router (rota da ficha).
// USADO POR: LearningScreen (topo do hub do Caderno).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/pitada_tag.dart';
import '../../application/caderno_providers.dart';
import '../caderno_add_sheet.dart';
import '../diary_quick_sheet.dart';
import '../note_quick_sheet.dart';

/// Barra de captura do Caderno: card com borda tinta, linha de escrita livre
/// (abre o sheet de adicionar) e três chips de registro rápido — Cozinhei
/// (diário, pré-preenchido se houver cozinha pendente), Anotei (nota) e Ficha.
/// Usada por: LearningScreen.
class CaptureBar extends ConsumerWidget {
  const CaptureBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    // Cozinha sem registro → o chip "Cozinhei" já abre com a receita.
    final pending = ref.watch(pendingCookProvider).valueOrNull;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // —— linha 1: convite de escrita livre ——
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showCadernoAddSheet(context),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Icon(AppIcons.editNote, size: 20, color: pit.muted),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    'O que ficou de hoje?',
                    style: AppType.on(AppType.body, pit.muted),
                  ),
                ],
              ),
            ),
          ),
          // divisória interna de largura total, na tinta da borda
          Container(height: AppSpacing.borderStrong, color: pit.border),
          // —— linha 2: capturas de 1 toque ——
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _QuickChip(
                  label: 'Cozinhei',
                  icon: AppIcons.cook,
                  color: pit.card('moss'),
                  onTap: () => showDiaryQuickSheet(
                    context,
                    recipeName: pending?.recipeName,
                  ),
                ),
                _QuickChip(
                  label: 'Anotei',
                  icon: AppIcons.bookmark,
                  color: pit.card('ochre'),
                  onTap: () => showNoteQuickSheet(context),
                ),
                _QuickChip(
                  label: 'Ficha',
                  icon: AppIcons.book,
                  color: pit.card('clay'),
                  onTap: () => context.push('/lesson-edit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip de captura: PitadaTag pastel tocável com micro-scale de toque (.96),
/// no mesmo idioma do PitadaButton. Usada por: CaptureBar.
class _QuickChip extends StatefulWidget {
  const _QuickChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color; // fundo pastel — ex.: pit.card('moss')
  final VoidCallback onTap;

  @override
  State<_QuickChip> createState() => _QuickChipState();
}

class _QuickChipState extends State<_QuickChip> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _down ? 0.96 : 1,
        duration: const Duration(milliseconds: 100),
        child: PitadaTag(
          label: widget.label,
          color: widget.color,
          icon: widget.icon,
        ),
      ),
    );
  }
}
