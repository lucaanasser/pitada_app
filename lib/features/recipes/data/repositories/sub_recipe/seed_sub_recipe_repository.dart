// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/sub_recipe/seed_sub_recipe_repository.dart
// O QUÊ:     Implementação EM MEMÓRIA do SubRecipesRepository (preview no PC):
//            serve o seed e guarda edições da sessão em overrides.
// USA:       sub_recipe_repository (contrato), sub_recipe.dart,
//            sub_recipe_seed, core/utils/app_log.
// USADO POR: sub_recipe_providers (default offline) e seed_recipe_repository
//            (sessionSubRecipeById: resolução de vínculo a cada leitura).
// SPEC:      specs/features/sub_recipes.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/utils/app_log.dart';
import '../../models/recipe/sub_recipe.dart';
import '../../seed/sub_recipe_seed.dart';
import 'sub_recipe_repository.dart';

/// Edições da sessão (persistência MOCK): id -> subreceita alterada.
/// Usada por: SeedSubRecipesRepository e sessionSubRecipeById.
final Map<String, SubRecipe> _subRecipeOverrides = {};

/// Subreceitas NOVAS criadas na sessão (ex.: componente promovido).
/// Usada por: SeedSubRecipesRepository e sessionSubRecipeById.
final List<SubRecipe> _createdSubRecipes = [];

/// Estado ATUAL de uma subreceita na sessão (override > criada > seed) — é o
/// que faz a edição PROPAGAR no preview: o seed de receitas resolve os
/// vínculos por aqui a cada leitura. Usada por: SeedRecipesRepository.
SubRecipe? sessionSubRecipeById(String id) {
  final override = _subRecipeOverrides[id];
  if (override != null) return override;
  for (final s in _createdSubRecipes) {
    if (s.id == id) return s;
  }
  for (final s in kSeedSubRecipes) {
    if (s.id == id) return s;
  }
  return null;
}

/// Repositório de preview: seed + edições em memória. A semântica é idêntica à
/// versão Supabase (id estável). Usada por: sub_recipe_providers (default).
class SeedSubRecipesRepository implements SubRecipesRepository {
  const SeedSubRecipesRepository();

  /// Biblioteca inteira (criadas + seed, com override), por nome.
  /// Usada por: subRecipesProvider.
  @override
  Future<List<SubRecipe>> fetchSubRecipes() async {
    final list = [
      for (final s in _createdSubRecipes) _subRecipeOverrides[s.id] ?? s,
      for (final s in kSeedSubRecipes) _subRecipeOverrides[s.id] ?? s,
    ];
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return list;
  }

  /// Uma subreceita pelo id (estado da sessão). Usada por: subRecipeByIdProvider.
  @override
  Future<SubRecipe?> fetchById(String id) async {
    final sub = sessionSubRecipeById(id);
    if (sub == null) AppLog.w('recipes', 'subreceita não encontrada: $id');
    return sub;
  }

  /// Cria uma subreceita nova em memória. Gera id se vier vazio. Devolve o id.
  /// Usada por: SubRecipeEditController.promote.
  @override
  Future<String> createSubRecipe(SubRecipe subRecipe) async {
    final id = subRecipe.id.isEmpty
        ? 'sub-${DateTime.now().millisecondsSinceEpoch}'
        : subRecipe.id;
    _createdSubRecipes.insert(0, subRecipe.copyWith(id: id));
    AppLog.i('recipes', 'subreceita criada (seed): $id');
    return id;
  }

  /// Grava a edição como override da sessão — todos os pratos que vinculam
  /// refletem na próxima leitura. Usada por: SubRecipeEditController.save.
  @override
  Future<void> updateSubRecipe(SubRecipe subRecipe) async {
    _subRecipeOverrides[subRecipe.id] = subRecipe;
    AppLog.i('recipes', 'subreceita editada (seed): ${subRecipe.id}');
  }
}
