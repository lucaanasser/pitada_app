// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/food/estimate_input_view.dart
// O QUÊ:     Modo de entrada do sheet de estimativa: chips de 1 toque (itens
//            comuns), campo de linguagem natural e botão "Estimar".
// USA:       theme/*, PitadaChip, PitadaButton, EstimateFieldView, providers
//            (foodsProvider), data (food_item).
// USADO POR: estimate_food_sheet (quando ainda não há resultado).
// SPEC:      specs/features/plans_progress.yaml (sheets: showEstimateFoodSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/controls/pitada_chip.dart';
import '../../../application/progress_providers.dart';
import '../../../data/models/food_item.dart';
import 'estimate_field_view.dart';

/// Ids da base curada mostrados como chips de 1 toque (itens super comuns).
/// Usada por: [EstimateInputView].
const List<String> _kQuickIds = [
  'cerveja',
  'brigadeiro',
  'pizza',
  'refri',
  'cafe_leite',
  'coxinha',
];

/// Chips rápidos + campo de linguagem natural + botão estimar. [onPick] devolve
/// o item curado tocado; [onEstimate] dispara a IA. Usada por: EstimateFoodSheet.
class EstimateInputView extends ConsumerWidget {
  const EstimateInputView({
    super.key,
    required this.controller,
    required this.loading,
    required this.onEstimate,
    required this.onPick,
  });

  final TextEditingController controller;
  final bool loading;
  final VoidCallback onEstimate;
  final ValueChanged<FoodItem> onPick;

  /// Monta chips + campo + botão. Usada por: EstimateFoodSheet.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final quick = [
      for (final id in _kQuickIds)
        for (final f in ref.watch(foodsProvider))
          if (f.id == id) f,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final f in quick)
              PitadaChip(label: f.name, onTap: () => onPick(f)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        EstimateFieldView(
          controller: controller,
          hint: 'Ex.: 5 colheres de brigadeiro',
          onSubmitted: (_) => onEstimate(),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Descreva em linguagem natural — a IA estima as calorias.',
          style: AppType.on(AppType.caption, pit.muted),
        ),
        const SizedBox(height: AppSpacing.xl),
        PitadaButton(
          label: loading ? 'Estimando…' : 'Estimar',
          onPressed: loading ? null : onEstimate,
        ),
      ],
    );
  }
}
