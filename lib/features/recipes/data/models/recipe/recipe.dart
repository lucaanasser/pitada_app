// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/recipe.dart
// O QUÊ:     Modelo principal de receita (agrega componentes, ingredientes,
//            passos e metadados).
// USA:       freezed + json_serializable (codegen), ingredient.dart,
//            recipe_step.dart, recipe_component.dart.
// USADO POR: recipe_seed, repositórios (seed/Supabase), providers e telas de Receitas.
// SPEC:      specs/features/recipes.yaml (data.models, data.componentes, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'recipe_component.dart';
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
    String? sourceUrl,
    @Default(2) int servings,
    int? timeMinutes,
    required int kcal,
    @Default(0) num protein,
    @Default(0) num carb,
    @Default(0) num fat,
    @Default('clay') String heroColor,
    @Default(0) int photoCount,
    String? notes,
    @Default([]) List<String> folderIds,
    @Default([]) List<String> techniques,
    @Default([]) List<RecipeComponent> components,
    @Default(1) int version,
    String? versionGroupId,
  }) = _Recipe;

  /// Monta a partir do JSON do banco (snake_case; aninhados já mapeados pelo
  /// repositório). Usada por: SupabaseRecipesRepository.
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  /// True quando a receita faz parte de um grupo de versões. Usada por: RecipeDetailScreen.
  bool get hasVersions => versionGroupId != null;

  /// Ingredientes de todos os componentes, achatados na ordem (macros somam:
  /// componente é sub-receita). Usada por: cook mode, lista de compras, macros.
  List<Ingredient> get allIngredients =>
      [for (final c in components) ...c.ingredients];

  /// Passos de todos os componentes, achatados na ordem (fila reta do cook
  /// mode). Usada por: CookModeScreen, StepProgress.
  List<RecipeStep> get allSteps => [for (final c in components) ...c.steps];

  /// Deriva a receita com UM componente trocado (edição inline endereça por
  /// componente + índice). Usada por: RecipeItemEdit (ingrediente/passo).
  Recipe withComponent(int index, RecipeComponent component) {
    final list = List<RecipeComponent>.of(components);
    list[index] = component;
    return copyWith(components: list);
  }

  /// Deriva um snapshot com a IDENTIDADE de versão trocada (id, número, grupo e,
  /// opcionalmente, as pastas) — o conteúdo permanece. Usada por:
  /// repositórios (saveAsNewVersion: arquivar definitiva / promover edição).
  Recipe withVersionIdentity({
    required String id,
    required int version,
    required String versionGroupId,
    List<String>? folderIds,
  }) =>
      copyWith(
        id: id,
        version: version,
        versionGroupId: versionGroupId,
        folderIds: folderIds ?? this.folderIds,
      );
}
