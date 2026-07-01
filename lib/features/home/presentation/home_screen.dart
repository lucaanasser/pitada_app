// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/home_screen.dart
// O QUÊ:     Aba Home (comunidade): marca, título, atalho de perfil, compartilhar
//            e feed de posts de amigos (CommunityPostCard).
// USA:       core/widgets (Masthead, PitadaScaffold, PitadaIconButton, EmptyState),
//            home_providers (feedProvider), CommunityPostCard, share_sheet, go_router.
// USADO POR: core/router/router.dart (branch /home).
// SPEC:      specs/features/home.yaml (screens.HomeScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../application/home_providers.dart';
import 'share_sheet.dart';
import 'widgets/community_post_card.dart';

/// Tela principal da comunidade (feed). Usada por: router (/home).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedProvider);
    return PitadaScaffold(
      top: const Masthead(),
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          _header(context),
          Padding(
            padding: AppSpacing.screenH,
            child: feed.when(
              loading: () => const Padding(
                padding: EdgeInsets.only(top: AppSpacing.xxxl),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxxl),
                child: EmptyState(
                  title: 'Não deu para carregar o feed',
                  message: '$e',
                  icon: Icons.error_outline,
                ),
              ),
              data: (posts) => posts.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: AppSpacing.xxxl),
                      child: EmptyState(
                        title: 'Feed vazio',
                        message: 'Quando seus amigos publicarem, aparece aqui.',
                        icon: Icons.groups_outlined,
                      ),
                    )
                  : Column(
                      children: [
                        for (final post in posts)
                          CommunityPostCard(
                            post: post,
                            onTap: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Abrir post — próximo passo'),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// Cabeçalho da aba: título "Home" + atalhos de perfil e compartilhar.
  /// Usada por: [build].
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Expanded(child: Text('Home', style: AppType.screenTitle)),
          PitadaIconButton(
            icon: Icons.person_outline,
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: AppSpacing.sm),
          PitadaIconButton(
            icon: Icons.ios_share,
            onPressed: () => showShareSheet(context),
          ),
        ],
      ),
    );
  }
}
