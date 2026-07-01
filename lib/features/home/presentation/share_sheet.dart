// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/presentation/share_sheet.dart
// O QUÊ:     Bottom sheet "Compartilhar na comunidade" — escolhe o que publicar
//            (receita / técnica ou framework / log de processo / nota de fonte).
// USA:       core/widgets (HairlineRow), core/theme (AppColors, AppType, AppSpacing),
//            core/utils/app_log.
// USADO POR: HomeScreen (botão compartilhar do cabeçalho).
// SPEC:      specs/features/home.yaml (sheets.ShareSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/hairline_row.dart';

/// Abre o bottom sheet "Compartilhar na comunidade" com as 4 opções de publicação.
/// Usada por: HomeScreen (ação de compartilhar do cabeçalho).
void showShareSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surf,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
    ),
    builder: (ctx) => const _ShareSheet(),
  );
}

/// Conteúdo do sheet: grip + título + subtítulo + lista de opções.
/// Usada por: [showShareSheet].
class _ShareSheet extends StatelessWidget {
  const _ShareSheet();

  /// Opções de publicação: rótulo, subtítulo e ícone de miniatura. Usada por: [build].
  static const _options = <_ShareOption>[
    _ShareOption(
      label: 'Uma receita',
      subtitle: 'Das suas receitas salvas',
      icon: Icons.restaurant_menu,
    ),
    _ShareOption(
      label: 'Uma técnica ou framework',
      subtitle: 'Do seu Caderno',
      icon: Icons.school_outlined,
    ),
    _ShareOption(
      label: 'Um log de processo',
      subtitle: 'Fermentação, cura, sous-vide…',
      icon: Icons.timeline_outlined,
    ),
    _ShareOption(
      label: 'Uma nota de fonte',
      subtitle: 'De um livro, vídeo ou chef',
      icon: Icons.menu_book_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.md,
          AppSpacing.gutter,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.line2,
                  borderRadius: AppSpacing.br(3),
                ),
              ),
            ),
            const Text('Compartilhar na comunidade', style: AppType.title),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'O que você quer publicar para seus amigos?',
              style: AppType.on(AppType.bodySm, AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < _options.length; i++)
              HairlineRow(
                leading: _OptionIcon(icon: _options[i].icon),
                title: Text(
                  _options[i].label,
                  style: AppType.on(AppType.body, AppColors.text),
                ),
                subtitle: Text(_options[i].subtitle, style: AppType.caption),
                trailing: const Icon(Icons.chevron_right,
                    size: 20, color: AppColors.faint),
                showDivider: i != _options.length - 1,
                onTap: () {
                  AppLog.i('home', 'compartilhar ${_options[i].label}');
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Miniatura de ícone (quadrado suave) que precede cada opção do sheet.
/// Usada por: [_ShareSheet].
class _OptionIcon extends StatelessWidget {
  const _OptionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.iconButton,
      height: AppSpacing.iconButton,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.accentLine, width: AppSpacing.hair),
      ),
      child: Icon(icon, size: 18, color: AppColors.accent2),
    );
  }
}

/// Uma opção do sheet de compartilhar. Usada por: [_ShareSheet].
class _ShareOption {
  final String label;
  final String subtitle;
  final IconData icon;

  const _ShareOption({
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}
