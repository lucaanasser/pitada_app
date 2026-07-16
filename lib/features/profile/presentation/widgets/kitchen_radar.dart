// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/kitchen_radar.dart
// O QUÊ:     Radar do perfil: pendências acionáveis da cozinha (cozinha sem
//            registro no diário, itens vencendo/acabando na despensa e
//            "refazer pendente"). Cada linha navega para onde se resolve.
// USA:       core/theme (context.pit, AppType, AppSpacing, AppIcons),
//            core/widgets (HairlineRow, ExpiryTag), core/utils/app_log,
//            overview_providers (kitchenRadarProvider), RadarItem, go_router.
// USADO POR: ProfileScreen (seção "No radar").
// SPEC:      specs/features/profile.yaml (components_da_feature.KitchenRadar)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/widgets/tags/expiry_tag.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../application/overview_providers.dart';
import '../../data/radar_item.dart';

/// Lista de pendências acionáveis (máx. 5) ou a linha calma de "tudo em dia".
/// Usada por: ProfileScreen.
class KitchenRadar extends ConsumerWidget {
  const KitchenRadar({super.key});

  /// Lê o radar agregado e monta as linhas. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(kitchenRadarProvider);
    if (items.isEmpty) return _allClear(context.pit);
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          _row(context, items[i], showDivider: i < items.length - 1),
      ],
    );
  }

  /// Linha calma quando não há pendência nenhuma. Usada por: [build].
  Widget _allClear(PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          const Icon(AppIcons.checkCircle, size: 18, color: AppColors.sage),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Nada pedindo atenção — despensa e caderno em dia.',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ],
      ),
    );
  }

  /// Uma pendência: ícone pelo tipo, título, apoio e tag/seta à direita.
  /// Toque navega para a rota onde ela se resolve. Usada por: [build].
  Widget _row(BuildContext context, RadarItem item,
      {required bool showDivider}) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      leading: Icon(_icon(item.kind), size: 18, color: pit.muted),
      title: Text(item.title, style: AppType.on(AppType.body, pit.text)),
      subtitle: item.detail == null
          ? null
          : Text(item.detail!, style: AppType.on(AppType.caption, pit.muted)),
      trailing: _trailing(pit, item),
      onTap: () {
        AppLog.i('profile', 'radar -> ${item.route} (${item.kind.name})');
        item.push ? context.push(item.route) : context.go(item.route);
      },
    );
  }

  /// Ícone da pendência pelo tipo. Usada por: [_row].
  IconData _icon(RadarKind kind) {
    return switch (kind) {
      RadarKind.cook => AppIcons.cook,
      RadarKind.expiry => AppIcons.time,
      RadarKind.low => AppIcons.basket,
      RadarKind.redo => AppIcons.history,
    };
  }

  /// Tag de validade / "acabando" ou a setinha de navegação. Usada por: [_row].
  Widget _trailing(PitadaColors pit, RadarItem item) {
    return switch (item.kind) {
      RadarKind.expiry => ExpiryTag.fromDate(item.expiresOn) ??
          Icon(AppIcons.chevron, size: 16, color: pit.faint),
      RadarKind.low => const ExpiryTag(label: 'acabando'),
      RadarKind.cook ||
      RadarKind.redo =>
        Icon(AppIcons.chevron, size: 16, color: pit.faint),
    };
  }
}
