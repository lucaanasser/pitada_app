// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/widgets/profile_header.dart
// O QUÊ:     Cabeçalho do perfil: avatar com inicial + badge de sequência, nome,
//            bio e linha de estatísticas (receitas / caderno / preparos).
// USA:       core/theme (AppColors, AppType, AppSpacing), Profile (modelo).
// USADO POR: ProfileScreen (topo da tela).
// SPEC:      specs/features/home.yaml (components_da_feature.ProfileHeader)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../data/profile.dart';

/// Cabeçalho do perfil pessoal. Usada por: ProfileScreen.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Avatar(initial: profile.initial, streak: profile.streak),
        const SizedBox(height: AppSpacing.lg),
        Text(profile.name, style: AppType.display),
        const SizedBox(height: AppSpacing.xs),
        Text(profile.bio, style: AppType.on(AppType.bodySm, AppColors.text2)),
        const SizedBox(height: AppSpacing.lg),
        _stats(),
      ],
    );
  }

  /// Linha de estatísticas com ponto de cor por métrica. Usada por: [build].
  Widget _stats() {
    return Row(
      children: [
        _Stat(
          value: profile.recipesCount,
          label: 'receitas',
          dot: AppColors.accent2,
        ),
        _divider(),
        _Stat(
          value: profile.notebookCount,
          label: 'no caderno',
          dot: AppColors.sage,
        ),
        _divider(),
        _Stat(
          value: profile.cooksCount,
          label: 'preparos',
          dot: AppColors.teal,
        ),
      ],
    );
  }

  /// Ponto separador "·" entre as estatísticas. Usada por: [_stats].
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text('·', style: AppType.on(AppType.body, AppColors.faint)),
    );
  }
}

/// Avatar circular com a inicial + badge de sequência (fogo + dias) no canto.
/// Usada por: [ProfileHeader].
class _Avatar extends StatelessWidget {
  const _Avatar({required this.initial, required this.streak});

  final String initial;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 76,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 76,
            height: 76,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surf2,
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.line2, width: AppSpacing.borderThick),
            ),
            child: Text(
              initial.toUpperCase(),
              style: AppType.on(AppType.display, AppColors.text),
            ),
          ),
          Positioned(
              bottom: -2, right: -6, child: _StreakBadge(streak: streak)),
        ],
      ),
    );
  }
}

/// Badge de sequência: ícone de fogo + número de dias, sobre o accent.
/// Usada por: [_Avatar].
class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs - 1,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
        border: Border.all(color: AppColors.bg, width: AppSpacing.borderThick),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(AppIcons.cook,
              size: 13, color: AppColors.onAccent),
          const SizedBox(width: 2),
          Text('$streak',
              style: AppType.on(AppType.caption, AppColors.onAccent)),
        ],
      ),
    );
  }
}

/// Uma estatística: número grande (Cormorant) + ponto de cor + rótulo.
/// Usada por: [ProfileHeader].
class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.dot});

  final int value;
  final String label;
  final Color dot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.xs + 2),
        Text('$value', style: AppType.on(AppType.numeralSm, AppColors.text)),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppType.on(AppType.caption, AppColors.muted)),
      ],
    );
  }
}
