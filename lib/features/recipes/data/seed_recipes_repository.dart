// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed_recipes_repository.dart
// O QUÊ:     Implementação EM MEMÓRIA do RecipesRepository (preview no PC, sem
//            chaves): serve o seed e guarda edições da sessão em overrides.
// USA:       recipes_repository (contrato), recipe/folder, recipes_seed(_versions),
//            core/utils/app_log.
// USADO POR: recipes_providers (default do provider, quando offline).
// SPEC:      specs/features/recipes.yaml (data.edicao_inline, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'folder.dart';
import 'recipe.dart';
import 'recipes_repository.dart';
import 'recipes_seed.dart';
import 'recipes_seed_versions.dart';

/// Edições da sessão (persistência MOCK): id -> receita alterada. Aplicadas por cima
/// do seed em toda leitura. Usada por: SeedRecipesRepository (fetch* + updateRecipe).
final Map<String, Recipe> _recipeOverrides = {};

/// Repositório de preview: dados de exemplo + edições em memória. A semântica é
/// idêntica à versão Supabase. Usada por: recipes_providers (default offline).
class SeedRecipesRepository implements RecipesRepository {
  const SeedRecipesRepository();

  /// Todos os snapshots: definitivas + versões antigas. Usada internamente.
  List<Recipe> get _all => const [...kSeedRecipes, ...kSeedOldVersions];

  /// Aplica o override da sessão (se houver) por cima da receita do seed. Usada
  /// internamente por fetchRecipes/fetchById/fetchVersionGroup.
  Recipe _withOverride(Recipe r) => _recipeOverrides[r.id] ?? r;

  /// Só as DEFINITIVAS do seed, com override aplicado. Usada por: recipesProvider.
  @override
  Future<List<Recipe>> fetchRecipes() async {
    AppLog.d('recipes', 'carregando receitas (seed)');
    return [for (final r in kSeedRecipes) _withOverride(r)];
  }

  /// Pastas fixas do seed. Usada por: foldersProvider.
  @override
  Future<List<Folder>> fetchFolders() async => kSeedFolders;

  /// Consulta o override PRIMEIRO (aceita ids novos, ex.: um snapshot arquivado)
  /// e cai no seed — INCLUI versões antigas. Usada por: recipeByIdProvider.
  @override
  Future<Recipe?> fetchById(String id) async {
    final override = _recipeOverrides[id];
    if (override != null) return override;
    for (final r in _all) {
      if (r.id == id) return r;
    }
    AppLog.w('recipes', 'receita não encontrada: $id');
    return null;
  }

  /// Une o seed (com override) aos snapshots SÓ-override (ids novos do grupo),
  /// deduplicando por id. Usada por: recipeVersionGroupProvider.
  @override
  Future<List<Recipe>> fetchVersionGroup(String groupId) async {
    final byId = <String, Recipe>{};
    for (final r in _all) {
      final eff = _withOverride(r);
      if (eff.versionGroupId == groupId) byId[eff.id] = eff;
    }
    for (final r in _recipeOverrides.values) {
      if (r.versionGroupId == groupId) byId[r.id] = r;
    }
    return byId.values.toList()..sort((a, b) => a.version.compareTo(b.version));
  }

  /// Grava a edição como override da sessão. Usada por: RecipeEditController.
  @override
  Future<void> updateRecipe(Recipe recipe) async {
    _recipeOverrides[recipe.id] = recipe;
    AppLog.i('recipes', 'receita editada (seed): ${recipe.id}');
  }

  /// Versão em memória do "trocar tudo": arquiva a definitiva sob id derivado
  /// '{canonical}-v{n}' (sem pasta) e promove [edited] no id canônico,
  /// com version = max+1, herdando as pastas. Usada por: RecipeEditController.
  @override
  Future<void> saveAsNewVersion(Recipe edited) async {
    // O id do grupo é o id canônico da definitiva; sem grupo, o próprio id o inicia.
    final groupId = edited.versionGroupId ?? edited.id;
    final prev =
        await fetchById(groupId); // definitiva atual (antes desta edição)
    final group = await fetchVersionGroup(groupId);
    final maxV = group.isEmpty ? (prev?.version ?? 1) : group.last.version;

    if (prev != null) {
      final archivedId = '$groupId-v${prev.version}';
      _recipeOverrides[archivedId] = prev.withVersionIdentity(
        id: archivedId,
        version: prev.version,
        versionGroupId: groupId,
        folderIds: const [],
      );
    }
    _recipeOverrides[groupId] = edited.withVersionIdentity(
      id: groupId,
      version: maxV + 1,
      versionGroupId: groupId,
      folderIds: prev?.folderIds ?? edited.folderIds,
    );
    AppLog.i('recipes', 'nova versão (seed): $groupId v${maxV + 1}');
  }
}
