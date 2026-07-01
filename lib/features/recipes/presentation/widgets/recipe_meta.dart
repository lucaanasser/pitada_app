// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/recipe_meta.dart
// O QUÊ:     Fonte clicável + meta da receita (porções · tempo · dificuldade).
// USA:       theme/*, utils/format, Recipe, url_launcher NÃO (link é placeholder).
// USADO POR: recipe_detail_screen.
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: meta)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../data/recipe.dart';

/// Bloco com o link de origem (quando houver) e três metadados da receita.
/// Usada por: recipe_detail_screen.
class RecipeMeta extends StatelessWidget {
  const RecipeMeta({super.key, required this.recipe});

  final Recipe recipe;

  /// Monta a fonte de origem + a linha de três metadados. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _source(),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            _item('${recipe.servings}', 'porções'),
            if (recipe.timeMinutes != null)
              _item(formatMinutes(recipe.timeMinutes), 'tempo'),
            if (recipe.difficulty != null) _item(recipe.difficulty!, 'nível'),
          ],
        ),
      ],
    );
  }

  /// Link de origem clicável, ou rótulo 'Receita manual'. Usada por: [build].
  Widget _source() {
    if (recipe.sourceUrl == null) {
      return Text('Receita manual',
          style: AppType.on(AppType.caption, AppColors.faint));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.link, size: 14, color: AppColors.accent2),
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

  /// Um metadado: valor em serifa + rótulo em versalete. Usada por: [build].
  Widget _item(String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppType.numeralSm),
          const SizedBox(height: 1),
          Text(label, style: AppType.on(AppType.caption, AppColors.muted)),
        ],
      ),
    );
  }

  /// Extrai o domínio de uma URL para exibição curta. Usada por: [_source].
  String _host(String url) {
    final uri = Uri.tryParse(url);
    return uri?.host.replaceFirst('www.', '') ?? url;
  }
}
