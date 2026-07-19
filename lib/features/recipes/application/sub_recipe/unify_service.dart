// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/sub_recipe/unify_service.dart
// O QUÊ:     Detecção de componentes locais PARECIDOS para unificar numa
//            subreceita (o caso "4 bolos com coberturas quase iguais").
//            Funções puras: similaridade, escala sugerida e diffs.
// USA:       core/utils/slug (slugify), recipe.dart, recipe_component.dart.
// USADO POR: UnifyScreen (lista de candidatas) e sheet de ações do componente.
// SPEC:      specs/features/sub_recipes.yaml (unificacao.deteccao)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/utils/slug.dart';
import '../../data/models/recipe/recipe.dart';
import '../../data/models/recipe/recipe_component.dart';

/// Um componente local parecido com a origem, candidato à unificação.
/// [similarity] em 0..1; [preselected] marca as bem parecidas (>= 0,75);
/// [suggestedScale] é a razão de gramas vs. a canônica; [diffs] lista o que a
/// candidata tem a mais (+) ou a menos (−). Usada por: UnifyScreen.
class UnifyCandidate {
  const UnifyCandidate({
    required this.recipeId,
    required this.recipeTitle,
    required this.componentIndex,
    required this.component,
    required this.similarity,
    required this.suggestedScale,
    required this.diffs,
  });

  final String recipeId;
  final String recipeTitle;
  final int componentIndex;
  final RecipeComponent component;
  final double similarity;
  final num suggestedScale;
  final List<String> diffs;

  /// True quando a semelhança justifica vir pré-marcada. Usada por: UnifyScreen.
  bool get preselected => similarity >= 0.75;
}

/// Varre as receitas atrás de componentes LOCAIS nomeados parecidos com o
/// componente [originIndex] de [origin] (score = 0,5·nome + 0,5·ingredientes;
/// entra com >= 0,5), ordenados do mais parecido. Usada por: UnifyScreen.
List<UnifyCandidate> findUnifyCandidates(
  List<Recipe> recipes,
  Recipe origin,
  int originIndex,
) {
  final canonical = origin.components[originIndex];
  final result = <UnifyCandidate>[];
  for (final r in recipes) {
    for (var i = 0; i < r.components.length; i++) {
      if (r.id == origin.id && i == originIndex) continue;
      final c = r.components[i];
      if (c.isLinked || c.name == null) continue;
      final score = _similarity(canonical, c);
      if (score < 0.5) continue;
      result.add(
        UnifyCandidate(
          recipeId: r.id,
          recipeTitle: r.title,
          componentIndex: i,
          component: c,
          similarity: score,
          suggestedScale: suggestScale(canonical, c),
          diffs: componentDiffs(canonical, c),
        ),
      );
    }
  }
  result.sort((a, b) => b.similarity.compareTo(a.similarity));
  return result;
}

/// Escala sugerida: razão das somas de gramas dos ingredientes CASADOS por
/// slug (2 casas). Sem casamento (ou gramas zeradas) devolve 1.
/// Usada por: findUnifyCandidates, UnifyScreen.
num suggestScale(RecipeComponent canonical, RecipeComponent other) {
  num base = 0;
  num target = 0;
  final byName = {
    for (final i in canonical.ingredients) slugify(i.name): i.grams ?? 0,
  };
  for (final i in other.ingredients) {
    final match = byName[slugify(i.name)];
    if (match == null || match <= 0) continue;
    base += match;
    target += i.grams ?? 0;
  }
  if (base <= 0 || target <= 0) return 1;
  return (target / base * 100).round() / 100;
}

/// O que a candidata tem a mais (+) e a menos (−) que a canônica, por nome de
/// ingrediente. Usada por: findUnifyCandidates, UnifyScreen.
List<String> componentDiffs(RecipeComponent canonical, RecipeComponent other) {
  final base = {for (final i in canonical.ingredients) slugify(i.name): i.name};
  final target = {for (final i in other.ingredients) slugify(i.name): i.name};
  return [
    for (final e in target.entries)
      if (!base.containsKey(e.key)) '+ ${e.value}',
    for (final e in base.entries)
      if (!target.containsKey(e.key)) '− ${e.value}',
  ];
}

/// Score 0..1 de semelhança: metade nome (slug igual 1; um contém o outro
/// 0,7), metade Jaccard dos ingredientes por slug. Usada por: findUnifyCandidates.
double _similarity(RecipeComponent a, RecipeComponent b) {
  final an = slugify(a.name ?? '');
  final bn = slugify(b.name ?? '');
  final nameScore = an == bn
      ? 1.0
      : (an.contains(bn) || bn.contains(an))
          ? 0.7
          : 0.0;
  final aSet = {for (final i in a.ingredients) slugify(i.name)};
  final bSet = {for (final i in b.ingredients) slugify(i.name)};
  final union = aSet.union(bSet).length;
  final jaccard = union == 0 ? 0.0 : aSet.intersection(bSet).length / union;
  return 0.5 * nameScore + 0.5 * jaccard;
}
