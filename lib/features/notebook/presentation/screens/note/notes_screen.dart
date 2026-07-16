// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/screens/note/notes_screen.dart
// O QUÊ:     Tela "Notas de fonte": lista de SourceNote (livro/vídeo/curso/chef).
// USA:       providers (notesProvider), NoteRow, DetailHeader, core/widgets.
// USADO POR: core/router/routes.dart (/learning/notes).
// SPEC:      specs/features/notebook.yaml (screens.NotesScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../application/providers.dart';
import '../../../data/models/activity/source_note.dart';
import '../../widgets/shared/detail_header.dart';
import '../../widgets/note/note_row.dart';

/// Lista de notas de fonte do Caderno. Usada por: router (/learning/notes).
class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  /// Monta cabeçalho + lista de notas + ação de adicionar. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final async = ref.watch(notesProvider);
    return PitadaScaffold(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const DetailHeader(
            kicker: 'Conhecimento',
            title: 'Notas de fonte',
            lead: 'O que ficou de cada livro, vídeo, curso ou chef.',
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
            data: (notes) => _list(context, notes),
          ),
        ],
      ),
    );
  }

  /// Renderiza a lista de notas + botão "Adicionar fonte", ou estado vazio.
  /// Usada por: [build].
  Widget _list(BuildContext context, List<SourceNote> notes) {
    if (notes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Nenhuma nota ainda',
          message: 'Guarde aqui o que aprender de uma fonte.',
          icon: AppIcons.bookmark,
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
          for (var i = 0; i < notes.length; i++)
            NoteRow(
              note: notes[i],
              showDivider: i != notes.length - 1,
              onTap: () => context.push('/note/${notes[i].id}'),
            ),
          const SizedBox(height: AppSpacing.xxl),
          PitadaButton(
            label: 'Adicionar fonte',
            icon: AppIcons.add,
            variant: PitadaButtonVariant.outline,
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Adicionar fonte — próximo passo')),
            ),
          ),
        ],
      ),
    );
  }
}
