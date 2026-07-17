// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/seed_recipe_repository.dart
// O QUÊ:     Implementação EM MEMÓRIA do RecipesRepository (preview no PC, sem
//            chaves): serve o seed e guarda edições da sessão em overrides.
// USA:       recipe_repository (contrato), recipe/folder, recipe_seed,
//            recipe_versions_seed, core/utils/app_log.
// USADO POR: recipes_providers (default do provider, quando offline).
// SPEC:      specs/features/recipes.yaml (data.edicao_inline, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/utils/app_log.dart';
import '../../models/folder.dart';
import '../../models/recipe/recipe.dart';
import 'recipe_repository.dart';
import '../../seed/recipe_seed.dart';
import '../../seed/recipe_versions_seed.dart';

/// Edições da sessão (persistência MOCK): id -> receita alterada. Aplicadas por cima
/// do seed em toda leitura. Usada por: SeedRecipesRepository (fetch* + updateRecipe).
final Map<String, Recipe> _recipeOverrides = {};

/// Receitas NOVAS criadas na sessão (ex.: importadas), fora do seed. Aparecem no
/// topo das listas. Usada por: SeedRecipesRepository (createRecipe + fetch*).
final List<Recipe> _createdRecipes = [];

/// Repositório de preview: dados de exemplo + edições em memória. A semântica é
/// idêntica à versão Supabase. Usada por: recipes_providers (default offline).
class SeedRecipesRepository implements RecipesRepository {
  const SeedRecipesRepository();

  /// Todos os snapshots: criadas na sessão + definitivas + versões antigas.
  /// Usada internamente por fetchById/fetchVersionGroup.
  List<Recipe> get _all =>
      [..._createdRecipes, ...kSeedRecipes, ...kSeedOldVersions];

  /// Aplica o override da sessão (se houver) por cima da receita do seed. Usada
  /// internamente por fetchRecipes/fetchById/fetchVersionGroup.
  Recipe _withOverride(Recipe r) => _recipeOverrides[r.id] ?? r;

  /// Criadas na sessão (topo) + definitivas do seed, com override aplicado.
  /// Usada por: recipesProvider.
  @override
  Future<List<Recipe>> fetchRecipes() async {
    AppLog.d('recipes', 'carregando receitas (seed)');
    return [
      for (final r in _createdRecipes) _withOverride(r),
      for (final r in kSeedRecipes) _withOverride(r),
    ];
  }

  /// Cria uma receita nova em memória (topo da lista). Gera id se vier vazio.
  /// Devolve o id final. Usada por: RecipeEditController.create (importação).
  @override
  Future<String> createRecipe(Recipe recipe) async {
    final id = recipe.id.isEmpty
        ? 'novo-${DateTime.now().millisecondsSinceEpoch}'
        : recipe.id;
    _createdRecipes.insert(0, recipe.copyWith(id: id));
    AppLog.i('recipes', 'receita criada (seed): $id');
    return id;
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
    final groupId = edited.versionGroupId ?? edited.id;
    final prev =
        await fetchById(groupId);
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
