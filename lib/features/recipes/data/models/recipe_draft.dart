// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe_draft.dart
// O QUÊ:     Rascunho mutável leve de receita, para telas de edição/importação.
// USA:       recipe.dart, ingredient.dart, recipe_step.dart (converte de/para).
// USADO POR: import_controller (preview) e RecipeEditScreen (edição em memória).
// SPEC:      specs/features/recipes.yaml (RecipeEditScreen: rascunho local)
// ─────────────────────────────────────────────────────────────────────────────
import 'ingredient.dart';
import 'recipe.dart';
import 'recipe_step.dart';

/// Rascunho editável de receita. Diferente de [Recipe] (imutável), aqui os campos
/// mudam enquanto o usuário edita ou revisa uma importação, virando [Recipe] no fim.
/// Usada por: import_controller (preview) e a tela de edição.
class RecipeDraft {
  String id;
  String title;
  RecipeSource source;
  String? sourceUrl;
  int servings;
  int? timeMinutes;
  int kcal;
  num protein;
  num carb;
  num fat;
  String? difficulty;
  String heroColor;
  String? notes;
  List<String> folderIds;
  List<String> techniques;
  List<Ingredient> ingredients;
  List<RecipeStep> steps;

  RecipeDraft({
    this.id = '',
    this.title = '',
    this.source = RecipeSource.manual,
    this.sourceUrl,
    this.servings = 2,
    this.timeMinutes,
    this.kcal = 0,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
    this.difficulty,
    this.heroColor = 'clay',
    this.notes,
    List<String>? folderIds,
    List<String>? techniques,
    List<Ingredient>? ingredients,
    List<RecipeStep>? steps,
  })  : folderIds = folderIds ?? <String>[],
        techniques = techniques ?? <String>[],
        ingredients = ingredients ?? <Ingredient>[],
        steps = steps ?? <RecipeStep>[];

  /// Cria um rascunho a partir de uma receita existente (para editar).
  /// Usada por: RecipeEditScreen ao carregar uma receita.
  factory RecipeDraft.fromRecipe(Recipe r) => RecipeDraft(
        id: r.id,
        title: r.title,
        source: r.source,
        sourceUrl: r.sourceUrl,
        servings: r.servings,
        timeMinutes: r.timeMinutes,
        kcal: r.kcal,
        protein: r.protein,
        carb: r.carb,
        fat: r.fat,
        difficulty: r.difficulty,
        heroColor: r.heroColor,
        notes: r.notes,
        folderIds: List<String>.of(r.folderIds),
        techniques: List<String>.of(r.techniques),
        ingredients: List<Ingredient>.of(r.ingredients),
        steps: List<RecipeStep>.of(r.steps),
      );

  /// Congela o rascunho numa [Recipe] imutável, pronta para salvar.
  /// Usada por: import_controller e RecipeEditScreen ao concluir.
  Recipe toRecipe() => Recipe(
        id: id,
        title: title,
        source: source,
        sourceUrl: sourceUrl,
        servings: servings,
        timeMinutes: timeMinutes,
        kcal: kcal,
        protein: protein,
        carb: carb,
        fat: fat,
        difficulty: difficulty,
        heroColor: heroColor,
        notes: notes,
        folderIds: List<String>.of(folderIds),
        techniques: List<String>.of(techniques),
        ingredients: List<Ingredient>.of(ingredients),
        steps: List<RecipeStep>.of(steps),
      );
}
