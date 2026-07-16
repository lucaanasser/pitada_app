// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/reactivation_card.dart
// O QUÊ:     Card pastel de reativação ("Para hoje") do hub do Caderno: kicker,
//            título, corpo curto, botão-selo de ação e dispensa ("depois").
// USA:       core/theme (pit.*, AppColors, AppType, AppSpacing), go_router,
//            caderno_providers (dismiss), reactivation_item, diary_quick_sheet.
// USADO POR: NotebookScreen (seção "Para hoje" do hub).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/hub_providers.dart';
import '../../data/reactivation_item.dart';
import '../diary_quick_sheet.dart';

/// Card de reativação: pastel do hero + borda tinta, ação primária em
/// botão-selo e "depois" que dispensa o card na sessão.
/// Usada por: NotebookScreen (hub do Caderno).
class ReactivationCard extends ConsumerWidget {
  const ReactivationCard({super.key, required this.item});

  final ReactivationItem item;

  /// Executa a ação primária: cook abre o diário rápido pré-preenchido;
  /// os demais navegam para a rota do item. Usada por: build (botão-selo).
  void _onAction(BuildContext context) {
    if (item.kind == ReactivationKind.cook) {
      showDiaryQuickSheet(context, recipeName: item.title);
    } else {
      context.push(item.actionRoute!);
    }
  }

  /// Dispensa o card nesta sessão ("depois"). Usada por: build.
  void _dismiss(WidgetRef ref) {
    ref.read(dismissedReactivationsProvider.notifier).state = {
      ...ref.read(dismissedReactivationsProvider),
      item.id,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: pit.card(item.hero),
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.kicker.toUpperCase(),
                style: AppType.on(AppType.label, pit.text2),
              ),
              const Spacer(),
              if (item.trailing != null)
                Text(
                  item.trailing!,
                  style: AppType.on(AppType.numeralSm, AppColors.accent),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(item.title, style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.xs + 2),
          Text(
            item.body,
            style: AppType.on(AppType.bodySm, pit.text2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onAction(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: pit.surf,
                    borderRadius: AppSpacing.br(AppSpacing.radiusPill),
                    border: Border.all(
                      color: pit.border,
                      width: AppSpacing.borderStrong,
                    ),
                  ),
                  child: Text(
                    item.actionLabel,
                    style: AppType.on(AppType.button, pit.text),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _dismiss(ref),
                child: Text(
                  'depois',
                  style: AppType.on(AppType.caption, pit.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
