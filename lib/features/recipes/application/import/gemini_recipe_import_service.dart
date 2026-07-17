// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/import/gemini_recipe_import_service.dart
// O QUÊ:     Implementação REAL da importação: chama a Edge Function `import-recipe`
//            (que fala com o Gemini) e converte a resposta em RecipeDraft. Só roda
//            com Supabase configurado; no preview usa-se o mock. Para ligar, faça
//            override de recipeImportServiceProvider com esta classe.
// USA:       core/supabase (functions.invoke), recipe_draft, ingredient, recipe_step, app_log.
// USADO POR: recipeImportServiceProvider (quando online — override em main.dart).
// SPEC:      specs/backend/edge_functions.yaml (functions.import-recipe)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase.dart';
import '../../../../core/utils/app_log.dart';
import '../../data/models/recipe/ingredient.dart';
import '../../data/models/recipe/recipe_draft.dart';
import '../../data/models/recipe/recipe_step.dart';
import 'recipe_import_service.dart';

/// Importação via Gemini na Edge Function `import-recipe`. Contrato:
///   entrada:  { source, url? , content? (base64) }
///   saída:    { title, servings, time_minutes?, techniques?,
///               ingredients:[{name, grams?, human_qty?, human_unit?}],
///               steps:[{text, tip?}], kcal/protein/carb/fat? }
/// Usada por: recipeImportServiceProvider quando online (override).
class GeminiRecipeImportService implements RecipeImportService {
  const GeminiRecipeImportService();

  /// Invoca a Edge Function e mapeia a resposta em RecipeDraft. Traduz os erros
  /// da função (422/502...) em RecipeImportException. Usada por: import_controller.
  @override
  Future<RecipeDraft> importFrom(RecipeImportInput input) async {
    AppLog.d('recipes', 'import-recipe (gemini): ${input.source.name} ${input.url ?? '[arquivo]'}');
    try {
      final res = await SupabaseService.client.functions.invoke(
        'import-recipe',
        body: {
          'source': input.source.name,
          if (input.url != null) 'url': input.url,
          if (input.content != null) 'content': input.content,
        },
      );
      final data = (res.data as Map).cast<String, dynamic>();
      return _draftFromJson(data, input);
    } on FunctionException catch (e) {
      AppLog.w('recipes', 'import-recipe falhou: ${e.status}');
      throw RecipeImportException(_message(e.status));
    }
  }

  /// Mensagem amigável por status da função. Usada por: [importFrom].
  String _message(int? status) => switch (status) {
        400 => 'Não consegui ler essa fonte. Confira o link ou o arquivo.',
        422 => 'Não encontrei uma receita aí.',
        _ => 'A IA não respondeu agora. Tente de novo.',
      };

  /// Converte o JSON da função no rascunho editável. Usada por: [importFrom].
  RecipeDraft _draftFromJson(Map<String, dynamic> d, RecipeImportInput input) {
    final ingredients = [
      for (final e in (d['ingredients'] as List? ?? const []))
        Ingredient.fromJson((e as Map).cast<String, dynamic>()),
    ];
    final steps = [
      for (final e in (d['steps'] as List? ?? const []))
        RecipeStep.fromJson((e as Map).cast<String, dynamic>()),
    ];
    return RecipeDraft(
      title: (d['title'] as String?)?.trim() ?? '',
      source: input.source,
      sourceUrl: input.url,
      servings: (d['servings'] as num?)?.round() ?? 2,
      timeMinutes: (d['time_minutes'] as num?)?.round(),
      kcal: (d['kcal'] as num?)?.round() ?? 0,
      protein: (d['protein'] as num?) ?? 0,
      carb: (d['carb'] as num?) ?? 0,
      fat: (d['fat'] as num?) ?? 0,
      techniques: (d['techniques'] as List?)?.cast<String>() ?? const [],
      components: [DraftComponent(ingredients: ingredients, steps: steps)],
    );
  }
}
