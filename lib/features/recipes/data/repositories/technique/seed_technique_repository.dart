// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/technique/seed_technique_repository.dart
// O QUÊ:     Repositório de técnicas em MEMÓRIA (preview no PC): parte do
//            technique_seed e guarda o que a sessão criar; some ao recarregar.
// USA:       technique_repository (contrato), technique.dart, technique_seed,
//            core/utils (app_log, slug).
// USADO POR: techniquesRepositoryProvider (default offline).
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/slug.dart';
import '../../models/technique.dart';
import '../../seed/technique_seed.dart';
import 'technique_repository.dart';

/// Implementação seed: lista mutável em memória, semeada com kSeedTechniques.
/// Usada por: techniquesRepositoryProvider.
class SeedTechniquesRepository implements TechniquesRepository {
  const SeedTechniquesRepository();

  /// Técnicas da sessão: seed + criadas (some ao recarregar).
  /// Usada por: todos os métodos do repositório.
  static final List<Technique> _session = [...kSeedTechniques];

  /// Lista as técnicas em ordem alfabética. Usada por: techniquesProvider.
  @override
  Future<List<Technique>> fetchTechniques() async =>
      List.of(_session)..sort((a, b) => a.name.compareTo(b.name));

  /// Busca por id (ou null). Usada por: techniqueByIdProvider.
  @override
  Future<Technique?> fetchById(String id) async {
    for (final t in _session) {
      if (t.id == id) return t;
    }
    return null;
  }

  /// Cria deduplicando pelo slug: técnica já existente devolve o id dela.
  /// Usada por: autocomplete da edição de passo.
  @override
  Future<String> createTechnique(Technique technique) async {
    final slug = slugify(technique.name);
    for (final t in _session) {
      if (t.slug == slug) return t.id;
    }
    final created = technique.copyWith(id: 'tq-$slug', slug: slug);
    _session.add(created);
    AppLog.i('recipes', 'técnica criada: ${created.name}');
    return created.id;
  }

  /// Substitui a técnica de mesmo id. Usada por: página de técnica.
  @override
  Future<void> updateTechnique(Technique technique) async {
    final i = _session.indexWhere((t) => t.id == technique.id);
    if (i < 0) {
      AppLog.w('recipes', 'técnica não encontrada: ${technique.id}');
      return;
    }
    _session[i] = technique;
    AppLog.i('recipes', 'técnica atualizada: ${technique.name}');
  }
}
