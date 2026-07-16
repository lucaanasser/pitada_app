// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/framework_repository.dart
// O QUÊ:     Contrato do repositório de frameworks (listar, buscar, criar,
//            atualizar, apagar). Impl atual: seed em memória; Supabase depois.
// USA:       framework.dart (modelo).
// USADO POR: framework_providers (application) via frameworksRepositoryProvider.
// ─────────────────────────────────────────────────────────────────────────────
import '../models/framework.dart';

/// Contrato de acesso aos frameworks do usuário. Usada por: framework_providers.
abstract class FrameworksRepository {
  /// Lista todos os frameworks. Usada por: frameworksProvider.
  Future<List<Framework>> fetchFrameworks();

  /// Busca um framework por id (ou null). Usada por: frameworkByIdProvider.
  Future<Framework?> fetchById(String id);

  /// Cria um framework novo e devolve o id gerado. Usada por: FrameworkEditController.
  Future<String> createFramework(Framework framework);

  /// Atualiza um framework existente. Usada por: FrameworkEditController.
  Future<void> updateFramework(Framework framework);

  /// Apaga um framework. Usada por: FrameworkEditController.
  Future<void> deleteFramework(String id);
}
