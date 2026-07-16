// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_suggestion_card.dart
// O QUÊ:     A ÚNICA sugestão socrática da tab: aponta receitas parentes e
//            pergunta o que têm em comum — quem responde (e nomeia) é a pessoa.
//            Dispensável no X; nunca mais de uma por vez.
// USA:       core/theme, core/widgets (PitadaButton), FrameworkSuggestion.
// USADO POR: frameworks_tab_view.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../application/framework_suggestion_service.dart';

/// Card da pergunta socrática. Usada por: FrameworksTabView.
class FrameworkSuggestionCard extends StatelessWidget {
  const FrameworkSuggestionCard({
    super.key,
    required this.suggestion,
    this.onAnswer,
    this.onDismiss,
  });

  final FrameworkSuggestion suggestion;
  final VoidCallback? onAnswer;
  final VoidCallback? onDismiss;

  /// Monta o card (nomes + pista + pergunta + ação). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final names = [for (final r in suggestion.recipes) r.title];
    final list = names.length <= 2
        ? names.join(' e ')
        : '${names.sublist(0, names.length - 1).join(', ')} e ${names.last}';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: pit.surf2,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.line2, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'PARECEM PARENTES',
                  style: AppType.on(AppType.label, AppColors.accent),
                ),
              ),
              GestureDetector(
                onTap: onDismiss,
                behavior: HitTestBehavior.opaque,
                child: Icon(AppIcons.close, size: 18, color: pit.muted),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$list — ${suggestion.sharedTrait}.',
            style: AppType.on(AppType.body, pit.text2),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'O que elas têm em comum?',
            style: AppType.on(AppType.titleSm, pit.text),
          ),
          const SizedBox(height: AppSpacing.lg),
          PitadaButton(
            label: 'Responder criando um framework',
            variant: PitadaButtonVariant.outline,
            onPressed: onAnswer,
          ),
        ],
      ),
    );
  }
}
