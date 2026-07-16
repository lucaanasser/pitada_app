// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/cook_chat_sheet.dart
// O QUÊ:     Bottom sheet de feedback pós-preparo ("Como ficou?"): 4 opções rápidas
//            e um card de ajuste sugerido (accentSoft/accentLine) com "Salvar ajuste".
// USA:       cook_feedback_options, sheet_grip, core/widgets (PitadaButton), theme/*.
// USADO POR: cook_mode_screen (ao concluir o último passo) via showCookChatSheet.
// SPEC:      specs/features/recipes.yaml (SHEET-COOKCHAT)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/sheets/pitada_sheet.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../data/recipe.dart';
import 'widgets/cook_feedback_options.dart';
import '../../../core/widgets/sheets/sheet_grip.dart';

/// Opções de feedback e o ajuste sugerido para cada uma (mock fixo).
/// 'Ficou perfeito' não tem ajuste (valor vazio). Usada por: _CookChatSheet.
const _kFeedback = <String, String>{
  'Ficou salgado': 'Reduza o sal em ~20% na próxima vez.',
  'Faltou cozimento': 'Aumente o tempo em ~5 min ou reduza o fogo.',
  'Ficou seco': 'Retire do fogo um pouco antes e deixe descansar tampado.',
  'Ficou perfeito': '',
};

/// Abre a sheet de feedback pós-preparo (surf, cantos arredondados, grip).
/// Usada por: cook_mode_screen ao concluir o preparo.
void showCookChatSheet(BuildContext context, {required Recipe recipe}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => _CookChatSheet(recipe: recipe),
  );
}

/// Conteúdo da sheet: guarda a opção escolhida e mostra o ajuste sugerido.
/// Usada por: showCookChatSheet.
class _CookChatSheet extends StatefulWidget {
  const _CookChatSheet({required this.recipe});

  final Recipe recipe;

  @override
  State<_CookChatSheet> createState() => _CookChatSheetState();
}

class _CookChatSheetState extends State<_CookChatSheet> {
  int _selected = -1;

  /// Rótulos das opções, na ordem exibida. Usada por: [build] e [_suggestion].
  List<String> get _options => _kFeedback.keys.toList();

  /// Ajuste sugerido para a opção marcada (vazio = sem ajuste). Usada por: [build].
  String get _suggestion =>
      _selected < 0 ? '' : _kFeedback[_options[_selected]] ?? '';

  /// Registra o ajuste nas anotações (mock: log) e fecha. Usada por: botão salvar.
  void _saveAdjust() {
    AppLog.i('recipes', 'feedback: ${_options[_selected]}');
    Navigator.of(context).pop();
  }

  /// Monta título + opções + card de ajuste + rodapé. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final hasSuggestion = _suggestion.isNotEmpty;
    final title = widget.recipe.title;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xxxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetGrip(),
            Text('Como ficou?', style: AppType.on(AppType.title, pit.text)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Seu retorno afina "$title".',
              style: AppType.on(AppType.body, pit.muted),
            ),
            const SizedBox(height: AppSpacing.xl),
            CookFeedbackOptions(
              options: _options,
              selected: _selected,
              onSelect: (i) => setState(() => _selected = i),
            ),
            if (_selected >= 0) ...[
              const SizedBox(height: AppSpacing.xl),
              hasSuggestion ? _adjustCard(pit) : _congrats(),
            ],
            const SizedBox(height: AppSpacing.xl),
            if (hasSuggestion)
              PitadaButton(
                label: 'Salvar ajuste',
                icon: AppIcons.check,
                onPressed: _saveAdjust,
              )
            else
              PitadaButton(
                label: 'Fechar',
                variant: PitadaButtonVariant.outline,
                onPressed: () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    );
  }

  /// Card de ajuste sugerido (accentSoft/accentLine). Usada por: [build].
  Widget _adjustCard(PitadaColors pit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: AppSpacing.br(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.accentLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AJUSTE SUGERIDO',
            style: AppType.on(AppType.label, AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(_suggestion, style: AppType.on(AppType.tip, pit.text2)),
        ],
      ),
    );
  }

  /// Mensagem de parabéns quando ficou perfeito (sem ajuste). Usada por: [build].
  Widget _congrats() {
    return Text(
      'Perfeito. Receita guardada como está — bom apetite!',
      style: AppType.on(AppType.tip, AppColors.sage),
    );
  }
}
