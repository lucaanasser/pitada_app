// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/food/free_item_sheet.dart
// O QUÊ:     Sheet de item livre: registrar algo comido fora do plano que não está
//            no dataset (nome + kcal aproximada). Retorna um ExtraEntry.
// USA:       theme/*, core/widgets (PitadaButton, SheetGrip), data/day_log, app_log.
// USADO POR: food_search_sheet ("+ Outro").
// SPEC:      specs/features/plans_progress.yaml (sheets: showFoodSearchSheet -> "+ Outro")
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../data/models/day_log.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';

/// Abre o sheet de item livre e devolve o ExtraEntry (ou null se cancelou).
/// Usada por: food_search_sheet.
Future<ExtraEntry?> showFreeItemSheet(BuildContext context) {
  return showPitadaSheet<ExtraEntry>(
    context,
    builder: (_) => const _FreeItemSheet(),
  );
}

/// Formulário de item livre (nome + kcal). Usada por: showFreeItemSheet.
class _FreeItemSheet extends StatefulWidget {
  const _FreeItemSheet();

  @override
  State<_FreeItemSheet> createState() => _FreeItemSheetState();
}

class _FreeItemSheetState extends State<_FreeItemSheet> {
  final _name = TextEditingController();
  final _kcal = TextEditingController();

  /// Libera os controllers. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    _kcal.dispose();
    super.dispose();
  }

  /// Valida nome + kcal e devolve o ExtraEntry ao chamador. Usada por: botão "Adicionar".
  void _add() {
    final name = _name.text.trim();
    final kcal = int.tryParse(_kcal.text.trim());
    if (name.isEmpty || kcal == null || kcal <= 0) {
      AppLog.w('plans', 'item livre inválido: "$name" ${_kcal.text}');
      return;
    }
    Navigator.of(context).pop(ExtraEntry(name: name, kcal: kcal));
  }

  /// Monta o formulário do item livre. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
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
          Text('Outro item', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Uma boa estimativa já basta.',
            style: AppType.on(AppType.caption, pit.muted),
          ),
          const SizedBox(height: AppSpacing.lg),
          _field(pit, _name, 'Ex.: bombom, marmita da vó', autofocus: true),
          const SizedBox(height: AppSpacing.md),
          _field(pit, _kcal, 'kcal aprox.', numeric: true),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Adicionar', onPressed: _add),
        ],
      ),
    );
  }

  /// Campo de texto padrão do sheet; [numeric] usa teclado numérico. Usada por: [build].
  Widget _field(
    PitadaColors pit,
    TextEditingController c,
    String hint, {
    bool numeric = false,
    bool autofocus = false,
  }) {
    return TextField(
      controller: c,
      autofocus: autofocus,
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      inputFormatters:
          numeric ? [FilteringTextInputFormatter.digitsOnly] : null,
      style: AppType.on(AppType.body, pit.text),
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppType.on(AppType.body, pit.faint),
        filled: true,
        fillColor: pit.surf2,
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
