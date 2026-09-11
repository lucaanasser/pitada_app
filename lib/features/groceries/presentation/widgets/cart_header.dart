// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/cart_header.dart
// O QUÊ:     Topo fixo do card-pasta: nome do carrinho + ⋯ (menu futuro),
//            'X de Y itens comprados' com barra de progresso e o toggle verde
//            'Descontar despensa'. Contagem e barra somem com o carrinho vazio.
// USA:       providers (carrinho ativo + itens exibidos), FuelBar, PitadaToggle,
//            theme/*.
// USADO POR: grocery_list_view (dentro do card, acima do miolo rolável).
// SPEC:      specs/features/groceries.yaml (screens.compras: CartHeader)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/fuel_bar.dart';
import '../../../../core/widgets/controls/pitada_toggle.dart';
import '../../application/providers.dart';

/// Cabeçalho fixo do carrinho: título, progresso da compra e toggle da despensa.
/// Usada por: grocery_list_view.
class CartHeader extends ConsumerWidget {
  const CartHeader({super.key});

  /// Monta título + ⋯, contagem/barra (se há itens) e o toggle. Usada por:
  /// grocery_list_view.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final list = ref.watch(activeListProvider);
    final items = ref.watch(activeListItemsProvider);
    final bought = items.where((i) => i.checked).length;
    final total = items.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  list.name,
                  style: AppType.on(AppType.title, pit.text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(AppIcons.more, size: 22, color: pit.text2),
            ],
          ),
          if (total > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '$bought de $total ${total == 1 ? 'item comprado' : 'itens comprados'}',
              style: AppType.on(AppType.bodySm, pit.text2),
            ),
            const SizedBox(height: AppSpacing.md),
            FuelBar(
              progress: bought / total,
              color: AppColors.accent,
              height: AppSpacing.sm,
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          GestureDetector(
            onTap: () =>
                ref.read(groceryListsProvider.notifier).togglePantry(list.id),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                PitadaToggle(
                  value: list.usePantry,
                  activeColor: AppColors.sage,
                  onChanged: (_) => ref
                      .read(groceryListsProvider.notifier)
                      .togglePantry(list.id),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  'Descontar despensa',
                  style: AppType.on(AppType.body, pit.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
