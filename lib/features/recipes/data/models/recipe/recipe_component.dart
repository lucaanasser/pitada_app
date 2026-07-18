// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/recipe_component.dart
// O QUÊ:     Componente de receita = SUB-RECEITA (massa, cobertura, molho):
//            macros somam no prato (rules/data-model.md), nunca é pasta.
//            LOCAL (embutido) ou VINCULADO a uma SubRecipe compartilhada.
// USA:       freezed + json_serializable, ingredient.dart, recipe_step.dart,
//            sub_recipe.dart.
// USADO POR: recipe.dart (Recipe.components), recipe_row_mapper, seeds,
//            repositórios (resolução de vínculo).
// SPEC:      specs/features/recipes.yaml (data.componentes) +
//            specs/features/sub_recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';
import 'recipe_step.dart';
import 'sub_recipe.dart';

part 'recipe_component.freezed.dart';
part 'recipe_component.g.dart';

/// Uma parte nomeada da receita (massa/cobertura) com seus ingredientes e
/// passos. [name] null = componente implícito: a receita não tem partes e a
/// tela não mostra subcabeçalho. [subRecipeId] != null = VINCULADO: o conteúdo
/// vem da SubRecipe (resolvido na leitura, escalado por [scale]).
/// Usada por: Recipe.components.
@freezed
abstract class RecipeComponent with _$RecipeComponent {
  const RecipeComponent._();

  const factory RecipeComponent({
    String? name,
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<RecipeStep> steps,
    String? subRecipeId,
    @Default(1) num scale,
  }) = _RecipeComponent;

  /// Monta a partir do JSON aninhado do mapper. Usada por: Recipe.fromJson.
  factory RecipeComponent.fromJson(Map<String, dynamic> json) =>
      _$RecipeComponentFromJson(json);

  /// True quando o componente aponta para uma subreceita compartilhada.
  /// Usada por: mapper (escrita), seções do detalhe, editores.
  bool get isLinked => subRecipeId != null;

  /// Resolve o vínculo: preenche nome/passos da [sub] e os ingredientes JÁ
  /// escalados pelo [scale]. Caminho ÚNICO de resolução (seed e Supabase).
  /// Usada por: SeedRecipesRepository, recipe_row_mapper.
  RecipeComponent resolvedWith(SubRecipe sub) => copyWith(
        name: sub.name,
        ingredients: [for (final i in sub.ingredients) i.scaled(scale)],
        steps: sub.steps,
      );

  /// Deriva a cópia LOCAL do componente (desvincular): mantém o conteúdo
  /// resolvido na escala atual e solta o vínculo. Usada por:
  /// SubRecipeEditController.unlink.
  RecipeComponent unlinked() => copyWith(subRecipeId: null, scale: 1);
}
