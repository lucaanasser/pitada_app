// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/recipe_versions_seed.dart
// O QUÊ:     Snapshots ANTIGOS das receitas versionadas (Frango xadrez v1/v2,
//            Strogonoff v1). Cada um é um Recipe COMPLETO — "trocar tudo" no seletor.
// USA:       recipe.dart, ingredient.dart, recipe_step.dart.
// USADO POR: seed_recipe_repository (compõe com kSeedRecipes p/ fetchById/
//            fetchVersionGroup).
// SPEC:      specs/features/recipes.yaml (data.seed_versions, data.versoes)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../models/recipe_step.dart';

/// Versões antigas (não-definitivas). Compartilham versionGroupId com a definitiva,
/// mas ficam FORA de listas/pastas (folderIds vazio).
/// As notas "o que mudou" moram no Caderno (notebook: kSeedVersions) — fonte única.
/// Usada por: seed_recipe_repository (fetchById, fetchVersionGroup).
const kSeedOldVersions = <Recipe>[
  Recipe(
    id: 'frango-xadrez-v1',
    title: 'Frango xadrez',
    source: RecipeSource.instagram,
    sourceUrl: 'https://instagram.com/reel/frango-xadrez',
    servings: 4,
    timeMinutes: 20,
    kcal: 498,
    protein: 40,
    carb: 41,
    fat: 16,
    heroColor: 'terra',
    version: 1,
    versionGroupId: 'frango-xadrez',
    techniques: ['Emulsionar um molho'],
    ingredients: [
      Ingredient(
        name: 'Peito de frango',
        grams: 500,
        humanQty: 500,
        humanUnit: 'g',
      ),
      Ingredient(
        name: 'Pimentão',
        grams: 120,
        humanQty: 1,
        humanUnit: 'unidade',
      ),
      Ingredient(name: 'Shoyu', grams: 60, humanQty: 4, humanUnit: 'c. sopa'),
      Ingredient(
        name: 'Amendoim',
        grams: 40,
        humanQty: 0.3,
        humanUnit: 'xícara',
      ),
      Ingredient(name: 'Alho', grams: 15, humanQty: 3, humanUnit: 'dentes'),
    ],
    steps: [
      RecipeStep(text: 'Corte o frango em cubos e pique o pimentão e o alho.'),
      RecipeStep(
        text:
            'Junte tudo na panela de uma vez e cozinhe até o frango passar do ponto.',
        tip:
            'Cozinhar tudo junto solta água — o molho fica ralo e o frango, cinza.',
      ),
      RecipeStep(text: 'Acerte o sal com o shoyu e finalize com o amendoim.'),
    ],
  ),

  Recipe(
    id: 'frango-xadrez-v2',
    title: 'Frango xadrez',
    source: RecipeSource.instagram,
    sourceUrl: 'https://instagram.com/reel/frango-xadrez',
    servings: 4,
    timeMinutes: 25,
    kcal: 520,
    protein: 41,
    carb: 40,
    fat: 19,
    heroColor: 'terra',
    version: 2,
    versionGroupId: 'frango-xadrez',
    techniques: ['Selar a carne', 'Emulsionar um molho'],
    ingredients: [
      Ingredient(
        name: 'Peito de frango',
        grams: 500,
        humanQty: 500,
        humanUnit: 'g',
      ),
      Ingredient(
        name: 'Pimentão',
        grams: 120,
        humanQty: 1,
        humanUnit: 'unidade',
      ),
      Ingredient(name: 'Shoyu', grams: 60, humanQty: 4, humanUnit: 'c. sopa'),
      Ingredient(
        name: 'Amendoim',
        grams: 40,
        humanQty: 0.3,
        humanUnit: 'xícara',
      ),
      Ingredient(name: 'Alho', grams: 15, humanQty: 3, humanUnit: 'dentes'),
    ],
    steps: [
      RecipeStep(
        text: 'Corte o frango em cubos e seque bem com papel-toalha.',
        tip: 'Frango seco doura em vez de cozinhar na própria água.',
      ),
      RecipeStep(
        text: 'Sele os cubos em LEVAS, sem lotar a panela, até criar crosta.',
        tip: 'Panela cheia demais esfria e cozinha; sele em levas.',
      ),
      RecipeStep(text: 'Refogue o alho e o pimentão rapidamente.'),
      RecipeStep(
        text: 'Volte o frango, junte o shoyu e o amendoim e finalize.',
      ),
    ],
  ),

  Recipe(
    id: 'strogonoff-v1',
    title: 'Strogonoff de carne',
    source: RecipeSource.site,
    servings: 4,
    timeMinutes: 25,
    kcal: 700,
    protein: 37,
    carb: 42,
    fat: 36,
    heroColor: 'rust',
    version: 1,
    versionGroupId: 'strogonoff',
    ingredients: [
      Ingredient(name: 'Alcatra', grams: 500, humanQty: 500, humanUnit: 'g'),
      Ingredient(
        name: 'Creme de leite',
        grams: 200,
        humanQty: 1,
        humanUnit: 'lata',
      ),
      Ingredient(name: 'Champignon', grams: 80, humanQty: 80, humanUnit: 'g'),
    ],
    steps: [
      RecipeStep(text: 'Sele a carne e refogue com cebola e mostarda.'),
      RecipeStep(
        text: 'Desligue o fogo e incorpore o creme de leite de lata.',
        tip: 'Creme de leite ferve e talha — junte fora do fogo.',
      ),
    ],
  ),
];
