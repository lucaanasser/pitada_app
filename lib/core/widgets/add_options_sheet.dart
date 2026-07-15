// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/add_options_sheet.dart
// O QUÊ:     Bottom sheet padrão "escolher o que adicionar": grip + título +
//            opções (miniatura hero + título + subtítulo). Destino do '+' do
//            header de cada aba. Promovido do caderno_add_sheet (reuso).
// USA:       pitada_sheet, sheet_grip, hairline_row, recipe_thumb, theme/*.
// USADO POR: caderno_add_sheet, plan_add_sheet, shopping_add_sheet.
// SPEC:      specs/components/add_options_sheet.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import 'hairline_row.dart';
import 'pitada_sheet.dart';
import 'recipe_thumb.dart';
import 'sheet_grip.dart';

/// Uma opção do sheet: dados visuais + ação executada DEPOIS do pop, com o
/// contexto externo (da tela) — que sobrevive ao fechamento do sheet.
/// Usada por: caderno_add_sheet, plan_add_sheet, shopping_add_sheet.
class AddSheetOption {
  final String title;
  final String subtitle;
  final String hero; // nome da cor hero da miniatura (AppColors.heroOf)
  final IconData icon;
  final void Function(BuildContext) action;
  const AddSheetOption(
    this.title,
    this.subtitle,
    this.hero,
    this.icon,
    this.action,
  );
}

/// Abre o sheet "escolher o que adicionar" com [title] e [options]. As ações
/// são SEMPRE atalhos para fluxos já existentes (mesmo destino, nunca novo).
/// Usada por: showCadernoAddSheet, showPlanAddSheet, showShoppingAddSheet.
void showAddOptionsSheet(
  BuildContext context, {
  required String title,
  required List<AddSheetOption> options,
}) {
  showPitadaSheet<void>(
    context,
    builder: (_) =>
        _AddOptionsSheet(title: title, options: options, rootContext: context),
  );
}

/// Conteúdo do sheet: grip + título + uma HairlineRow por opção.
/// Usada por: [showAddOptionsSheet].
class _AddOptionsSheet extends StatelessWidget {
  const _AddOptionsSheet({
    required this.title,
    required this.options,
    required this.rootContext,
  });

  final String title;
  final List<AddSheetOption> options;

  /// Contexto da tela (fora do sheet) — usado nas ações depois do pop.
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.md,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetGrip(),
            Text(title, style: AppType.on(AppType.title, pit.text)),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < options.length; i++)
              HairlineRow(
                leading: RecipeThumb(
                  color: AppColors.heroOf(options[i].hero),
                  size: 44,
                  icon: options[i].icon,
                ),
                title: Text(
                  options[i].title,
                  style: AppType.on(AppType.body, pit.text),
                ),
                subtitle: Text(
                  options[i].subtitle,
                  style: AppType.on(AppType.caption, pit.muted),
                ),
                trailing: Icon(AppIcons.chevron, size: 20, color: pit.faint),
                showDivider: i != options.length - 1,
                onTap: () {
                  // Fecha o sheet e age com o contexto EXTERNO — o ctx do
                  // builder morre no pop e quebraria push/quick sheets.
                  Navigator.of(context).pop();
                  options[i].action(rootContext);
                },
              ),
          ],
        ),
      ),
    );
  }
}
