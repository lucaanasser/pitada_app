// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/cook_mode_screen.dart
// O QUÊ:     Modo cozinhar em tela cheia: um passo por vez, com progresso no topo
//            e navegação embaixo. Ao concluir, abre o diário rápido do Caderno
//            (as 3 perguntas) — o registro acontece na hora, não depois.
// USA:       recipes_providers, cook_step_view, cook_nav_bar,
//            notebook/diary_quick_sheet, core/widgets (StepProgress), theme/*.
// USADO POR: core/router (/recipe/:id/cook) — via botão "Cozinhar" do detalhe.
// SPEC:      specs/features/recipes.yaml (CookModeScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/cards/step_progress.dart';
import '../../../notebook/presentation/sheets/diary_quick_sheet.dart';
import '../../application/recipes_providers.dart';
import '../../data/models/recipe/recipe.dart';
import '../widgets/cook/cook_nav_bar.dart';
import '../widgets/cook/cook_step_view.dart';

/// Modo cozinhar de uma receita. Guarda o índice do passo atual em memória.
/// Usada por: router (/recipe/:id/cook).
class CookModeScreen extends ConsumerStatefulWidget {
  const CookModeScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  ConsumerState<CookModeScreen> createState() => _CookModeScreenState();
}

class _CookModeScreenState extends ConsumerState<CookModeScreen> {
  int _current = 0;

  /// Avança um passo ou, no último, conclui e abre o diário rápido (as 3
  /// perguntas, no momento certo). Usada por: CookNavBar.
  void _next(Recipe recipe) {
    if (_current < recipe.allSteps.length - 1) {
      setState(() => _current++);
      return;
    }
    AppLog.i('recipes', 'cozimento concluído: ${recipe.id}');
    showDiaryQuickSheet(context, recipeName: recipe.title, recipeId: recipe.id);
    context.pop();
  }

  /// Constrói a tela cheia (sem tab bar). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final async = ref.watch(recipeByIdProvider(widget.recipeId));
    final recipe = async.valueOrNull;

    return Scaffold(
      backgroundColor: context.pit.bg,
      body: SafeArea(
        child: recipe == null || recipe.allSteps.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              )
            : _content(recipe),
      ),
    );
  }

  /// Monta topo (fechar + progresso) + passo atual + rodapé. Usada por: [build].
  Widget _content(Recipe recipe) {
    return Column(
      children: [
        _top(recipe),
        Expanded(
          child: CookStepView(
            step: recipe.allSteps[_current],
            index: _current,
            total: recipe.allSteps.length,
          ),
        ),
        CookNavBar(
          isFirst: _current == 0,
          isLast: _current == recipe.allSteps.length - 1,
          onBack: () => setState(() => _current--),
          onNext: () => _next(recipe),
        ),
      ],
    );
  }

  /// Linha "Fechar" (X) + StepProgress com rótulos curtos. Usada por: [_content].
  Widget _top(Recipe recipe) {
    final labels = [
      for (var i = 0; i < recipe.allSteps.length; i++) 'Passo ${i + 1}',
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.pop(),
              behavior: HitTestBehavior.opaque,
              child: Icon(AppIcons.close, size: 22, color: context.pit.muted),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          StepProgress(steps: labels, activeIndex: _current),
        ],
      ),
    );
  }
}
