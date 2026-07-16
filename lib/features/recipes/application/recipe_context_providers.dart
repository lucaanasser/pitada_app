// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/recipe_context_providers.dart
// O QUÊ:     Contexto vivo da aba Receitas (máx. 3 cards): registro pendente,
//            item da despensa vencendo (com receita que o usa) e prato
//            combinado no plano. Só sinais reais — nada nasce de "salvei".
// USA:       notebook/hub_providers (cozinha pendente), groceries/providers
//            (despensa), plans/plans_providers (plano), recipes_providers.
// USADO POR: ContextStrip (presentation/widgets/home).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../groceries/application/providers.dart';
import '../../notebook/application/hub_providers.dart';
import '../../plans/application/plans_providers.dart';
import '../data/models/recipe.dart';
import 'recipes_providers.dart';

/// Tipo de sinal de um card do contexto vivo. Usada por: ContextStrip (ação).
enum RecipeContextKind { register, expiring, planned }

/// Um card do contexto vivo: sinal real que pede a próxima ação.
/// [route] navega; kind register abre o diário rápido pré-preenchido.
/// Usada por: recipeContextProvider e ContextStrip.
class RecipeContextItem {
  final RecipeContextKind kind;
  final String kicker;
  final String title;
  final String body;
  final String hero;
  final String? route;
  final String? recipeId;
  final String? recipeName;

  const RecipeContextItem({
    required this.kind,
    required this.kicker,
    required this.title,
    required this.body,
    required this.hero,
    this.route,
    this.recipeId,
    this.recipeName,
  });
}

/// Data sem hora (para contar dias de validade). Usada por: _expiringItem.
DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// Rótulo humano da validade ("vence hoje/amanhã/em N dias"). Usada por: _expiringItem.
String _expiryLabel(int days) => switch (days) {
      0 => 'vence hoje',
      1 => 'vence amanhã',
      _ => 'vence em $days dias',
    };

/// A primeira receita do acervo que usa o ingrediente. Usada por: _expiringItem.
Recipe? _recipeUsing(List<Recipe> recipes, String ingredientName) {
  final wanted = ingredientName.toLowerCase();
  for (final r in recipes) {
    for (final i in r.ingredients) {
      final name = i.name.toLowerCase();
      if (name.contains(wanted) || wanted.contains(name)) return r;
    }
  }
  return null;
}

/// Os cards do contexto vivo (máx. 3, um por sinal), na ordem:
/// registro pendente > despensa vencendo > combinado do plano.
/// Usada por: ContextStrip (recipes_screen).
final recipeContextProvider = Provider<List<RecipeContextItem>>((ref) {
  final items = <RecipeContextItem>[];

  final cook = ref.watch(pendingCookProvider).valueOrNull;
  if (cook != null) {
    final days = DateTime.now().difference(cook.when).inDays;
    items.add(
      RecipeContextItem(
        kind: RecipeContextKind.register,
        kicker: days <= 1 ? 'Ontem você cozinhou' : 'Você cozinhou',
        title: cook.recipeName,
        body: 'Registrar as três perguntas leva 20 segundos.',
        hero: 'moss',
        recipeId: cook.recipeId,
        recipeName: cook.recipeName,
      ),
    );
  }

  final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
  final expiring = _expiringItem(ref, recipes);
  if (expiring != null) items.add(expiring);

  final planned = _plannedItem(ref);
  if (planned != null) items.add(planned);

  return items.take(3).toList();
});

/// Card "despensa vencendo": o item mais urgente (até 4 dias) que alguma
/// receita usa. Usada por: recipeContextProvider.
RecipeContextItem? _expiringItem(Ref ref, List<Recipe> recipes) {
  final pantry = ref.watch(pantryProvider).valueOrNull ?? const [];
  final today = _day(DateTime.now());
  RecipeContextItem? best;
  var bestDays = 999;
  for (final item in pantry) {
    final expiresOn = item.expiresOn;
    if (expiresOn == null) continue;
    final days = _day(expiresOn).difference(today).inDays;
    if (days < 0 || days > 4 || days >= bestDays) continue;
    final recipe = _recipeUsing(recipes, item.name);
    if (recipe == null) continue;
    bestDays = days;
    best = RecipeContextItem(
      kind: RecipeContextKind.expiring,
      kicker: 'Na despensa',
      title: '${item.name} ${_expiryLabel(days)}',
      body: 'Use em "${recipe.title}" antes de perder.',
      hero: 'ochre',
      route: '/recipe/${recipe.id}',
      recipeId: recipe.id,
    );
  }
  return best;
}

/// Card "combinado do plano": o primeiro prato do plano ligado a uma receita.
/// Usada por: recipeContextProvider.
RecipeContextItem? _plannedItem(Ref ref) {
  final plan = ref.watch(planControllerProvider);
  for (final meal in plan.meals) {
    final options = [
      if (meal.chosenOption != null) meal.chosenOption!,
      ...meal.options,
    ];
    for (final option in options) {
      for (final item in option.items) {
        final recipeId = item.recipeId;
        if (recipeId == null) continue;
        return RecipeContextItem(
          kind: RecipeContextKind.planned,
          kicker: 'No seu plano',
          title: item.name,
          body: 'Combinado para ${meal.name.toLowerCase()}.',
          hero: 'teal',
          route: '/recipe/$recipeId',
          recipeId: recipeId,
        );
      }
    }
  }
  return null;
}
