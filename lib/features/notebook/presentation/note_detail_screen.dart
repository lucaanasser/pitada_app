// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/note_detail_screen.dart
// O QUÊ:     Detalhe de uma nota de fonte: kicker, título, meta, "O que fica", "Aplica em".
// USA:       learning_providers (noteByIdProvider), DetailHeader, NoteTake,
//            RecipeLinkRow, PitadaChip, SectionHeader, core/widgets, theme/*.
// USADO POR: core/router/router.dart (/note/:id).
// SPEC:      specs/features/notebook.yaml (screens.NoteDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/controls/pitada_chip.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../application/providers.dart';
import '../data/source_note.dart';
import 'widgets/detail_header.dart';
import 'widgets/note_take.dart';
import 'widgets/recipe_link_row.dart';

/// Tela de detalhe de uma nota de fonte. Usada por: router (/note/:id).
class NoteDetailScreen extends ConsumerWidget {
  const NoteDetailScreen({super.key, required this.noteId});

  final String noteId;

  /// Resolve a nota por id e renderiza o corpo (ou estado de erro). Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final async = ref.watch(noteByIdProvider(noteId));
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
          data: (note) => note == null
              ? Center(
                  child: Text(
                    'Nota não encontrada',
                    style: AppType.on(AppType.body, pit.text),
                  ),
                )
              : _content(note),
        ),
      ),
    );
  }

  /// Monta a lista rolável com as seções da nota. Usada por: [build].
  Widget _content(SourceNote note) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      children: [
        DetailHeader(kicker: note.kind, title: note.title),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.meta.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                PitadaChip(label: note.meta, icon: AppIcons.profile),
              ],
              if (note.takeaways.isNotEmpty) ...[
                const SectionHeader(label: 'O que fica'),
                for (var i = 0; i < note.takeaways.length; i++)
                  NoteTake(
                    number: i + 1,
                    text: note.takeaways[i],
                    showDivider: i != note.takeaways.length - 1,
                  ),
              ],
              if (note.recipeIds.isNotEmpty) ...[
                const SectionHeader(label: 'Aplica em'),
                for (var i = 0; i < note.recipeIds.length; i++)
                  RecipeLinkRow(
                    recipeId: note.recipeIds[i],
                    showDivider: i != note.recipeIds.length - 1,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
