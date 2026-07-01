// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/presentation/shopping_screen.dart
// O QUÊ:     Aba Compras: título + SegTabs (Lista/Despensa) e o corpo conforme a aba.
// USA:       core/widgets (Masthead, PitadaScaffold, SegTabs), ShoppingListView,
//            PantryView, theme/*. Estado da aba num StateProvider local à tela.
// USADO POR: core/router/router.dart (branch /shopping).
// SPEC:      specs/features/shopping.yaml (screens.ShoppingScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/seg_tabs.dart';
import 'widgets/pantry_view.dart';
import 'widgets/shopping_list_view.dart';

/// Aba selecionada em Compras (0 = Lista, 1 = Despensa). Estado só da tela.
/// Usada por: ShoppingScreen (SegTabs). Fica aqui pois é estado de apresentação.
final shoppingTabProvider = StateProvider<int>((ref) => 0);

/// Tela principal de Compras: alterna Lista/Despensa por SegTabs. Usada por: router.
class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({super.key});

  /// Monta Masthead + título + abas e escolhe o corpo conforme a aba ativa.
  /// Usada por: router (/shopping).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(shoppingTabProvider);

    return PitadaScaffold(
      top: const Masthead(),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Expanded(child: Text('Compras', style: AppType.screenTitle)),
              ],
            ),
          ),
          SegTabs(
            tabs: const ['Lista', 'Despensa'],
            selected: tab,
            onSelect: (i) => ref.read(shoppingTabProvider.notifier).state = i,
          ),
          Expanded(
            child: tab == 0 ? const ShoppingListView() : const PantryView(),
          ),
        ],
      ),
    );
  }
}
