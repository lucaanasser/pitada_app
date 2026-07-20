// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/seed_folder_store.dart
// O QUÊ:     Estado mutável das pastas no preview (seed inicial + criar/editar/
//            apagar da sessão). Espelha a tabela folders do Postgres, sem banco.
// USA:       data/folder (Folder), recipe_seed (kSeedFolders), core/utils/app_log.
// USADO POR: seed_recipe_repository (delegação das operações de pasta).
// SPEC:      specs/features/recipes.yaml (data.repository_pastas)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/utils/app_log.dart';
import '../../models/folder.dart';
import '../../seed/recipe_seed.dart';

/// Lista viva de pastas da sessão (lazy a partir do seed). Usada por: getters abaixo.
List<Folder>? _folders;

/// Acesso mutável interno, semeado 1x com kSeedFolders. Usada por: funções deste arquivo.
List<Folder> get _store => _folders ??= [...kSeedFolders];

/// Pastas atuais do preview (cópia imutável). Usada por: SeedRecipesRepository.fetchFolders.
List<Folder> sessionFolders() => List.unmodifiable(_store);

/// Cria uma pasta no topo; gera id se vier vazio e devolve o id final.
/// Usada por: SeedRecipesRepository.createFolder.
String createSessionFolder(Folder folder) {
  final id = folder.id.isEmpty
      ? 'pasta-${DateTime.now().millisecondsSinceEpoch}'
      : folder.id;
  _store.insert(0, folder.copyWith(id: id));
  AppLog.i('recipes', 'pasta criada (seed): $id');
  return id;
}

/// Renomeia / troca a cor de uma pasta no lugar. Usada por: SeedRecipesRepository.updateFolder.
void updateSessionFolder(Folder folder) {
  final i = _store.indexWhere((f) => f.id == folder.id);
  if (i >= 0) {
    _store[i] = folder;
  } else {
    _store.insert(0, folder);
  }
  AppLog.i('recipes', 'pasta editada (seed): ${folder.id}');
}

/// Remove a pasta da lista. Usada por: SeedRecipesRepository.deleteFolder.
void deleteSessionFolder(String id) {
  _store.removeWhere((f) => f.id == id);
  AppLog.i('recipes', 'pasta apagada (seed): $id');
}
