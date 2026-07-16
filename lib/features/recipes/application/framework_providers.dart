// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/framework_providers.dart
// O QUÊ:     Providers Riverpod dos frameworks (lista, por id, por receita) e o
//            controller de criação/edição. Inclui o índice da tab da aba
//            Receitas (Receitas | Frameworks).
// USA:       framework_repository (contrato), seed_framework_repository
//            (default offline), framework.dart, riverpod.
// USADO POR: recipes_screen, FrameworksTabView, FrameworkDetailScreen,
//            FrameworkCreateScreen, recipe_detail_body (ponte).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/framework.dart';
import '../data/repositories/framework_repository.dart';
import '../data/repositories/seed_framework_repository.dart';

/// Instância do repositório de frameworks. Default = seed em memória;
/// main.dart sobrescreve com a versão Supabase quando ela existir.
/// Usada por: os providers abaixo.
final frameworksRepositoryProvider =
    Provider<FrameworksRepository>((ref) => const SeedFrameworksRepository());

/// Tab ativa da aba Receitas: 0 = Receitas, 1 = Frameworks.
/// Usada por: recipes_screen.
final recipesTabIndexProvider = StateProvider<int>((ref) => 0);

/// Todos os frameworks do usuário. Usada por: FrameworksTabView.
final frameworksProvider = FutureProvider<List<Framework>>((ref) {
  return ref.watch(frameworksRepositoryProvider).fetchFrameworks();
});

/// Um framework por id, para o detalhe. Usada por: FrameworkDetailScreen.
final frameworkByIdProvider =
    FutureProvider.family<Framework?, String>((ref, id) {
  return ref.watch(frameworksRepositoryProvider).fetchById(id);
});

/// Frameworks dos quais uma receita é instância — a ponte "faz parte de".
/// Usada por: recipe_detail_body.
final frameworksForRecipeProvider =
    Provider.family<List<Framework>, String>((ref, recipeId) {
  final all = ref.watch(frameworksProvider).valueOrNull ?? const <Framework>[];
  return [
    for (final f in all)
      if (f.recipeIds.contains(recipeId)) f,
  ];
});

/// Controller de escrita: cria/atualiza/apaga e refaz os providers dependentes.
/// Presentation nunca fala com o repositório direto — passa por aqui.
/// Usada por: frameworkEditControllerProvider.
class FrameworkEditController {
  const FrameworkEditController(this._ref);

  final Ref _ref;

  /// Cria um framework novo e refaz a lista. Devolve o id gerado.
  /// Usada por: FrameworkCreateScreen.
  Future<String> create(Framework framework) async {
    final id =
        await _ref.read(frameworksRepositoryProvider).createFramework(framework);
    _ref.invalidate(frameworksProvider);
    return id;
  }

  /// Persiste o framework editado e refaz lista + detalhe.
  /// Usada por: edição futura do detalhe.
  Future<void> update(Framework framework) async {
    await _ref.read(frameworksRepositoryProvider).updateFramework(framework);
    _ref.invalidate(frameworksProvider);
    _ref.invalidate(frameworkByIdProvider(framework.id));
  }

  /// Apaga o framework e refaz a lista. Usada por: edição futura do detalhe.
  Future<void> delete(String id) async {
    await _ref.read(frameworksRepositoryProvider).deleteFramework(id);
    _ref.invalidate(frameworksProvider);
  }
}

/// Instância do controller de frameworks. Usada por: FrameworkCreateScreen.
final frameworkEditControllerProvider =
    Provider<FrameworkEditController>(FrameworkEditController.new);
