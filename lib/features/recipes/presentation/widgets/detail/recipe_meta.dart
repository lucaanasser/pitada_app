// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/recipe_meta.dart
// O QUÊ:     Fonte de origem + meta da receita em TEXTO sóbrio (porções · tempo).
//            Métrica não vira cápsula (regra: pitada_tag.yaml).
// USA:       core/theme (AppIcons, AppColors, PitadaColors), utils/format, Recipe.
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: meta)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/format.dart';
import '../../../../../core/widgets/controls/editable.dart';
import '../../../data/models/recipe.dart';

/// Bloco com o link de origem (quando houver) e a meta em texto sóbrio. Cada
/// segmento (porções/tempo) é editável por gesto quando o respectivo
/// onEdit* é passado. Usada por: recipe_detail_screen.
class RecipeMeta extends StatelessWidget {
  const RecipeMeta({
    super.key,
    required this.recipe,
    this.onEditServings,
    this.onEditTime,
  });

  final Recipe recipe;
  final VoidCallback? onEditServings;
  final VoidCallback? onEditTime;

  /// Monta a fonte de origem + a linha de meta em segmentos editáveis. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final segs = <(String, VoidCallback?)>[
      ('${recipe.servings} porções', onEditServings),
      if (recipe.timeMinutes != null)
        (formatMinutes(recipe.timeMinutes), onEditTime),
    ];
    final style = AppType.on(AppType.bodySm, pit.text2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _source(pit),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var i = 0; i < segs.length; i++) ...[
              if (i > 0) Text('  ·  ', style: style),
              Editable(
                onEdit: segs[i].$2,
                child: Text(segs[i].$1, style: style),
              ),
            ],
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
