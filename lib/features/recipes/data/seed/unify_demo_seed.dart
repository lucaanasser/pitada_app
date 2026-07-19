// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/unify_demo_seed.dart
// O QUÊ:     Dados de exemplo do fluxo UNIFICAR: 2 bolos com coberturas LOCAIS
//            quase iguais (o caso "bolos importados com coberturas parecidas").
// USA:       recipe.dart, recipe_component.dart, ingredient.dart,
//            recipe_step.dart, flavor_axis.dart.
// USADO POR: seed_recipe_repository (preview).
// SPEC:      specs/features/sub_recipes.yaml (unificacao.seed_demo)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/recipe/flavor_axis.dart';
import '../models/recipe/ingredient.dart';
import '../models/recipe/recipe.dart';
import '../models/recipe/recipe_component.dart';
import '../models/recipe/recipe_step.dart';

/// Bolos com coberturas locais parecidas, matéria-prima do unificar.
/// Usada por: seed_recipe_repository.
const kSeedUnifyDemoRecipes = <Recipe>[
  Recipe(
    id: 'bolo-formigueiro',
    title: 'Bolo formigueiro',
    source: RecipeSource.instagram,
    sourceUrl: 'https://instagram.com/reel/bolo-formigueiro',
    servings: 12,
    timeMinutes: 55,
    kcal: 395,
    protein: 6,
    carb: 50,
    fat: 18,
    heroColor: 'plum',
    folderIds: ['doces'],
    components: [
      RecipeComponent(
        name: 'Massa',
        ingredients: [
          Ingredient(name: 'Ovos', grams: 150, humanQty: 3, humanUnit: 'unidade', flavors: [FlavorAxis.fat]),
          Ingredient(name: 'Açúcar', grams: 270, humanQty: 1.5, humanUnit: 'xícara', flavors: [FlavorAxis.sweet]),
          Ingredient(name: 'Farinha de trigo', grams: 300, humanQty: 2.5, humanUnit: 'xícara'),
          Ingredient(name: 'Granulado', grams: 80, humanQty: 0.5, humanUnit: 'xícara', flavors: [FlavorAxis.sweet]),
        ],
        steps: [
          RecipeStep(text: 'Bata ovos, açúcar e a manteiga; junte os secos.'),
          RecipeStep(
            text: 'Envolva o granulado por último e asse a 180 °C por 40 min.',
            tip: 'Granulado enfarinhado não afunda na massa.',
          ),
        ],
      ),
      RecipeComponent(
        name: 'Cobertura de chocolate',
        ingredients: [
          Ingredient(name: 'Manteiga', grams: 20, humanQty: 1.5, humanUnit: 'c. sopa', flavors: [FlavorAxis.fat]),
          Ingredient(name: 'Chocolate em pó', grams: 40, humanQty: 4, humanUnit: 'c. sopa', flavors: [FlavorAxis.bitter, FlavorAxis.sweet]),
          Ingredient(name: 'Açúcar', grams: 120, humanQty: 0.7, humanUnit: 'xícara', flavors: [FlavorAxis.sweet]),
          Ingredient(name: 'Granulado', grams: 50, humanQty: 0.3, humanUnit: 'xícara', flavors: [FlavorAxis.sweet]),
        ],
        steps: [
          RecipeStep(text: 'Derreta tudo em fogo baixo e cubra o bolo.'),
        ],
      ),
    ],
  ),
  Recipe(
    id: 'bolo-nega-maluca',
    title: 'Nega maluca',
    source: RecipeSource.site,
    sourceUrl: 'https://receitas.com/nega-maluca',
    servings: 10,
    timeMinutes: 45,
    kcal: 420,
    protein: 6,
    carb: 56,
    fat: 20,
    heroColor: 'clay',
    folderIds: ['doces'],
    components: [
      RecipeComponent(
        name: 'Massa',
        ingredients: [
          Ingredient(name: 'Ovos', grams: 150, humanQty: 3, humanUnit: 'unidade', flavors: [FlavorAxis.fat]),
          Ingredient(name: 'Chocolate em pó', grams: 90, humanQty: 1, humanUnit: 'xícara', flavors: [FlavorAxis.bitter]),
          Ingredient(name: 'Farinha de trigo', grams: 240, humanQty: 2, humanUnit: 'xícara'),
          Ingredient(name: 'Água quente', grams: 240, humanQty: 1, humanUnit: 'xícara'),
        ],
        steps: [
          RecipeStep(text: 'Misture tudo e bata até a massa ficar lisa.'),
          RecipeStep(text: 'Asse a 180 °C por 35 minutos.'),
        ],
      ),
      RecipeComponent(
        name: 'Cobertura de chocolate',
        ingredients: [
          Ingredient(name: 'Manteiga', grams: 15, humanQty: 1, humanUnit: 'c. sopa', flavors: [FlavorAxis.fat]),
          Ingredient(name: 'Chocolate em pó', grams: 30, humanQty: 3, humanUnit: 'c. sopa', flavors: [FlavorAxis.bitter, FlavorAxis.sweet]),
          Ingredient(name: 'Açúcar', grams: 90, humanQty: 0.5, humanUnit: 'xícara', flavors: [FlavorAxis.sweet]),
          Ingredient(name: 'Leite', grams: 60, humanQty: 60, humanUnit: 'ml'),
        ],
        steps: [
          RecipeStep(
            text: 'Leve tudo ao fogo mexendo até encorpar; despeje quente.',
            tip: 'Calda quente escorre e cobre por igual.',
          ),
        ],
      ),
    ],
  ),
];
