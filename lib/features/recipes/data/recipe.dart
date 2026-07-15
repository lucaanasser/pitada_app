// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipe.dart
// O QUÊ:     Modelo principal de receita (agrega ingredientes, passos, metadados).
// USA:       freezed + json_serializable (codegen), ingredient.dart, recipe_step.dart.
// USADO POR: recipes_seed, repositórios (seed/Supabase), providers e telas de Receitas.
// SPEC:      specs/features/recipes.yaml (data.models, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'recipe_step.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

/// Origem da receita — de onde ela foi importada (define ícone/label da fonte).
/// Nomes casam 1:1 com o enum recipe_source do Postgres.
enum RecipeSource { youtube, instagram, site, pdf, photo, manual }

/// Uma receita completa. Nutrição é por porção; grama é a base dos macros.
/// Cada VERSÃO é um Recipe inteiro; snapshots do mesmo prato compartilham o
/// versionGroupId e a definitiva é dona do id canônico (id == versionGroupId).
/// Usada por: aba Receitas (lista/detalhe/editar/cozinhar) e Planos (link).
@freezed
abstract class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
    required String id,
    required String title,
    @Default(RecipeSource.manual) RecipeSource source,
    String? sourceUrl, // preenchido quando salva por link
    @Default(2) int servings,
    int? timeMinutes,
    required int kcal, // por porção
    @Default(0) num protein,
    @Default(0) num carb,
    @Default(0) num fat,
    String? difficulty,
    @Default(false) bool favorite, // marcada como favorita (aba Favoritas)
    @Default('clay') String heroColor, // nome em AppColors.hero
    @Default(0) int photoCount, // fotos na galeria (0 = placeholder)
    String? notes, // "Anotações & ajustes"
    @Default([]) List<String> folderIds, // pastas a que pertence
    @Default([]) List<String> techniques, // "Técnicas desta receita"
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<RecipeStep> steps,
    // —— Versões ("trocar tudo": cada versão é um Recipe COMPLETO) ——
    @Default(1) int version, // número da versão (1,2,3…) — vira o rótulo "V3"
    String? versionGroupId, // null = sem versões; senão, id do grupo
  }) = _Recipe;

  /// Monta a partir do JSON do banco (snake_case; aninhados já mapeados pelo
  /// repositório). Usada por: SupabaseRecipesRepository.
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  /// True quando a receita faz parte de um grupo de versões. Usada por: RecipeDetailScreen.
  bool get hasVersions => versionGroupId != null;

  /// Deriva um snapshot com a IDENTIDADE de versão trocada (id, número, grupo e,
  /// opcionalmente, folder/favorite) — o conteúdo permanece. Usada por:
  /// repositórios (saveAsNewVersion: arquivar definitiva / promover edição).
  Recipe withVersionIdentity({
    required String id,
    required int version,
    required String versionGroupId,
    bool? favorite,
    List<String>? folderIds,
  }) =>
      copyWith(
        id: id,
        version: version,
        versionGroupId: versionGroupId,
        favorite: favorite ?? this.favorite,
        folderIds: folderIds ?? this.folderIds,
      );
}
