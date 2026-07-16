// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/pantry_view.dart
// O QUÊ:     Aba Despensa: legenda, grupos por categoria (estoque + validade/tag) e ação.
// USA:       shopping_providers, category_group, add_pantry_sheet, core/widgets
//            (HairlineRow, ExpiryTag, PitadaButton, EmptyState), utils/format, theme/*.
// USADO POR: shopping_screen (corpo da aba Despensa).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen.despensa)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/format.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/expiry_tag.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../../../core/widgets/pitada_scaffold.dart';
import '../../application/providers.dart';
import '../../data/pantry_item.dart';
import '../add_pantry_sheet.dart';
import 'category_group.dart';

/// Corpo da aba Despensa: legenda, itens agrupados com validade e botão de adicionar.
/// Usada por: shopping_screen (aba 1).
class PantryView extends ConsumerWidget {
  const PantryView({super.key});

  /// Renderiza a despensa agrupada ou um EmptyState quando ainda não há itens.
  /// Usada por: shopping_screen.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final grouped = ref.watch(pantryByCategoryProvider);

    if (grouped.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xxxl),
        child: Column(
          children: [
            const EmptyState(
              title: 'Despensa vazia',
              message: 'Escaneie um código de barras ou a nota para começar.',
              icon: AppIcons.dish,
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: AppSpacing.screenH,
              child: PitadaButton(
                label: 'Adicionar à despensa',
                icon: AppIcons.add,
                onPressed: () => showAddPantrySheet(context),
              ),
            ),
          ],
        ),
      );
    }

    final categories = grouped.keys.toList();
    return ListView(
      padding: tabListPadding(context),
      children: [
        _legend(pit),
        for (var c = 0; c < categories.length; c++)
          CategoryGroup(
            label: categories[c],
            topGap: c == 0 ? AppSpacing.xl : AppSpacing.xxxl,
            children: [
              for (var i = 0; i < grouped[categories[c]]!.length; i++)
                _PantryRow(
                  item: grouped[categories[c]]![i],
                  showDivider: i != grouped[categories[c]]!.length - 1,
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.xxxl,
            AppSpacing.gutter,
            0,
          ),
          child: PitadaButton(
            label: 'Adicionar à despensa',
            icon: AppIcons.add,
            onPressed: () => showAddPantrySheet(context),
          ),
        ),
      ],
    );
  }

  /// Legenda que explica como a despensa é abastecida. Usada por: [build].
  Widget _legend(PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Text(
        'Adicione por código de barras ou foto da nota — a validade entra junto',
        style: AppType.on(AppType.caption, pit.muted),
      ),
    );
  }
}

/// Uma linha da despensa: nome, validade (subtítulo), estoque + ExpiryTag/'acabando'.
/// Usada por: [PantryView].
class _PantryRow extends StatelessWidget {
  const _PantryRow({required this.item, required this.showDivider});

  final PantryItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final expiryTag = ExpiryTag.fromDate(item.expiresOn);
    final tag =
        expiryTag ?? (item.low ? const ExpiryTag(label: 'acabando') : null);

    return HairlineRow(
      showDivider: showDivider,
      title: Text(item.name, style: AppType.on(AppType.body, pit.text)),
      subtitle: item.expiresOn != null
          ? Text(
              'Validade ${formatDayMonth(item.expiresOn)}',
              style: AppType.on(AppType.captionSm, pit.muted),
            )
          : null,
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _stock(item),
            style: AppType.on(AppType.numeral, pit.text),
          ),
          if (tag != null)
            Padding(padding: const EdgeInsets.only(top: 6), child: tag),
        ],
      ),
    );
  }

  /// Texto do estoque: gramas quando a unidade é 'g', senão a unidade humana.
  /// Usada por: [build].
  String _stock(PantryItem item) {
    if (item.unit == 'g') return formatGrams(item.grams ?? item.quantity);
    return formatHuman(item.quantity, item.unit);
  }
}
