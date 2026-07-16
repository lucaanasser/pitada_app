// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_list_providers.dart
// O QUÊ:     Providers da LISTA da aba Receitas: busca (título/ingrediente),
//            lente ativa, lista filtrada ordenada por última atividade, linha
//            de posse ("v3 sua · feita 2×") e repertório de técnicas.
// USA:       recipes_providers (fonte), notebook/application/providers (diário
//            e versões — atividade real), recipe.dart, riverpod.
// USADO POR: recipes_screen, LensChipRow (camada de apresentação).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notebook/application/providers.dart';
import '../../notebook/data/models/activity/diary_entry.dart';
import '../data/models/recipe.dart';
import 'recipes_providers.dart';

/// Lente "Rápidas": tempo máximo em minutos. Usada por: filteredRecipesProvider.
const kQuickLensMinutes = 20;

/// Texto digitado na busca (título OU ingrediente). Usada por: recipes_screen.
final recipeSearchQueryProvider = StateProvider<String>((ref) => '');

/// Lente ativa da lista: null = todas; 'quick' = rápidas (≤ 20 min);
/// 'tech:<nome>' = receitas que usam a técnica. Usada por: LensChipRow, filtro.
final recipeLensProvider = StateProvider<String?>((ref) => null);

/// Técnicas distintas do acervo (ordenadas) para os chips de lente.
/// Usada por: LensChipRow.
final techniqueLensOptionsProvider = Provider<List<String>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final names = <String>{for (final r in recipes) ...r.techniques};
  return names.toList()..sort();
});

/// Data da última atividade real (diário/versão) por id de receita.
/// Usada por: filteredRecipesProvider (ordenação por última atividade).
final _activityDatesProvider = Provider<Map<String, DateTime>>((ref) {
  final dates = <String, DateTime>{};
  void keep(String id, DateTime? d) {
    if (d == null) return;
    final cur = dates[id];
    if (cur == null || d.isAfter(cur)) dates[id] = d;
  }

  for (final d in ref.watch(diaryProvider).valueOrNull ?? const []) {
    for (final id in d.recipeIds) {
      keep(id, d.date);
    }
  }
  for (final v in ref.watch(versionsProvider).valueOrNull ?? const []) {
    keep(v.recipeId, v.date);
  }
  return dates;
});

/// Lista exibida na aba: busca + lente aplicadas, receitas com atividade
/// recente primeiro (o acervo puro fica depois, na ordem original).
/// Usada por: recipes_screen.
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final query = ref.watch(recipeSearchQueryProvider).trim().toLowerCase();
  final lens = ref.watch(recipeLensProvider);

  bool matches(Recipe r) {
    if (query.isNotEmpty) {
      final inTitle = r.title.toLowerCase().contains(query);
      final inIngredient =
          r.ingredients.any((i) => i.name.toLowerCase().contains(query));
      if (!inTitle && !inIngredient) return false;
    }
    if (lens == null) return true;
    if (lens == 'quick') return (r.timeMinutes ?? 999) <= kQuickLensMinutes;
    if (lens.startsWith('tech:')) {
      return r.techniques.contains(lens.substring(5));
    }
    return true;
  }

  final visible = recipes.where(matches).toList();
  final dates = ref.watch(_activityDatesProvider);
  final active = visible.where((r) => dates.containsKey(r.id)).toList()
    ..sort((a, b) => dates[b.id]!.compareTo(dates[a.id]!));
  final rest = visible.where((r) => !dates.containsKey(r.id)).toList();
  return [...active, ...rest];
});

/// Nº de vezes que a receita foi registrada no diário. Usada por: posse.
int _cooksOf(Recipe r, List<DiaryEntry> diary) => diary
    .where((d) => d.recipeIds.contains(r.id) || d.recipeName == r.title)
    .length;

/// Linha de posse de uma receita: "v3 sua · feita 2×" quando há história;
/// "importada · nunca feita" quando ainda é acervo. Usada por: recipes_screen.
final recipeOwnershipProvider = Provider.family<String, String>((ref, id) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final r = recipes.where((x) => x.id == id).firstOrNull;
  if (r == null) return '';
  final diary = ref.watch(diaryProvider).valueOrNull ?? const [];
  final cooks = _cooksOf(r, diary);
  final parts = <String>[
    if (r.version > 1) 'v${r.version} sua',
    if (cooks > 0)
      'feita $cooks×'
    else if (r.version <= 1)
      r.source == RecipeSource.manual
          ? 'nunca feita'
          : 'importada · nunca feita',
  ];
  return parts.join(' · ');
});

/// Técnicas distintas em receitas com atividade real (feitas ou versionadas) —
/// o repertório: um número sem teto, que só sobe. Usada por: recipes_screen.
final techniqueRepertoireProvider = Provider<int>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final diary = ref.watch(diaryProvider).valueOrNull ?? const [];
  final used = <String>{
    for (final r in recipes)
      if (r.version > 1 || _cooksOf(r, diary) > 0) ...r.techniques,
  };
  return used.length;
});
