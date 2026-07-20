// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/recipe/cake_seed.dart
// O QUÊ:     Bolos de exemplo que VINCULAM a subreceita "cobertura de
//            chocolate" (escalas 1× e 1,5×) — o caso canônico de propagação.
// USA:       recipe.dart, recipe_component.dart, ingredient.dart,
//            recipe_step.dart, flavor_axis.dart.
// USADO POR: seed_recipe_repository (preview da subreceita compartilhada).
// SPEC:      specs/features/sub_recipes.yaml (seed)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/recipe/flavor_axis.dart';
import '../../models/recipe/ingredient.dart';
import '../../models/recipe/recipe.dart';
import '../../models/recipe/recipe_component.dart';
import '../../models/recipe/recipe_step.dart';

/// Bolos que vinculam a cobertura (1× e 1,5×): editar a cobertura reflete
/// nos dois. Usada por: seed_recipe_repository.
const kSeedCakeRecipes = <Recipe>[
  Recipe(
    id: 'bolo-cenoura',
    title: 'Bolo de cenoura',
    source: RecipeSource.manual,
    servings: 12,
    timeMinutes: 50,
    kcal: 385,
    protein: 5,
    carb: 52,
    fat: 17,
    heroColor: 'ochre',
    folderIds: ['doces'],
    components: [
      RecipeComponent(
        name: 'Massa',
        ingredients: [
          Ingredient(
            name: 'Óleo',
            grams: 100,
            humanQty: 0.5,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(
            name: 'Cenouras médias',
            grams: 250,
            humanQty: 3,
            humanUnit: 'unidade',
            flavors: [FlavorAxis.sweet],
          ),
          Ingredient(
            name: 'Ovos',
            grams: 200,
            humanQty: 4,
            humanUnit: 'unidade',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(
            name: 'Açúcar',
            grams: 360,
            humanQty: 2,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.sweet],
          ),
          Ingredient(
            name: 'Farinha de trigo',
            grams: 300,
            humanQty: 2.5,
            humanUnit: 'xícara',
          ),
          Ingredient(
            name: 'Fermento em pó',
            grams: 15,
            humanQty: 1,
            humanUnit: 'c. sopa',
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Bata no liquidificador as cenouras, os ovos e o óleo.',
          ),
          RecipeStep(
            text: 'Misture o açúcar e a farinha; o fermento vai por último.',
            tip: 'Fermento por último e sem bater: bater demais tira o ar.',
          ),
          RecipeStep(text: 'Asse em forma untada a 180 °C por 40 minutos.'),
        ],
      ),
      RecipeComponent(subRecipeId: 'cobertura-chocolate', scale: 1),
    ],
  ),
  Recipe(
    id: 'bolo-chocolate',
    title: 'Bolo de chocolate',
    source: RecipeSource.manual,
    servings: 10,
    timeMinutes: 45,
    kcal: 410,
    protein: 6,
    carb: 55,
    fat: 19,
    heroColor: 'rust',
    folderIds: ['doces'],
    components: [
      RecipeComponent(
        name: 'Massa',
        ingredients: [
          Ingredient(
            name: 'Farinha de trigo',
            grams: 240,
            humanQty: 2,
            humanUnit: 'xícara',
          ),
          Ingredient(
            name: 'Chocolate em pó',
            grams: 90,
            humanQty: 1,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.bitter],
          ),
          Ingredient(
            name: 'Açúcar',
            grams: 270,
            humanQty: 1.5,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.sweet],
          ),
          Ingredient(
            name: 'Ovos',
            grams: 150,
            humanQty: 3,
            humanUnit: 'unidade',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(name: 'Leite', grams: 240, humanQty: 1, humanUnit: 'xícara'),
          Ingredient(
            name: 'Óleo',
            grams: 100,
            humanQty: 0.5,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(
            name: 'Fermento em pó',
            grams: 15,
            humanQty: 1,
            humanUnit: 'c. sopa',
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Misture os secos: farinha, chocolate, açúcar e fermento.',
          ),
          RecipeStep(text: 'Junte ovos, leite e óleo e bata até ficar liso.'),
          RecipeStep(text: 'Asse a 180 °C por 35 minutos.'),
        ],
      ),
      RecipeComponent(subRecipeId: 'cobertura-chocolate', scale: 1.5),
    ],
  ),
];
