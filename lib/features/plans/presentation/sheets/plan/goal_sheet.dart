// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/plan/goal_sheet.dart
// O QUÊ:     Bottom sheet para editar as metas diárias do plano (kcal + macros
//            em gramas). Aberto pelo link 'Editar metas' sob o anel do Plano.
// USA:       core/widgets (PitadaSheet, SheetGrip, EditTextField, PitadaButton),
//            theme/*, plan_providers (updateGoals), data/plan.
// USADO POR: plans_screen (linha 'Editar metas').
// SPEC:      specs/features/plans/plans.yaml (showGoalSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/edit_field.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../application/plan_providers.dart';
import '../../../data/models/plan.dart';

/// Abre o sheet de metas diárias pré-preenchido com as metas de [plan].
/// Usada por: plans_screen ('Editar metas').
void showGoalSheet(BuildContext context, {required Plan plan}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => _GoalSheet(plan: plan),
  );
}

/// Conteúdo do sheet de metas (4 campos numéricos + salvar). Usada por: showGoalSheet.
class _GoalSheet extends ConsumerStatefulWidget {
  const _GoalSheet({required this.plan});

  final Plan plan;

  @override
  ConsumerState<_GoalSheet> createState() => _GoalSheetState();
}

class _GoalSheetState extends ConsumerState<_GoalSheet> {
  late final TextEditingController _kcal;
  late final TextEditingController _protein;
  late final TextEditingController _carb;
  late final TextEditingController _fat;

  /// Preenche os controllers com as metas atuais do plano. Usada por: framework.
  @override
  void initState() {
    super.initState();
    _kcal = TextEditingController(text: '${widget.plan.dailyKcalGoal}');
    _protein = TextEditingController(text: '${widget.plan.proteinGoal}');
    _carb = TextEditingController(text: '${widget.plan.carbGoal}');
    _fat = TextEditingController(text: '${widget.plan.fatGoal}');
  }

  /// Libera os controllers dos 4 campos. Usada por: framework.
  @override
  void dispose() {
    _kcal.dispose();
    _protein.dispose();
    _carb.dispose();
    _fat.dispose();
    super.dispose();
  }

  /// Salva as metas no PlanController e fecha o sheet. Usada por: botão 'Salvar'.
  void _save() {
    ref.read(planControllerProvider.notifier).updateGoals(
          kcal: int.tryParse(_kcal.text),
          protein: int.tryParse(_protein.text),
          carb: int.tryParse(_carb.text),
          fat: int.tryParse(_fat.text),
        );
    Navigator.of(context).pop();
  }

  /// Monta o formulário (grip + título + 4 campos + salvar). Usada por: framework.
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
          Text('Editar metas', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.lg),
          EditTextField(
            label: 'Calorias (kcal)',
            controller: _kcal,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          EditTextField(
            label: 'Proteína (g)',
            controller: _protein,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          EditTextField(
            label: 'Carboidratos (g)',
            controller: _carb,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          EditTextField(
            label: 'Gorduras (g)',
            controller: _fat,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Salvar', onPressed: _save),
        ],
      ),
    );
  }
}
