// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/profile_header.dart
// O QUÊ:     Identidade compacta do perfil: avatar quadrado pastel com borda +
//            nome + linha de sequência atual (chama + texto, sem pílula).
// USA:       core/theme (AppColors, context.pit, AppType, AppSpacing, AppIcons),
//            overview_providers (atividade real), activity_stats, Profile.
// USADO POR: ProfileScreen (topo da aba).
// SPEC:      specs/features/profile.yaml (components_da_feature.ProfileHeader)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/overview_providers.dart';
import '../../data/activity_stats.dart';
import '../../data/profile.dart';

/// Lado do avatar quadrado (compacto — a página é painel, não cartão de visita).
/// Usada por: [_Avatar].
const double _kAvatar = 56;

/// Identidade compacta do perfil, com a sequência atual derivada da atividade
/// real — texto simples, sem pílula (peso visual só onde importa).
/// Usada por: ProfileScreen.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key, required this.profile});

  final Profile profile;

  /// Monta avatar + nome + linha de sequência. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final stats = computeActivityStats(ref.watch(activityProvider));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Avatar(initial: profile.initial),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name, style: AppType.on(AppType.title, pit.text)),
              const SizedBox(height: AppSpacing.xs + 2),
              _streakLine(pit, stats.currentStreak),
            ],
          ),
        ),
      ],
    );
  }

  /// Linha da sequência atual: chama + caption. Usada por: [build].
  Widget _streakLine(PitadaColors pit, int streak) {
    final label = switch (streak) {
      0 => 'sem sequência ativa — comece hoje',
      1 => '1 dia seguido na cozinha',
      _ => '$streak dias seguidos na cozinha',
    };
    return Row(
      children: [
        const Icon(AppIcons.cook, size: 14, color: AppColors.accent2),
        const SizedBox(width: AppSpacing.xs + 1),
        Text(label, style: AppType.on(AppType.caption, pit.text2)),
      ],
    );
  }
}

/// Avatar quadrado pastel com borda de tinta e a inicial em Space Grotesk.
/// Usada por: [ProfileHeader].
class _Avatar extends StatelessWidget {
  const _Avatar({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      width: _kAvatar,
      height: _kAvatar,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: pit.card('terra'),
        borderRadius: AppSpacing.br(AppSpacing.radiusLg),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Text(
        initial.toUpperCase(),
        style: AppType.on(AppType.title, pit.text),
      ),
    );
  }
}
