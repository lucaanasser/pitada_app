// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/header/recipe_meta.dart
// O QUÊ:     Fonte de origem + meta da receita em TEXTO sóbrio (porções · tempo),
//            com stepper − N + que reescala a visualização por porções.
//            Métrica não vira cápsula (regra: pitada_tag.yaml).
// USA:       core/theme (AppIcons, AppColors, PitadaColors), utils/format,
//            core/widgets (Editable, PitadaIconButton), Recipe.
// USADO POR: recipe_detail_body (compositor do detalhe).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: porcoes_stepper)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_icons.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../../../core/utils/format.dart';
import '../../../../../../core/widgets/controls/editable.dart';
import '../../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../data/models/recipe/recipe.dart';

/// Bloco com o link de origem (quando houver) e a meta em texto sóbrio.
/// [viewServings] é a quantidade em visualização (stepper − +); quando difere
/// da base, o número fica accent. Segurar/duplo-clique edita a BASE.
/// Usada por: recipe_detail_body.
class RecipeMeta extends StatelessWidget {
  const RecipeMeta({
    super.key,
    required this.recipe,
    required this.viewServings,
    this.onLessServing,
    this.onMoreServing,
    this.onEditServings,
    this.onEditTime,
  });

  final Recipe recipe;
  final int viewServings;
  final VoidCallback? onLessServing;
  final VoidCallback? onMoreServing;
  final VoidCallback? onEditServings;
  final VoidCallback? onEditTime;

  /// Monta a fonte de origem + a linha de meta (stepper de porções · tempo).
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final style = AppType.on(AppType.bodySm, pit.text2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _source(pit),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _servingsStepper(pit, style),
            if (recipe.timeMinutes != null) ...[
              Text('  ·  ', style: style),
              Editable(
                onEdit: onEditTime,
                child: Text(formatMinutes(recipe.timeMinutes), style: style),
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// Stepper − N porções +: muda a visualização; o texto (editável por gesto)
  /// fica accent quando as porções vistas diferem da base. Usada por: [build].
  Widget _servingsStepper(PitadaColors pit, TextStyle style) {
    final scaled = viewServings != recipe.servings;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PitadaIconButton(
          icon: AppIcons.remove,
          size: AppSpacing.iconButtonSm,
          onPressed: viewServings > 1 ? onLessServing : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Editable(
            onEdit: onEditServings,
            child: Text(
              '$viewServings porções',
              style: scaled ? AppType.on(AppType.bodySm, AppColors.accent) : style,
            ),
          ),
        ),
        PitadaIconButton(
          icon: AppIcons.add,
          size: AppSpacing.iconButtonSm,
          onPressed: onMoreServing,
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
