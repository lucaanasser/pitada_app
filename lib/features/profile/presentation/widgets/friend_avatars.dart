// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/friend_avatars.dart
// O QUÊ:     Fileira horizontal de avatares de amigos + botão "Adicionar".
// USA:       core/theme (AppColors.heroOf, PitadaColors via context.pit, AppType,
//            AppSpacing), core/utils/app_log.
// USADO POR: ProfileScreen (seção "Amigos").
// SPEC:      specs/features/profile.yaml (components_da_feature.FriendAvatars)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';

/// Amigos de exemplo (inicial + cor hero). Determinístico, sem random.
/// Usada por: [FriendAvatars].
const _kFriends = <_Friend>[
  _Friend('Marina', 'M', 'terra'),
  _Friend('Rafael', 'R', 'clay'),
  _Friend('Beatriz', 'B', 'moss'),
  _Friend('Tiago', 'T', 'ochre'),
  _Friend('Lívia', 'L', 'plum'),
];

/// Fileira de avatares de amigos, terminando no botão "Adicionar".
/// Usada por: ProfileScreen.
class FriendAvatars extends StatelessWidget {
  const FriendAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          for (final f in _kFriends)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: _FriendAvatar(friend: f),
            ),
          const _AddFriend(),
        ],
      ),
    );
  }
}

/// Avatar de um amigo: círculo com inicial + primeiro nome abaixo.
/// Usada por: [FriendAvatars].
class _FriendAvatar extends StatelessWidget {
  const _FriendAvatar({required this.friend});

  final _Friend friend;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSpacing.button - AppSpacing.md,
          height: AppSpacing.button - AppSpacing.md,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.heroOf(friend.hero),
            shape: BoxShape.circle,
          ),
          child: Text(
            friend.initial,
            // Creme fixo (AppColors.text): as cores hero são médias/escuras
            // nos 2 temas, então a inicial clara lê bem em ambos.
            style: AppType.on(AppType.titleSm, AppColors.text),
          ),
        ),
        const SizedBox(height: AppSpacing.xs + 1),
        Text(
          friend.name,
          style: AppType.on(AppType.captionSm, context.pit.muted),
        ),
      ],
    );
  }
}

/// Botão redondo tracejado "Adicionar" no fim da fileira. Usada por: [FriendAvatars].
class _AddFriend extends StatelessWidget {
  const _AddFriend();

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: () => AppLog.i('profile', 'adicionar amigo'),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpacing.button - AppSpacing.md,
            height: AppSpacing.button - AppSpacing.md,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: pit.line2, width: AppSpacing.hair),
            ),
            child: Icon(AppIcons.add, size: 20, color: pit.muted),
          ),
          const SizedBox(height: AppSpacing.xs + 1),
          Text(
            'Adicionar',
            style: AppType.on(AppType.captionSm, pit.muted),
          ),
        ],
      ),
    );
  }
}

/// Um amigo do perfil (dados de exemplo). Usada por: [FriendAvatars].
class _Friend {
  final String name;
  final String initial;
  final String hero;

  const _Friend(this.name, this.initial, this.hero);
}
