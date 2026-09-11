// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/cart_tab_bar.dart
// O QUÊ:     Abas-pasta dos carrinhos, largas como numa pasta de arquivo real:
//            dividem a largura do card, laterais externas retas (viram o canto
//            do card), internas inclinadas, bases encostadas. A ativa usa o
//            surf do card e emenda nele; a '+' (estreita) cria carrinho.
// USA:       providers (carrinhos + ativo), new_list_sheet (createAndSelectList),
//            theme/*.
// USADO POR: grocery_list_view (o topo do card-pasta).
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

/// Altura fixa das abas-pasta dos carrinhos. Usada por: [CartTabBar].
const double cartTabHeight = 48;

/// Fileira de abas-pasta: os carrinhos dividem a largura; '+' cria um novo.
/// Usada por: grocery_list_view.
class CartTabBar extends ConsumerWidget {
  const CartTabBar({super.key});

  /// Monta as abas na largura do card; tocar troca o carrinho ativo.
  /// Usada por: grocery_list_view.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final lists = ref.watch(groceryListsProvider);
    final activeId = ref.watch(activeListIdProvider);
    return Padding(
      padding: AppSpacing.screenH,
      child: SizedBox(
        height: cartTabHeight,
        child: Row(
          children: [
            for (var i = 0; i < lists.length; i++)
              Expanded(
                child: _CartTab(
                  active: lists[i].id == activeId,
                  slantLeft: i != 0,
                  slantRight: true,
                  onTap: () => ref.read(activeListIdProvider.notifier).state =
                      lists[i].id,
                  child: Text(
                    lists[i].tabLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppType.on(
                      AppType.button,
                      lists[i].id == activeId ? pit.text : pit.muted,
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: cartTabHeight + AppSpacing.md,
              child: _CartTab(
                active: false,
                slantLeft: true,
                slantRight: false,
                onTap: () => createAndSelectList(context, ref),
                child: Icon(AppIcons.add, size: 16, color: pit.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Uma aba-pasta pintada: cheia quando ativa; contorno quando não. A lateral
/// sem inclinação ganha canto reto arredondado (borda externa da fileira).
/// Usada por: [CartTabBar].
class _CartTab extends StatelessWidget {
  const _CartTab({
    required this.active,
    required this.slantLeft,
    required this.slantRight,
    required this.onTap,
    required this.child,
  });

  final bool active;
  final bool slantLeft;
  final bool slantRight;
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
          slantLeft: slantLeft,
          slantRight: slantRight,
        ),
        child: Container(
          height: cartTabHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: child,
        ),
      ),
    );
  }
}

/// Pinta a silhueta da aba: topo arredondado, lateral inclinada ou reta
/// conforme o lado; a base fica aberta para emendar no card.
/// Usada por: [_CartTab].
class _CartTabPainter extends CustomPainter {
  const _CartTabPainter({
    required this.fill,
    required this.slantLeft,
    required this.slantRight,
    this.stroke,
  });

  final Color fill;
  final Color? stroke;
  final bool slantLeft;
  final bool slantRight;

  /// Desenha o preenchimento e, nas inativas, o contorno sem a base.
  /// Usada por: framework.
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    const s = 11.0;
    const r = AppSpacing.radiusMd;
    final path = Path()..moveTo(0, h);
    if (slantLeft) {
      path
        ..lineTo(s, r)
        ..arcToPoint(const Offset(s + r, 0), radius: const Radius.circular(r));
    } else {
      path
        ..lineTo(0, r)
        ..arcToPoint(const Offset(r, 0), radius: const Radius.circular(r));
    }
    if (slantRight) {
      path
        ..lineTo(w - s - r, 0)
        ..arcToPoint(Offset(w - s, r), radius: const Radius.circular(r))
        ..lineTo(w, h);
    } else {
      path
        ..lineTo(w - r, 0)
        ..arcToPoint(Offset(w, r), radius: const Radius.circular(r))
        ..lineTo(w, h);
    }
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

  /// Repinta quando cor ou lados mudarem (troca de aba ativa). Usada por: framework.
  @override
  bool shouldRepaint(_CartTabPainter old) =>
      old.fill != fill ||
      old.stroke != stroke ||
      old.slantLeft != slantLeft ||
      old.slantRight != slantRight;
}
