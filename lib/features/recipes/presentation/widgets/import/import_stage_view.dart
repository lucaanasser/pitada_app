// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/import/import_stage_view.dart
// O QUÊ:     Os estágios visuais da sheet de importação: escolher origem,
//            loading com StepProgress e erro com retry. O preview tem widget
//            próprio (import_preview.dart).
// USA:       core/widgets (PitadaButton, StepProgress), import_source_grid, theme.
// USADO POR: import_sheet (switch de fase).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/step_progress.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import 'import_source_grid.dart';

/// Estágio 1: título + grade de origens. Usada por: import_sheet.
class ImportChooseView extends StatelessWidget {
  const ImportChooseView({
    super.key,
    required this.onSubmitUrl,
    required this.onPickPdf,
    required this.onManual,
    required this.onNewFramework,
  });

  final ValueChanged<String> onSubmitUrl;
  final VoidCallback onPickPdf;
  final VoidCallback onManual;
  final VoidCallback onNewFramework;

  /// Monta o título + ImportSourceGrid. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'De onde vem a receita?',
          style: AppType.on(AppType.title, context.pit.text),
        ),
        const SizedBox(height: AppSpacing.xl),
        ImportSourceGrid(
          onSubmitUrl: onSubmitUrl,
          onPickPdf: onPickPdf,
          onManual: onManual,
          onNewFramework: onNewFramework,
        ),
      ],
    );
  }
}

/// Estágio 2: título + StepProgress da extração. Usada por: import_sheet.
class ImportLoadingView extends StatelessWidget {
  const ImportLoadingView({super.key, required this.activeIndex});

  final int activeIndex;

  /// Monta o título + passos da extração. Usada por: framework.
  @override
  Widget build(BuildContext context) {
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
}

/// Estágio 4: mensagem de erro + tentar de novo / trocar de fonte.
/// Usada por: import_sheet.
class ImportErrorView extends StatelessWidget {
  const ImportErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.onReset,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onReset;

  /// Monta a mensagem + ações de retry/reset. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Não deu certo', style: AppType.on(AppType.title, pit.text)),
        const SizedBox(height: AppSpacing.sm),
        Text(message, style: AppType.on(AppType.body, pit.muted)),
        const SizedBox(height: AppSpacing.xl),
        PitadaButton(
          label: 'Tentar de novo',
          icon: AppIcons.history,
          onPressed: onRetry,
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: onReset,
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
