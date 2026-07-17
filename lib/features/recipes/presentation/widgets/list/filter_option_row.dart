// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/filter_option_row.dart
// O QUÊ:     Um eixo de filtro: rótulo do eixo + suas opções em TEXTO, a ligada
//            com filete accent embaixo — o traço do PitadaTabs, sem cápsula
//            (cápsula é só tag). Serve eixo de marcar vários e o de ordem.
// USA:       core/theme (AppColors, PitadaColors, AppSpacing, AppType).
// USADO POR: recipe_filter_panel (maestria, tempo, calorias, ordenar por).
// SPEC:      specs/features/recipes.yaml (screens.RecipesScreen.filtros)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// Uma opção de filtro: o rótulo pt-BR e se está ligada. Usada por: FilterOptionRow.
class FilterOption {
  const FilterOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
}

/// Eixo de filtro em texto: rótulo discreto + opções com filete accent na ligada.
/// Usada por: recipe_filter_panel.
class FilterOptionRow extends StatelessWidget {
  const FilterOptionRow({
    super.key,
    required this.label,
    required this.options,
  });

  final String label;
  final List<FilterOption> options;

  /// Monta o rótulo do eixo e a fileira de opções. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppType.on(AppType.captionSm, pit.faint)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.md,
            children: [for (final o in options) _option(pit, o)],
          ),
        ],
      ),
    );
  }

  /// Opção tocável: texto (ligada em text, solta em muted) sobre o filete accent
  /// que só existe quando ligada. Usada por: [build].
  Widget _option(PitadaColors pit, FilterOption o) {
    return GestureDetector(
      onTap: o.onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        selected: o.selected,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                o.label,
                style: AppType.on(
                  AppType.bodySm,
                  o.selected ? pit.text : pit.muted,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                height: AppSpacing.borderAccent,
                decoration: BoxDecoration(
                  color: o.selected ? AppColors.accent : null,
                  borderRadius: AppSpacing.br(AppSpacing.borderAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
