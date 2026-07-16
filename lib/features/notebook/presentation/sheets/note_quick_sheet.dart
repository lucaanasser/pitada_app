// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/sheets/note_quick_sheet.dart
// O QUÊ:     Sheet de nota de fonte rápida: guarda "o que fica" de um livro,
//            vídeo, curso ou chef com atrito mínimo.
// USA:       theme/* (pit, AppType, AppSpacing, AppColors), core/widgets
//            (PitadaTag, PitadaChip, PitadaButton), widgets/shared/
//            section_editor (EditField), core/utils/app_log.
// USADO POR: hub do Caderno (atalhos de captura) e sheet "Adicionar ao Caderno".
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../../core/widgets/sheets/pitada_sheet.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/controls/pitada_chip.dart';
import '../../../../core/widgets/tags/pitada_tag.dart';
import '../widgets/shared/section_editor.dart';

/// Abre o bottom sheet de nota de fonte rápida (tipo + título + o que fica).
/// Usada por: CaptureBar (captura rápida) e add_sheet.
void showNoteQuickSheet(BuildContext context) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => const _NoteQuickSheet(),
  );
}

/// Formulário da nota: seletor de tipo de fonte + 3 campos + salvar.
/// Usada por: [showNoteQuickSheet].
class _NoteQuickSheet extends StatefulWidget {
  const _NoteQuickSheet();

  @override
  State<_NoteQuickSheet> createState() => _NoteQuickSheetState();
}

class _NoteQuickSheetState extends State<_NoteQuickSheet> {
  /// Tipos de fonte disponíveis. Usada por: [build] (seletor em Wrap).
  static const _sourceTypes = ['Livro', 'Vídeo', 'Curso', 'Chef'];

  final _titleCtrl = TextEditingController();
  final _sourceCtrl = TextEditingController();
  final _takeawayCtrl = TextEditingController();
  String _type = 'Livro';

  @override
  void dispose() {
    _titleCtrl.dispose();
    _sourceCtrl.dispose();
    _takeawayCtrl.dispose();
    super.dispose();
  }

  /// Loga a nota, fecha o sheet e confirma com um SnackBar.
  /// Usada por: o botão "Guardar nota".
  void _save() {
    // TODO(pitada): persistir quando houver escrita no repositório
    AppLog.i(
      'notebook',
      'nota rápida guardada: $_type · ${_titleCtrl.text.trim()}',
    );
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Nota guardada no Caderno')),
    );
  }

  /// Uma opção do tipo de fonte: selecionada vira tag pastel, senão chip.
  /// Usada por: [build] (seletor de tipo).
  Widget _typeOption(BuildContext context, String label) {
    if (_type == label) {
      return PitadaTag(label: label, color: context.pit.card('clay'));
    }
    return PitadaChip(
      label: label,
      onTap: () => setState(() => _type = label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: pit.line2,
                    borderRadius: AppSpacing.br(3),
                  ),
                ),
              ),
              Text(
                'NOTA DE FONTE',
                style: AppType.on(AppType.label, AppColors.accent),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final type in _sourceTypes) _typeOption(context, type),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              EditField(label: 'Título', controller: _titleCtrl),
              const SizedBox(height: AppSpacing.lg),
              EditField(
                label: 'Fonte (autor, canal…)',
                controller: _sourceCtrl,
              ),
              const SizedBox(height: AppSpacing.lg),
              EditField(
                label: 'O que fica',
                controller: _takeawayCtrl,
                maxLines: 3,
                hint: 'A ideia que você quer guardar',
              ),
              const SizedBox(height: AppSpacing.xxl),
              PitadaButton(label: 'Guardar nota', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
