// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/folder.dart
// O QUÊ:     Modelo de pasta (capítulo) — agrupa receitas independentes.
// USA:       freezed + json_serializable (codegen; JSON snake_case via build.yaml).
// USADO POR: recipes_seed, recipes_providers (PitadaTabs), recipes_screen, repositórios.
// NOTA:      Pasta != sub-receita (esta agrupa; aquela soma macros num prato).
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

/// Uma pasta/capítulo de receitas (ex.: 'Marinadas de frango'). Uma receita pode
/// estar em várias. Usada por: aba Pastas (FolderCard) e FolderScreen.
@freezed
abstract class Folder with _$Folder {
  const factory Folder({
    required String id,
    required String name,
    @Default('clay')
    String heroColor,
  }) = _Folder;

  /// Monta a partir do JSON do banco (id/name/hero_color).
  /// Usada por: SupabaseRecipesRepository (fetchFolders).
  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
