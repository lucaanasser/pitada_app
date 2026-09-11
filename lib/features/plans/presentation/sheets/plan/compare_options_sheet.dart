// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/plan/compare_options_sheet.dart
// O QUÊ:     Bottom sheet que compara as opções de uma refeição lado a lado
//            (nome, macros, kcal, selo 'Hoje') e escolhe uma ao tocar.
// USA:       core/widgets (PitadaSheet, SheetGrip, HairlineRow, PitadaTag),
//            theme/*, utils/format, plan_providers, data/meal.
// USADO POR: MealCard (link 'Comparar opções').
// SPEC:      specs/features/plans/plans.yaml (showCompareOptionsSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../../../core/widgets/tags/pitada_tag.dart';
import '../../../application/plan_providers.dart';
import '../../../data/models/meal.dart';
import '../../../data/models/meal_option.dart';

/// Abre o sheet de comparação das opções de [meal]. Usada por: MealCard.
void showCompareOptionsSheet(BuildContext context, {required Meal meal}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => _CompareOptionsSheet(meal: meal),
  );
}

/// Conteúdo do sheet: uma linha por opção; tocar escolhe e fecha.
/// Usada por: showCompareOptionsSheet.
class _CompareOptionsSheet extends ConsumerWidget {
  const _CompareOptionsSheet({required this.meal});

  final Meal meal;

  /// Monta grip + título + linhas de opção. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        0,
        AppSpacing.gutter,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Text(
            'Comparar opções · ${meal.name}',
            style: AppType.on(AppType.title, pit.text),
          ),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < meal.options.length; i++)
            _optionRow(context, ref, pit, i),
        ],
      ),
    );
  }

  /// Uma opção: nome + macros embaixo; kcal + selo 'Hoje' à direita. Tocar
  /// escolhe a opção e fecha o sheet. Usada por: [build].
  Widget _optionRow(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    int i,
  ) {
    final option = meal.options[i];
    final label = option.name.isEmpty ? 'Opção ${i + 1}' : option.name;
    return HairlineRow(
      onTap: () {
        ref.read(planControllerProvider.notifier).chooseOption(meal.id, i);
        Navigator.of(context).pop();
      },
      showDivider: i < meal.options.length - 1,
      title: Text(label, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        _macrosOf(option),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (option.chosen) ...[
            const PitadaTag(label: 'Hoje', color: AppColors.sage),
            const SizedBox(width: AppSpacing.md),
          ],
          Text(
            '${formatKcal(option.totalKcal)} kcal',
            style: AppType.on(AppType.numeralSm, pit.text),
          ),
        ],
      ),
    );
  }

  /// Linha 'P x g · C y g · G z g' somada dos itens da opção. Usada por: [_optionRow].
  String _macrosOf(MealOption option) {
    num protein = 0, carb = 0, fat = 0;
    for (final it in option.items) {
      protein += it.protein;
      carb += it.carb;
      fat += it.fat;
    }
    return 'P ${formatMacro(protein)} · C ${formatMacro(carb)} · G ${formatMacro(fat)}';
  }
}
