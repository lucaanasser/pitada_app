// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_card.dart
// O QUÊ:     Card de receita sóbrio: bloco de foto (pastel) + título + uma linha
//            de meta em texto (tempo · kcal). [compact] encolhe
//            p/ 2 colunas. Reage ao tema; sem sombra, sem pílulas.
// USA:       core/theme (AppIcons, PitadaColors), recipe_meta_text, Recipe.
// USADO POR: folder_screen (grade da pasta).
// SPEC:      specs/components/recipe_card.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/recipe.dart';
import 'recipe_meta_text.dart';

/// Card de receita com foto (placeholder colorido) e meta em texto sóbrio.
/// [mastery] é a linha de maestria opcional ("nunca fiz" / "fiz 2×" / "domino").
/// Usada por: folder_screen (grade da pasta).
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.compact = false,
    this.mastery,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool compact;
  final String? mastery;

  /// Monta a caixa (borda tinta) com foto, título e meta. Usada por: framework.
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
                      compact ? AppType.titleSm : AppType.title,
                      pit.text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs + 2),
                  Text(
                    recipeMetaText(recipe),
                    style: AppType.on(AppType.bodySm, pit.text2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (mastery != null && mastery!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Text(
                        mastery!,
                        style: AppType.on(AppType.captionSm, pit.muted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bloco de "foto" (cor pastel do hero) com ícone de prato ao centro.
  /// Usada por: [build].
  Widget _image(PitadaColors pit) {
    return Container(
      height: compact ? 108 : 158,
      width: double.infinity,
      decoration: BoxDecoration(
        color: pit.card(recipe.heroColor),
        border: Border(
          bottom: BorderSide(color: pit.border, width: AppSpacing.borderStrong),
        ),
      ),
      child: Center(
        child: Icon(
          AppIcons.dish,
          size: compact ? 40 : 56,
          color: (pit.isDark ? pit.text : pit.border).withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
