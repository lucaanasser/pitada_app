// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/layout/masthead.dart
// O QUÊ:     Marca 'pitada' centralizada no topo das abas (três pontos + serifa).
// USA:       theme/colors, theme/spacing, theme/typography (tokens do design system).
// USADO POR: recipes/notebook/plans/groceries/profile screens (topo de cada aba)
//            e sign_in_screen.
// SPEC:      specs/components/layout/masthead.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Cabeçalho de marca do app. Visual fixo, sem parâmetros.
/// Usada por: todas as telas de aba (topo).
class Masthead extends StatelessWidget {
  const Masthead({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _Pinch(),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'pitada',
            style: AppType.titleSm.copyWith(
              fontSize: 18,
              letterSpacing: 1.1,
              color: context.pit.text2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Os três pontinhos terracota da marca (o "pinch"), alinhados pela base.
/// Usada por: [Masthead].
class _Pinch extends StatelessWidget {
  const _Pinch();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Dot(4.5),
        SizedBox(width: 2.5),
        _Dot(5.5),
        SizedBox(width: 2.5),
        _Dot(6.5),
      ],
    );
  }
}

/// Um ponto redondo terracota de tamanho [size]. Usada por: [_Pinch].
class _Dot extends StatelessWidget {
  const _Dot(this.size);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
    );
  }
}
