// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/add_item_sheet.dart
// O QUÊ:     Sheet 'Adicionar ingrediente' do card de compras: nome, quantidade,
//            unidade e categoria (chips) — o item entra CRU no carrinho ativo.
// USA:       core/widgets (EditTextField, PitadaChip, PitadaButton, pitada_sheet,
//            SheetGrip), providers (addItem + carrinho ativo), list_seed
//            (categorias), theme/*.
// USADO POR: grocery_list_view (linha '+ Adicionar ingrediente').
// SPEC:      specs/features/groceries.yaml (sheets.showAddItemSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/controls/edit_field.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../../../core/widgets/controls/pitada_chip.dart';
import '../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../core/widgets/sheets/sheet_grip.dart';
import '../application/providers.dart';
import '../data/grocery_item.dart';
import '../data/list_seed.dart';

/// Abre a sheet de item manual; quem grava é a própria sheet (addItem).
/// Usada por: GroceryListView ('Adicionar ingrediente').
void showAddItemSheet(BuildContext context, WidgetRef ref) {
  showPitadaSheet<void>(context, builder: (_) => const _AddItemSheet());
}

/// Formulário do item manual (nome + quantidade/unidade + categoria).
/// Usada por: showAddItemSheet.
class _AddItemSheet extends ConsumerStatefulWidget {
  const _AddItemSheet();

  @override
  ConsumerState<_AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends ConsumerState<_AddItemSheet> {
  final _name = TextEditingController();
  final _qty = TextEditingController();
  final _unit = TextEditingController();
  String _category = kCatMercearia;

  /// Libera os controllers. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    _qty.dispose();
    _unit.dispose();
    super.dispose();
  }

  /// Cria o item cru no carrinho ativo e fecha; gramas só quando a unidade já
  /// é peso (g/kg — grama é referência). Usada por: botão 'Adicionar'.
  void _add() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final qty = num.tryParse(_qty.text.trim().replaceAll(',', '.')) ?? 1;
    final unit = _unit.text.trim().isEmpty ? 'un' : _unit.text.trim();
    final item = GroceryItem(
      id: 'item-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: _category,
      humanQty: qty,
      humanUnit: unit,
      grams: unit == 'g' ? qty : (unit == 'kg' ? qty * 1000 : null),
    );
    ref
        .read(groceryListsProvider.notifier)
        .addItem(ref.read(activeListIdProvider), item);
    Navigator.of(context).pop();
  }

  /// Monta grip + título + campos + chips de categoria + botão. Usada por:
  /// framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Text(
            'Adicionar ingrediente',
            style: AppType.on(AppType.title, pit.text),
          ),
          const SizedBox(height: AppSpacing.lg),
          EditTextField(
            label: 'Nome',
            controller: _name,
            hint: 'Ex.: Tomate',
            autofocus: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: EditTextField(
                  label: 'Quantidade',
                  controller: _qty,
                  hint: '1',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: EditTextField(
                  label: 'Unidade',
                  controller: _unit,
                  hint: 'un, g, ml...',
                ),
              ),
            ],
          ),
          Text(
            'Categoria'.toUpperCase(),
            style: AppType.on(AppType.label, pit.muted),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final cat in kGroceryCategories)
                PitadaChip(
                  label: cat,
                  variant: cat == _category
                      ? PitadaChipVariant.accent
                      : PitadaChipVariant.plain,
                  onTap: () => setState(() => _category = cat),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Adicionar', onPressed: _add),
        ],
      ),
    );
  }
}
