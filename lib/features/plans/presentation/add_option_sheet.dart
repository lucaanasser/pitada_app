// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/add_option_sheet.dart
// O QUÊ:     Bottom sheet para escolher uma receita salva como nova opção da refeição.
// USA:       theme/*, core/widgets (RecipeThumb, HairlineRow, EmptyState), recipes_providers.
// USADO POR: MealCard ("Adicionar opção" em cada refeição).
// SPEC:      specs/features/plans.yaml (showAddOptionSheet)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/sheets/pitada_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/cards/hairline_row.dart';
import '../../../core/widgets/cards/recipe_thumb.dart';
import '../../recipes/application/recipes_providers.dart';
import '../../recipes/data/models/recipe.dart';
import '../data/meal.dart';
import '../../../core/widgets/sheets/sheet_grip.dart';

/// Abre o seletor de receitas para virar uma nova opção da refeição [meal].
/// Usada por: MealCard. O selo mostra "cabe" (sage) ou "+N" (accent2) na meta.
void showAddOptionSheet(BuildContext context, {required Meal meal}) {
  showPitadaSheet<void>(
    context,
    builder: (ctx) => _AddOptionSheet(meal: meal),
  );
}

/// Conteúdo do sheet: título + lista de receitas salvas com selo de encaixe.
/// Usada por: showAddOptionSheet.
class _AddOptionSheet extends ConsumerWidget {
  const _AddOptionSheet({required this.meal});

  final Meal meal;

  /// Monta o cabeçalho e a lista rolável de receitas. Usada por: showAddOptionSheet.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Padding(
            padding: AppSpacing.screenH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nova opção · ${meal.name}',
                  style: AppType.on(AppType.title, pit.text),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Escolha uma receita salva para a opção',
                  style: AppType.on(AppType.bodySm, pit.text2),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Flexible(child: _list(context, pit, recipes)),
        ],
      ),
    );
  }

  /// Lista rolável de receitas (ou vazio). Usada por: [build].
  Widget _list(BuildContext context, PitadaColors pit, List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.xxl),
        child: EmptyState(
          title: 'Sem receitas salvas',
          message: 'Importe uma receita para usá-la como opção.',
          icon: AppIcons.book,
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      padding: AppSpacing.screenH,
      children: [
        for (var i = 0; i < recipes.length; i++)
          _row(context, pit, recipes[i], showDivider: i != recipes.length - 1),
      ],
    );
  }

  /// Uma linha de receita com miniatura, kcal e selo de encaixe. Usada por: [_list].
  Widget _row(
    BuildContext context,
    PitadaColors pit,
    Recipe recipe, {
    required bool showDivider,
  }) {
    final over = recipe.kcal - meal.kcalGoal;
    final fits = over <= 0;
    return HairlineRow(
      onTap: () => _pick(context, recipe),
      showDivider: showDivider,
      leading: RecipeThumb(color: pit.card(recipe.heroColor), outlined: true),
      title: Text(
        recipe.title,
        style: AppType.on(AppType.numeralSm, pit.text),
      ),
      subtitle: Text(
        '${formatKcal(recipe.kcal)} kcal',
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Text(
        fits ? 'cabe' : '+$over',
        style: AppType.on(
          AppType.caption,
          fits ? AppColors.sage : AppColors.accent2,
        ),
      ),
    );
  }

  /// Loga a escolha e fecha o sheet (persistência entra com o backend).
  /// Usada por: [_row] ao tocar uma receita.
  void _pick(BuildContext context, Recipe recipe) {
    AppLog.i('plans', 'adicionar opção em ${meal.id}: ${recipe.id}');
    Navigator.of(context).pop();
  }
}
