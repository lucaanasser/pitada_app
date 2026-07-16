// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/log_day_sheet.dart
// O QUÊ:     Sheet "Registrar dia": em poucos toques a pessoa confirma o que comeu
//            (opção por refeição, pré-selecionada), marca refeições puladas e
//            adiciona rápido o que comeu fora do plano. Salva um DayLog (upsert);
//            se hoje já tem log, abre pré-preenchido com ele (modo editar).
// USA:       theme/*, utils/format, data (day_log/meal), providers (dayLog/
//            todayLog/plan), DayLogMealTile, DayLogExtrasSection, DayLogFooter,
//            estimate_food_sheet.
// USADO POR: TodaySection (botões "Registrar dia" e editar).
// SPEC:      specs/features/plans_progress.yaml (sheets: showLogDaySheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../core/widgets/pitada_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/format.dart';
import '../application/day_log_providers.dart';
import '../application/plans_providers.dart';
import '../data/day_log.dart';
import '../data/meal.dart';
import '../data/meal_option.dart';
import 'estimate_food_sheet.dart';
import 'widgets/day_log_extras.dart';
import 'widgets/day_log_footer.dart';
import 'widgets/day_log_meal_tile.dart';
import '../../../core/widgets/sheet_grip.dart';

/// Abre o sheet de registrar/editar o dia. Usada por: TodaySection.
void showLogDaySheet(BuildContext context) {
  showPitadaSheet<void>(
    context,
    builder: (_) => const _LogDaySheet(),
  );
}

/// Conteúdo do sheet: refeições + extras + total + salvar. Usada por: showLogDaySheet.
class _LogDaySheet extends ConsumerStatefulWidget {
  const _LogDaySheet();

  @override
  ConsumerState<_LogDaySheet> createState() => _LogDaySheetState();
}

class _LogDaySheetState extends ConsumerState<_LogDaySheet> {
  final Map<String, String?> _selected = {};
  final Set<String> _skipped = {};
  final List<ExtraEntry> _extras = [];

  /// Pré-preenche o sheet: se HOJE já tem log, restaura escolhas/puladas/extras
  /// (editar não pode zerar o registro); senão, pré-seleciona a opção já
  /// escolhida no plano (confirmar tende a ser 0 toque). Usada por: framework.
  @override
  void initState() {
    super.initState();
    final existing = ref.read(todayLogProvider);
    if (existing != null) {
      for (final m in existing.meals) {
        _selected[m.mealId] = m.optionId;
        if (m.skipped) _skipped.add(m.mealId);
      }
      _extras.addAll(existing.extras);
      return;
    }
    for (final m in ref.read(planControllerProvider).meals) {
      _selected[m.id] = m.chosenOption?.id;
    }
  }

  /// Total de kcal do dia em edição: refeições feitas + extras. Usada por: [build]/[_save].
  int _total(List<Meal> meals) {
    var sum = 0;
    for (final m in meals) {
      if (_skipped.contains(m.id)) continue;
      final o = _optionOf(m);
      if (o != null) sum += o.totalKcal;
    }
    for (final e in _extras) {
      sum += e.kcal;
    }
    return sum;
  }

  /// Opção selecionada de uma refeição (null se pulada/sem escolha). Usada por: totais/save.
  MealOption? _optionOf(Meal m) {
    final id = _selected[m.id];
    if (id == null) return null;
    for (final o in m.options) {
      if (o.id == id) return o;
    }
    return null;
  }

  /// Abre a estimativa por IA e adiciona o extra retornado. Usada por: "+ Adicionar".
  Future<void> _addExtra() async {
    final extra = await showEstimateFoodSheet(context);
    if (extra != null) setState(() => _extras.add(extra));
  }

  /// Monta o DayLog do dia e salva (upsert por data). Usada por: botão "Salvar dia".
  void _save(List<Meal> meals) {
    final entries = [
      for (final m in meals) _entryFor(m),
    ];
    ref.read(dayLogControllerProvider.notifier).saveDay(
          DayLog(date: DateTime.now(), meals: entries, extras: _extras),
        );
    Navigator.of(context).pop();
  }

  /// Converte uma refeição + escolha atual em MealLogEntry (com macros). Usada por: [_save].
  MealLogEntry _entryFor(Meal m) {
    final skipped = _skipped.contains(m.id);
    final o = skipped ? null : _optionOf(m);
    num p = 0, c = 0, f = 0;
    for (final it in o?.items ?? const []) {
      p += it.protein;
      c += it.carb;
      f += it.fat;
    }
    return MealLogEntry(
      mealId: m.id,
      mealName: m.name,
      optionId: o?.id,
      skipped: skipped,
      kcal: o?.totalKcal ?? 0,
      protein: p,
      carb: c,
      fat: f,
    );
  }

  /// Monta o sheet inteiro (grip + título + refeições/extras + rodapé). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final plan = ref.watch(planControllerProvider);
    final total = _total(plan.meals);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.82,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetGrip(),
            Padding(
              padding: AppSpacing.screenH,
              child: Text(
                'Registrar dia · ${formatDayMonth(DateTime.now())}',
                style: AppType.on(AppType.title, pit.text),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(child: _body(pit, plan.meals)),
            DayLogFooter(
              total: total,
              goal: plan.dailyKcalGoal,
              onSave: () => _save(plan.meals),
            ),
          ],
        ),
      ),
    );
  }

  /// Lista rolável: refeições + seção de extras. Usada por: [build].
  Widget _body(PitadaColors pit, List<Meal> meals) {
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
            selectedOptionId: _skipped.contains(m.id) ? null : _selected[m.id],
            skipped: _skipped.contains(m.id),
            onSelect: (id) => setState(() {
              _skipped.remove(m.id);
              _selected[m.id] = id;
            }),
            onToggleSkip: () => setState(() {
              _skipped.contains(m.id)
                  ? _skipped.remove(m.id)
                  : _skipped.add(m.id);
            }),
          ),
          const Divider(height: AppSpacing.xl),
        ],
        DayLogExtrasSection(
          extras: _extras,
          onAdd: _addExtra,
          onRemove: (i) => setState(() => _extras.removeAt(i)),
        ),
      ],
    );
  }
}
