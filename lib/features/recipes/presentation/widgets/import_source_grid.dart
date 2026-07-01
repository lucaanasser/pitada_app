// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/import_source_grid.dart
// O QUÊ:     Escolha de origem da importação: link de exemplo (Instagram) + 4 botões
//            (YouTube, Foto, PDF, Escrever). Cada opção devolve a origem escolhida.
// USA:       core/widgets (PitadaSearchField, PitadaButton), theme/*.
// USADO POR: import_sheet (primeiro estágio: choose).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT: choose / ImportSourceGrid)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/pitada_search_field.dart';

/// Grade de origens de importação. [onPick] recebe a origem ('youtube'/'foto'/
/// 'pdf'/'manual'/link) e o pai decide se vai para loading ou preview em branco.
/// Usada por: import_sheet.
class ImportSourceGrid extends StatelessWidget {
  const ImportSourceGrid({super.key, required this.onPick});

  final ValueChanged<String> onPick;

  /// Monta o campo de link + a grade 2x2 de origens. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PitadaSearchField(hint: 'Cole um link do Instagram, YouTube...'),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Ex.: instagram.com/reel/frango-xadrez',
          style: AppType.on(AppType.captionSm, AppColors.faint),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(child: _card(Icons.smart_display, 'YouTube', 'youtube')),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _card(Icons.photo_camera, 'Foto', 'foto')),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(child: _card(Icons.picture_as_pdf, 'PDF', 'pdf')),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _card(Icons.edit_note, 'Escrever', 'manual')),
          ],
        ),
      ],
    );
  }

  /// Card de origem (ícone + rótulo) sobre surf. Usada por: [build].
  Widget _card(IconData icon, String label, String origem) {
    return GestureDetector(
      onTap: () => onPick(origem),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.line2),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.accent2),
            const SizedBox(height: AppSpacing.sm),
            Text(label, style: AppType.on(AppType.button, AppColors.text)),
          ],
        ),
      ),
    );
  }
}
