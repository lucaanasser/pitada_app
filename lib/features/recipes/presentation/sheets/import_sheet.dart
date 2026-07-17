// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/sheets/import_sheet.dart
// O QUÊ:     Bottom sheet de importar receita em 4 estágios (escolher origem ->
//            loading com StepProgress -> preview editável -> erro com retry).
//            Detecta a fonte do link, escolhe PDF, persiste a receita importada
//            e dá o atalho p/ criar um framework (/framework/new).
// USA:       import_controller (fases), recipe_import_service (input), recipes_providers
//            (create), import_source_grid/preview, file_picker, core/widgets, theme/*,
//            go_router.
// USADO POR: recipes_screen (botão '+') via showImportSheet(context).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../../core/widgets/cards/step_progress.dart';
import '../../application/import_controller.dart';
import '../../application/recipe_import_service.dart';
import '../../application/recipes_providers.dart';
import '../../data/models/recipe.dart';
import '../widgets/import/import_preview.dart';
import '../widgets/import/import_source_grid.dart';

/// Abre a sheet de importação de receita (surf, cantos arredondados, grip).
/// Usada por: recipes_screen (ação '+'). Reseta o controller ao fechar.
void showImportSheet(BuildContext context) {
  showPitadaSheet<void>(context, builder: (ctx) => const _ImportSheet());
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

  /// Notifier do controller (atalho). Usada por: os handlers abaixo.
  ImportController get _ctrl => ref.read(importControllerProvider.notifier);

  /// Deduz a fonte a partir do link e dispara a importação. Usada por: grade.
  void _importUrl(String url) {
    final u = url.toLowerCase();
    final source = u.contains('instagram.')
        ? RecipeSource.instagram
        : (u.contains('youtube.') || u.contains('youtu.be'))
            ? RecipeSource.youtube
            : RecipeSource.site;
    _ctrl.startFrom(RecipeImportInput(source: source, url: url));
  }

  /// Abre o seletor de PDF, lê os bytes em base64 e dispara a importação.
  /// Usada por: grade (card PDF).
  Future<void> _importPdf() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      withData: true,
    );
    final bytes = res?.files.firstOrNull?.bytes;
    if (bytes == null) return;
    _ctrl.startFrom(
      RecipeImportInput(source: RecipeSource.pdf, content: base64Encode(bytes)),
    );
  }

  /// Fecha a sheet e abre a criação de framework. Usada por: grade (card Novo Framework).
  void _newFramework() {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    router.push('/framework/new');
  }

  /// Congela o preview numa receita nova, persiste e fecha. Usada por: ImportPreview.
  Future<void> _save() async {
    final draft = ref.read(importControllerProvider).preview;
    final nav = Navigator.of(context);
    if (draft != null) {
      if (draft.title.trim().isEmpty) draft.title = 'Receita importada';
      final id = await ref.read(recipeEditControllerProvider).create(draft.toRecipe());
      AppLog.i('recipes', 'receita importada salva: $id');
    }
    nav.pop();
  }

  /// Monta o corpo conforme a fase (choose/loading/ready/error). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importControllerProvider);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter, 0, AppSpacing.gutter, AppSpacing.xxxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [const SheetGrip(), _body(state)],
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
      case ImportPhase.error:
        return _errorView(state.error ?? 'Algo deu errado.');
    }
  }

  /// Estágio 1: título + grade de origens. Usada por: [_body].
  Widget _choose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('De onde vem a receita?', style: AppType.on(AppType.title, context.pit.text)),
        const SizedBox(height: AppSpacing.xl),
        ImportSourceGrid(
          onSubmitUrl: _importUrl,
          onPickPdf: _importPdf,
          onManual: () => _ctrl.startFrom(
            const RecipeImportInput(source: RecipeSource.manual),
          ),
          onNewFramework: _newFramework,
        ),
      ],
    );
  }

  /// Estágio 2: título + StepProgress da extração. Usada por: [_body].
  Widget _loading(int activeIndex) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lendo a receita...', style: AppType.on(AppType.title, pit.text)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A IA está estruturando ingredientes, medidas e macros.',
          style: AppType.on(AppType.body, pit.muted),
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

  /// Estágio 4: mensagem de erro + tentar de novo / trocar de fonte. Usada por: [_body].
  Widget _errorView(String message) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Não deu certo', style: AppType.on(AppType.title, pit.text)),
        const SizedBox(height: AppSpacing.sm),
        Text(message, style: AppType.on(AppType.body, pit.muted)),
        const SizedBox(height: AppSpacing.xl),
        PitadaButton(label: 'Tentar de novo', icon: AppIcons.history, onPressed: _ctrl.retry),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: _ctrl.reset,
          behavior: HitTestBehavior.opaque,
          child: Text(
            'Escolher outra fonte',
            style: AppType.on(AppType.button, pit.muted),
          ),
        ),
      ],
    );
  }
}
