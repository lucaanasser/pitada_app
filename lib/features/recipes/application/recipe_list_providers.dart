// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_list_providers.dart
// O QUÊ:     Providers da LISTA da aba Receitas: busca (título/ingrediente),
//            lista ordenada por última atividade, maestria por receita
//            ("nunca fiz → fiz N× → domino") e memória do último diário.
// USA:       recipes_providers (fonte), notebook/application/providers (diário
//            e versões — atividade real), recipe.dart, riverpod.
// USADO POR: recipes_screen, RecipeListView (camada de apresentação).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notebook/application/providers.dart';
import '../../notebook/data/models/activity/diary_entry.dart';
import '../data/models/recipe.dart';
import 'recipes_providers.dart';

/// Texto digitado na busca (título OU ingrediente). Usada por: recipes_screen.
final recipeSearchQueryProvider = StateProvider<String>((ref) => '');

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

/// Lista exibida na aba: busca aplicada, receitas com atividade recente
/// primeiro (o acervo puro fica depois, na ordem original).
/// Usada por: recipes_screen.
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final query = ref.watch(recipeSearchQueryProvider).trim().toLowerCase();

  bool matches(Recipe r) {
    if (query.isEmpty) return true;
    final inTitle = r.title.toLowerCase().contains(query);
    final inIngredient =
        r.ingredients.any((i) => i.name.toLowerCase().contains(query));
    return inTitle || inIngredient;
  }

  final visible = recipes.where(matches).toList();
  final dates = ref.watch(_activityDatesProvider);
  final active = visible.where((r) => dates.containsKey(r.id)).toList()
    ..sort((a, b) => dates[b.id]!.compareTo(dates[a.id]!));
  final rest = visible.where((r) => !dates.containsKey(r.id)).toList();
  return [...active, ...rest];
});

/// Nº de vezes que a receita foi registrada no diário. Usada por: maestria.
int _cooksOf(Recipe r, List<DiaryEntry> diary) => diary
    .where((d) => d.recipeIds.contains(r.id) || d.recipeName == r.title)
    .length;

/// Maestria de uma receita — fato sobre VOCÊ, não opinião sobre o prato:
/// "nunca fiz" -> "fiz N×" -> "domino" (3+ vezes, ou versionou e fez 1+).
/// Mantém o prefixo "vN sua" quando versionada. Usada por: RecipeListView.
final recipeMasteryProvider = Provider.family<String, String>((ref, id) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final r = recipes.where((x) => x.id == id).firstOrNull;
  if (r == null) return '';
  final diary = ref.watch(diaryProvider).valueOrNull ?? const [];
  final cooks = _cooksOf(r, diary);
  final masters = cooks >= 3 || (r.version > 1 && cooks >= 1);
  final level = masters
      ? 'domino'
      : cooks == 0
          ? 'nunca fiz'
          : 'fiz $cooks×';
  return [if (r.version > 1) 'v${r.version} sua', level].join(' · ');
});

/// Memória do caderno para uma receita: a anotação da última vez que ela foi
/// cozinhada ("última vez: faltou ácido"), ou null sem histórico — a recompensa
/// visível de registrar. Usada por: RecipeListView.
final lastCookMemoryProvider = Provider.family<String?, String>((ref, id) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final r = recipes.where((x) => x.id == id).firstOrNull;
  if (r == null) return null;
  final diary = ref.watch(diaryProvider).valueOrNull ?? const <DiaryEntry>[];
  DiaryEntry? last;
  for (final d in diary) {
    if (!d.recipeIds.contains(r.id) && d.recipeName != r.title) continue;
    if (last == null || d.date.isAfter(last.date)) last = d;
  }
  if (last == null) return null;
  final note = last.body.isNotEmpty ? last.body : last.label;
  if (note.isEmpty) return null;
  return 'última vez: $note';
});
