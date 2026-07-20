// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/supabase_folder_repository.dart
// O QUÊ:     Parte de PASTAS do repositório online: leitura e CRUD de folders +
//            vínculos recipe_folders (mixin do SupabaseRecipesRepository).
// USA:       recipe_repository (contrato), core/supabase (cliente),
//            core/utils/app_log, models/folder.
// USADO POR: supabase_recipe_repository (with SupabaseFolderRepository).
// SPEC:      specs/features/recipes.yaml (data.repository_pastas)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/supabase/supabase.dart';
import '../../../../../core/utils/app_log.dart';
import '../../models/folder.dart';
import 'recipe_repository.dart';

/// CRUD online de pastas (folders + recipe_folders). A RLS garante que só as
/// linhas do usuário chegam aqui. Usada por: SupabaseRecipesRepository.
mixin SupabaseFolderRepository implements RecipesRepository {
  SupabaseClient get _folderDb => SupabaseService.client;

  /// Pastas do usuário na ordem manual (position). Usada por: foldersProvider.
  @override
  Future<List<Folder>> fetchFolders() async {
    final rows = await _folderDb
        .from('folders')
        .select()
        .order('position', ascending: true);
    return rows.map(Folder.fromJson).toList();
  }

  /// Insere a pasta (o Postgres gera o uuid) e devolve o id.
  /// Usada por: FolderEditController.create.
  @override
  Future<String> createFolder(Folder folder) async {
    final inserted = await _folderDb
        .from('folders')
        .insert({'name': folder.name, 'hero_color': folder.heroColor})
        .select('id')
        .single();
    final id = inserted['id'] as String;
    AppLog.i('recipes', 'pasta criada (supabase): $id');
    return id;
  }

  /// Renomeia / troca a cor no lugar (mesmo id).
  /// Usada por: FolderEditController.save.
  @override
  Future<void> updateFolder(Folder folder) async {
    await _folderDb
        .from('folders')
        .update({'name': folder.name, 'hero_color': folder.heroColor})
        .eq('id', folder.id);
    AppLog.i('recipes', 'pasta salva (supabase): ${folder.id}');
  }

  /// Apaga a pasta; recipe_folders cai por cascade.
  /// Usada por: FolderEditController.
  @override
  Future<void> deleteFolder(String id) async {
    await _folderDb.from('folders').delete().eq('id', id);
    AppLog.i('recipes', 'pasta apagada (supabase): $id');
  }

  /// Substitui os vínculos da pasta: delete por folder_id + insert dos
  /// selecionados. Usada por: FolderEditController.setRecipes.
  @override
  Future<void> setFolderRecipes(String folderId, List<String> recipeIds) async {
    await _folderDb.from('recipe_folders').delete().eq('folder_id', folderId);
    if (recipeIds.isNotEmpty) {
      await _folderDb.from('recipe_folders').insert([
        for (final id in recipeIds) {'recipe_id': id, 'folder_id': folderId},
      ]);
    }
    AppLog.i('recipes', 'receitas da pasta $folderId: ${recipeIds.length}');
  }
}
