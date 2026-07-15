// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/presentation/shopping_add_sheet.dart
// O QUÊ:     Sheet "Adicionar" de Ingredientes — atalho do '+' do cabeçalho
//            para os MESMOS fluxos das abas (não substitui os existentes).
// USA:       core/widgets/add_options_sheet, theme/app_icons, new_list_sheet
//            (createAndSelectList), add_pantry_sheet.
// USADO POR: ShoppingScreen (botão '+' do cabeçalho).
// SPEC:      specs/features/shopping.yaml (sheets.showShoppingAddSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/widgets/add_options_sheet.dart';
import 'add_pantry_sheet.dart';
import 'new_list_sheet.dart';

/// Abre o sheet "Adicionar" com os 2 atalhos: nova lista (mesmo fluxo do chip
/// '+ Nova') e adicionar à despensa (mesmo botão da aba Despensa).
/// Usada por: ShoppingScreen (ação '+' do cabeçalho). [ref] cria/ativa a lista.
void showShoppingAddSheet(BuildContext context, WidgetRef ref) {
  showAddOptionsSheet(
    context,
    title: 'Adicionar',
    options: [
      AddSheetOption(
        'Nova lista',
        'Mais uma lista de compras',
        'moss',
        AppIcons.addToList,
        (ctx) => createAndSelectList(ctx, ref),
      ),
      AddSheetOption(
        'Adicionar à despensa',
        'Registre o que você tem em casa',
        'ochre',
        AppIcons.basket,
        (ctx) => showAddPantrySheet(ctx),
      ),
    ],
  );
}
