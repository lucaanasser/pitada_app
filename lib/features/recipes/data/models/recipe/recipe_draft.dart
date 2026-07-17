// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/recipe/recipe_draft.dart
// O QUÊ:     Rascunho mutável leve de receita, para telas de edição/importação.
//            Guarda DraftComponent mutáveis (massa/cobertura); receita simples
//            tem 1 componente sem nome.
// USA:       recipe.dart, recipe_component.dart, ingredient.dart, recipe_step.dart.
// USADO POR: import_controller (preview) e RecipeEditScreen (edição em memória).
// SPEC:      specs/features/recipes.yaml (RecipeEditScreen: rascunho local)
// ─────────────────────────────────────────────────────────────────────────────
import 'ingredient.dart';
import 'recipe.dart';
import 'recipe_component.dart';
import 'recipe_step.dart';

/// Componente mutável do rascunho (espelho editável de [RecipeComponent]).
/// Usada por: RecipeDraft, IngredientsEditor/StepsEditor (listas mutáveis).
class DraftComponent {
  String? name;
  List<Ingredient> ingredients;
  List<RecipeStep> steps;

  DraftComponent({
    this.name,
    List<Ingredient>? ingredients,
    List<RecipeStep>? steps,
  })  : ingredients = ingredients ?? <Ingredient>[],
        steps = steps ?? <RecipeStep>[];

  /// Cria a partir do componente imutável (para editar). Usada por: RecipeDraft.fromRecipe.
  factory DraftComponent.fromComponent(RecipeComponent c) => DraftComponent(
        name: c.name,
        ingredients: List<Ingredient>.of(c.ingredients),
        steps: List<RecipeStep>.of(c.steps),
      );

  /// Congela no componente imutável. Usada por: RecipeDraft.toRecipe.
  RecipeComponent toComponent() => RecipeComponent(
        name: name,
        ingredients: List<Ingredient>.of(ingredients),
        steps: List<RecipeStep>.of(steps),
      );
}

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
  String heroColor;
  String? notes;
  List<String> folderIds;
  List<DraftComponent> components;

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
    this.heroColor = 'clay',
    this.notes,
    List<String>? folderIds,
    List<DraftComponent>? components,
  })  : folderIds = folderIds ?? <String>[],
        components = (components == null || components.isEmpty)
            ? [DraftComponent()]
            : components;

  /// Ingredientes de todos os componentes, achatados (checagens do import).
  /// Usada por: import_controller.
  List<Ingredient> get allIngredients =>
      [for (final c in components) ...c.ingredients];

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
        heroColor: r.heroColor,
        notes: r.notes,
        folderIds: List<String>.of(r.folderIds),
        components: [
          for (final c in r.components) DraftComponent.fromComponent(c),
        ],
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
        heroColor: heroColor,
        notes: notes,
        folderIds: List<String>.of(folderIds),
        components: [for (final c in components) c.toComponent()],
      );
}
