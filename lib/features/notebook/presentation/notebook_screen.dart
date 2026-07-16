// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/learning_screen.dart
// O QUÊ:     Aba Caderno — o caderno aberto: captura rápida (CaptureBar),
//            reativação do dia ("Para hoje"), fio cronológico e ferramentas.
// USA:       core/widgets (Masthead, PitadaScaffold, SectionHeader, botões),
//            caderno_providers (fio/reativação) e os widgets do hub.
// USADO POR: core/router/router.dart (branch /learning).
// SPEC:      specs/features/learning.yaml (screens.LearningScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../application/caderno_providers.dart';
import 'caderno_add_sheet.dart';
import 'widgets/capture_bar.dart';
import 'widgets/fio_tile.dart';
import 'widgets/reactivation_card.dart';
import 'widgets/tools_panel.dart';

/// Quantos itens o fio mostra resumido (anti-densidade). Usada por: [LearningScreen].
const _kFioPreview = 5;

/// Tela principal do Caderno: o próprio caderno aberto, não um menu.
/// Usada por: router (/learning).
class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final reactivation = ref.watch(reactivationItemsProvider);
    final fio = ref.watch(fioProvider);
    final expanded = ref.watch(fioExpandedProvider);
    final visible = expanded ? fio : fio.take(_kFioPreview).toList();

    return PitadaScaffold(
      background: pit.tabBg(1),
      top: const Masthead(),
      child: ListView(
        padding: tabListPadding(context, respiro: AppSpacing.xxxl),
        children: [
          _header(context, pit),
          const SizedBox(height: AppSpacing.titleGap),
          const Padding(padding: AppSpacing.screenH, child: CaptureBar()),

          if (reactivation.isNotEmpty) ...[
            const Padding(
              padding: AppSpacing.screenH,
              child: SectionHeader(label: 'Para hoje'),
            ),
            for (final item in reactivation)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  0,
                  AppSpacing.gutter,
                  AppSpacing.md,
                ),
                child: ReactivationCard(item: item),
              ),
          ],

          const Padding(
            padding: AppSpacing.screenH,
            child: SectionHeader(label: 'O fio'),
          ),
          if (fio.isEmpty)
            const EmptyState(
              title: 'O caderno começa vazio',
              message: 'Capture a primeira ideia na barra acima.',
              icon: AppIcons.editNote,
            )
          else ...[
            Padding(
              padding: AppSpacing.screenH,
              child: Column(
                children: [
                  for (var i = 0; i < visible.length; i++)
                    FioTile(
                      entry: visible[i],
                      isLast: i == visible.length - 1,
                    ),
                ],
              ),
            ),
            if (fio.length > _kFioPreview)
              Padding(
                padding: AppSpacing.screenH,
                child: PitadaButton(
                  label: expanded ? 'Mostrar menos' : 'Ver o fio completo',
                  variant: PitadaButtonVariant.outline,
                  onPressed: () =>
                      ref.read(fioExpandedProvider.notifier).state = !expanded,
                ),
              ),
          ],

          const Padding(
            padding: AppSpacing.screenH,
            child: SectionHeader(label: 'Ferramentas'),
          ),
          const Padding(padding: AppSpacing.screenH, child: ToolsPanel()),
        ],
      ),
    );
  }

  /// Cabeçalho do hub: título "Caderno" + botão '+' (sheet de adição).
  /// Usada por: [build].
  Widget _header(BuildContext context, PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              'Caderno',
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
          ),
          PitadaIconButton(
            icon: AppIcons.add,
            filled: true,
            size: AppSpacing.iconButtonSm,
            onPressed: () => showCadernoAddSheet(context),
          ),
        ],
      ),
    );
  }
}
