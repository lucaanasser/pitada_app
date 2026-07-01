// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/profile_screen.dart
// O QUÊ:     Tela de Perfil (full-screen): cabeçalho, amigos, gráfico de atividade
//            estilo GitHub e o resumo "Sua cozinha ultimamente".
// USA:       core/widgets (SectionHeader, HairlineRow, PitadaChip, EmptyState),
//            home_providers (profileProvider), ProfileHeader, ActivityGraph,
//            FriendAvatars, go_router (voltar), core/utils/app_log.
// USADO POR: core/router/router.dart (/profile); aberta pelo botão de perfil.
// SPEC:      specs/features/home.yaml (screens.ProfileScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_chip.dart';
import '../../../core/widgets/section_header.dart';
import '../application/home_providers.dart';
import '../data/profile.dart';
import 'widgets/activity_graph.dart';
import 'widgets/friend_avatars.dart';
import 'widgets/profile_header.dart';

/// Tela de perfil do usuário. Usada por: router (/profile).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _bar(context),
            Expanded(
              child: profile.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
                error: (e, _) => EmptyState(
                  title: 'Não deu para carregar o perfil',
                  message: '$e',
                  icon: AppIcons.error,
                ),
                data: (p) => _content(p),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Barra superior: voltar (context.pop) + ícone de configurações. Usada por: [build].
  Widget _bar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(AppIcons.back, color: AppColors.text),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(AppIcons.settings, color: AppColors.text2),
            onPressed: () => AppLog.i('home', 'abrir configurações do perfil'),
          ),
        ],
      ),
    );
  }

  /// Corpo rolável do perfil. Usada por: [build].
  Widget _content(Profile p) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
      children: [
        Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(profile: p),
              SectionHeader(
                label: 'Amigos',
                action: 'ver todos',
                onAction: () => AppLog.i('home', 'ver todos os amigos'),
              ),
              const FriendAvatars(),
              const SectionHeader(
                  label: 'Seu semestre na cozinha', action: 'toque num dia'),
              const ActivityGraph(),
              const SectionHeader(label: 'Sua cozinha ultimamente'),
              _summary(p),
            ],
          ),
        ),
      ],
    );
  }

  /// Resumo "chave: valor" da cozinha; "técnica em alta" vira chip accent.
  /// Usada por: [_content].
  Widget _summary(Profile p) {
    return Column(
      children: [
        _summaryRow('Cozinha',
            Text(p.cuisine, style: AppType.on(AppType.body, AppColors.text2))),
        _summaryRow('Tipo de prato',
            Text(p.dishType, style: AppType.on(AppType.body, AppColors.text2))),
        _summaryRow(
          'Técnica em alta',
          PitadaChip(label: p.topTechnique, variant: PitadaChipVariant.accent),
        ),
        _summaryRow(
          'Mais feita',
          Text(p.mostCooked, style: AppType.on(AppType.body, AppColors.text2)),
          showDivider: false,
        ),
      ],
    );
  }

  /// Uma linha do resumo: rótulo à esquerda, valor (widget) à direita.
  /// Usada por: [_summary].
  Widget _summaryRow(String label, Widget value, {bool showDivider = true}) {
    return HairlineRow(
      showDivider: showDivider,
      title: Text(label, style: AppType.on(AppType.body, AppColors.muted)),
      trailing: value,
    );
  }
}
