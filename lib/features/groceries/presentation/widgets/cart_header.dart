// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/cart_header.dart
// O QUÊ:     Linha fixa e discreta no topo do card: toggle verde 'Descontar
//            despensa' + ⋯ (menu futuro). Sem título (o nome já está na aba)
//            e sem contagem (ela vive no rodapé) — o foco é a lista.
// USA:       providers (carrinho ativo), PitadaToggle, theme/*.
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
import '../../../../core/widgets/controls/pitada_toggle.dart';
import '../../application/providers.dart';

/// Linha compacta do carrinho: toggle da despensa à esquerda, ⋯ à direita.
/// Usada por: grocery_list_view.
class CartHeader extends ConsumerWidget {
  const CartHeader({super.key});

  /// Monta o toggle com rótulo sóbrio e o ⋯ sem ação (menu fica p/ depois).
  /// Usada por: grocery_list_view.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final list = ref.watch(activeListProvider);
    void flip() =>
        ref.read(groceryListsProvider.notifier).togglePantry(list.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: flip,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                PitadaToggle(
                  value: list.usePantry,
                  activeColor: AppColors.sage,
                  onChanged: (_) => flip(),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  'Descontar despensa',
                  style: AppType.on(AppType.bodySm, pit.text2),
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(AppIcons.more, size: 22, color: pit.text2),
        ],
      ),
    );
  }
}
