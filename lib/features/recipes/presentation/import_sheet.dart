// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/import_sheet.dart
// O QUÊ:     Bottom sheet de importar receita em 3 estágios (escolher origem ->
//            loading com StepProgress -> preview editável). Usa importControllerProvider.
// USA:       import_controller (fases/estado), import_source_grid, import_preview,
//            sheet_grip, core/widgets (StepProgress), theme/*.
// USADO POR: recipes_screen (botão '+') via showImportSheet(context).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../core/widgets/pitada_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/step_progress.dart';
import '../application/import_controller.dart';
import 'widgets/import_preview.dart';
import 'widgets/import_source_grid.dart';
import '../../../core/widgets/sheet_grip.dart';

/// Abre a sheet de importação de receita (surf, cantos arredondados, grip).
/// Usada por: recipes_screen (ação '+'). Reseta o controller ao fechar.
void showImportSheet(BuildContext context) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => const _ImportSheet(),
  );
}

/// Conteúdo da sheet: escolhe o que renderizar conforme a fase do controller.
/// Usada por: showImportSheet.
class _ImportSheet extends ConsumerStatefulWidget {
  const _ImportSheet();

  @override
  ConsumerState<_ImportSheet> createState() => _ImportSheetState();
}

class _ImportSheetState extends ConsumerState<_ImportSheet> {
  /// Ao fechar, volta o controller ao início para a próxima abertura.
  @override
  void dispose() {
    ref.read(importControllerProvider.notifier).reset();
    super.dispose();
  }

  /// Salva o preview (mock: log) e fecha a sheet. Usada por: ImportPreview.
  void _save() {
    final draft = ref.read(importControllerProvider).preview;
    if (draft != null) {
      AppLog.i('recipes', 'receita importada salva: ${draft.id}');
    }
    Navigator.of(context).pop();
  }

  /// Monta o corpo conforme a fase (choose/loading/ready). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importControllerProvider);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            0,
            AppSpacing.gutter,
            AppSpacing.xxxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetGrip(),
              _body(state),
            ],
          ),
        ),
      ),
    );
  }

  /// Escolhe o widget do estágio atual. Usada por: [build].
  Widget _body(ImportState state) {
    switch (state.phase) {
      case ImportPhase.idle:
        return _choose();
      case ImportPhase.loading:
        return _loading(state.stepIndex);
      case ImportPhase.ready:
        return ImportPreview(draft: state.preview!, onSave: _save);
    }
  }

  /// Estágio 1: título + grade de origens. Usada por: [_body].
  Widget _choose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'De onde vem a receita?',
          style: AppType.on(AppType.title, context.pit.text),
        ),
        const SizedBox(height: AppSpacing.xl),
        ImportSourceGrid(
          onPick: (origem) =>
              ref.read(importControllerProvider.notifier).startFrom(origem),
        ),
      ],
    );
  }

  /// Estágio 2: título + StepProgress da extração simulada. Usada por: [_body].
  Widget _loading(int activeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lendo a receita...',
          style: AppType.on(AppType.title, context.pit.text),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A IA está estruturando ingredientes, medidas e macros.',
          style: AppType.on(AppType.body, context.pit.muted),
        ),
        const SizedBox(height: AppSpacing.xl),
        StepProgress(
          steps: const [
            'Encontrando ingredientes e passos',
            'Convertendo medidas para gramas',
            'Calculando calorias e macros',
          ],
          activeIndex: activeIndex,
        ),
      ],
    );
  }
}
