// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/sub_recipe/sub_recipe_providers.dart
// O QUÊ:     Providers Riverpod de subreceitas (biblioteca, detalhe, uso) e o
//            controller de edição/vínculo — única porta de escrita.
// USA:       sub_recipe_repository (contrato), seed_sub_recipe_repository
//            (default offline), sub_recipe.dart, recipe.dart,
//            recipe_component.dart, recipes_providers (porta de receita).
// USADO POR: biblioteca de subreceitas, detalhe da receita (selo/edição),
//            unify_service (unificação N->1).
// SPEC:      specs/features/sub_recipes.yaml (application)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/recipe/recipe.dart';
import '../../data/models/recipe/recipe_component.dart';
import '../../data/models/recipe/sub_recipe.dart';
import '../../data/repositories/sub_recipe/seed_sub_recipe_repository.dart';
import '../../data/repositories/sub_recipe/sub_recipe_repository.dart';
import '../recipes_providers.dart';

/// Instância do repositório de subreceitas. Default = seed em memória;
/// main.dart sobrescreve com SupabaseSubRecipesRepository quando há chaves.
/// Usada por: os providers abaixo.
final subRecipesRepositoryProvider =
    Provider<SubRecipesRepository>((ref) => const SeedSubRecipesRepository());

/// Biblioteca de subreceitas (ordem por nome). Usada por: SubRecipesScreen,
/// seletor de vínculo.
final subRecipesProvider = FutureProvider<List<SubRecipe>>((ref) {
  return ref.watch(subRecipesRepositoryProvider).fetchSubRecipes();
});

/// Uma subreceita por id, para o detalhe da biblioteca.
/// Usada por: SubRecipeDetailScreen.
final subRecipeByIdProvider =
    FutureProvider.family<SubRecipe?, String>((ref, id) {
  return ref.watch(subRecipesRepositoryProvider).fetchById(id);
});

/// Quantas receitas DEFINITIVAS vinculam cada subreceita (id -> contagem).
/// Derivado das receitas em Dart — sem SQL, paridade seed/Supabase de graça.
/// Usada por: selo "usada em N receitas", biblioteca.
final subRecipeUsageProvider = FutureProvider<Map<String, int>>((ref) async {
  final recipes = await ref.watch(recipesProvider.future);
  final counts = <String, int>{};
  for (final r in recipes) {
    for (final c in r.components) {
      final id = c.subRecipeId;
      if (id != null) counts[id] = (counts[id] ?? 0) + 1;
    }
  }
  return counts;
});

/// Controller de subreceita: salvar (PROPAGA), promover, vincular, desvincular
/// e escalar. Saves de receita delegam ao RecipeEditController (porta única).
/// Usada por: subRecipeEditControllerProvider.
class SubRecipeEditController {
  const SubRecipeEditController(this._ref);

  final Ref _ref;

  /// Persiste a subreceita editada e refaz TODAS as telas de receita — cada
  /// prato que a vincula reflete na hora. Usada por: edição na biblioteca e
  /// edição inline de componente vinculado.
  Future<void> save(SubRecipe sub) async {
    await _ref.read(subRecipesRepositoryProvider).updateSubRecipe(sub);
    _invalidate();
  }

  /// Promove o componente [index] a subreceita compartilhada com [name]:
  /// cria a SubRecipe com o conteúdo atual e troca o componente pelo vínculo
  /// (scale 1). Devolve o id criado. Usada por: ação "tornar subreceita".
  Future<String> promote(Recipe recipe, int index, String name) async {
    final c = recipe.components[index];
    final id = await _ref.read(subRecipesRepositoryProvider).createSubRecipe(
          SubRecipe(
            id: '',
            name: name,
            ingredients: c.ingredients,
            steps: c.steps,
          ),
        );
    await _ref.read(recipeEditControllerProvider).save(
          recipe.withComponent(
            index,
            c.copyWith(name: name, subRecipeId: id, scale: 1),
          ),
        );
    _invalidate();
    return id;
  }

  /// Anexa um vínculo com a subreceita [subRecipeId] no fim da receita.
  /// Usada por: ação "usar subreceita" (seletor da biblioteca).
  Future<void> link(Recipe recipe, String subRecipeId, {num scale = 1}) async {
    final linked = RecipeComponent(subRecipeId: subRecipeId, scale: scale);
    await _ref.read(recipeEditControllerProvider).save(
          recipe.copyWith(components: [...recipe.components, linked]),
        );
    _invalidate();
  }

  /// Desvincula o componente [index]: vira cópia LOCAL desta receita (mantém o
  /// conteúdo resolvido na escala atual). Usada por: ação "desvincular".
  Future<void> unlink(Recipe recipe, int index) async {
    await _ref.read(recipeEditControllerProvider).save(
          recipe.withComponent(index, recipe.components[index].unlinked()),
        );
    _invalidate();
  }

  /// Troca o fator de escala do vínculo [index] (única variação por uso).
  /// Usada por: ação de escala no componente vinculado.
  Future<void> setScale(Recipe recipe, int index, num scale) async {
    final c = recipe.components[index];
    await _ref.read(recipeEditControllerProvider).save(
          recipe.withComponent(index, c.copyWith(scale: scale)),
        );
    _invalidate();
  }

  /// Unifica N componentes locais parecidos numa subreceita: promove a ORIGEM
  /// como canônica e troca cada alvo (recipeId, índice, scale sugerido) pelo
  /// vínculo. Devolve o id criado. Usada por: UnifyScreen.
  Future<String> unify(
    Recipe origin,
    int originIndex,
    String name,
    List<(String, int, num)> targets,
  ) async {
    final id = await promote(origin, originIndex, name);
    final repo = _ref.read(recipesRepositoryProvider);
    for (final (recipeId, index, scale) in targets) {
      final fresh = await repo.fetchById(recipeId);
      if (fresh == null || index >= fresh.components.length) continue;
      final c = fresh.components[index];
      await _ref.read(recipeEditControllerProvider).save(
            fresh.withComponent(
              index,
              c.copyWith(subRecipeId: id, scale: scale),
            ),
          );
    }
    _invalidate();
    return id;
  }

  /// Refaz subreceitas + TODAS as famílias de receita (propagação na hora).
  /// Usada por: métodos acima.
  void _invalidate() {
    _ref.invalidate(subRecipesProvider);
    _ref.invalidate(subRecipeByIdProvider);
    _ref.invalidate(recipesProvider);
    _ref.invalidate(recipeByIdProvider);
    _ref.invalidate(recipeVersionGroupProvider);
  }
}

/// Instância do controller de subreceita. Usada por: telas da biblioteca e
/// ações de vínculo no detalhe/editor da receita.
final subRecipeEditControllerProvider =
    Provider<SubRecipeEditController>(SubRecipeEditController.new);
