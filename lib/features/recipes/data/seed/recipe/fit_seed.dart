// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/recipe/fit_seed.dart
// O QUÊ:     Receitas de exemplo leves (bowl de quinoa e panqueca de banana) —
//            o grupo fit/doce do seed do protótipo.
// USA:       recipe.dart, recipe_component.dart, ingredient.dart,
//            recipe_step.dart, flavor_axis.dart.
// USADO POR: recipe_seed (agrega em kSeedRecipes).
// SPEC:      specs/features/recipes.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/recipe/flavor_axis.dart';
import '../../models/recipe/ingredient.dart';
import '../../models/recipe/recipe.dart';
import '../../models/recipe/recipe_component.dart';
import '../../models/recipe/recipe_step.dart';

/// Receitas fit/doces leves do seed. Usada por: recipe_seed (kSeedRecipes).
const kSeedFitRecipes = <Recipe>[
  Recipe(
    id: 'bowl-quinoa',
    title: 'Bowl de quinoa',
    source: RecipeSource.manual,
    servings: 2,
    timeMinutes: 15,
    kcal: 438,
    protein: 22,
    carb: 54,
    fat: 14,
    heroColor: 'moss',
    folderIds: ['fit'],
    components: [
      RecipeComponent(
        ingredients: [
          Ingredient(
            name: 'Quinoa',
            grams: 90,
            humanQty: 0.5,
            humanUnit: 'xícara',
          ),
          Ingredient(
            name: 'Grão-de-bico',
            grams: 120,
            humanQty: 120,
            humanUnit: 'g',
          ),
          Ingredient(
            name: 'Abacate',
            grams: 80,
            humanQty: 0.5,
            humanUnit: 'unidade',
            flavors: [FlavorAxis.fat],
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Cozinhe a quinoa e monte o bowl com os demais itens.',
          ),
        ],
      ),
    ],
  ),
  Recipe(
    id: 'panqueca-banana',
    title: 'Panqueca de banana',
    source: RecipeSource.manual,
    servings: 1,
    timeMinutes: 10,
    kcal: 286,
    protein: 12,
    carb: 44,
    fat: 7,
    heroColor: 'ochre',
    folderIds: ['doces', 'fit'],
    components: [
      RecipeComponent(
        ingredients: [
          Ingredient(
            name: 'Banana',
            grams: 120,
            humanQty: 1,
            humanUnit: 'unidade',
            flavors: [FlavorAxis.sweet],
          ),
          Ingredient(
            name: 'Ovo',
            grams: 100,
            humanQty: 2,
            humanUnit: 'unidade',
          ),
          Ingredient(
            name: 'Aveia',
            grams: 30,
            humanQty: 3,
            humanUnit: 'c. sopa',
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Amasse a banana, misture tudo e doure dos dois lados.',
          ),
        ],
      ),
    ],
  ),
];
