// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/shared/detail_header.dart
// O QUÊ:     Cabeçalho das telas de detalhe/lista do Caderno: voltar + kicker +
//            título + lead, com ação opcional à direita (editar/adicionar).
// USA:       core/widgets (PitadaIconButton), theme/*, go_router (voltar).
// USADO POR: ProcessLogsScreen, ProcessLogScreen, RepertoireScreen, PairingDetailScreen.
// SPEC:      specs/features/notebook.yaml (layout "voltar/'+', kicker + título + lead")
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';

/// Cabeçalho editorial de uma tela do Caderno: linha de botões (voltar + ação),
/// [kicker] em versalete, [title] em serifa e [lead] opcional de apoio.
/// Usada por: telas de detalhe e listas do Caderno (parte Repertório/Logs).
class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.kicker,
    required this.title,
    this.lead,
    this.actionIcon,
    this.onAction,
  });

  final String kicker;
  final String title;
  final String? lead;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  /// Monta a linha de navegação e o bloco de título. Usada por: as telas do Caderno.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PitadaIconButton(
                icon: AppIcons.back,
                onPressed: () => context.pop(),
              ),
              const Spacer(),
              if (actionIcon != null)
                PitadaIconButton(icon: actionIcon!, onPressed: onAction),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            kicker.toUpperCase(),
            style: AppType.on(AppType.label, pit.muted),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: AppType.on(AppType.display, pit.text)),
          if (lead != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(lead!, style: AppType.on(AppType.body, pit.text2)),
          ],
        ],
      ),
    );
  }
}
