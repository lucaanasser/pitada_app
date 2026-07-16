// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/profile_stats.dart
// O QUÊ:     Fileira FLAT (sem caixa) dos números reais do perfil: numeral
//            Space Grotesk + rótulo, tocáveis — cada um navega para a origem.
// USA:       core/theme (context.pit, AppType, AppSpacing), core/utils/app_log,
//            overview_providers (profileCountsProvider), go_router.
// USADO POR: ProfileScreen (logo abaixo da identidade).
// SPEC:      specs/features/profile.yaml (components_da_feature.ProfileStats)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';
import '../../application/overview_providers.dart';

/// Números reais em linha, sem caixa — o peso fica no numeral, não na moldura.
/// Usada por: ProfileScreen.
class ProfileStats extends ConsumerWidget {
  const ProfileStats({super.key});

  /// Lê os contadores agregados e monta os 3 números. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(profileCountsProvider);
    return Row(
      children: [
        _Stat(
          value: counts.recipes,
          label: 'receitas',
          onTap: () => _open(context, '/recipes', go: true),
        ),
        _Stat(
          value: counts.captures,
          label: 'no caderno',
          onTap: () => _open(context, '/learning', go: true),
        ),
        _Stat(
          value: counts.cooks,
          label: 'preparos',
          onTap: () => _open(context, '/learning/diary', go: false),
        ),
      ],
    );
  }

  /// Navega para a origem do número (aba via go, detalhe via push) e loga.
  /// Usada por: [build].
  void _open(BuildContext context, String route, {required bool go}) {
    AppLog.i('profile', 'número do perfil -> $route');
    go ? context.go(route) : context.push(route);
  }
}

/// Um número flat: numeral grande + rótulo caption, tocável. Usada por: [ProfileStats].
class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.onTap});

  final int value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$value', style: AppType.on(AppType.numeralLg, pit.text)),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: AppType.on(AppType.caption, pit.muted)),
          ],
        ),
      ),
    );
  }
}
