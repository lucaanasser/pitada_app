// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/home/context_strip.dart
// O QUÊ:     Bloco de contexto vivo no topo da aba Receitas: até 3 cards de
//            sinal real (registrar cozinha, despensa vencendo, combinado do
//            plano). Some quando não há sinal.
// USA:       recipe_context_providers, notebook/diary_quick_sheet (registro),
//            core/theme (pit, AppType, AppSpacing, AppIcons), go_router.
// USADO POR: recipes_screen (topo da lista).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../notebook/presentation/sheets/diary_quick_sheet.dart';
import '../../../application/recipe_context_providers.dart';

/// Os cards do contexto vivo, empilhados. Usada por: recipes_screen.
class ContextStrip extends ConsumerWidget {
  const ContextStrip({super.key});

  /// Observa os sinais e monta um card por item (nada quando vazio).
  /// Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(recipeContextProvider);
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _ContextCard(item: item),
          ),
      ],
    );
  }
}

/// Um card de sinal: kicker + título + convite, pastel do sinal, tocável.
/// Usada por: [ContextStrip].
class _ContextCard extends StatelessWidget {
  const _ContextCard({required this.item});

  final RecipeContextItem item;

  /// Registro pendente abre o diário rápido; os demais navegam para a receita.
  /// Usada por: [build].
  void _open(BuildContext context) {
    if (item.kind == RecipeContextKind.register) {
      showDiaryQuickSheet(context, recipeName: item.recipeName);
      return;
    }
    final route = item.route;
    if (route != null) context.push(route);
  }

  /// Monta a caixa pastel com kicker, título, corpo e seta. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return GestureDetector(
      onTap: () => _open(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: pit.card(item.hero),
          borderRadius: AppSpacing.br(AppSpacing.radiusCard),
          border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.kicker.toUpperCase(),
                    style: AppType.on(AppType.label, pit.text2),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.title,
                    style: AppType.on(AppType.titleSm, pit.text),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.body,
                    style: AppType.on(AppType.captionSm, pit.text2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Icon(AppIcons.chevron, size: 16, color: pit.text2),
          ],
        ),
      ),
    );
  }
}
