// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipe.dart
// O QUÊ:     Modelo principal de receita (agrega ingredientes, passos, metadados).
// USA:       ingredient.dart, recipe_step.dart (composição).
// USADO POR: recipes_seed, recipes_repository, providers e telas de Receitas.
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────
import 'ingredient.dart';
import 'recipe_step.dart';

/// Origem da receita — de onde ela foi importada (define ícone/label da fonte).
enum RecipeSource { youtube, instagram, site, pdf, photo, manual }

/// Uma receita completa. Nutrição é por porção; grama é a base dos macros.
/// Usada por: aba Receitas (lista/detalhe/editar/cozinhar) e Planos (link).
class Recipe {
  final String id;
  final String title;
  final RecipeSource source;
  final String? sourceUrl; // preenchido quando salva por link
  final int servings;
  final int? timeMinutes;
  final int kcal; // por porção
  final num protein;
  final num carb;
  final num fat;
  final String? difficulty;
  final String heroColor; // nome em AppColors.hero
  final int photoCount; // fotos na galeria (0 = placeholder)
  final String? notes; // "Anotações & ajustes"
  final List<String> folderIds; // pastas a que pertence
  final List<String> techniques; // "Técnicas desta receita" (títulos de lição)
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  const Recipe({
    required this.id,
    required this.title,
    this.source = RecipeSource.manual,
    this.sourceUrl,
    this.servings = 2,
    this.timeMinutes,
    required this.kcal,
    this.protein = 0,
    this.carb = 0,
    this.fat = 0,
    this.difficulty,
    this.heroColor = 'clay',
    this.photoCount = 0,
    this.notes,
    this.folderIds = const [],
    this.techniques = const [],
    this.ingredients = const [],
    this.steps = const [],
  });
}
