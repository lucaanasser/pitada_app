// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/lesson_cards_screen.dart
// O QUÊ:     Fichas — enciclopédia pessoal. Abas por categoria (Técnicas…Ervas)
//            e lista de fichas que abre o detalhe.
// USA:       core/widgets (PitadaTabs), theme/*, learning_providers, LessonCardRow,
//            DetailHeader, go_router (navegação).
// USADO POR: core/router/router.dart (/learning/cards).
// SPEC:      specs/features/notebook.yaml (screens.LessonCardsScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/tabs/pitada_tabs.dart';
import '../application/providers.dart';
import '../data/lesson.dart';
import 'widgets/detail_header.dart';
import 'widgets/lesson_card_row.dart';

/// Categorias das Fichas, na ordem das abas. Usada por: [LessonCardsScreen].
const _tabCategories = <LessonKind>[
  LessonKind.technique,
  LessonKind.framework,
  LessonKind.ingredient,
  LessonKind.flavor,
  LessonKind.herb,
];

/// Rótulos das abas, alinhados a [_tabCategories]. Usada por: [LessonCardsScreen].
const _tabLabels = <String>[
  'Técnicas',
  'Frameworks',
  'Ingredientes',
  'Sabores',
  'Ervas',
];

/// Tela de Fichas: abas de categoria + lista de fichas. Usada por: router (/learning/cards).
class LessonCardsScreen extends ConsumerWidget {
  const LessonCardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedLessonCategoryProvider);
    final async = ref.watch(lessonsProvider);
    final pit = context.pit;

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeader(
              kicker: 'Conhecimento',
              title: 'Fichas',
              lead: 'Sua enciclopédia pessoal de cozinha.',
              actionIcon: AppIcons.add,
              onAction: () => context.push('/lesson-edit'),
            ),
            const SizedBox(height: AppSpacing.sm),
            PitadaTabs(
              tabs: _tabLabels,
              selected: selected,
              onSelect: (i) =>
                  ref.read(selectedLessonCategoryProvider.notifier).state = i,
            ),
            Expanded(
              child: async.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
                error: (e, _) => Center(
                  child: Text('Erro: $e',
                      style: AppType.on(AppType.body, pit.text)),
                ),
                data: (lessons) => _list(context, lessons, selected),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Filtra as fichas pela categoria da aba e monta a lista (ou vazio).
  /// Usada por: [build].
  Widget _list(BuildContext context, List<Lesson> lessons, int selected) {
    final category = _tabCategories[selected];
    final items = lessons.where((l) => l.category == category).toList();
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child: EmptyState(
          title: 'Nada por aqui ainda',
          message: 'Toque em + para criar a primeira ficha desta categoria.',
          icon: AppIcons.book,
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.xxxl,
      ),
      children: [
        for (var i = 0; i < items.length; i++)
          LessonCardRow(
            lesson: items[i],
            showDivider: i != items.length - 1,
            onTap: () => context.push('/lesson/${items[i].id}'),
          ),
      ],
    );
  }
}
