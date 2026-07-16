// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/seed_framework_repository.dart
// O QUÊ:     Repositório de frameworks em MEMÓRIA (preview no PC): começa vazio
//            — o primeiro framework nasce da pessoa, não do app — e guarda o
//            que a sessão criar. Some ao recarregar; vira Supabase depois.
// USA:       framework_repository (contrato), framework.dart, core/utils/app_log.
// USADO POR: frameworksRepositoryProvider (default offline).
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/utils/app_log.dart';
import '../models/framework.dart';
import 'framework_repository.dart';

/// Implementação seed: lista mutável em memória, vazia no primeiro uso.
/// Usada por: frameworksRepositoryProvider.
class SeedFrameworksRepository implements FrameworksRepository {
  const SeedFrameworksRepository();

  /// Frameworks criados nesta sessão (em memória, some ao recarregar).
  /// Usada por: todos os métodos do repositório.
  static final List<Framework> _session = [];

  /// Lista os frameworks da sessão. Usada por: frameworksProvider.
  @override
  Future<List<Framework>> fetchFrameworks() async => List.of(_session);

  /// Busca um framework por id (ou null). Usada por: frameworkByIdProvider.
  @override
  Future<Framework?> fetchById(String id) async {
    for (final f in _session) {
      if (f.id == id) return f;
    }
    return null;
  }

  /// Cria um framework com id derivado do momento. Usada por: FrameworkEditController.
  @override
  Future<String> createFramework(Framework framework) async {
    final id = 'fw-${DateTime.now().microsecondsSinceEpoch}';
    _session.add(framework.copyWith(id: id));
    AppLog.i('recipes', 'framework criado: ${framework.name}');
    return id;
  }

  /// Substitui o framework de mesmo id. Usada por: FrameworkEditController.
  @override
  Future<void> updateFramework(Framework framework) async {
    final i = _session.indexWhere((f) => f.id == framework.id);
    if (i < 0) {
      AppLog.w('recipes', 'framework não encontrado: ${framework.id}');
      return;
    }
    _session[i] = framework;
    AppLog.i('recipes', 'framework atualizado: ${framework.name}');
  }

  /// Remove o framework por id. Usada por: FrameworkEditController.
  @override
  Future<void> deleteFramework(String id) async {
    _session.removeWhere((f) => f.id == id);
    AppLog.i('recipes', 'framework removido: $id');
  }
}
