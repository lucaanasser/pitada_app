// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/add_pantry_sheet.dart
// O QUÊ:     Bottom sheet "Adicionar à despensa": escolher origem, ler nota, conferir.
// USA:       scanner_service (scannerProvider), add_pantry_data (origens/preview),
//            core/widgets (StepProgress, HairlineRow, PitadaButton), format+app_log, theme/*.
// USADO POR: pantry_view (botão "Adicionar à despensa").
// SPEC:      specs/features/groceries.yaml (sheets.showAddPantrySheet)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/pitada_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/step_progress.dart';
import '../application/scanner_service.dart';
import 'widgets/add_pantry_data.dart';

/// Abre o sheet de adicionar à despensa. Usada por: pantry_view.
void showAddPantrySheet(BuildContext context) {
  showPitadaSheet(
    context,
    builder: (_) => const _AddPantrySheet(),
  );
}

/// Conteúdo do sheet com três estados: escolha, leitura (loading) e conferência.
/// Usada por: showAddPantrySheet.
class _AddPantrySheet extends ConsumerStatefulWidget {
  const _AddPantrySheet();

  @override
  ConsumerState<_AddPantrySheet> createState() => _AddPantrySheetState();
}

class _AddPantrySheetState extends ConsumerState<_AddPantrySheet> {
  int _step = 0;
  int _progress = 0;

  /// Dispara a leitura simulada (StepProgress) e avança ao preview. Usada por: escolha.
  Future<void> _read(PantrySource source) async {
    if (!source.scan) {
      setState(() => _step = 2);
      return;
    }
    setState(() {
      _step = 1;
      _progress = 0;
    });
    final code = await ref.read(scannerProvider).scanBarcode();
    AppLog.i('shopping', 'origem "${source.label}" lida: ${code ?? "-"}');
    for (var i = 1; i <= 2; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      setState(() => _progress = i);
    }
    if (mounted) setState(() => _step = 2);
  }

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _grip(pit),
            Text('Adicionar à despensa',
                style: AppType.on(AppType.title, pit.text)),
            const SizedBox(height: AppSpacing.lg),
            if (_step == 0) _chooser(pit),
            if (_step == 1) _loading(pit),
            if (_step == 2) _preview(pit),
          ],
        ),
      ),
    );
  }

  /// "Grip" padrão do topo do sheet (36x5, line2). Usada por: [build].
  Widget _grip(PitadaColors pit) {
    return Center(
      child: Container(
        width: 36,
        height: 5,
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: pit.line2,
          borderRadius: AppSpacing.br(3),
        ),
      ),
    );
  }

  /// Passo 1: lista de origens em HairlineRow. Usada por: [build].
  Widget _chooser(PitadaColors pit) {
    return Column(
      children: [
        for (var i = 0; i < kPantrySources.length; i++)
          HairlineRow(
            showDivider: i != kPantrySources.length - 1,
            onTap: () => _read(kPantrySources[i]),
            leading:
                Icon(kPantrySources[i].icon, size: 22, color: AppColors.accent),
            title: Text(
              kPantrySources[i].label,
              style: AppType.on(AppType.body, pit.text),
            ),
            trailing: Icon(
              AppIcons.chevron,
              size: 20,
              color: pit.muted,
            ),
          ),
      ],
    );
  }

  /// Passo 2 (opcional): feedback de leitura da nota via StepProgress. Usada por: [build].
  Widget _loading(PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lendo a nota',
            style: AppType.on(AppType.titleSm, pit.text2),
          ),
          const SizedBox(height: AppSpacing.md),
          StepProgress(
            steps: const ['Escanear', 'Ler', 'Conferir'],
            activeIndex: _progress,
          ),
        ],
      ),
    );
  }

  /// Passo 3: itens reconhecidos + botão de gravar na despensa. Usada por: [build].
  Widget _preview(PitadaColors pit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confira antes de guardar',
          style: AppType.on(AppType.bodySm, pit.muted),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (var i = 0; i < kRecognizedPreview.length; i++)
          HairlineRow(
            showDivider: i != kRecognizedPreview.length - 1,
            title: Text(
              kRecognizedPreview[i].name,
              style: AppType.on(AppType.body, pit.text),
            ),
            subtitle: kRecognizedPreview[i].expiresOn != null
                ? Text(
                    'Validade ${formatDayMonth(kRecognizedPreview[i].expiresOn)}',
                    style: AppType.on(AppType.captionSm, pit.muted),
                  )
                : null,
            trailing: Text(
              formatHuman(
                kRecognizedPreview[i].quantity,
                kRecognizedPreview[i].unit,
              ),
              style: AppType.on(AppType.numeralSm, pit.text),
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
        PitadaButton(
          label: 'Adicionar à despensa',
          onPressed: () {
            AppLog.i(
              'shopping',
              'preview confirmado: ${kRecognizedPreview.length} itens',
            );
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Adicionado à despensa')),
            );
          },
        ),
      ],
    );
  }
}
