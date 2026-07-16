// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/diary_entry_screen.dart
// O QUÊ:     Detalhe de uma entrada de diário: rótulo, título (receita + data),
//            corpo da reflexão e "Ligado a" (receitas).
// USA:       providers (diaryByIdProvider), DetailHeader, RecipeLinkRow,
//            PitadaChip, SectionHeader, utils/format, core/widgets, theme/*.
// USADO POR: core/router/routes.dart (/diary/:id).
// SPEC:      specs/features/notebook.yaml (screens.DiaryEntryScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/controls/pitada_chip.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../application/providers.dart';
import '../data/diary_entry.dart';
import 'widgets/detail_header.dart';
import 'widgets/recipe_link_row.dart';

/// Tela de detalhe de uma entrada de diário. Usada por: router (/diary/:id).
class DiaryEntryScreen extends ConsumerWidget {
  const DiaryEntryScreen({super.key, required this.entryId});

  final String entryId;

  /// Resolve a entrada por id e renderiza o corpo (ou estado de erro). Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(diaryByIdProvider(entryId));
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        bottom: false,
        child: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(
            child: Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
          ),
          data: (entry) => entry == null
              ? Center(
                  child: Text(
                    'Entrada não encontrada',
                    style: AppType.on(AppType.body, pit.text),
                  ),
                )
              : _content(pit, entry),
        ),
      ),
    );
  }

  /// Monta a lista rolável com as seções da entrada. Usada por: [build].
  Widget _content(PitadaColors pit, DiaryEntry entry) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        DetailHeader(
          kicker: 'Diário · ${formatDayMonth(entry.date)}',
          title: entry.recipeName,
        ),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.label.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                PitadaChip(
                  label: entry.label,
                  icon: AppIcons.checkCircle,
                  variant: PitadaChipVariant.accent,
                ),
              ],
              if (entry.body.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                Text(entry.body, style: AppType.on(AppType.quote, pit.text)),
              ],
              if (entry.recipeIds.isNotEmpty) ...[
                const SectionHeader(label: 'Ligado a'),
                for (var i = 0; i < entry.recipeIds.length; i++)
                  RecipeLinkRow(
                    recipeId: entry.recipeIds[i],
                    showDivider: i != entry.recipeIds.length - 1,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
