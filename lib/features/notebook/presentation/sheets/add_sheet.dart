// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/sheets/add_sheet.dart
// O QUÊ:     Sheet "Adicionar ao Caderno" — escolhe o que criar (ficha/nota/
//            diário/log). Só define as 4 opções; o visual é o AddOptionsSheet.
// USA:       core/widgets/sheets/add_options_sheet, theme/app_icons, go_router,
//            diary_quick_sheet, note_quick_sheet.
// USADO POR: NotebookScreen (botão '+' do hub do Caderno).
// SPEC:      specs/features/notebook.yaml (sheets.showNotebookAddSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/widgets/sheets/add_options_sheet.dart';
import 'diary_quick_sheet.dart';
import 'note_quick_sheet.dart';

/// Abre o bottom sheet "Adicionar ao Caderno" com as 4 opções de criação.
/// As ações rodam com o contexto EXTERNO (o do hub), que sobrevive ao pop.
/// Usada por: NotebookScreen (ação '+' do cabeçalho).
void showNotebookAddSheet(BuildContext context) {
  showAddOptionsSheet(
    context,
    title: 'Adicionar ao Caderno',
    options: [
      AddSheetOption(
        'Ficha',
        'Técnica, framework ou guia',
        'clay',
        AppIcons.book,
        (ctx) => ctx.push('/lesson-edit'),
      ),
      AddSheetOption(
        'Nota de fonte',
        'O que fica de um livro, vídeo ou chef',
        'ochre',
        AppIcons.bookmark,
        (ctx) => showNoteQuickSheet(ctx),
      ),
      AddSheetOption(
        'Entrada de diário',
        'As três perguntas de depois de cozinhar',
        'moss',
        AppIcons.editNote,
        (ctx) => showDiaryQuickSheet(ctx),
      ),
      AddSheetOption(
        'Log de processo',
        'Fermentação, sous-vide, cura — avançado',
        'plum',
        AppIcons.science,
        (ctx) => ctx.push('/learning/logs'),
      ),
    ],
  );
}
