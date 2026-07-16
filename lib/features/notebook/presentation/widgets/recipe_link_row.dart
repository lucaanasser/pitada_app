// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/recipe_link_row.dart
// O QUÊ:     Linha "abrir receita" — resolve o título por id e navega p/ /recipe/<id>.
// USA:       recipes_providers (recipeByIdProvider), core/widgets, theme/*, go_router.
// USADO POR: NoteDetailScreen, DiaryEntryScreen, VersionHistoryScreen ("Aplica/Ligado a").
// SPEC:      specs/features/notebook.yaml (applies -> RecipeDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/cards/recipe_thumb.dart';
import '../../../../features/recipes/application/recipes_providers.dart';

/// Linha que liga a uma receita: mostra o título (ou o id como fallback) e
/// navega para /recipe/<id> ao tocar. Usada por: detalhes do Caderno.
class RecipeLinkRow extends ConsumerWidget {
  const RecipeLinkRow({
    super.key,
    required this.recipeId,
    this.showDivider = true,
  });

  final String recipeId;
  final bool showDivider;

  /// Resolve o título da receita e monta a linha navegável. Usada por: detalhes.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final recipe = ref.watch(recipeByIdProvider(recipeId)).valueOrNull;
    final title = recipe?.title ?? recipeId;
    final hero = recipe?.heroColor ?? 'clay';
    return HairlineRow(
      onTap: () => context.push('/recipe/$recipeId'),
      showDivider: showDivider,
      leading: RecipeThumb(color: AppColors.heroOf(hero), size: 42),
      title: Text(title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        'Abrir receita',
        style: AppType.on(AppType.caption, AppColors.accent),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}
