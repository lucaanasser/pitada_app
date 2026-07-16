// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/diary_screen.dart
// O QUÊ:     Tela "Diário de cozinha": dica no topo + lista de entradas (DiaryEntry).
// USA:       learning_providers (diaryProvider), DiaryRow, HintCard, DetailHeader.
// USADO POR: core/router/router.dart (/learning/diary).
// SPEC:      specs/features/notebook.yaml (screens.DiaryScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../application/providers.dart';
import '../data/diary_entry.dart';
import 'widgets/detail_header.dart';
import 'widgets/diary_row.dart';
import 'widgets/hint_card.dart';

/// Lista do diário de cozinha. Usada por: router (/learning/diary).
class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  /// Monta cabeçalho + dica + lista de entradas do diário. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(diaryProvider);
    final pit = context.pit;
    return PitadaScaffold(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const DetailHeader(
            kicker: 'Prática',
            title: 'Diário de cozinha',
            lead: 'Três perguntas rápidas cada vez que você cozinha.',
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.lg,
              AppSpacing.gutter,
              0,
            ),
            child: HintCard(
              text: 'Abre sozinho quando você conclui o modo cozinhar. '
                  'Leva 20 segundos.',
            ),
          ),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xxxl),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child:
                  Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
            ),
            data: (entries) => _list(context, entries),
          ),
        ],
      ),
    );
  }

  /// Renderiza a lista de entradas ou um estado vazio. Usada por: [build].
  Widget _list(BuildContext context, List<DiaryEntry> entries) {
    if (entries.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Diário vazio',
          message: 'Cozinhe uma receita para a primeira entrada.',
          icon: AppIcons.editNote,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Column(
        children: [
          for (var i = 0; i < entries.length; i++)
            DiaryRow(
              entry: entries[i],
              showDivider: i != entries.length - 1,
              onTap: () => context.push('/diary/${entries[i].id}'),
            ),
        ],
      ),
    );
  }
}
