// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/food_search_sheet.dart
// O QUÊ:     Sheet p/ escolher rápido o que se comeu FORA do plano, buscando no
//            dataset curado (chips por categoria + busca). Retorna um ExtraEntry.
// USA:       theme/*, core/widgets (SheetGrip, PitadaChip, PitadaSearchField,
//            HairlineRow), foodsProvider, data (food_item/day_log), free_item_sheet.
// USADO POR: log_day_sheet ("+ Adicionar extra").
// SPEC:      specs/features/plans_progress.yaml (sheets: showFoodSearchSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../../core/widgets/pitada_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_chip.dart';
import '../../../core/widgets/pitada_search_field.dart';
import '../application/progress_providers.dart';
import '../data/day_log.dart';
import '../data/food_item.dart';
import 'free_item_sheet.dart';
import '../../../core/widgets/sheet_grip.dart';

/// Chips de atalho: rótulo pt-BR -> categoria do dataset. Usada por: [_FoodSearchSheet].
const Map<String, String> _kCategories = {
  'Doce': 'doce',
  'Salgado': 'salgado',
  'Fast food': 'fastfood',
  'Bebida': 'bebida',
  'Álcool': 'alcool',
  'Fruta': 'fruta',
  'Lanche': 'lanche',
  'Prato': 'prato',
};

/// Abre o sheet de busca de comida e devolve o ExtraEntry escolhido (ou null).
/// Usada por: log_day_sheet.
Future<ExtraEntry?> showFoodSearchSheet(BuildContext context) {
  return showPitadaSheet<ExtraEntry>(
    context,
    builder: (_) => const _FoodSearchSheet(),
  );
}

/// Conteúdo do sheet: chips + busca + lista do dataset + "Outro". Usada por: showFoodSearchSheet.
class _FoodSearchSheet extends ConsumerStatefulWidget {
  const _FoodSearchSheet();

  @override
  ConsumerState<_FoodSearchSheet> createState() => _FoodSearchSheetState();
}

class _FoodSearchSheetState extends ConsumerState<_FoodSearchSheet> {
  String _query = '';
  String? _category; // null = todas as categorias

  /// Filtra o dataset pela categoria e pelo texto buscado. Usada por: [build].
  List<FoodItem> _filtered(List<FoodItem> all) {
    final q = _query.trim().toLowerCase();
    return [
      for (final f in all)
        if ((_category == null || f.category == _category) &&
            (q.isEmpty || f.name.toLowerCase().contains(q)))
          f,
    ];
  }

  /// Abre o item livre e, se preenchido, devolve-o ao chamador. Usada por: "Outro".
  Future<void> _openFree() async {
    final extra = await showFreeItemSheet(context);
    if (extra != null && mounted) Navigator.of(context).pop(extra);
  }

  /// Monta o sheet (grip + título + chips + busca + lista). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final foods = _filtered(ref.watch(foodsProvider));
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Padding(
            padding: AppSpacing.screenH,
            child: Text(
              'O que você comeu?',
              style: AppType.on(AppType.title, pit.text),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _chips(),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: AppSpacing.screenH,
            child: PitadaSearchField(
              hint: 'Buscar comida',
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            child: _list(pit, foods),
          ),
        ],
      ),
    );
  }

  /// Faixa rolável de chips de categoria (accent = ativa). Usada por: [build].
  Widget _chips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.screenH,
      child: Row(
        children: [
          for (final entry in _kCategories.entries)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: PitadaChip(
                label: entry.key,
                variant: _category == entry.value
                    ? PitadaChipVariant.accent
                    : PitadaChipVariant.plain,
                onTap: () => setState(
                  () =>
                      _category = _category == entry.value ? null : entry.value,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Lista de comidas do dataset + linha "Outro" no fim. Usada por: [build].
  Widget _list(PitadaColors pit, List<FoodItem> foods) {
    return ListView(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: AppSpacing.xl + MediaQuery.paddingOf(context).bottom,
      ),
      children: [
        for (final f in foods)
          HairlineRow(
            title: Text(f.name, style: AppType.on(AppType.body, pit.text)),
            subtitle:
                Text(f.portion, style: AppType.on(AppType.caption, pit.muted)),
            trailing: Text(
              '${f.kcal} kcal',
              style: AppType.on(AppType.numeralSm, pit.text),
            ),
            onTap: () => Navigator.of(context).pop(ExtraEntry.fromFood(f)),
          ),
        HairlineRow(
          showDivider: false,
          title: Text(
            'Outro (não está na lista)',
            style: AppType.on(AppType.body, AppColors.accent),
          ),
          onTap: _openFree,
        ),
      ],
    );
  }
}
