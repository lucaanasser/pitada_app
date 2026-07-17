// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/technique_providers.dart
// O QUÊ:     Providers das técnicas: lista, busca por id e criação/edição
//            (com invalidação das telas que as mostram).
// USA:       technique_repository (seed default; main.dart troca p/ Supabase),
//            technique.dart, riverpod.
// USADO POR: technique_detail_screen, autocomplete da edição de passo.
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/technique.dart';
import '../data/repositories/technique/seed_technique_repository.dart';
import '../data/repositories/technique/technique_repository.dart';

/// Repositório de técnicas em uso (seed no preview; Supabase via override no
/// main.dart). Usada por: providers abaixo.
final techniquesRepositoryProvider = Provider<TechniquesRepository>(
  (ref) => const SeedTechniquesRepository(),
);

/// Todas as técnicas do usuário (ordem alfabética). Usada por: autocomplete
/// da edição de passo.
final techniquesProvider = FutureProvider<List<Technique>>(
  (ref) => ref.watch(techniquesRepositoryProvider).fetchTechniques(),
);

/// Uma técnica por id (ou null). Usada por: TechniqueDetailScreen, StepTile.
final techniqueByIdProvider = FutureProvider.family<Technique?, String>(
  (ref, id) => ref.watch(techniquesRepositoryProvider).fetchById(id),
);

/// Ações de escrita sobre técnicas, invalidando os providers de leitura.
/// Usada por: página de técnica (editar noção) e autocomplete (criar).
class TechniqueEditController {
  const TechniqueEditController(this._ref);

  final Ref _ref;

  /// Cria (ou reusa pelo slug) e devolve o id. Usada por: autocomplete.
  Future<String> create(Technique technique) async {
    final id = await _ref
        .read(techniquesRepositoryProvider)
        .createTechnique(technique);
    _invalidate();
    return id;
  }

  /// Salva nome/noção editados. Usada por: página de técnica.
  Future<void> update(Technique technique) async {
    await _ref.read(techniquesRepositoryProvider).updateTechnique(technique);
    _invalidate();
  }

  /// Recarrega lista e detalhes após uma escrita. Usada por: [create]/[update].
  void _invalidate() {
    _ref.invalidate(techniquesProvider);
    _ref.invalidate(techniqueByIdProvider);
  }
}

/// Injeta o controller de escrita. Usada por: página de técnica e autocomplete.
final techniqueEditControllerProvider =
    Provider((ref) => TechniqueEditController(ref));
