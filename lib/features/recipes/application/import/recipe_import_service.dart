// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/import/recipe_import_service.dart
// O QUÊ:     Service de importação de receita atrás de uma interface (real + mock,
//            como FoodEstimateService). O mock roda no preview (rascunho de exemplo);
//            o real (Gemini/Edge Function) fica em gemini_recipe_import_service.dart.
// USA:       recipe.dart (RecipeSource), recipe_draft, ingredient, recipe_step, riverpod.
// USADO POR: import_controller (via recipeImportServiceProvider).
// SPEC:      specs/backend/edge_functions.yaml (import-recipe) + features/recipes.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/ingredient.dart';
import '../../data/models/recipe.dart';
import '../../data/models/recipe_draft.dart';
import '../../data/models/recipe_step.dart';

/// Entrada da importação: a fonte + link (site/instagram/youtube) OU conteúdo
/// (base64 do PDF). manual não usa rede — abre um rascunho em branco.
/// Usada por: import_controller e as implementações do service.
class RecipeImportInput {
  final RecipeSource source;
  final String? url;
  final String? content;

  const RecipeImportInput({required this.source, this.url, this.content});
}

/// Erro amigável de importação (mensagem já em pt-BR para a UI mostrar).
/// Usada por: GeminiRecipeImportService (lança) e import_controller (exibe).
class RecipeImportException implements Exception {
  final String message;
  const RecipeImportException(this.message);
  @override
  String toString() => message;
}

/// Extrai um [RecipeDraft] a partir de uma fonte. Interface única: no preview usa
/// o mock; com Supabase, a impl. Gemini. Usada por: import_controller.
abstract class RecipeImportService {
  /// Importa a receita da [input] e devolve o rascunho editável.
  /// Usada por: import_controller.startFrom.
  Future<RecipeDraft> importFrom(RecipeImportInput input);
}

/// Importação offline p/ preview: rascunho fixo de exemplo (ou em branco no
/// manual). Aproxima o fluxo sem rede. Usada por: recipeImportServiceProvider (padrão).
class MockRecipeImportService implements RecipeImportService {
  const MockRecipeImportService();

  /// Delay curto p/ dar a sensação de "processando" (como a estimativa mock).
  static const _delay = Duration(milliseconds: 700);

  /// Manual -> rascunho em branco; demais fontes -> receita de exemplo (frango).
  /// Usada por: import_controller (preview no PC).
  @override
  Future<RecipeDraft> importFrom(RecipeImportInput input) async {
    await Future<void>.delayed(_delay);
    if (input.source == RecipeSource.manual) {
      return RecipeDraft(source: RecipeSource.manual);
    }
    return RecipeDraft(
      title: 'Frango xadrez',
      source: input.source,
      sourceUrl: input.url,
      servings: 4,
      timeMinutes: 25,
      kcal: 512,
      protein: 42,
      carb: 38,
      fat: 18,
      heroColor: 'terra',
      techniques: <String>['Selar a carne', 'Emulsionar um molho'],
      ingredients: const <Ingredient>[
        Ingredient(name: 'Peito de frango', grams: 500, humanQty: 500, humanUnit: 'g'),
        Ingredient(name: 'Ovo', grams: 80, humanQty: 2, humanUnit: 'unidade'),
        Ingredient(name: 'Pimentão', grams: 120, humanQty: 1, humanUnit: 'unidade'),
        Ingredient(name: 'Shoyu', grams: 45, humanQty: 3, humanUnit: 'c. sopa'),
        Ingredient(name: 'Amendoim', grams: 70, humanQty: 0.5, humanUnit: 'xícara'),
        Ingredient(name: 'Alho', grams: 15, humanQty: 3, humanUnit: 'dentes'),
      ],
      steps: const <RecipeStep>[
        RecipeStep(
          text: 'Corte o frango em cubos e seque bem com papel-toalha.',
          tip: 'Frango seco doura em vez de cozinhar na própria água — mais sabor.',
        ),
        RecipeStep(
          text: 'Sele os cubos em fogo alto, sem mexer demais, até dourar.',
          tip: 'Panela cheia demais esfria e cozinha; sele em levas.',
        ),
        RecipeStep(text: 'Refogue alho e pimentão rapidamente para manter a crocância.'),
        RecipeStep(
          text: 'Volte o frango, junte o shoyu e o amendoim e finalize.',
          tip: 'O shoyu reduz e vira molho — desligue quando encorpar.',
        ),
      ],
    );
  }
}

/// Injeta a importação em uso. Padrão: mock (preview). Override p/ o Gemini real
/// (GeminiRecipeImportService) quando o Supabase estiver configurado.
/// Usada por: import_controller.
final recipeImportServiceProvider =
    Provider<RecipeImportService>((ref) => const MockRecipeImportService());
