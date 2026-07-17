// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_filters.dart
// O QUÊ:     Os eixos de filtro da lista de Receitas (maestria, tempo, kcal) e a
//            ordem da lista — valor imutável + os rótulos pt-BR de cada faixa.
// USA:       recipe.dart (Recipe: timeMinutes, kcal).
// USADO POR: recipe_list_providers (aplica), RecipeFilterPanel (desenha os chips).
// SPEC:      specs/features/recipes.yaml (screens.RecipesScreen.filtros)
// ─────────────────────────────────────────────────────────────────────────────
import '../data/models/recipe.dart';

/// Maestria como FATO comparável (o rótulo é derivado daqui, não o contrário).
/// Usada por: recipeMasteryProvider (rótulo) e RecipeFilters (filtro).
enum Mastery { never, some, mastered }

/// Faixa de tempo de preparo. Usada por: RecipeFilters.
enum TimeRange { upTo30, from30To60, over60 }

/// Faixa de kcal por porção. Usada por: RecipeFilters.
enum KcalRange { upTo400, from400To700, over700 }

/// Ordem da lista — não é filtro, é arranjo. Usada por: filteredRecipesProvider.
enum RecipeSort { activity, recent, alphabetical }

/// Rótulo pt-BR de uma maestria. Usada por: RecipeFilterPanel.
String masteryLabel(Mastery m) => switch (m) {
      Mastery.never => 'nunca fiz',
      Mastery.some => 'fiz 1-2×',
      Mastery.mastered => 'domino',
    };

/// Rótulo pt-BR de uma faixa de tempo. Usada por: RecipeFilterPanel.
String timeRangeLabel(TimeRange t) => switch (t) {
      TimeRange.upTo30 => 'até 30 min',
      TimeRange.from30To60 => '30-60 min',
      TimeRange.over60 => '1h+',
    };

/// Rótulo pt-BR de uma faixa de kcal. Usada por: RecipeFilterPanel.
String kcalRangeLabel(KcalRange k) => switch (k) {
      KcalRange.upTo400 => 'até 400',
      KcalRange.from400To700 => '400-700',
      KcalRange.over700 => '700+',
    };

/// Rótulo pt-BR de uma ordem. Usada por: RecipeFilterPanel.
String recipeSortLabel(RecipeSort s) => switch (s) {
      RecipeSort.activity => 'atividade',
      RecipeSort.recent => 'recentes',
      RecipeSort.alphabetical => 'A-Z',
    };

/// Faixa de tempo em que a receita cai; null quando ela não declara tempo.
/// Usada por: RecipeFilters.matches.
TimeRange? timeRangeOf(Recipe r) {
  final minutes = r.timeMinutes;
  if (minutes == null) return null;
  if (minutes <= 30) return TimeRange.upTo30;
  if (minutes <= 60) return TimeRange.from30To60;
  return TimeRange.over60;
}

/// Faixa de kcal por porção em que a receita cai. Usada por: RecipeFilters.matches.
KcalRange kcalRangeOf(Recipe r) {
  if (r.kcal <= 400) return KcalRange.upTo400;
  if (r.kcal <= 700) return KcalRange.from400To700;
  return KcalRange.over700;
}

/// Os filtros ligados na aba Receitas e a ordem escolhida. Vazio = tudo passa.
/// Dentro de um eixo as opções somam (OU); entre eixos elas restringem (E).
/// Usada por: recipeFiltersProvider, RecipeFilterPanel.
class RecipeFilters {
  const RecipeFilters({
    this.mastery = const {},
    this.time = const {},
    this.kcal = const {},
    this.sort = RecipeSort.activity,
  });

  final Set<Mastery> mastery;
  final Set<TimeRange> time;
  final Set<KcalRange> kcal;
  final RecipeSort sort;

  /// True quando algum eixo está ligado ou a ordem saiu do padrão — é o que
  /// acende o ícone e revela o "Limpar". Usada por: RecipeSearchField, painel.
  bool get isActive =>
      mastery.isNotEmpty ||
      time.isNotEmpty ||
      kcal.isNotEmpty ||
      sort != RecipeSort.activity;

  /// Quantos eixos de filtro estão ligados (a ordem não conta). Usada por: painel.
  int get activeAxes =>
      (mastery.isEmpty ? 0 : 1) +
      (time.isEmpty ? 0 : 1) +
      (kcal.isEmpty ? 0 : 1);

  /// True quando a receita passa por TODOS os eixos ligados. Usada por:
  /// filteredRecipesProvider.
  bool matches(Recipe r, Mastery m) {
    if (mastery.isNotEmpty && !mastery.contains(m)) return false;
    if (time.isNotEmpty) {
      final range = timeRangeOf(r);
      if (range == null || !time.contains(range)) return false;
    }
    if (kcal.isNotEmpty && !kcal.contains(kcalRangeOf(r))) return false;
    return true;
  }

  /// Devolve uma cópia com um eixo/ordem trocado. Usada por: RecipeFilterPanel.
  RecipeFilters copyWith({
    Set<Mastery>? mastery,
    Set<TimeRange>? time,
    Set<KcalRange>? kcal,
    RecipeSort? sort,
  }) =>
      RecipeFilters(
        mastery: mastery ?? this.mastery,
        time: time ?? this.time,
        kcal: kcal ?? this.kcal,
        sort: sort ?? this.sort,
      );
}
