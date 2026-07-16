// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/log/log_weight_sheet.dart
// O QUÊ:     Bottom sheet rápido para registrar o peso do dia (um número em kg).
// USA:       theme/*, core/widgets (PitadaButton, SheetGrip), progress_providers,
//            utils/format, app_log.
// USADO POR: ProgressView (botão "Registrar peso").
// SPEC:      specs/features/plans_progress.yaml (sheets: showLogWeightSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/format.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../application/progress_providers.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';

/// Abre o sheet de registrar peso. Usada por: ProgressView.
void showLogWeightSheet(BuildContext context) {
  showPitadaSheet<void>(
    context,
    builder: (_) => const _LogWeightSheet(),
  );
}

/// Conteúdo do sheet de peso (campo numérico + salvar). Usada por: showLogWeightSheet.
class _LogWeightSheet extends ConsumerStatefulWidget {
  const _LogWeightSheet();

  @override
  ConsumerState<_LogWeightSheet> createState() => _LogWeightSheetState();
}

class _LogWeightSheetState extends ConsumerState<_LogWeightSheet> {
  final _kg = TextEditingController();

  /// Libera o controller do campo. Usada por: framework.
  @override
  void dispose() {
    _kg.dispose();
    super.dispose();
  }

  /// Lê o campo (aceita vírgula), registra o peso e fecha. Ignora valor inválido.
  /// Usada por: botão "Salvar".
  void _save() {
    final value = double.tryParse(_kg.text.trim().replaceAll(',', '.'));
    if (value == null || value <= 0) {
      AppLog.w('plans', 'peso inválido no sheet: ${_kg.text}');
      return;
    }
    ref.read(weightControllerProvider.notifier).addWeight(value);
    Navigator.of(context).pop();
  }

  /// Monta o formulário (grip + título + campo + dica + salvar). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final entries = ref.watch(weightControllerProvider);
    final hint =
        entries.isEmpty ? 'kg' : 'último: ${formatKg(entries.last.kg)}';
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Text('Registrar peso', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.lg),
          _field(pit, hint),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'De manhã, em jejum e no mesmo horário — assim a linha é confiável.',
            style: AppType.on(AppType.caption, pit.muted),
          ),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Salvar', onPressed: _save),
        ],
      ),
    );
  }

  /// Campo numérico do peso (aceita dígitos, vírgula e ponto). Usada por: [build].
  Widget _field(PitadaColors pit, String hint) {
    return TextField(
      controller: _kg,
      autofocus: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
      ],
      style: AppType.on(AppType.numeral, pit.text),
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppType.on(AppType.body, pit.faint),
        filled: true,
        fillColor: pit.surf2,
        suffixText: 'kg',
        suffixStyle: AppType.on(AppType.body, pit.muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: pit.line2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: pit.line2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.accentLine),
        ),
      ),
    );
  }
}
