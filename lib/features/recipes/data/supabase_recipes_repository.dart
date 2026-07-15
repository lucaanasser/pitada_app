// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/supabase_recipes_repository.dart
// O QUÊ:     Implementação ONLINE do RecipesRepository: Postgres via PostgREST
//            (leitura com embedding numa query; escrita = linha + filhas).
// USA:       recipes_repository (contrato), recipe_row_mapper (linha<->modelo),
//            core/supabase (cliente), core/utils/app_log.
// USADO POR: main.dart (override do recipesRepositoryProvider quando online).
// SPEC:      specs/features/recipes.yaml (data.repository_supabase) +
//            specs/backend/database.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase.dart';
import '../../../core/utils/app_log.dart';
import 'folder.dart';
import 'recipe.dart';
import 'recipe_row_mapper.dart';
import 'recipes_repository.dart';

/// Repositório online. A RLS garante que só as linhas do usuário chegam aqui —
/// nenhuma query precisa filtrar por user_id. Usada por: main.dart (override).
class SupabaseRecipesRepository implements RecipesRepository {
  const SupabaseRecipesRepository();

  SupabaseClient get _db => SupabaseService.client;

  /// Embedding padrão: receita + filhas numa query só (mapper monta o modelo).
  static const _select =
      '*, recipe_ingredients(*), recipe_steps(*), recipe_folders(folder_id)';

  /// Só as DEFINITIVAS (coluna gerada is_definitive), na ordem de criação.
  /// Usada por: recipesProvider.
  @override
  Future<List<Recipe>> fetchRecipes() async {
    final rows = await _db
        .from('recipes')
        .select(_select)
        .eq('is_definitive', true)
        .order('created_at', ascending: true);
    AppLog.d('recipes', 'carregadas ${rows.length} receitas (supabase)');
    return rows.map(recipeFromRow).toList();
  }

  /// Pastas do usuário na ordem manual (position). Usada por: foldersProvider.
  @override
  Future<List<Folder>> fetchFolders() async {
    final rows =
        await _db.from('folders').select().order('position', ascending: true);
    return rows.map(Folder.fromJson).toList();
  }

  /// Qualquer versão pelo id (uuid). Id malformado (ex.: slug do seed) vira
  /// null + warn, como no seed. Usada por: recipeByIdProvider.
  @override
  Future<Recipe?> fetchById(String id) async {
    try {
      final row =
          await _db.from('recipes').select(_select).eq('id', id).maybeSingle();
      if (row == null) AppLog.w('recipes', 'receita não encontrada: $id');
      return row == null ? null : recipeFromRow(row);
    } on PostgrestException catch (e) {
      AppLog.w('recipes', 'fetchById($id) falhou: ${e.code}');
      return null;
    }
  }

  /// Todas as versões do grupo, v1..vN. Usada por: recipeVersionGroupProvider.
  @override
  Future<List<Recipe>> fetchVersionGroup(String groupId) async {
    final rows = await _db
        .from('recipes')
        .select(_select)
        .eq('version_group_id', groupId)
        .order('version', ascending: true);
    return rows.map(recipeFromRow).toList();
  }

  /// Upsert da linha + troca das filhas. (Sem transação multi-tabela no
  /// PostgREST: numa falha rara no meio, reeditar/salvar conserta — ver spec.)
  /// Usada por: RecipeEditController.save (edição inline).
  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await _db.from('recipes').upsert(recipeToRow(recipe));
    await _writeChildren(recipe, recipe.id);
    AppLog.i('recipes', 'receita salva (supabase): ${recipe.id}');
  }

  /// "Trocar tudo" online: arquiva a definitiva atual como LINHA NOVA (uuid do
  /// banco, fora de pastas/favoritas) e promove [edited] no id canônico com
  /// version = max+1, herdando pasta/favorito. Mesma semântica do seed.
  /// Usada por: RecipeEditController.save (asNewVersion).
  @override
  Future<void> saveAsNewVersion(Recipe edited) async {
    final groupId = edited.versionGroupId ?? edited.id;
    final prev = await fetchById(groupId); // definitiva atual
    final group = await fetchVersionGroup(groupId);
    final maxV = group.isEmpty ? (prev?.version ?? 1) : group.last.version;

    if (prev != null) {
      final archived = prev.withVersionIdentity(
        id: prev.id, // descartado no insert (withId: false) — banco gera outro
        version: prev.version,
        versionGroupId: groupId,
        favorite: false,
        folderIds: const [],
      );
      final inserted = await _db
          .from('recipes')
          .insert(recipeToRow(archived, withId: false))
          .select('id')
          .single();
      await _writeChildren(archived, inserted['id'] as String);
    }
    await updateRecipe(
      edited.withVersionIdentity(
        id: groupId,
        version: maxV + 1,
        versionGroupId: groupId,
        favorite: prev?.favorite ?? edited.favorite,
        folderIds: prev?.folderIds ?? edited.folderIds,
      ),
    );
    AppLog.i('recipes', 'nova versão (supabase): $groupId v${maxV + 1}');
  }

  /// Regrava as filhas de [recipeId] (delete + insert; position = ordem atual).
  /// Usada por: updateRecipe e saveAsNewVersion.
  Future<void> _writeChildren(Recipe recipe, String recipeId) async {
    await _db.from('recipe_ingredients').delete().eq('recipe_id', recipeId);
    await _db.from('recipe_steps').delete().eq('recipe_id', recipeId);
    await _db.from('recipe_folders').delete().eq('recipe_id', recipeId);
    final ings = ingredientRows(recipe, recipeId);
    final steps = stepRows(recipe, recipeId);
    final folders = folderRows(recipe, recipeId);
    if (ings.isNotEmpty) await _db.from('recipe_ingredients').insert(ings);
    if (steps.isNotEmpty) await _db.from('recipe_steps').insert(steps);
    if (folders.isNotEmpty) await _db.from('recipe_folders').insert(folders);
  }
}
