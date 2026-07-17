// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/frameworks_tab_view.dart
// O QUÊ:     Conteúdo da tab Frameworks: a única sugestão socrática (quando
//            houver) e os cards de planta baixa. Estado vazio didático — o
//            primeiro contato com a ideia. Criar framework fica no '+' do
//            header (card Novo Framework da ImportSheet).
// USA:       framework_providers, framework_suggestion_service, framework_card,
//            framework_suggestion_card, core/widgets (EmptyState).
// USADO POR: recipes_screen (tab 1).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../application/framework_providers.dart';
import '../../../application/framework_suggestion_service.dart';
import '../../../data/models/framework.dart';
import 'framework_card.dart';
import 'framework_suggestion_card.dart';

/// Corpo da tab Frameworks. Usada por: recipes_screen.
class FrameworksTabView extends ConsumerWidget {
  const FrameworksTabView({super.key});

  /// Observa frameworks + sugestão e monta a tab. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frameworks =
        ref.watch(frameworksProvider).valueOrNull ?? const <Framework>[];
    final suggestion = ref.watch(frameworkSuggestionProvider);
    final dismissed = ref.watch(frameworkSuggestionDismissedProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (suggestion != null && !dismissed) ...[
          FrameworkSuggestionCard(
            suggestion: suggestion,
            onAnswer: () {
              final ids = [for (final r in suggestion.recipes) r.id].join(',');
              context.push('/framework/new?recipes=$ids');
            },
            onDismiss: () => ref
                .read(frameworkSuggestionDismissedProvider.notifier)
                .state = true,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (frameworks.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
            child: EmptyState(
              title: 'Nenhum framework ainda',
              message: 'Um framework é o que sobra de uma receita quando '
                  'você tira as quantidades — a estrutura que se repete. '
                  'Junte receitas parecidas e dê um nome ao padrão '
                  'no botão +.',
              icon: AppIcons.framework,
            ),
          )
        else
          for (final f in frameworks)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: FrameworkCard(
                framework: f,
                onTap: () => context.push('/framework/${f.id}'),
              ),
            ),
      ],
    );
  }
}
