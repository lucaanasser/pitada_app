// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/lesson_detail_screen.dart
// O QUÊ:     Detalhe de uma ficha — renderiza por kind (técnica/framework/guia).
//            Cabeçalho com voltar e botão editar (lápis).
// USA:       core/widgets (PitadaIconButton), theme/*, learning_providers,
//            lessonBody (corpo por kind), go_router (voltar/editar).
// USADO POR: core/router/router.dart (/lesson/:id).
// SPEC:      specs/features/notebook.yaml (screens.LessonDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/pitada_button.dart';
import '../application/providers.dart';
import '../data/lesson.dart';
import 'widgets/lesson_body.dart';

/// Tela de detalhe de uma ficha. Usada por: router (/lesson/:id).
class LessonDetailScreen extends ConsumerWidget {
  const LessonDetailScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(lessonByIdProvider(lessonId));
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        bottom: false,
        child: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(
            child: Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
          ),
          data: (lesson) => lesson == null
              ? Center(
                  child: Text(
                    'Ficha não encontrada',
                    style: AppType.on(AppType.body, pit.text),
                  ),
                )
              : _content(context, lesson),
        ),
      ),
    );
  }

  /// Monta a barra de navegação e o corpo rolável da ficha. Usada por: [build].
  Widget _content(BuildContext context, Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bar(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.xs,
              AppSpacing.gutter,
              AppSpacing.xxxl,
            ),
            children: lessonBody(context.pit, lesson),
          ),
        ),
      ],
    );
  }

  /// Linha superior: voltar à esquerda, lápis (editar) à direita. Usada por: [_content].
  Widget _bar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          PitadaIconButton(icon: AppIcons.back, onPressed: () => context.pop()),
          const Spacer(),
          PitadaIconButton(
            icon: AppIcons.edit,
            onPressed: () => context.push('/lesson-edit'),
          ),
        ],
      ),
    );
  }
}
