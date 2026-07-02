// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_meta.dart
// O QUÊ:     Fonte de origem + meta da receita como tags coloridas (porções/tempo/nível).
// USA:       core/theme (AppIcons, PitadaColors), core/widgets/pitada_tag, format, Recipe.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: meta)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/pitada_tag.dart';
import '../../data/recipe.dart';

/// Bloco com o link de origem (quando houver) e a meta em tags coloridas.
/// Usada por: recipe_detail_screen.
class RecipeMeta extends StatelessWidget {
  const RecipeMeta({super.key, required this.recipe});

  final Recipe recipe;

  /// Monta a fonte de origem + as tags de meta. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _source(pit),
        const SizedBox(height: AppSpacing.md + 2),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            PitadaTag(
              label: '${recipe.servings} porções',
              color: pit.card('moss'),
              icon: AppIcons.servings,
            ),
            if (recipe.timeMinutes != null)
              PitadaTag(
                label: formatMinutes(recipe.timeMinutes),
                color: pit.card('teal'),
                icon: AppIcons.time,
              ),
            if (recipe.difficulty != null)
              PitadaTag(
                label: recipe.difficulty!,
                color: pit.card('ochre'),
                icon: AppIcons.difficulty,
              ),
          ],
        ),
      ],
    );
  }

  /// Link de origem clicável, ou rótulo 'Receita manual'. Usada por: [build].
  Widget _source(PitadaColors pit) {
    if (recipe.sourceUrl == null) {
      return Text(
        'Receita manual',
        style: AppType.on(AppType.caption, pit.faint),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(AppIcons.link, size: 14, color: AppColors.accent2),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            _host(recipe.sourceUrl!),
            style: AppType.on(AppType.bodySm, AppColors.accent2),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Extrai o domínio de uma URL para exibição curta. Usada por: [_source].
  String _host(String url) {
    final uri = Uri.tryParse(url);
    return uri?.host.replaceFirst('www.', '') ?? url;
  }
}
