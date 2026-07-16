// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/widgets/theme_picker.dart
// O QUÊ:     Seletor visual de tema: 3 cards (Claro / Escuro / Sistema) com
//            mini-preview de cada tema; o selecionado ganha borda accent.
// USA:       core/theme (AppColors — tokens crus dos 2 temas p/ os previews,
//            theme_providers, context.pit, AppSpacing, AppType), app_log.
// USADO POR: SettingsScreen (seção "Aparência").
// SPEC:      specs/features/profile.yaml (components_da_feature.ThemePicker)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/theme_providers.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/app_log.dart';

/// Altura do mini-preview de tema dentro do card. Usada por: [_Preview].
const double _kPreview = 56;

/// Seletor de tema com previews. Lê/grava themeModeProvider.
/// Usada por: SettingsScreen.
class ThemePicker extends ConsumerWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return Row(
      children: [
        _card(ref, ThemeMode.light, 'Claro', mode),
        const SizedBox(width: AppSpacing.md),
        _card(ref, ThemeMode.dark, 'Escuro', mode),
        const SizedBox(width: AppSpacing.md),
        _card(ref, ThemeMode.system, 'Sistema', mode),
      ],
    );
  }

  /// Um card de opção: preview + rótulo; toque grava o modo. Usada por: [build].
  Widget _card(WidgetRef ref, ThemeMode option, String label, ThemeMode mode) {
    return Expanded(
      child: _ThemeCard(
        option: option,
        label: label,
        selected: option == mode,
        onTap: () {
          ref.read(themeModeProvider.notifier).state = option;
          AppLog.i('profile', 'tema alterado: ${option.name}');
        },
      ),
    );
  }
}

/// Card individual: mini-preview do tema + rótulo; selecionado = borda accent.
/// Usada por: [ThemePicker].
class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.option,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final ThemeMode option;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            height: _kPreview,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: AppSpacing.br(AppSpacing.radiusLg),
              border: Border.all(
                color: selected ? AppColors.accent : pit.border,
                width: selected
                    ? AppSpacing.borderAccent
                    : AppSpacing.borderStrong,
              ),
            ),
            child: _Preview(option: option),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppType.on(
              AppType.titleXs,
              selected ? AppColors.accent : pit.text2,
            ),
          ),
        ],
      ),
    );
  }
}

/// O miolo do preview: fundo do tema + barra de "texto" + ponto accent.
/// Sistema mostra metade claro / metade escuro. Usada por: [_ThemeCard].
class _Preview extends StatelessWidget {
  const _Preview({required this.option});

  final ThemeMode option;

  @override
  Widget build(BuildContext context) {
    if (option == ThemeMode.system) {
      return const Row(
        children: [
          Expanded(child: _PreviewHalf(dark: false)),
          Expanded(child: _PreviewHalf(dark: true)),
        ],
      );
    }
    return _PreviewHalf(dark: option == ThemeMode.dark);
  }
}

/// Amostra de um tema: fundo + 2 barrinhas de texto + ponto accent.
/// Usada por: [_Preview].
class _PreviewHalf extends StatelessWidget {
  const _PreviewHalf({required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.bg : AppColors.bgLight;
    final ink = dark ? AppColors.text : AppColors.textLight;
    final line = dark ? AppColors.line2 : AppColors.line2Light;
    return Container(
      color: bg,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bar(ink, 22),
          const SizedBox(height: AppSpacing.xs),
          _bar(line, 32),
          const Spacer(),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  /// Barrinha que imita uma linha de texto. Usada por: [build].
  Widget _bar(Color color, double width) {
    return Container(
      width: width,
      height: 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppSpacing.br(AppSpacing.radiusPill),
      ),
    );
  }
}
