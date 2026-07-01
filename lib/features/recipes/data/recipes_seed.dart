// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/recipes_seed.dart
// O QUÊ:     Dados de exemplo (as receitas/pastas do protótipo) para preview no PC.
// USA:       recipe.dart, ingredient.dart, recipe_step.dart, folder.dart.
// USADO POR: recipes_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/recipes.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'folder.dart';
import 'ingredient.dart';
import 'recipe.dart';
import 'recipe_step.dart';

/// Pastas de exemplo (capítulos). Usada por: recipes_repository.
const kSeedFolders = <Folder>[
  Folder(id: 'marinadas', name: 'Marinadas de frango'),
  Folder(id: 'rapidos', name: 'Jantares rápidos'),
  Folder(id: 'fit', name: 'Fit'),
  Folder(id: 'doces', name: 'Doces'),
];

/// Receitas de exemplo. Usada por: recipes_repository (preview sem backend).
const kSeedRecipes = <Recipe>[
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
    difficulty: 'Intermediário',
    heroColor: 'terra',
    folderIds: ['rapidos'],
    techniques: ['Selar a carne', 'Emulsionar um molho'],
    ingredients: [
      Ingredient(
          name: 'Peito de frango', grams: 500, humanQty: 500, humanUnit: 'g'),
      Ingredient(name: 'Ovo', grams: 80, humanQty: 2, humanUnit: 'unidade'),
      Ingredient(
          name: 'Pimentão', grams: 120, humanQty: 1, humanUnit: 'unidade'),
      Ingredient(name: 'Shoyu', grams: 45, humanQty: 3, humanUnit: 'c. sopa'),
      Ingredient(
          name: 'Amendoim', grams: 70, humanQty: 0.5, humanUnit: 'xícara'),
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
      ),
      RecipeStep(
          text:
              'Refogue alho e pimentão rapidamente para manterem a crocância.'),
      RecipeStep(
        text: 'Volte o frango, junte o shoyu e o amendoim e finalize.',
        tip: 'O shoyu reduz e vira molho — desligue quando encorpar.',
      ),
    ],
  ),
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
    difficulty: 'Fácil',
    heroColor: 'moss',
    folderIds: ['fit'],
    ingredients: [
      Ingredient(name: 'Quinoa', grams: 90, humanQty: 0.5, humanUnit: 'xícara'),
      Ingredient(
          name: 'Grão-de-bico', grams: 120, humanQty: 120, humanUnit: 'g'),
      Ingredient(
          name: 'Abacate', grams: 80, humanQty: 0.5, humanUnit: 'unidade'),
    ],
    steps: [
      RecipeStep(text: 'Cozinhe a quinoa e monte o bowl com os demais itens.')
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
    difficulty: 'Intermediário',
    heroColor: 'rust',
    folderIds: ['rapidos'],
    ingredients: [
      Ingredient(name: 'Alcatra', grams: 500, humanQty: 500, humanUnit: 'g'),
      Ingredient(
          name: 'Creme de leite', grams: 200, humanQty: 1, humanUnit: 'lata'),
      Ingredient(name: 'Champignon', grams: 100, humanQty: 100, humanUnit: 'g'),
    ],
    steps: [
      RecipeStep(
          text: 'Sele a carne, faça o molho e incorpore o creme de leite.')
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
    difficulty: 'Fácil',
    heroColor: 'ochre',
    folderIds: ['doces', 'fit'],
    ingredients: [
      Ingredient(name: 'Banana', grams: 120, humanQty: 1, humanUnit: 'unidade'),
      Ingredient(name: 'Ovo', grams: 100, humanQty: 2, humanUnit: 'unidade'),
      Ingredient(name: 'Aveia', grams: 30, humanQty: 3, humanUnit: 'c. sopa'),
    ],
    steps: [
      RecipeStep(text: 'Amasse a banana, misture tudo e doure dos dois lados.')
    ],
  ),
];
