// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/supabase_folder_ops.dart
// O QUÊ:     Escrita ONLINE das pastas: linha em folders (criar/editar/apagar) e
//            os vínculos N:N em recipe_folders. Mantém o repositório enxuto.
// USA:       supabase_flutter (SupabaseClient), data/folder (Folder).
// USADO POR: supabase_recipe_repository (delegação das operações de pasta).
// SPEC:      specs/features/recipes.yaml (data.repository_pastas)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/folder.dart';

/// Insere a pasta (Postgres gera o uuid; user_id vem do default auth.uid()) e
/// devolve o id. Usada por: SupabaseRecipesRepository.createFolder.
Future<String> insertFolder(SupabaseClient db, Folder folder) async {
  final inserted = await db
      .from('folders')
      .insert(folder.toJson()..remove('id'))
      .select('id')
      .single();
  return inserted['id'] as String;
}

/// Renomeia / troca a cor da pasta no lugar. Usada por: SupabaseRecipesRepository.updateFolder.
Future<void> updateFolderRow(SupabaseClient db, Folder folder) async {
  await db
      .from('folders')
      .update({'name': folder.name, 'hero_color': folder.heroColor}).eq(
          'id', folder.id);
}

/// Apaga a pasta (recipe_folders cai por cascade). Usada por: SupabaseRecipesRepository.deleteFolder.
Future<void> deleteFolderRow(SupabaseClient db, String id) async {
  await db.from('folders').delete().eq('id', id);
}

/// Substitui os vínculos recipe_folders da pasta pela lista dada (delete + insert).
/// Usada por: SupabaseRecipesRepository.setFolderRecipes.
Future<void> replaceFolderRecipes(
  SupabaseClient db,
  String folderId,
  List<String> recipeIds,
) async {
  await db.from('recipe_folders').delete().eq('folder_id', folderId);
  if (recipeIds.isEmpty) return;
  await db.from('recipe_folders').insert([
    for (final id in recipeIds) {'recipe_id': id, 'folder_id': folderId},
  ]);
}
