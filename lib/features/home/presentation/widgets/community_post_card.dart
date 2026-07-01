// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/widgets/community_post_card.dart
// O QUÊ:     Card de um post do feed: autor (avatar+inicial), tipo, título e
//            miniatura do item compartilhado, com ações de curtir/comentar/salvar.
// USA:       core/widgets (RecipeThumb), core/theme (AppColors, AppType, AppSpacing),
//            CommunityPost (modelo).
// USADO POR: HomeScreen (lista do feed da comunidade).
// SPEC:      specs/features/home.yaml (components_da_feature.FeedPostCard)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/recipe_thumb.dart';
import '../../data/community_post.dart';

/// Card de um post da comunidade. Mostra quem publicou e o item compartilhado.
/// Usada por: HomeScreen (feed rolável).
class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({super.key, required this.post, this.onTap});

  final CommunityPost post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surf,
          borderRadius: AppSpacing.br(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.line, width: AppSpacing.hair),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _authorRow(),
            const SizedBox(height: AppSpacing.md),
            _sharedItem(),
          ],
        ),
      ),
    );
  }

  /// Cabeçalho do post: avatar com inicial + nome do autor + rótulo do tipo.
  /// Usada por: [build].
  Widget _authorRow() {
    return Row(
      children: [
        _Avatar(
            initial: post.authorInitial,
            color: AppColors.heroOf(post.heroColor)),
        const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.author,
                  style: AppType.on(AppType.titleSm, AppColors.text)),
              const SizedBox(height: 2),
              Text(
                'compartilhou ${post.kind}',
                style: AppType.on(AppType.caption, AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Bloco do item compartilhado: miniatura colorida + título + meta.
  /// Usada por: [build].
  Widget _sharedItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RecipeThumb(color: AppColors.heroOf(post.heroColor)),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title, style: AppType.titleSm),
              const SizedBox(height: AppSpacing.xs),
              Text(
                post.subtitle,
                style: AppType.on(AppType.caption, AppColors.muted),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        const Icon(AppIcons.chevron, size: 16, color: AppColors.faint),
      ],
    );
  }
}

/// Avatar circular com a inicial do autor sobre a cor hero dele.
/// Usada por: [CommunityPostCard].
class _Avatar extends StatelessWidget {
  const _Avatar({required this.initial, required this.color});

  final String initial;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.iconButton,
      height: AppSpacing.iconButton,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        initial.toUpperCase(),
        style: AppType.on(AppType.titleSm, AppColors.text),
      ),
    );
  }
}
