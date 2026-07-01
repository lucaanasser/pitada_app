// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/caderno_add_sheet.dart
// O QUÊ:     Sheet "Adicionar ao Caderno" — escolhe o que criar (ficha/nota/
//            diário/log) a partir do hub.
// USA:       core/widgets (HairlineRow), theme/*, go_router (navegação p/ editores).
// USADO POR: LearningScreen (botão '+' do hub).
// SPEC:      specs/features/learning.yaml (sheets.showCadernoAddSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/hairline_row.dart';

/// Abre o bottom sheet "Adicionar ao Caderno" com as 4 opções de criação.
/// Usada por: LearningScreen (ação '+' do cabeçalho).
void showCadernoAddSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surf,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
    ),
    builder: (ctx) => const _CadernoAddSheet(),
  );
}

/// Conteúdo do sheet: grip + título + lista de opções (SourceRow).
/// Usada por: [showCadernoAddSheet].
class _CadernoAddSheet extends StatelessWidget {
  const _CadernoAddSheet();

  /// Cada opção: rótulo, subtítulo e rota do editor a abrir. Usada por: [build].
  static const _options = <_AddOption>[
    _AddOption(
      title: 'Ficha',
      subtitle: 'Técnica, framework ou guia de ingrediente',
      route: '/lesson-edit',
    ),
    _AddOption(
      title: 'Nota de fonte',
      subtitle: 'O que fica de um livro, vídeo, curso ou chef',
      route: '/note-edit',
    ),
    _AddOption(
      title: 'Entrada de diário',
      subtitle: 'Registro do que você aprendeu cozinhando',
      route: '/diary-edit',
    ),
    _AddOption(
      title: 'Log de processo',
      subtitle: 'Fermentação, sous-vide, cura — o avançado',
      route: '/log-edit',
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
            const Text('Adicionar ao Caderno', style: AppType.title),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < _options.length; i++)
              HairlineRow(
                title: Text(_options[i].title,
                    style: AppType.on(AppType.body, AppColors.text)),
                subtitle: Text(_options[i].subtitle, style: AppType.caption),
                trailing: const Icon(Icons.chevron_right,
                    size: 20, color: AppColors.faint),
                showDivider: i != _options.length - 1,
                onTap: () {
                  Navigator.of(context).pop();
                  context.push(_options[i].route);
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Uma opção do sheet de adição. Usada por: [_CadernoAddSheet].
class _AddOption {
  final String title;
  final String subtitle;
  final String route;

  const _AddOption({
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
