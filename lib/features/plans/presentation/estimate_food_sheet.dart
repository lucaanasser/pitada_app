// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/estimate_food_sheet.dart
// O QUÊ:     Sheet p/ logar algo fora do plano: chips de 1 toque (comuns) + campo
//            de linguagem natural estimado por IA ("5 colheres de brigadeiro").
//            Mostra a estimativa (kcal/macros), permite ajustar e devolve ExtraEntry.
// USA:       theme/*, core/widgets (SheetGrip, PitadaChip, PitadaButton), providers
//            (foodsProvider, foodEstimateServiceProvider), data (food_item/day_log).
// USADO POR: log_day_sheet ("+ Adicionar algo fora do plano").
// SPEC:      specs/features/plans_progress.yaml (sheets: showEstimateFoodSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../core/widgets/pitada_sheet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_chip.dart';
import '../application/food_estimate_service.dart';
import '../application/progress_providers.dart';
import '../data/day_log.dart';
import '../../../core/widgets/sheet_grip.dart';

/// Ids da base curada mostrados como chips de 1 toque (itens super comuns).
/// Usada por: [_EstimateFoodSheet].
const List<String> _kQuickIds = [
  'cerveja',
  'brigadeiro',
  'pizza',
  'refri',
  'cafe_leite',
  'coxinha',
];

/// Abre o sheet de estimativa e devolve o ExtraEntry escolhido (ou null).
/// Usada por: log_day_sheet.
Future<ExtraEntry?> showEstimateFoodSheet(BuildContext context) {
  return showPitadaSheet<ExtraEntry>(
    context,
    builder: (_) => const _EstimateFoodSheet(),
  );
}

/// Conteúdo do sheet (chips + campo + estimativa). Usada por: showEstimateFoodSheet.
class _EstimateFoodSheet extends ConsumerStatefulWidget {
  const _EstimateFoodSheet();

  @override
  ConsumerState<_EstimateFoodSheet> createState() => _EstimateFoodSheetState();
}

class _EstimateFoodSheetState extends ConsumerState<_EstimateFoodSheet> {
  final _input = TextEditingController();
  final _kcalEdit = TextEditingController();
  bool _loading = false;
  bool _adjusting = false;
  ExtraEntry? _result;

  @override
  void dispose() {
    _input.dispose();
    _kcalEdit.dispose();
    super.dispose();
  }

  /// Chama a estimativa (IA/mock) com o texto digitado. Usada por: botão "Estimar".
  Future<void> _estimate() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    setState(() => _loading = true);
    final extra = await ref.read(foodEstimateServiceProvider).estimate(text);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _result = extra;
      _kcalEdit.text = '${extra.kcal}';
    });
  }

  /// Adiciona o resultado (com kcal ajustada se editado) e fecha. Usada por: "Adicionar".
  void _add() {
    final r = _result!;
    final kcal = int.tryParse(_kcalEdit.text.trim()) ?? r.kcal;
    Navigator.of(context).pop(
      ExtraEntry(
        foodId: r.foodId,
        name: r.name,
        portion: r.portion,
        kcal: kcal,
        protein: r.protein,
        carb: r.carb,
        fat: r.fat,
      ),
    );
  }

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
          Text('O que você comeu?', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.md),
          if (_result == null) ..._inputMode(pit) else ..._resultMode(pit),
        ],
      ),
    );
  }

  /// Modo de entrada: chips rápidos + campo de texto + botão estimar. Usada por: [build].
  List<Widget> _inputMode(PitadaColors pit) {
    final quick = [
      for (final id in _kQuickIds)
        for (final f in ref.watch(foodsProvider))
          if (f.id == id) f,
    ];
    return [
      Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final f in quick)
            PitadaChip(
              label: f.name,
              onTap: () => Navigator.of(context).pop(ExtraEntry.fromFood(f)),
            ),
        ],
      ),
      const SizedBox(height: AppSpacing.lg),
      _field(pit),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Descreva em linguagem natural — a IA estima as calorias.',
        style: AppType.on(AppType.caption, pit.muted),
      ),
      const SizedBox(height: AppSpacing.xl),
      PitadaButton(
        label: _loading ? 'Estimando…' : 'Estimar',
        onPressed: _loading ? null : _estimate,
      ),
    ];
  }

  /// Modo resultado: estimativa + ajuste de kcal + adicionar/refazer. Usada por: [build].
  List<Widget> _resultMode(PitadaColors pit) {
    final r = _result!;
    return [
      Text(r.name, style: AppType.on(AppType.titleSm, pit.text)),
      if (r.portion.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: Text(r.portion, style: AppType.on(AppType.caption, pit.muted)),
        ),
      const SizedBox(height: AppSpacing.md),
      if (_adjusting)
        _kcalField(pit)
      else
        Text(
          '${r.kcal} kcal',
          style: AppType.on(AppType.displayXl, pit.text),
        ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Aprox. P ${_g(r.protein)} · C ${_g(r.carb)} · G ${_g(r.fat)}',
        style: AppType.on(AppType.caption, pit.text2),
      ),
      const SizedBox(height: AppSpacing.xl),
      Row(
        children: [
          Expanded(
            child: PitadaButton(
              label: _adjusting ? 'Pronto' : 'Ajustar',
              variant: PitadaButtonVariant.outline,
              onPressed: () => setState(() => _adjusting = !_adjusting),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: PitadaButton(label: 'Adicionar', onPressed: _add)),
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      Center(
        child: GestureDetector(
          onTap: () => setState(() {
            _result = null;
            _adjusting = false;
          }),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(
              'Descrever outra coisa',
              style: AppType.on(AppType.caption, AppColors.accent),
            ),
          ),
        ),
      ),
    ];
  }

  /// Formata gramas curtinho p/ a legenda de macros. Usada por: [_resultMode].
  String _g(num n) => '${n.round()} g';

  /// Campo de linguagem natural (autofocus). Usada por: [_inputMode].
  Widget _field(PitadaColors pit) {
    return TextField(
      controller: _input,
      autofocus: true,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _estimate(),
      style: AppType.on(AppType.body, pit.text),
      cursorColor: AppColors.accent,
      decoration: _inputDeco(pit, 'Ex.: 5 colheres de brigadeiro'),
    );
  }

  /// Campo numérico p/ ajustar a kcal estimada. Usada por: [_resultMode].
  Widget _kcalField(PitadaColors pit) {
    return TextField(
      controller: _kcalEdit,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: AppType.on(AppType.numeral, pit.text),
      cursorColor: AppColors.accent,
      decoration: _inputDeco(pit, 'kcal').copyWith(suffixText: 'kcal'),
    );
  }

  /// Decoração padrão dos campos do sheet. Usada por: [_field]/[_kcalField].
  InputDecoration _inputDeco(PitadaColors pit, String hint) {
    return InputDecoration(
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
    );
  }
}
