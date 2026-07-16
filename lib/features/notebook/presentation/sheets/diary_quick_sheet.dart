// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/sheets/diary_quick_sheet.dart
// O QUÊ:     Sheet de diário rápido (20 segundos): as 3 perguntas pós-cozinha
//            (o que mudei / o que aprendi / refazer assim?) com atrito mínimo.
//            Grava no repositório do Caderno — a maestria da receita reflete.
// USA:       theme/* (pit, AppType, AppSpacing, AppColors), core/widgets
//            (PitadaTag, PitadaChip, PitadaButton), widgets/shared/
//            section_editor (EditField), application/providers, DiaryEntry.
// USADO POR: hub do Caderno (chamada de reativação) e fim do modo cozinhar.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/sheets/pitada_sheet.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/controls/pitada_chip.dart';
import '../../../../core/widgets/tags/pitada_tag.dart';
import '../../application/providers.dart';
import '../../data/models/activity/diary_entry.dart';
import '../widgets/shared/section_editor.dart';

/// Abre o bottom sheet de diário rápido. Se [recipeName] vier preenchido
/// (ex.: veio do modo cozinhar), a receita já aparece fixa no título;
/// [recipeId] liga a entrada à receita (maestria e memória na lista).
/// Usada por: NotebookScreen (reativação "Você cozinhou X") e cook mode.
void showDiaryQuickSheet(
  BuildContext context, {
  String? recipeName,
  String? recipeId,
}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) =>
        _DiaryQuickSheet(recipeName: recipeName, recipeId: recipeId),
  );
}

/// Formulário das 3 perguntas do diário + veredito "Refazer assim?".
/// Usada por: [showDiaryQuickSheet].
class _DiaryQuickSheet extends ConsumerStatefulWidget {
  const _DiaryQuickSheet({this.recipeName, this.recipeId});

  final String? recipeName;
  final String? recipeId;

  @override
  ConsumerState<_DiaryQuickSheet> createState() => _DiaryQuickSheetState();
}

class _DiaryQuickSheetState extends ConsumerState<_DiaryQuickSheet> {
  final _recipeCtrl = TextEditingController();
  final _changedCtrl = TextEditingController();
  final _learnedCtrl = TextEditingController();
  String _verdict = 'Refazer';

  @override
  void dispose() {
    _recipeCtrl.dispose();
    _changedCtrl.dispose();
    _learnedCtrl.dispose();
    super.dispose();
  }

  /// Grava a entrada no repositório, invalida o diário, fecha o sheet e
  /// confirma com um SnackBar. Usada por: o botão "Salvar no diário".
  Future<void> _save() async {
    final recipe = widget.recipeName ?? _recipeCtrl.text.trim();
    final now = DateTime.now();
    final body = [
      _changedCtrl.text.trim(),
      _learnedCtrl.text.trim(),
    ].where((s) => s.isNotEmpty).join(' · ');
    await ref.read(notebookRepositoryProvider).addDiaryEntry(
          DiaryEntry(
            id: 'diary-${now.microsecondsSinceEpoch}',
            recipeName: recipe,
            date: now,
            label: _verdict,
            body: body,
            recipeIds: [if (widget.recipeId != null) widget.recipeId!],
          ),
        );
    ref.invalidate(diaryProvider);
    AppLog.i('notebook', 'diário rápido salvo: $recipe · $_verdict');
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Registrado no Caderno')),
    );
  }

  /// Um selo do veredito: selecionado vira tag pastel, senão chip de contorno.
  /// Usada por: [build] (linha "Refazer assim?").
  Widget _verdictOption(BuildContext context, String label, String hero) {
    if (_verdict == label) {
      return PitadaTag(label: label, color: context.pit.card(hero));
    }
    return PitadaChip(
      label: label,
      onTap: () => setState(() => _verdict = label),
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
                'DIÁRIO · 20 SEGUNDOS',
                style: AppType.on(AppType.label, AppColors.accent),
              ),
              const SizedBox(height: AppSpacing.sm),
              if (widget.recipeName != null)
                Text(
                  widget.recipeName!,
                  style: AppType.on(AppType.title, pit.text),
                )
              else
                EditField(
                  label: 'Receita',
                  controller: _recipeCtrl,
                  hint: 'O que você cozinhou?',
                ),
              const SizedBox(height: AppSpacing.xl),
              EditField(
                label: 'O que mudei?',
                controller: _changedCtrl,
                maxLines: 2,
              ),
              const SizedBox(height: AppSpacing.lg),
              EditField(
                label: 'O que aprendi?',
                controller: _learnedCtrl,
                maxLines: 2,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'REFAZER ASSIM?',
                style: AppType.on(AppType.label, pit.muted),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  _verdictOption(context, 'Refazer', 'moss'),
                  const SizedBox(width: AppSpacing.sm),
                  _verdictOption(context, 'Ajustar', 'ochre'),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              PitadaButton(label: 'Salvar no diário', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
