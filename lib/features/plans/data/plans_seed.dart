// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/plans_seed.dart
// O QUÊ:     Plano de exemplo do protótipo ("Meu plano" 1900) para preview sem backend.
// USA:       plan.dart, meal.dart, meal_option.dart.
// USADO POR: plans_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/plans.yaml (seed: "Meu plano" 1900; Café/Almoço/Jantar/Lanche)
// ─────────────────────────────────────────────────────────────────────────────
import 'meal.dart';
import 'meal_option.dart';
import 'plan.dart';

/// Plano ativo de exemplo. Usada por: plans_repository (preview no PC).
/// Macros são estimativas do protótipo; kcal é a base do encaixe na meta.
const kSeedPlan = Plan(
  id: 'cutting',
  name: 'Meu plano', // rótulo interno; a tela não exibe título de plano
  dailyKcalGoal: 1900,
  meals: [
    // ── Café · meta 500 kcal ──────────────────────────────────────────────
    Meal(
      id: 'cafe',
      name: 'Café',
      kcalGoal: 500,
      options: [
        MealOption(
          id: 'cafe-opt1',
          fits: true,
          fitLabel: 'cabe',
          chosen: true,
          items: [
            MealOptionItem(
              name: 'Panqueca de banana',
              kcal: 286,
              protein: 12,
              carb: 40,
              fat: 8,
            ),
            MealOptionItem(
              name: 'Iogurte natural',
              kcal: 100,
              protein: 10,
              carb: 8,
              fat: 3,
            ),
            MealOptionItem(
              name: 'Café com leite',
              kcal: 60,
              protein: 3,
              carb: 6,
              fat: 3,
            ),
          ],
        ),
        MealOption(
          id: 'cafe-opt2',
          fits: true,
          fitLabel: 'cabe',
          items: [
            MealOptionItem(
              name: 'Overnight oats',
              kcal: 320,
              protein: 14,
              carb: 48,
              fat: 8,
            ),
            MealOptionItem(
              name: 'Fruta',
              kcal: 120,
              protein: 1,
              carb: 30,
              fat: 0,
            ),
            MealOptionItem(
              name: 'Iogurte',
              kcal: 60,
              protein: 6,
              carb: 5,
              fat: 2,
            ),
          ],
        ),
      ],
    ),
    // ── Almoço · meta 650 kcal ────────────────────────────────────────────
    Meal(
      id: 'almoco',
      name: 'Almoço',
      kcalGoal: 650,
      options: [
        MealOption(
          id: 'almoco-opt1',
          fits: true,
          fitLabel: 'cabe',
          chosen: true,
          items: [
            MealOptionItem(
              name: 'Frango xadrez',
              kcal: 512,
              recipeId: 'frango-xadrez',
              protein: 42,
              carb: 38,
              fat: 18,
            ),
            MealOptionItem(
              name: 'Salada verde',
              kcal: 80,
              protein: 3,
              carb: 8,
              fat: 4,
            ),
          ],
        ),
        MealOption(
          id: 'almoco-opt2',
          fits: true,
          fitLabel: 'cabe',
          items: [
            MealOptionItem(
              name: 'Bowl de quinoa',
              kcal: 438,
              recipeId: 'bowl-quinoa',
              protein: 20,
              carb: 60,
              fat: 12,
            ),
            MealOptionItem(
              name: 'Frango grelhado',
              kcal: 200,
              protein: 38,
              carb: 0,
              fat: 5,
            ),
          ],
        ),
      ],
    ),
    // ── Jantar · meta 550 kcal ────────────────────────────────────────────
    Meal(
      id: 'jantar',
      name: 'Jantar',
      kcalGoal: 550,
      options: [
        MealOption(
          id: 'jantar-opt1',
          fits: false,
          fitLabel: '+130',
          chosen: true,
          items: [
            MealOptionItem(
              name: 'Strogonoff de carne',
              kcal: 680,
              recipeId: 'strogonoff',
              protein: 45,
              carb: 30,
              fat: 40,
            ),
          ],
        ),
        MealOption(
          id: 'jantar-opt2',
          fits: true,
          fitLabel: 'cabe',
          items: [
            MealOptionItem(
              name: 'Sopa de legumes',
              kcal: 320,
              protein: 12,
              carb: 45,
              fat: 8,
            ),
            MealOptionItem(
              name: 'Pão',
              kcal: 120,
              protein: 4,
              carb: 22,
              fat: 2,
            ),
          ],
        ),
      ],
    ),
    // ── Lanche · meta 300 kcal · sem opções ───────────────────────────────
    Meal(
      id: 'lanche',
      name: 'Lanche',
      kcalGoal: 300,
      options: [],
    ),
  ],
);
