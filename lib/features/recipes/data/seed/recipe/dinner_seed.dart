// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/recipe/dinner_seed.dart
// O QUÊ:     Receitas de exemplo dos jantares rápidos (frango xadrez e
//            strogonoff) — o grupo salgado do seed do protótipo.
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

/// Receitas de jantar rápido do seed. Usada por: recipe_seed (kSeedRecipes).
const kSeedDinnerRecipes = <Recipe>[
  Recipe(
    id: 'frango-xadrez',
    title: 'Frango xadrez',
    source: RecipeSource.instagram,
    sourceUrl: 'https://instagram.com/reel/frango-xadrez',
    servings: 4,
    timeMinutes: 25,
    kcal: 512,
    protein: 42,
    carb: 38,
    fat: 18,
    heroColor: 'terra',
    folderIds: ['rapidos'],
    version: 3,
    versionGroupId: 'frango-xadrez',
    components: [
      RecipeComponent(
        ingredients: [
          Ingredient(
            name: 'Peito de frango',
            grams: 500,
            humanQty: 500,
            humanUnit: 'g',
          ),
          Ingredient(name: 'Ovo', grams: 80, humanQty: 2, humanUnit: 'unidade'),
          Ingredient(
            name: 'Pimentão',
            grams: 120,
            humanQty: 1,
            humanUnit: 'unidade',
          ),
          Ingredient(
            name: 'Shoyu',
            grams: 45,
            humanQty: 3,
            humanUnit: 'c. sopa',
            flavors: [FlavorAxis.umami, FlavorAxis.salt],
          ),
          Ingredient(
            name: 'Amendoim',
            grams: 70,
            humanQty: 0.5,
            humanUnit: 'xícara',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(name: 'Alho', grams: 15, humanQty: 3, humanUnit: 'dentes'),
        ],
        steps: [
          RecipeStep(
            text: 'Corte o frango em cubos e seque bem com papel-toalha.',
            tip:
                'Frango seco doura em vez de cozinhar na própria água — mais sabor.',
          ),
          RecipeStep(
            text: 'Sele os cubos em fogo alto, sem mexer demais, até dourar.',
            tip: 'Panela cheia demais esfria e cozinha; sele em levas.',
            techniques: [
              StepTechnique(techniqueId: 'tq-selar', anchor: 'Sele os cubos'),
            ],
          ),
          RecipeStep(
            text:
                'Refogue alho e pimentão rapidamente para manterem a crocância.',
            techniques: [
              StepTechnique(techniqueId: 'tq-refogar', anchor: 'Refogue'),
            ],
          ),
          RecipeStep(
            text: 'Volte o frango, junte o shoyu e o amendoim e finalize.',
            tip: 'O shoyu reduz e vira molho — desligue quando encorpar.',
          ),
        ],
      ),
    ],
  ),
  Recipe(
    id: 'strogonoff',
    title: 'Strogonoff de carne',
    source: RecipeSource.site,
    servings: 4,
    timeMinutes: 30,
    kcal: 680,
    protein: 38,
    carb: 40,
    fat: 34,
    heroColor: 'rust',
    folderIds: ['rapidos'],
    version: 2,
    versionGroupId: 'strogonoff',
    components: [
      RecipeComponent(
        name: 'Base',
        ingredients: [
          Ingredient(
            name: 'Alcatra',
            grams: 500,
            humanQty: 500,
            humanUnit: 'g',
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Sele a carne em fogo alto, em levas.',
            techniques: [
              StepTechnique(techniqueId: 'tq-selar', anchor: 'Sele a carne'),
            ],
          ),
        ],
      ),
      RecipeComponent(
        name: 'Molho',
        ingredients: [
          Ingredient(
            name: 'Creme de leite',
            grams: 200,
            humanQty: 1,
            humanUnit: 'lata',
            flavors: [FlavorAxis.fat],
          ),
          Ingredient(
            name: 'Champignon',
            grams: 100,
            humanQty: 100,
            humanUnit: 'g',
            flavors: [FlavorAxis.umami],
          ),
        ],
        steps: [
          RecipeStep(
            text: 'Faça o molho e incorpore o creme de leite.',
            techniques: [
              StepTechnique(
                techniqueId: 'tq-emulsionar',
                anchor: 'incorpore o creme de leite',
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
