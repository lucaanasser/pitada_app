// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipe_step.dart
// O QUÊ:     Modelo de passo de preparo, com dica 'Por quê' opcional.
// USA:       freezed + json_serializable (codegen; JSON snake_case via build.yaml).
// USADO POR: recipe.dart, StepTile, cook_mode, repositórios.
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step.freezed.dart';
part 'recipe_step.g.dart';

/// Um passo do modo de preparo. [tip] vira o callout WhyCallout, quando existe.
/// Usada por: Recipe, RecipeDetailScreen e CookModeScreen.
@freezed
abstract class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    required String text,
    String? tip,
  }) = _RecipeStep;

  /// Monta a partir do JSON do banco (text/tip).
  /// Usada por: SupabaseRecipesRepository (linhas de recipe_steps).
  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}
