// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_list_providers.dart
// O QUÊ:     Providers da LISTA da aba Receitas: busca (título/ingrediente),
//            filtros (maestria/tempo/kcal), ordem da lista e maestria por
//            receita ("nunca fiz → fiz N× → domino").
// USA:       recipes_providers (fonte), notebook/application/providers (diário
//            e versões — atividade real), recipe_filters, recipe.dart, riverpod.
// USADO POR: recipes_screen, RecipeListView, RecipeFilterPanel, RecipeSearchField.
// SPEC:      specs/features/recipes.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notebook/application/providers.dart';
import '../../notebook/data/models/activity/diary_entry.dart';
import '../data/models/recipe.dart';
import 'recipe_filters.dart';
import 'recipes_providers.dart';

/// Texto digitado na busca (título OU ingrediente). Usada por: recipes_screen.
final recipeSearchQueryProvider = StateProvider<String>((ref) => '');

/// Filtros e ordem ligados na aba. Usada por: RecipeFilterPanel, lista.
final recipeFiltersProvider =
    StateProvider<RecipeFilters>((ref) => const RecipeFilters());

/// Painel de filtros aberto ou colapsado. Usada por: recipes_screen.
final recipeFiltersOpenProvider = StateProvider<bool>((ref) => false);

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

/// Nº de vezes que a receita foi registrada no diário. Usada por: maestria.
int _cooksOf(Recipe r, List<DiaryEntry> diary) => diary
    .where((d) => d.recipeIds.contains(r.id) || d.recipeName == r.title)
    .length;

/// Maestria de cada receita — fato sobre VOCÊ, não opinião sobre o prato.
/// Domina com 3+ preparos, ou versionando e tendo feito ao menos 1×.
/// Usada por: recipeMasteryProvider (rótulo) e filteredRecipesProvider (filtro).
final _masteryByIdProvider = Provider<Map<String, Mastery>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final diary = ref.watch(diaryProvider).valueOrNull ?? const <DiaryEntry>[];
  return {
    for (final r in recipes) r.id: _masteryOf(r, _cooksOf(r, diary)),
  };
});

/// Traduz nº de preparos + versionamento em maestria. Usada por: [_masteryByIdProvider].
Mastery _masteryOf(Recipe r, int cooks) {
  if (cooks >= 3 || (r.version > 1 && cooks >= 1)) return Mastery.mastered;
  return cooks == 0 ? Mastery.never : Mastery.some;
}

/// Nº de preparos por receita — o "N" de "fiz N×". Usada por: recipeMasteryProvider.
final _cooksByIdProvider = Provider<Map<String, int>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final diary = ref.watch(diaryProvider).valueOrNull ?? const <DiaryEntry>[];
  return {for (final r in recipes) r.id: _cooksOf(r, diary)};
});

/// Lista exibida na aba: busca, filtros e ordem aplicados nessa sequência.
/// Usada por: recipes_screen.
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final query = ref.watch(recipeSearchQueryProvider).trim().toLowerCase();
  final filters = ref.watch(recipeFiltersProvider);
  final mastery = ref.watch(_masteryByIdProvider);

  bool matchesQuery(Recipe r) {
    if (query.isEmpty) return true;
    final inTitle = r.title.toLowerCase().contains(query);
    final inIngredient =
        r.ingredients.any((i) => i.name.toLowerCase().contains(query));
    return inTitle || inIngredient;
  }

  final visible = recipes
      .where(matchesQuery)
      .where((r) => filters.matches(r, mastery[r.id] ?? Mastery.never))
      .toList();

  return switch (filters.sort) {
    RecipeSort.alphabetical => visible
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase())),
    RecipeSort.recent => visible.reversed.toList(),
    RecipeSort.activity =>
      _byActivity(visible, ref.watch(_activityDatesProvider)),
  };
});

/// Receitas com atividade recente primeiro; o acervo puro fica depois, na ordem
/// original. Usada por: [filteredRecipesProvider].
List<Recipe> _byActivity(List<Recipe> visible, Map<String, DateTime> dates) {
  final active = visible.where((r) => dates.containsKey(r.id)).toList()
    ..sort((a, b) => dates[b.id]!.compareTo(dates[a.id]!));
  final rest = visible.where((r) => !dates.containsKey(r.id)).toList();
  return [...active, ...rest];
}

/// Rótulo de maestria de uma receita: "nunca fiz" -> "fiz N×" -> "domino".
/// Usada por: RecipeListView.
final recipeMasteryProvider = Provider.family<String, String>((ref, id) {
  final mastery = ref.watch(_masteryByIdProvider)[id];
  if (mastery == null) return '';
  if (mastery == Mastery.mastered) return 'domino';
  final cooks = ref.watch(_cooksByIdProvider)[id] ?? 0;
  return cooks == 0 ? 'nunca fiz' : 'fiz $cooks×';
});
