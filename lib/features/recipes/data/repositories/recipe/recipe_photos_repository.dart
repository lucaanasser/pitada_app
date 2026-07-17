// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/recipe/recipe_photos_repository.dart
// O QUÊ:     Fotos de receita no Storage (bucket privado recipe-photos):
//            upload + URL assinada. A galeria liga aqui na próxima fatia.
// USA:       supabase_flutter (FileOptions), core/supabase (cliente), core/utils/app_log.
// USADO POR: (próxima fatia) EditPhotoStrip/galeria do detalhe, via provider.
// SPEC:      specs/backend/storage.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/supabase/supabase.dart';
import '../../../../../core/utils/app_log.dart';

/// Acesso às fotos no Storage. Paths seguem {user_id}/{recipe_id}/{index}.jpg —
/// o 1º segmento é a base do RLS (dono só acessa a própria subpasta).
/// Usada por: (futuro) provider de galeria; criado junto com a fundação.
class RecipePhotosRepository {
  const RecipePhotosRepository();

  static const _bucket = 'recipe-photos';

  /// Sobe/substitui a foto [index] da receita e devolve o path salvo.
  /// Usada por: fluxo de adicionar foto (próxima fatia).
  Future<String> uploadPhoto(
    String recipeId,
    int index,
    Uint8List bytes,
  ) async {
    final userId = SupabaseService.client.auth.currentUser!.id;
    final path = '$userId/$recipeId/$index.jpg';
    await SupabaseService.client.storage.from(_bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
    AppLog.i('recipes', 'foto enviada: $path');
    return path;
  }

  /// URL temporária (1h) para exibir uma foto do bucket privado.
  /// Usada por: galeria do detalhe (próxima fatia).
  Future<String> signedUrl(String path) {
    return SupabaseService.client.storage
        .from(_bucket)
        .createSignedUrl(path, 3600);
  }
}
