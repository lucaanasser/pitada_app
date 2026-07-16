// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/plan_add_sheet.dart
// O QUÊ:     Sheet "Adicionar ao Plano" — atalho do '+' do cabeçalho para os
//            MESMOS fluxos das sub-abas (não substitui os botões existentes).
// USA:       core/widgets/add_options_sheet, theme/app_icons, meal_sheet,
//            log_day_sheet, log_weight_sheet.
// USADO POR: PlansScreen (botão '+' do cabeçalho).
// SPEC:      specs/features/plans.yaml (sheets.showPlanAddSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/widgets/sheets/add_options_sheet.dart';
import 'log_day_sheet.dart';
import 'log_weight_sheet.dart';
import 'meal_sheet.dart';

/// Abre o sheet "Adicionar ao Plano" com os 3 atalhos: nova refeição (mesmo do
/// Cardápio), registrar refeição (TodaySection) e registrar peso (Progresso).
/// Usada por: PlansScreen (ação '+' do cabeçalho).
void showPlanAddSheet(BuildContext context) {
  showAddOptionsSheet(
    context,
    title: 'Adicionar ao Plano',
    options: [
      AddSheetOption(
        'Nova refeição',
        'Mais uma refeição no cardápio do dia',
        'clay',
        AppIcons.dish,
        (ctx) => showMealSheet(ctx),
      ),
      AddSheetOption(
        'Registrar refeição',
        'O que você comeu hoje',
        'ochre',
        AppIcons.logDay,
        (ctx) => showLogDaySheet(ctx),
      ),
      AddSheetOption(
        'Registrar peso',
        'Acompanhe seu progresso',
        'teal',
        AppIcons.weight,
        (ctx) => showLogWeightSheet(ctx),
      ),
    ],
  );
}
