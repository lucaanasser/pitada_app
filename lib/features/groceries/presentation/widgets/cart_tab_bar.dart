// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/cart_tab_bar.dart
// O QUÊ:     Abas-pasta dos carrinhos (trapézio de topo arredondado, como a aba
//            de uma pasta de arquivo) + aba '+' de criar carrinho. A ativa usa
//            o mesmo surf do card e emenda nele sem costura.
// USA:       providers (carrinhos + ativo), new_list_sheet (createAndSelectList),
//            theme/*.
// USADO POR: grocery_list_view (logo acima do card-pasta).
// SPEC:      specs/features/groceries.yaml (screens.compras: CartTabBar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/providers.dart';
import '../new_list_sheet.dart';

/// Altura fixa das abas-pasta dos carrinhos. Usada por: [CartTabBar] e o card
/// que emenda nelas.
const double cartTabHeight = 42;

/// Fileira de abas-pasta: um carrinho por aba + '+' que cria um novo.
/// Usada por: grocery_list_view.
class CartTabBar extends ConsumerWidget {
  const CartTabBar({super.key});

  /// Monta as abas roláveis na horizontal; tocar troca o carrinho ativo.
  /// Usada por: grocery_list_view.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final lists = ref.watch(groceryListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    return SizedBox(
      height: cartTabHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.screenH,
        child: Row(
          children: [
            for (final list in lists) ...[
              _CartTab(
                active: list.id == activeId,
                onTap: () =>
                    ref.read(activeListIdProvider.notifier).state = list.id,
                child: Text(
                  list.tabLabel,
                  style: AppType.on(
                    AppType.titleXs,
                    list.id == activeId ? pit.text : pit.muted,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            _CartTab(
              active: false,
              onTap: () => createAndSelectList(context, ref),
              child: Icon(AppIcons.add, size: 16, color: pit.muted),
            ),
          ],
        ),
      ),
    );
  }
}

/// Uma aba-pasta: trapézio pintado (cheio quando ativa; contorno quando não).
/// Usada por: [CartTabBar].
class _CartTab extends StatelessWidget {
  const _CartTab({
    required this.active,
    required this.onTap,
    required this.child,
  });

  final bool active;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        painter: _CartTabPainter(
          fill: active ? pit.surf : pit.bg,
          stroke: active ? null : pit.line2,
        ),
        child: Container(
          height: cartTabHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: child,
        ),
      ),
    );
  }
}

/// Pinta a silhueta da aba: laterais levemente inclinadas e topo arredondado;
/// a base fica aberta para emendar no card. Usada por: [_CartTab].
class _CartTabPainter extends CustomPainter {
  const _CartTabPainter({required this.fill, this.stroke});

  final Color fill;
  final Color? stroke;

  /// Desenha o preenchimento e, nas inativas, o contorno sem a base.
  /// Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    const s = 9.0;
    const r = AppSpacing.radiusMd;
    final path = Path()
      ..moveTo(0, h)
      ..lineTo(s, r)
      ..arcToPoint(const Offset(s + r, 0), radius: const Radius.circular(r))
      ..lineTo(w - s - r, 0)
      ..arcToPoint(Offset(w - s, r), radius: const Radius.circular(r))
      ..lineTo(w, h);
    canvas.drawPath(Path.from(path)..close(), Paint()..color = fill);
    if (stroke != null) {
      canvas.drawPath(
        path,
        Paint()
          ..color = stroke!
          ..style = PaintingStyle.stroke
          ..strokeWidth = AppSpacing.hair,
      );
    }
  }

  /// Repinta quando as cores mudarem (troca de aba ativa). Usada por: framework.
  @override
  bool shouldRepaint(_CartTabPainter old) =>
      old.fill != fill || old.stroke != stroke;
}
