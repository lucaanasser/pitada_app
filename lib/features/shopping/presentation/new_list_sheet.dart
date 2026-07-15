// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/presentation/new_list_sheet.dart
// O QUÊ:     Sheet de criar lista de compras (só o nome) + createAndSelectList,
//            o fluxo completo que cria a lista e a torna ativa.
// USA:       theme/*, core/widgets (PitadaButton, pitada_sheet, SheetGrip),
//            flutter_riverpod + shopping_providers (createAndSelectList).
// USADO POR: ListHeaderRow (via ListsSheet), shopping_add_sheet ('+' do header).
// SPEC:      specs/features/shopping.yaml (sheets.showNewListSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_sheet.dart';
import '../../../core/widgets/sheet_grip.dart';
import '../application/shopping_providers.dart';

/// Abre o sheet de nova lista e devolve o nome digitado (ou null se cancelou).
/// Usada por: [createAndSelectList].
Future<String?> showNewListSheet(BuildContext context) {
  return showPitadaSheet<String>(
    context,
    builder: (_) => const _NewListSheet(),
  );
}

/// Fluxo completo de criar lista: abre o sheet de nome, cria e a torna ativa.
/// Usada por: ListHeaderRow (sheet de listas) e showShoppingAddSheet — o atalho
/// do header cai exatamente no mesmo fluxo.
Future<void> createAndSelectList(BuildContext context, WidgetRef ref) async {
  final name = await showNewListSheet(context);
  if (name == null || name.trim().isEmpty) return;
  final id = ref.read(shoppingListsProvider.notifier).addList(name.trim());
  ref.read(activeListIdProvider.notifier).state = id;
}

/// Formulário de nova lista (nome + criar). Usada por: showNewListSheet.
class _NewListSheet extends StatefulWidget {
  const _NewListSheet();

  @override
  State<_NewListSheet> createState() => _NewListSheetState();
}

class _NewListSheetState extends State<_NewListSheet> {
  final _name = TextEditingController();

  /// Libera o controller. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Devolve o nome ao chamador se não estiver vazio. Usada por: botão "Criar".
  void _create() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(name);
  }

  /// Monta o formulário (grip + título + campo + botão). Usada por: framework.
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
          Text('Nova lista', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Dê um nome — dá para escolher depois se ela desconta a despensa.',
            style: AppType.on(AppType.caption, pit.muted),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _name,
            autofocus: true,
            onSubmitted: (_) => _create(),
            style: AppType.on(AppType.body, pit.text),
            cursorColor: AppColors.accent,
            decoration: InputDecoration(
              hintText: 'Ex.: Praia, Churrasco, Mês',
              hintStyle: AppType.on(AppType.body, pit.faint),
              filled: true,
              fillColor: pit.surf2,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius: AppSpacing.br(AppSpacing.radiusMd),
                borderSide: BorderSide(color: pit.line2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppSpacing.br(AppSpacing.radiusMd),
                borderSide: BorderSide(color: pit.line2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppSpacing.br(AppSpacing.radiusMd),
                borderSide: const BorderSide(color: AppColors.accentLine),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Criar lista', onPressed: _create),
        ],
      ),
    );
  }
}
