// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/list/lens_chip_row.dart
// O QUÊ:     Linha horizontal de lentes da lista de receitas: Todas, Rápidas
//            (≤ 20 min) e uma lente por técnica do acervo. Lente é filtro,
//            não gaveta — a lista é uma só.
// USA:       recipe_list_providers (lente + opções), core/widgets (PitadaChip),
//            core/theme (AppSpacing, AppIcons).
// USADO POR: recipes_screen (acima da lista).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/controls/pitada_chip.dart';
import '../../../application/recipe_list_providers.dart';

/// Chips de lente roláveis na horizontal. Usada por: recipes_screen.
class LensChipRow extends ConsumerWidget {
  const LensChipRow({super.key});

  /// Observa a lente ativa e as técnicas do acervo e monta os chips.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lens = ref.watch(recipeLensProvider);
    final techniques = ref.watch(techniqueLensOptionsProvider);

    void select(String? value) =>
        ref.read(recipeLensProvider.notifier).state = value;

    Widget chip(String label, String? value, {IconData? icon}) {
      final active = lens == value;
      return Padding(
        padding: const EdgeInsets.only(right: AppSpacing.sm),
        child: PitadaChip(
          label: label,
          icon: icon,
          variant: active ? PitadaChipVariant.accent : PitadaChipVariant.plain,
          onTap: () => select(active ? null : value),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.screenH,
      child: Row(
        children: [
          chip('Todas', null),
          chip('Rápidas', 'quick', icon: AppIcons.time),
          for (final t in techniques)
            chip(t, 'tech:$t', icon: AppIcons.technique),
        ],
      ),
    );
  }
}
