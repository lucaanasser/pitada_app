// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/import_source_grid.dart
// O QUÊ:     Escolha da fonte da importação: campo de link (site/Instagram/YouTube)
//            com botão Importar + cards PDF e Escrever. Devolve a ação escolhida.
// USA:       core/widgets (PitadaSearchField, PitadaButton), theme/*, app_icons.
// USADO POR: import_sheet (primeiro estágio: choose).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT: choose / ImportSourceGrid)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/controls/pitada_search_field.dart';

/// Grade de origens de importação. Chama [onSubmitUrl] com um link, [onPickPdf]
/// para escolher um PDF ou [onManual] para começar em branco. Usada por: import_sheet.
class ImportSourceGrid extends StatefulWidget {
  const ImportSourceGrid({
    super.key,
    required this.onSubmitUrl,
    required this.onPickPdf,
    required this.onManual,
  });

  final ValueChanged<String> onSubmitUrl;
  final VoidCallback onPickPdf;
  final VoidCallback onManual;

  @override
  State<ImportSourceGrid> createState() => _ImportSourceGridState();
}

class _ImportSourceGridState extends State<ImportSourceGrid> {
  final _link = TextEditingController();

  /// Libera o controller do link. Usada por: framework.
  @override
  void dispose() {
    _link.dispose();
    super.dispose();
  }

  /// Dispara a importação do link digitado (se houver). Usada por: botão/onSubmitted.
  void _submit() {
    final url = _link.text.trim();
    if (url.isNotEmpty) widget.onSubmitUrl(url);
  }

  /// Monta o campo de link + botão + cards. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final hasLink = _link.text.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PitadaSearchField(
          hint: 'Cole um link do Instagram, site...',
          controller: _link,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),
        if (hasLink)
          PitadaButton(
            label: 'Importar link',
            icon: AppIcons.link,
            onPressed: _submit,
          )
        else
          Text(
            'Ex.: instagram.com/reel/... ou um blog de receitas',
            style: AppType.on(AppType.captionSm, pit.faint),
          ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(child: _card(pit, AppIcons.pdf, 'PDF', widget.onPickPdf)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _card(pit, AppIcons.editNote, 'Escrever', widget.onManual),
            ),
          ],
        ),
      ],
    );
  }

  /// Card de origem (ícone + rótulo) sobre surf. Usada por: [build].
  Widget _card(PitadaColors pit, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        decoration: BoxDecoration(
          color: pit.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: pit.line2),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.accent2),
            const SizedBox(height: AppSpacing.sm),
            Text(label, style: AppType.on(AppType.button, pit.text)),
          ],
        ),
      ),
    );
  }
}
