// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/option_card.dart
// O QUÊ:     Opção de refeição (Planos): bloco flat (surf2; accent se escolhida)
//            com cabeçalho escolhível + pratos linkáveis.
// USA:       theme/*, utils/format (formatKcal).
// USADO POR: plans (MealCard, na sub-aba Cardápio).
// SPEC:      specs/components/option_card.yaml
// ─────────────────────────────────────────────────────────────────────────────
import '../theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/pitada_colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../utils/format.dart';

/// Prato dentro de uma opção. [linked] indica que é uma receita salva (abrível).
class OptionDish {
  final String name;
  final int kcal;
  final bool linked;
  const OptionDish({
    required this.name,
    required this.kcal,
    this.linked = false,
  });
}

/// Cartão de uma opção de refeição. [chosen] realça; [fits] escolhe o selo.
/// Usada por: plans_screen. onTapDish só dispara em pratos linkados.
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.name,
    required this.dishes,
    required this.chosen,
    required this.fits,
    required this.fitLabel,
    required this.onChoose,
    this.onTapDish,
  });

  final String name;
  final List<OptionDish> dishes;
  final bool chosen;
  final bool fits;
  final String fitLabel;
  final VoidCallback onChoose;
  final ValueChanged<int>? onTapDish;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md - 2),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md + 2,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: chosen ? AppColors.accentSoft : pit.surf2,
        borderRadius: AppSpacing.br(AppSpacing.radiusLg),
        border: Border.all(
          color: chosen ? AppColors.accent : Colors.transparent,
          width: AppSpacing.borderStrong,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onChoose,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                _Radio(on: chosen),
                const SizedBox(width: AppSpacing.md - 1),
                Expanded(
                  child: Text(
                    name,
                    style: AppType.on(AppType.numeralSm, pit.text),
                  ),
                ),
                Text(
                  fitLabel,
                  style: AppType.on(
                    AppType.caption,
                    fits ? AppColors.sage : AppColors.accent2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          for (var i = 0; i < dishes.length; i++) _dish(pit, i),
        ],
      ),
    );
  }

  /// Renderiza um prato da opção; se linkado, mostra seta e fica clicável.
  /// Usada por: [build].
  Widget _dish(PitadaColors pit, int i) {
    final d = dishes[i];
    return GestureDetector(
      onTap: d.linked ? () => onTapDish?.call(i) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 29, top: 6, bottom: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                d.name,
                style: AppType.on(
                  AppType.bodySm,
                  d.linked ? pit.text : pit.text2,
                ),
              ),
            ),
            Text(
              formatKcal(d.kcal),
              style: AppType.on(AppType.caption, pit.muted),
            ),
            if (d.linked) ...[
              const SizedBox(width: AppSpacing.sm),
              Icon(AppIcons.chevron, size: 15, color: pit.faint),
            ],
          ],
        ),
      ),
    );
  }
}

/// Bolinha de rádio (vazia/preenchida) da opção. Usada por: [OptionCard].
class _Radio extends StatelessWidget {
  const _Radio({required this.on});
  final bool on;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: on ? AppColors.accent : context.pit.line2,
          width: 2,
        ),
      ),
      child: on
          ? Container(
              margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}
