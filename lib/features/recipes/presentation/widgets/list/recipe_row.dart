// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_row.dart
// O QUÊ:     Linha de receita na lista: marca-página de maestria (bloco-papel
//            vertical — alça no nunca-fiz; aba cheia / nº de versões / estrela)
//            + título + meta + seta. Sem miniatura: o app não é catálogo.
// USA:       core/theme (AppColors, AppIcons, AppType, PitadaColors, AppSpacing),
//            core/widgets (HairlineRow), recipe_filters (Mastery),
//            recipe_list_providers (recipeMasteryLevelProvider), recipe_meta_text,
//            Recipe.
// USADO POR: recipes_screen (via RecipeListView), framework_detail_screen,
//            technique_detail_screen; framework_row (usa InitialStamp).
// SPEC:      specs/features/recipes.yaml (RecipesScreen: recipe_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../application/recipe_filters.dart';
import '../../../application/recipe_list_providers.dart';
import '../../../data/models/recipe/recipe.dart';
import 'recipe_meta_text.dart';

/// Uma receita como linha de lista: marca-página + título + meta + seta.
/// Usada por: RecipeListView, FrameworkDetailScreen, TechniqueDetailScreen.
class RecipeRow extends ConsumerWidget {
  const RecipeRow({
    super.key,
    required this.recipe,
    this.onTap,
    this.showDivider = true,
  });

  final Recipe recipe;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha (marca-página + título + meta + seta). Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final mastery = ref.watch(recipeMasteryLevelProvider(recipe.id));
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeMark(mastery: mastery, versions: recipe.version),
      title: Text(recipe.title, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        recipeMetaText(recipe),
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}

const _kMarkW = 40.0;
const _kMarkH = 36.0;

/// Estado do marca-página, do nunca-fiz ao domino. Usada por: [RecipeMark].
enum _MarkState { never, made, versioned, mastered }

/// Traduz maestria + nº de versões no estado do marca-página. Domino vence: quem
/// domina já chegou na versão final, então não mostra contagem. Usada por: [RecipeMark].
_MarkState _markStateOf(Mastery mastery, int versions) {
  if (mastery == Mastery.mastered) return _MarkState.mastered;
  if (versions > 1) return _MarkState.versioned;
  if (mastery == Mastery.some) return _MarkState.made;
  return _MarkState.never;
}

/// Âncora de leitura da lista: um bloco-papel vertical cuja peça de topo resume
/// o histórico da receita — alça em contorno (nunca fiz), aba cheia (já fiz),
/// aba com o nº de versões (ainda iterando) ou com estrela (domino).
/// Usada por: [RecipeRow].
class RecipeMark extends StatelessWidget {
  const RecipeMark({super.key, required this.mastery, required this.versions});

  final Mastery mastery;
  final int versions;

  /// Desenha o bloco-papel + peça de topo no estado atual. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final state = _markStateOf(mastery, versions);
    return SizedBox(
      width: _kMarkW,
      height: _kMarkH,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(_kMarkW, _kMarkH),
            painter: _MarkPainter(
              filled: state != _MarkState.never,
              paper: AppColors.surfLight,
              line: AppColors.line2Light,
              tab: AppColors.moss,
            ),
          ),
          if (state == _MarkState.versioned || state == _MarkState.mastered)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 8,
              child: Center(child: _glyph(state)),
            ),
        ],
      ),
    );
  }

  /// Glifo da aba: estrela para o domino, o nº de versões caso contrário.
  /// Usada por: [build].
  Widget _glyph(_MarkState state) {
    if (state == _MarkState.mastered) {
      return const Icon(AppIcons.star, size: 6, color: AppColors.surfLight);
    }
    return FittedBox(
      child: Text(
        '$versions',
        style: AppType.on(AppType.numeralSm, AppColors.surfLight),
      ),
    );
  }
}

/// Pinta o bloco-papel (creme chapado, sem contorno, na família das pastas) e
/// a peça de topo atrás dele — aba chapada [tab] quando [filled], alça em
/// contorno no nunca-fiz. Geometria autoral na caixa 40×36, nas proporções do
/// mock. Usada por: [RecipeMark].
class _MarkPainter extends CustomPainter {
  const _MarkPainter({
    required this.filled,
    required this.paper,
    required this.line,
    required this.tab,
  });

  final bool filled;
  final Color paper;
  final Color line;
  final Color tab;

  /// Desenha aba/alça (atrás) → papel → linhas, nessa ordem. Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    if (filled) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(12.5, 0.5, 15, 12),
          const Radius.circular(2.5),
        ),
        Paint()..color = tab,
      );
    } else {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(13, 1, 14, 10),
          const Radius.circular(3),
        ),
        Paint()
          ..color = tab
          ..style = PaintingStyle.stroke
          ..strokeWidth = AppSpacing.borderStrong,
      );
    }

    final note = RRect.fromRectAndRadius(
      const Rect.fromLTWH(7, 7, 26, 29),
      const Radius.circular(3),
    );
    canvas.drawRRect(note, Paint()..color = paper);

    final linePaint = Paint()..color = line;
    for (final y in const [17.0, 22.5]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(13, y, 14, 3),
          const Radius.circular(AppSpacing.radiusPill),
        ),
        linePaint,
      );
    }
  }

  /// Repinta quando estado ou cores mudam. Usada por: framework.
  @override
  bool shouldRepaint(_MarkPainter old) =>
      old.filled != filled ||
      old.paper != paper ||
      old.line != line ||
      old.tab != tab;
}

const _kStampWidth = 34.0;

/// Capitular de lista: a inicial de [text] em Space Grotesk pesada, sem caixa,
/// num slot de largura fixa (títulos alinhados). Âncora de leitura com uma
/// função só — a variedade vem das iniciais. Usada por: FrameworkRow.
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
