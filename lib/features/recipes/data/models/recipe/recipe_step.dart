// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/recipe_step.dart
// O QUÊ:     Modelo de passo de preparo, com dica 'Por quê' opcional e as
//            técnicas que o passo executa (com a âncora do grifo).
// USA:       freezed + json_serializable (codegen; JSON snake_case via build.yaml).
// USADO POR: recipe.dart, StepTile, cook_mode, repositórios.
// SPEC:      specs/features/recipes.yaml (data.models, data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step.freezed.dart';
part 'recipe_step.g.dart';

/// Técnica executada por um passo. [anchor] é o trecho LITERAL do texto do
/// passo a grifar; se não casar mais (texto editado), o grifo some em silêncio.
/// Usada por: RecipeStep, StepTile (grifo clicável).
@freezed
abstract class StepTechnique with _$StepTechnique {
  const factory StepTechnique({
    required String techniqueId,
    String? anchor,
  }) = _StepTechnique;

  /// Monta a partir do JSON do banco (technique_id/anchor).
  /// Usada por: SupabaseRecipesRepository (linhas de recipe_step_techniques).
  factory StepTechnique.fromJson(Map<String, dynamic> json) =>
      _$StepTechniqueFromJson(json);
}

/// Um passo do modo de preparo. [tip] vira o callout WhyCallout, quando existe;
/// [techniques] são as técnicas que o passo executa (grifo no texto).
/// Usada por: Recipe, RecipeDetailScreen e CookModeScreen.
@freezed
abstract class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    required String text,
    String? tip,
    @Default([]) List<StepTechnique> techniques,
  }) = _RecipeStep;

  /// Monta a partir do JSON do banco (text/tip; técnicas aninhadas pelo mapper).
  /// Usada por: SupabaseRecipesRepository (linhas de recipe_steps).
  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}
