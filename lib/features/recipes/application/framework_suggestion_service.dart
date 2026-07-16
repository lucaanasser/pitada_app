// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/framework_suggestion_service.dart
// O QUÊ:     Sugestão socrática da tab Frameworks: acha NO MÁXIMO um grupo de
//            receitas parecidas e pergunta o que elas têm em comum — a IA
//            aponta, o usuário nomeia. Heurística local, sem rede.
// USA:       recipes_providers (acervo), framework_providers (instâncias já
//            usadas), recipe.dart, riverpod.
// USADO POR: FrameworksTabView (via frameworkSuggestionProvider).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/framework.dart';
import '../data/models/recipe.dart';
import 'framework_providers.dart';
import 'recipes_providers.dart';

/// Um grupo de receitas parecidas + o traço que elas compartilham (a pista da
/// pergunta socrática — nunca o nome do framework). Usada por: FrameworksTabView.
class FrameworkSuggestion {
  const FrameworkSuggestion({required this.recipes, required this.sharedTrait});

  final List<Recipe> recipes;
  final String sharedTrait;
}

/// Sugestão dispensada nesta sessão (o X do card). Usada por: FrameworksTabView.
final frameworkSuggestionDismissedProvider = StateProvider<bool>((ref) => false);

/// A única sugestão socrática da vez (ou null): receitas ainda sem framework
/// que compartilham uma técnica ou 2+ ingredientes. Usada por: FrameworksTabView.
final frameworkSuggestionProvider = Provider<FrameworkSuggestion?>((ref) {
  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final frameworks =
      ref.watch(frameworksProvider).valueOrNull ?? const <Framework>[];
  final taken = <String>{for (final f in frameworks) ...f.recipeIds};
  final free = [for (final r in recipes) if (!taken.contains(r.id)) r];
  if (free.length < 2) return null;
  return _byTechnique(free) ?? _byIngredients(free);
});

/// Maior grupo (2+) de receitas livres que usa a mesma técnica.
/// Usada por: [frameworkSuggestionProvider].
FrameworkSuggestion? _byTechnique(List<Recipe> free) {
  final groups = <String, List<Recipe>>{};
  for (final r in free) {
    for (final t in r.techniques) {
      groups.putIfAbsent(t, () => []).add(r);
    }
  }
  List<Recipe>? best;
  String? trait;
  groups.forEach((t, rs) {
    if (rs.length >= 2 && (best == null || rs.length > best!.length)) {
      best = rs;
      trait = t;
    }
  });
  if (best == null) return null;
  final subject = best!.length == 2 ? 'as duas' : 'todas';
  return FrameworkSuggestion(
    recipes: best!,
    sharedTrait: '$subject passam por "${trait!.toLowerCase()}"',
  );
}

/// Par de receitas livres com 2+ ingredientes em comum (nomes normalizados).
/// Usada por: [frameworkSuggestionProvider].
FrameworkSuggestion? _byIngredients(List<Recipe> free) {
  Set<String> names(Recipe r) =>
      {for (final i in r.ingredients) i.name.trim().toLowerCase()};
  for (var a = 0; a < free.length; a++) {
    for (var b = a + 1; b < free.length; b++) {
      final shared = names(free[a]).intersection(names(free[b]));
      if (shared.length >= 2) {
        return FrameworkSuggestion(
          recipes: [free[a], free[b]],
          sharedTrait: 'as duas levam ${shared.take(2).join(' e ')}',
        );
      }
    }
  }
  return null;
}
