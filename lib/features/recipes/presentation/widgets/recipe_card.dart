// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_card.dart
// O QUÊ:     Card de receita: bloco de foto (pastel) + título + tags coloridas.
//            [compact] encolhe para caber em 2 colunas. Reage ao tema; sem sombra.
// USA:       core/theme (AppIcons, PitadaColors), core/widgets/pitada_tag, format, Recipe.
// USADO POR: recipes_screen (modos single e grid).
// SPEC:      specs/components/recipe_card.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/pitada_tag.dart';
import '../../data/recipe.dart';

/// Card de receita com foto (placeholder colorido) e meta em tags. Usada por: recipes_screen.
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.compact = false,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: pit.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusCard),
          border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(pit),
            Padding(
              padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: AppType.on(
                        compact ? AppType.titleSm : AppType.title, pit.text),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.xs + 2,
                    runSpacing: AppSpacing.xs + 2,
                    children: [
                      if (recipe.timeMinutes != null)
                        PitadaTag(
                          label: formatMinutes(recipe.timeMinutes),
                          color: pit.card('teal'),
                          icon: AppIcons.time,
                        ),
                      if (!compact)
                        PitadaTag(
                          label: '${formatKcal(recipe.kcal)} kcal',
                          color: pit.card('ochre'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bloco de "foto" (cor pastel do hero) com ícone e tag de dificuldade no canto.
  /// Usada por: [build].
  Widget _image(PitadaColors pit) {
    return SizedBox(
      height: compact ? 108 : 158,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: pit.card(recipe.heroColor),
                border: Border(
                  bottom: BorderSide(
                      color: pit.border, width: AppSpacing.borderStrong),
                ),
              ),
              child: Center(
                child: Icon(
                  AppIcons.dish,
                  size: compact ? 40 : 56,
                  color:
                      (pit.isDark ? pit.text : pit.border).withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          if (recipe.difficulty != null)
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: PitadaTag(label: recipe.difficulty!, color: pit.surf),
            ),
        ],
      ),
    );
  }
}
