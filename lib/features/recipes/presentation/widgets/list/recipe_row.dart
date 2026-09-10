// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista: capitular (inicial do título, cor da
//            pasta) + título + meta + seta — sem miniatura: o app não é
//            catálogo.
// USA:       core/theme (AppColors, AppIcons, AppType, PitadaColors),
//            core/widgets (HairlineRow), recipe_meta_text, Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen,
//            technique_detail_screen; framework_row (usa InitialStamp).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../data/models/recipe/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista: capitular + título + meta + seta.
/// Usada por: RecipeListView, FrameworkDetailScreen, TechniqueDetailScreen.
class RecipeRow extends StatelessWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
    this.folderHero,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;
  final String? folderHero;

  /// Monta a linha (capitular + título + meta + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: InitialStamp(
        text: recipe.title,
        tint: folderHero != null ? AppColors.heroOf(folderHero) : pit.muted,
      ),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}

const _kStampWidth = 34.0;

/// Capitular de lista: a inicial de [text] em Space Grotesk pesada, sem caixa,
/// num slot de largura fixa (títulos alinhados). Âncora de leitura com uma
/// função só — a variedade vem das iniciais. Usada por: [RecipeRow],
/// FrameworkRow.
class InitialStamp extends StatelessWidget {
  const InitialStamp({super.key, required this.text, required this.tint});

  final String text;
  final Color tint;

  /// Desenha a inicial maiúscula tingida por [tint]. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final letter =
        text.trim().isEmpty ? '·' : text.trim().characters.first.toUpperCase();
    return SizedBox(
      width: _kStampWidth,
      child: Text(
        letter,
        textAlign: TextAlign.center,
        style: AppType.on(AppType.numeralLg, tint),
      ),
    );
  }
}
