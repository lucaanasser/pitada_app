// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/technique/technique_repository.dart
// O QUÊ:     Contrato do repositório de técnicas (entidade canônica).
// USA:       technique.dart (modelo).
// USADO POR: seed_technique_repository, supabase_technique_repository,
//            technique_providers.
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/technique.dart';

/// Contrato de acesso às técnicas do usuário. Usada por: technique_providers.
abstract class TechniquesRepository {
  /// Lista as técnicas (ordem alfabética de nome). Usada por: techniquesProvider.
  Future<List<Technique>> fetchTechniques();

  /// Busca uma técnica por id (ou null). Usada por: techniqueByIdProvider.
  Future<Technique?> fetchById(String id);

  /// Cria (ou devolve a existente de mesmo slug) e retorna o id.
  /// Usada por: autocomplete da edição de passo.
  Future<String> createTechnique(Technique technique);

  /// Substitui a técnica de mesmo id (editar nome/noção).
  /// Usada por: página de técnica.
  Future<void> updateTechnique(Technique technique);
}
