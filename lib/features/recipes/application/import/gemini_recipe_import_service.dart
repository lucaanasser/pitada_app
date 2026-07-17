// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/import/gemini_recipe_import_service.dart
// O QUÊ:     Implementação REAL da importação: chama a Edge Function `import-recipe`
//            (que fala com o Gemini) e converte a resposta em RecipeDraft com
//            componentes, sabor por ingrediente e técnica por passo (resolvida
//            em entidade canônica via TechniquesRepository).
// USA:       core/supabase (functions.invoke), core/utils (app_log, slug),
//            recipe_draft, ingredient, recipe_step, technique,
//            supabase_technique_repository.
// USADO POR: recipeImportServiceProvider (quando online — override em main.dart).
// SPEC:      specs/backend/edge_functions.yaml (functions.import-recipe)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase.dart';
import '../../../../core/utils/app_log.dart';
import '../../../../core/utils/slug.dart';
import '../../data/models/recipe/ingredient.dart';
import '../../data/models/recipe/recipe_draft.dart';
import '../../data/models/recipe/recipe_step.dart';
import '../../data/models/technique.dart';
import '../../data/repositories/technique/supabase_technique_repository.dart';
import 'recipe_import_service.dart';

/// Importação via Gemini na Edge Function `import-recipe`. Contrato:
///   entrada:  { source, url?, content? (base64) }
///   saída:    { title, servings, time_minutes?, kcal/protein/carb/fat?,
///               components:[{name?, ingredients:[{... flavors?}],
///               steps:[{text, tip?, techniques:[{name, anchor}]?}]}] }
/// Usada por: recipeImportServiceProvider quando online (override).
class GeminiRecipeImportService implements RecipeImportService {
  const GeminiRecipeImportService();

  /// Invoca a Edge Function e mapeia a resposta em RecipeDraft. Traduz os erros
  /// da função (422/502...) em RecipeImportException. Usada por: import_controller.
  @override
  Future<RecipeDraft> importFrom(RecipeImportInput input) async {
    AppLog.d('recipes',
        'import-recipe (gemini): ${input.source.name} ${input.url ?? '[arquivo]'}',);
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
      return await _draftFromJson(data, input);
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

  /// Converte o JSON da função no rascunho editável, resolvendo cada técnica
  /// {name, anchor} em entidade canônica (cria as inéditas). Usada por: [importFrom].
  Future<RecipeDraft> _draftFromJson(
    Map<String, dynamic> d,
    RecipeImportInput input,
  ) async {
    final resolve = _TechniqueResolver();
    final components = <DraftComponent>[
      for (final c in (d['components'] as List? ?? const []))
        await _component((c as Map).cast<String, dynamic>(), resolve),
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
      components: components,
    );
  }

  /// Um componente do JSON: ingredientes (com sabor) + passos (com técnicas
  /// resolvidas). Usada por: [_draftFromJson].
  Future<DraftComponent> _component(
    Map<String, dynamic> c,
    _TechniqueResolver resolve,
  ) async {
    final steps = <RecipeStep>[];
    for (final e in (c['steps'] as List? ?? const [])) {
      final s = (e as Map).cast<String, dynamic>();
      final links = <StepTechnique>[];
      for (final t in (s['techniques'] as List? ?? const [])) {
        final m = (t as Map).cast<String, dynamic>();
        final name = (m['name'] as String?)?.trim() ?? '';
        if (name.isEmpty) continue;
        links.add(StepTechnique(
          techniqueId: await resolve.idFor(name),
          anchor: m['anchor'] as String?,
        ),);
      }
      steps.add(
        RecipeStep.fromJson({...s}..remove('techniques'))
            .copyWith(techniques: links),
      );
    }
    return DraftComponent(
      name: (c['name'] as String?)?.trim().isEmpty ?? true
          ? null
          : (c['name'] as String).trim(),
      ingredients: [
        for (final e in (c['ingredients'] as List? ?? const []))
          Ingredient.fromJson((e as Map).cast<String, dynamic>()),
      ],
      steps: steps,
    );
  }
}

/// Resolve nomes de técnica em ids canônicos com cache local da importação:
/// reusa pelo slug, cria as inéditas (uma vez só por nome). Usada por: service.
class _TechniqueResolver {
  final _repo = const SupabaseTechniquesRepository();
  final _cache = <String, String>{};
  List<Technique>? _known;

  /// Id canônico para [name] (cria se não existir). Usada por: _component.
  Future<String> idFor(String name) async {
    final slug = slugify(name);
    final hit = _cache[slug];
    if (hit != null) return hit;
    _known ??= await _repo.fetchTechniques();
    for (final t in _known!) {
      if (t.slug == slug) return _cache[slug] = t.id;
    }
    final id = await _repo
        .createTechnique(Technique(id: '', slug: slug, name: name));
    return _cache[slug] = id;
  }
}
