// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/plan/meal_sheet.dart
// O QUÊ:     Bottom sheet para criar/editar uma refeição (nome + meta kcal).
// USA:       theme/*, core/widgets (PitadaButton), data/meal, app_log.
// USADO POR: plans_screen (nova refeição) e MealHeaderRow (editar refeição).
// SPEC:      specs/features/plans.yaml (showMealSheet)
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
import '../../../data/models/meal.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';

/// Abre o sheet de refeição: novo (meal==null) ou editar (meal preenchido).
/// Usada por: plans_screen (botão "Adicionar refeição") e MealHeaderRow (editar).
void showMealSheet(BuildContext context, {Meal? meal}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => _MealSheet(meal: meal),
  );
}

/// Conteúdo do sheet de refeição (formulário de nome + meta). Usada por: showMealSheet.
class _MealSheet extends StatefulWidget {
  const _MealSheet({this.meal});

  final Meal? meal;

  @override
  State<_MealSheet> createState() => _MealSheetState();
}

class _MealSheetState extends State<_MealSheet> {
  late final TextEditingController _name;
  late final TextEditingController _goal;

  /// Preenche os controllers com os dados da refeição (vazios se nova). Usada por: framework.
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.meal?.name ?? '');
    _goal = TextEditingController(
      text: widget.meal == null ? '' : '${widget.meal!.kcalGoal}',
    );
  }

  /// Libera os controllers de nome e meta. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    _goal.dispose();
    super.dispose();
  }

  /// Loga a intenção e fecha o sheet (persistência entra com o backend).
  /// Usada por: botão "Salvar".
  void _save() {
    AppLog.i('plans', 'salvar refeição: ${_name.text} meta ${_goal.text}');
    Navigator.of(context).pop();
  }

  /// Loga a remoção e fecha o sheet. Usada por: ação "Remover refeição".
  void _remove() {
    AppLog.i('plans', 'remover refeição: ${widget.meal?.id}');
    Navigator.of(context).pop();
  }

  /// Monta o formulário (grip + título + campos + salvar/remover). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final editing = widget.meal != null;
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
          Text(
            editing ? 'Editar refeição' : 'Nova refeição',
            style: AppType.on(AppType.title, pit.text),
          ),
          const SizedBox(height: AppSpacing.lg),
          _field(pit, _name, 'Ex.: Pré-treino'),
          const SizedBox(height: AppSpacing.md),
          _field(pit, _goal, 'kcal', numeric: true),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Salvar', onPressed: _save),
          if (editing) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: GestureDetector(
                onTap: _remove,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Text(
                    'Remover refeição',
                    style: AppType.on(AppType.button, AppColors.accent2),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Campo de texto padrão do sheet; [numeric] mostra teclado numérico.
  /// Usada por: [build] (nome e meta de kcal).
  Widget _field(
    PitadaColors pit,
    TextEditingController controller,
    String hint, {
    bool numeric = false,
  }) {
    return TextField(
      controller: controller,
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
