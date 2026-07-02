// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/caderno_add_sheet.dart
// O QUÊ:     Sheet "Adicionar ao Caderno" — escolhe o que criar (ficha/nota/
//            diário/log). Tema-aware; nota e diário abrem quick sheets.
// USA:       core/widgets (HairlineRow, RecipeThumb), theme (pit/AppColors/
//            AppIcons), go_router, diary_quick_sheet, note_quick_sheet.
// USADO POR: LearningScreen (botão '+' do hub do Caderno).
// SPEC:      specs/features/learning.yaml (sheets.showCadernoAddSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/recipe_thumb.dart';
import 'diary_quick_sheet.dart';
import 'note_quick_sheet.dart';

/// Abre o bottom sheet "Adicionar ao Caderno" com as 4 opções de criação.
/// As ações usam o [context] EXTERNO (o do hub), que sobrevive ao pop do sheet.
/// Usada por: LearningScreen (ação '+' do cabeçalho).
void showCadernoAddSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: context.pit.surf,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
    ),
    builder: (ctx) => _CadernoAddSheet(rootContext: context),
  );
}

/// Conteúdo do sheet: grip + título + 4 opções (thumb colorido + HairlineRow).
/// Usada por: [showCadernoAddSheet].
class _CadernoAddSheet extends StatelessWidget {
  const _CadernoAddSheet({required this.rootContext});

  /// Contexto do hub (fora do sheet) — usado nas ações depois do pop.
  final BuildContext rootContext;

  /// As 4 opções: título, subtítulo, hero (cor), ícone e ação pós-pop.
  /// Usada por: [build].
  static final _options = <_AddOption>[
    _AddOption(
      'Ficha',
      'Técnica, framework ou guia',
      'clay',
      AppIcons.book,
      (ctx) => ctx.push('/lesson-edit'),
    ),
    _AddOption(
      'Nota de fonte',
      'O que fica de um livro, vídeo ou chef',
      'ochre',
      AppIcons.bookmark,
      (ctx) => showNoteQuickSheet(ctx),
    ),
    _AddOption(
      'Entrada de diário',
      'As três perguntas de depois de cozinhar',
      'moss',
      AppIcons.editNote,
      (ctx) => showDiaryQuickSheet(ctx),
    ),
    _AddOption(
      'Log de processo',
      'Fermentação, sous-vide, cura — avançado',
      'plum',
      AppIcons.science,
      (ctx) => ctx.push('/learning/logs'),
    ),
  ];

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
            Center(
              child: Container(
                width: 36,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: pit.line2,
                  borderRadius: AppSpacing.br(3),
                ),
              ),
            ),
            Text(
              'Adicionar ao Caderno',
              style: AppType.on(AppType.title, pit.text),
            ),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < _options.length; i++)
              HairlineRow(
                leading: RecipeThumb(
                  color: AppColors.heroOf(_options[i].hero),
                  size: 44,
                  icon: _options[i].icon,
                ),
                title: Text(
                  _options[i].title,
                  style: AppType.on(AppType.body, pit.text),
                ),
                subtitle: Text(
                  _options[i].subtitle,
                  style: AppType.on(AppType.caption, pit.muted),
                ),
                trailing: Icon(AppIcons.chevron, size: 20, color: pit.faint),
                showDivider: i != _options.length - 1,
                onTap: () {
                  // Fecha o sheet e age com o contexto EXTERNO — o ctx do
                  // builder morre no pop e quebraria push/quick sheets.
                  Navigator.of(context).pop();
                  _options[i].action(rootContext);
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Uma opção do sheet: dados visuais + ação executada com o contexto do hub.
/// Usada por: [_CadernoAddSheet].
class _AddOption {
  final String title;
  final String subtitle;
  final String hero;
  final IconData icon;
  final void Function(BuildContext) action;
  const _AddOption(
    this.title,
    this.subtitle,
    this.hero,
    this.icon,
    this.action,
  );
}
