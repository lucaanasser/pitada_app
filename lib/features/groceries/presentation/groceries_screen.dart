// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/groceries_screen.dart
// O QUÊ:     Aba Ingredientes: título + PitadaTabs (Lista/Despensa) e o corpo conforme a aba.
// USA:       core/widgets (Masthead, PitadaScaffold, PitadaTabs), GroceryListView,
//            PantryView, theme/*. Estado da aba num StateProvider local à tela.
// USADO POR: core/router/router.dart (branch /shopping).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/layout/masthead.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../core/widgets/tabs/pitada_tabs.dart';
import 'add_sheet.dart';
import 'widgets/pantry_view.dart';
import 'widgets/grocery_list_view.dart';

/// Aba selecionada em Ingredientes (0 = Lista, 1 = Despensa). Estado só da tela.
/// Usada por: GroceriesScreen (PitadaTabs). Fica aqui pois é estado de apresentação.
final shoppingTabProvider = StateProvider<int>((ref) => 0);

/// Tela principal de Ingredientes: alterna Lista/Despensa por PitadaTabs. Usada por: router.
class GroceriesScreen extends ConsumerWidget {
  const GroceriesScreen({super.key});

  /// Monta Masthead + título + abas e escolhe o corpo conforme a aba ativa.
  /// Usada por: router (/shopping).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final tab = ref.watch(shoppingTabProvider);

    return PitadaScaffold(
      background: pit.tabBg(3),
      top: const Masthead(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.titleGap,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'Ingredientes',
                    style: AppType.on(AppType.screenTitle, pit.text),
                  ),
                ),
                PitadaIconButton(
                  icon: AppIcons.add,
                  filled: true,
                  size: AppSpacing.iconButtonSm,
                  onPressed: () => showGroceriesAddSheet(context, ref),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: PitadaTabs(
              tabs: const ['Lista', 'Despensa'],
              selected: tab,
              onSelect: (i) => ref.read(shoppingTabProvider.notifier).state = i,
            ),
          ),
          Expanded(
            child: tab == 0 ? const GroceryListView() : const PantryView(),
          ),
        ],
      ),
    );
  }
}
