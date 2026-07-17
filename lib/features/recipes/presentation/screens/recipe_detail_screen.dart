// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/recipe_detail_screen.dart
// O QUÊ:     Detalhe da receita: galeria grande, kcal, macros, ingredientes, passos.
// USA:       recipes_providers, widgets do detalhe, core/widgets, core/theme (pit).
// USADO POR: core/router/router.dart (/recipe/:id).
// SPEC:      specs/features/recipes.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../application/recipes_providers.dart';
import '../../data/models/recipe.dart';
import '../sheets/recipe_version_sheet.dart';
import '../widgets/detail/header/recipe_version_tag.dart';
import '../widgets/detail/recipe_detail_body.dart';

/// Tela de detalhe de uma receita. Usada por: router (/recipe/:id).
class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  /// Observa a receita por id e monta carregando/erro/conteúdo. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(recipeByIdProvider(recipeId));
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: async.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (e, _) => Center(
          child: Text('Erro: $e', style: AppType.on(AppType.body, pit.text)),
        ),
        data: (recipe) => recipe == null
            ? Center(
                child: Text(
                  'Receita não encontrada',
                  style: AppType.on(AppType.body, pit.text),
                ),
              )
            : _body(context, ref, recipe),
      ),
    );
  }

  /// Resolve a VERSÃO a exibir: sem grupo (ou grupo de 1) mostra a receita como
  /// está; com 2+ versões, mostra a selecionada (default = definitiva) e um marcador
  /// "V3" tocável que abre o seletor. Usada por: [build].
  Widget _body(BuildContext context, WidgetRef ref, Recipe base) {
    final groupId = base.versionGroupId;
    if (groupId == null) return RecipeDetailBody(recipe: base);

    final group = ref.watch(recipeVersionGroupProvider(groupId)).valueOrNull;
    if (group == null || group.length < 2) {
      return RecipeDetailBody(recipe: base);
    }

    final maxVersion = group.last.version;
    final selected =
        ref.watch(selectedRecipeVersionProvider(groupId)) ?? maxVersion;
    final current = group.firstWhere(
      (r) => r.version == selected,
      orElse: () => base,
    );
    final tag = RecipeVersionTag(
      version: current.version,
      onTap: () => showRecipeVersionSheet(
        context,
        groupId: groupId,
        definitivaId: group.last.id,
      ),
    );
    return RecipeDetailBody(recipe: current, versionTag: tag);
  }
}
