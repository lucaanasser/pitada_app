// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_log/meal_list_view.dart
// O QUÊ:     Lista rolável do "Registrar dia": um DayLogMealTile por refeição
//            (com divisor) + a seção de extras no fim.
// USA:       theme/spacing, DayLogMealTile, DayLogExtrasSection, data (meal,
//            day_log: ExtraEntry).
// USADO POR: log_day_sheet (corpo do sheet).
// SPEC:      specs/features/plans/progress.yaml (sheets: showLogDaySheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../data/models/day_log.dart';
import '../../../data/models/meal.dart';
import 'day_log_extras_section.dart';
import 'day_log_meal_tile.dart';

/// Refeições + extras do dia em edição. [selected] e [skipped] refletem o
/// estado do sheet; os callbacks avisam o sheet-pai. Usada por: LogDaySheet.
class DayLogMealListView extends StatelessWidget {
  const DayLogMealListView({
    super.key,
    required this.meals,
    required this.selected,
    required this.skipped,
    required this.extras,
    required this.onSelect,
    required this.onToggleSkip,
    required this.onAddExtra,
    required this.onRemoveExtra,
  });

  final List<Meal> meals;
  final Map<String, String?> selected;
  final Set<String> skipped;
  final List<ExtraEntry> extras;
  final void Function(String mealId, String optionId) onSelect;
  final ValueChanged<String> onToggleSkip;
  final VoidCallback onAddExtra;
  final ValueChanged<int> onRemoveExtra;

  /// Monta a ListView com tiles de refeição e a seção de extras. Usada por: LogDaySheet.
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: AppSpacing.lg,
      ),
      children: [
        for (final m in meals) ...[
          DayLogMealTile(
            meal: m,
            selectedOptionId: skipped.contains(m.id) ? null : selected[m.id],
            skipped: skipped.contains(m.id),
            onSelect: (id) => onSelect(m.id, id),
            onToggleSkip: () => onToggleSkip(m.id),
          ),
          const Divider(height: AppSpacing.xl),
        ],
        DayLogExtrasSection(
          extras: extras,
          onAdd: onAddExtra,
          onRemove: onRemoveExtra,
        ),
      ],
    );
  }
}
