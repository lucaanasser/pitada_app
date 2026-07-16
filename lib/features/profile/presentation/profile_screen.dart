// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/profile_screen.dart
// O QUÊ:     Aba Perfil (painel editorial da cozinha): identidade compacta,
//            números reais flat, gráfico de atividade estilo GitHub (cor única,
//            drill-down por dia), radar de pendências e amigos.
// USA:       core/widgets (PitadaScaffold, Masthead, SectionHeader,
//            PitadaIconButton, EmptyState), profile_providers, ProfileHeader,
//            ProfileStats, ActivityGraph, KitchenRadar, FriendAvatars,
//            core/theme, app_log.
// USADO POR: core/router/router.dart (branch /profile, aba 4).
// SPEC:      specs/features/profile.yaml (screens.ProfileScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/layout/masthead.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../application/profile_providers.dart';
import '../data/models/profile.dart';
import 'widgets/activity/activity_graph.dart';
import 'widgets/friend_avatars.dart';
import 'widgets/kitchen_radar.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';

/// Aba Perfil — painel da cozinha do usuário. Usada por: router (/profile).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Observa o perfil e monta marca + título + conteúdo. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final profile = ref.watch(profileProvider);
    return PitadaScaffold(
      background: pit.tabBg(4),
      top: const Masthead(),
      child: profile.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (e, _) => EmptyState(
          title: 'Não deu para carregar o perfil',
          message: '$e',
          icon: AppIcons.error,
        ),
        data: (p) => _content(context, pit, p),
      ),
    );
  }

  /// Corpo rolável da aba (título + seções). Usada por: [build].
  Widget _content(BuildContext context, PitadaColors pit, Profile p) {
    return ListView(
      padding: tabListPadding(context),
      children: [
        _header(context, pit),
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(profile: p),
              const SizedBox(height: AppSpacing.xxl),
              const ProfileStats(),
              const SectionHeader(label: 'Seu semestre na cozinha'),
              const ActivityGraph(),
              const SectionHeader(label: 'No radar'),
              const KitchenRadar(),
              SectionHeader(
                label: 'Amigos',
                action: 'ver todos',
                onAction: () => AppLog.i('profile', 'ver todos os amigos'),
              ),
              const FriendAvatars(),
            ],
          ),
        ),
      ],
    );
  }

  /// Cabeçalho da aba: título grande + botão de configurações. Usada por: [_content].
  Widget _header(BuildContext context, PitadaColors pit) {
    return Padding(
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
              'Perfil',
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
          ),
          PitadaIconButton(
            icon: AppIcons.settings,
            filled: true,
            size: AppSpacing.iconButtonSm,
            onPressed: () {
              AppLog.i('profile', 'abrir configurações do perfil');
              context.push('/profile/settings');
            },
          ),
        ],
      ),
    );
  }
}
