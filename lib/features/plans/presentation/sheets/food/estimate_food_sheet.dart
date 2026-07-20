// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/food/estimate_food_sheet.dart
// O QUÊ:     Sheet p/ logar algo fora do plano: chips de 1 toque (comuns) + campo
//            de linguagem natural estimado por IA ("5 colheres de brigadeiro").
//            Mostra a estimativa (kcal/macros), permite ajustar e devolve ExtraEntry.
// USA:       theme/*, core/widgets (SheetGrip), EstimateInputView,
//            EstimateResultView, providers (foodEstimateServiceProvider),
//            data (day_log).
// USADO POR: log_day_sheet ("+ Adicionar algo fora do plano").
// SPEC:      specs/features/plans/progress.yaml (sheets: showEstimateFoodSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../application/food_estimate_service.dart';
import '../../../data/models/day_log.dart';
import 'estimate_input_view.dart';
import 'estimate_result_view.dart';

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

  /// Monta o sheet: grip + título + modo entrada ou resultado. Usada por: framework.
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
          if (_result == null)
            EstimateInputView(
              controller: _input,
              loading: _loading,
              onEstimate: _estimate,
              onPick: (f) => Navigator.of(context).pop(ExtraEntry.fromFood(f)),
            )
          else
            EstimateResultView(
              result: _result!,
              adjusting: _adjusting,
              kcalController: _kcalEdit,
              onToggleAdjust: () => setState(() => _adjusting = !_adjusting),
              onAdd: _add,
              onReset: () => setState(() {
                _result = null;
                _adjusting = false;
              }),
            ),
        ],
      ),
    );
  }
}
