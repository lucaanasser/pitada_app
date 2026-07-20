// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/sub_recipe_seed.dart
// O QUÊ:     Dados de exemplo da biblioteca de SUBRECEITAS COMPARTILHADAS:
//            a cobertura de chocolate. Os bolos que a vinculam: recipe/cake_seed.
// USA:       sub_recipe.dart, ingredient.dart, recipe_step.dart, flavor_axis.dart.
// USADO POR: seed_sub_recipe_repository (preview).
// SPEC:      specs/features/sub_recipes.yaml (seed)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/recipe/flavor_axis.dart';
import '../models/recipe/ingredient.dart';
import '../models/recipe/recipe_step.dart';
import '../models/recipe/sub_recipe.dart';

/// Subreceitas de exemplo da biblioteca. Usada por: seed_sub_recipe_repository.
const kSeedSubRecipes = <SubRecipe>[
  SubRecipe(
    id: 'cobertura-chocolate',
    name: 'Cobertura de chocolate',
    ingredients: [
      Ingredient(
        name: 'Manteiga',
        grams: 15,
        humanQty: 1,
        humanUnit: 'c. sopa',
        flavors: [FlavorAxis.fat],
      ),
      Ingredient(
        name: 'Chocolate em pó',
        grams: 30,
        humanQty: 3,
        humanUnit: 'c. sopa',
        flavors: [FlavorAxis.bitter, FlavorAxis.sweet],
      ),
      Ingredient(
        name: 'Açúcar',
        grams: 90,
        humanQty: 0.5,
        humanUnit: 'xícara',
        flavors: [FlavorAxis.sweet],
      ),
      Ingredient(name: 'Leite', grams: 60, humanQty: 60, humanUnit: 'ml'),
    ],
    steps: [
      RecipeStep(
        text: 'Derreta a manteiga com o chocolate em pó em fogo baixo.',
      ),
      RecipeStep(
        text: 'Junte o leite e o açúcar e mexa até encorpar; cubra o bolo.',
        tip: 'Calda ganha brilho no bolo ainda morno — não espere esfriar.',
      ),
    ],
  ),
];
