// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/recipe_search_field.dart
// O QUÊ:     Campo de busca da aba Receitas: lupa + texto sobre o fundo da
//            tela (sem caixa fechada), separado por um filete embaixo — o
//            mesmo traço das listas do app, não um card flutuando por cima.
//            No fim da barra, o ícone que colapsa/abre os filtros.
// USA:       core/theme (AppIcons, PitadaColors, AppSpacing, AppType).
// USADO POR: recipes_screen.
// SPEC:      specs/features/recipes.yaml (screens.RecipesScreen.busca_e_filtros)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Campo de busca leve, no traço de filete do resto da aba Receitas, com o
/// botão de filtros no fim da barra. Usada por: recipes_screen.
class RecipeSearchField extends StatelessWidget {
  const RecipeSearchField({
    super.key,
    required this.hint,
    this.onChanged,
    this.onToggleFilters,
    this.filtersOpen = false,
    this.filtersActive = false,
  });

  final String hint;
  final ValueChanged<String>? onChanged;

  /// Abre/colapsa o painel de filtros. Usada por: recipes_screen.
  final VoidCallback? onToggleFilters;

  /// Painel aberto — o ícone fica aceso. Usada por: recipes_screen.
  final bool filtersOpen;

  /// Há filtro ligado — o ícone acende e ganha o ponto. Usada por: recipes_screen.
  final bool filtersActive;

  /// Monta lupa + campo + filtros sobre filete inferior. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      height: AppSpacing.searchBar,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: pit.line, width: AppSpacing.borderThick),
        ),
      ),
      child: Row(
        children: [
          Icon(AppIcons.search, size: 18, color: pit.muted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppType.on(AppType.body, pit.text),
              cursorColor: AppColors.accent,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hint,
                hintStyle: AppType.on(AppType.body, pit.faint),
              ),
            ),
          ),
          if (onToggleFilters != null) _filterButton(pit),
        ],
      ),
    );
  }

  /// Ícone de filtros: aceso quando aberto ou com filtro ligado, com um ponto
  /// accent que denuncia filtro ativo mesmo colapsado. Usada por: [build].
  Widget _filterButton(PitadaColors pit) {
    final lit = filtersOpen || filtersActive;
    return GestureDetector(
      onTap: onToggleFilters,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.sm),
        child: SizedBox(
          width: AppSpacing.iconButtonSm,
          height: AppSpacing.iconButtonSm,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                AppIcons.tune,
                size: 18,
                color: lit ? AppColors.accent : pit.muted,
              ),
              if (filtersActive)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    width: AppSpacing.xs,
                    height: AppSpacing.xs,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
