// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_log/day_log_meal_tile.dart
// O QUÊ:     Tile de uma refeição no "Registrar dia": nome, atalho "Pulei" e as
//            opções selecionáveis (radio). Pré-seleciona a opção já escolhida no
//            plano, então confirmar o dia costuma ser zero toque.
// USA:       theme/*, core/theme/app_icons, data/meal e meal_option.
// USADO POR: log_day_sheet (uma por refeição do plano).
// SPEC:      specs/features/plans_progress.yaml (sheets: showLogDaySheet fluxo)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/meal.dart';
import '../../../data/models/meal_option.dart';

/// Tile de refeição do log do dia. [selectedOptionId] destaca a opção comida;
/// [skipped] mostra a refeição como pulada. Callbacks avisam o sheet-pai.
/// Usada por: LogDaySheet.
class DayLogMealTile extends StatelessWidget {
  const DayLogMealTile({
    super.key,
    required this.meal,
    required this.selectedOptionId,
    required this.skipped,
    required this.onSelect,
    required this.onToggleSkip,
  });

  final Meal meal;
  final String? selectedOptionId;
  final bool skipped;
  final ValueChanged<String> onSelect;
  final VoidCallback onToggleSkip;

  /// Monta o cabeçalho (nome + "Pulei") e as opções (ou o aviso de pulada).
  /// Usada por: LogDaySheet.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                meal.name,
                style: AppType.on(AppType.titleSm, pit.text),
              ),
            ),
            GestureDetector(
              onTap: onToggleSkip,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Text(
                  skipped ? 'Pulei ✓' : 'Pulei',
                  style: AppType.on(
                    AppType.caption,
                    skipped ? AppColors.accent2 : pit.muted,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (skipped)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              'Refeição pulada — não conta no dia.',
              style: AppType.on(AppType.caption, pit.faint),
            ),
          )
        else
          for (final o in meal.options) _optionRow(pit, o),
      ],
    );
  }

  /// Uma opção selecionável (radio + pratos + kcal). Usada por: [build].
  Widget _optionRow(PitadaColors pit, MealOption o) {
    final selected = o.id == selectedOptionId;
    final dishes = o.items.map((i) => i.name).join(' + ');
    return GestureDetector(
      onTap: () => onSelect(o.id),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            _radio(pit, selected),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                dishes.isEmpty ? 'Opção' : dishes,
                style: AppType.on(AppType.body, pit.text),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              '${o.totalKcal} kcal',
              style: AppType.on(AppType.caption, pit.muted),
            ),
          ],
        ),
      ),
    );
  }

  /// Marcador de rádio: círculo de contorno; preenche accent+check se selecionado.
  /// Usada por: [_optionRow].
  Widget _radio(PitadaColors pit, bool selected) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.accent : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.accent : pit.border,
          width: AppSpacing.borderStrong,
        ),
      ),
      child: selected
          ? const Icon(AppIcons.check, size: 13, color: AppColors.onAccent)
          : null,
    );
  }
}
