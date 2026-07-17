// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/technique/supabase_technique_repository.dart
// O QUÊ:     Implementação ONLINE do TechniquesRepository (Postgres via PostgREST).
// USA:       technique_repository (contrato), technique.dart, core/supabase,
//            core/utils (app_log, slug).
// USADO POR: main.dart (override do techniquesRepositoryProvider quando online).
// SPEC:      specs/backend/database.yaml (0015_techniques.sql)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/supabase/supabase.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/slug.dart';
import '../../models/technique.dart';
import 'technique_repository.dart';

/// Repositório online. A RLS garante que só as técnicas do usuário chegam aqui.
/// Usada por: main.dart (override).
class SupabaseTechniquesRepository implements TechniquesRepository {
  const SupabaseTechniquesRepository();

  SupabaseClient get _db => SupabaseService.client;

  /// Lista as técnicas em ordem alfabética. Usada por: techniquesProvider.
  @override
  Future<List<Technique>> fetchTechniques() async {
    final rows = await _db.from('techniques').select().order('name');
    return rows.map(Technique.fromJson).toList();
  }

  /// Busca por id (ou null). Usada por: techniqueByIdProvider.
  @override
  Future<Technique?> fetchById(String id) async {
    try {
      final row =
          await _db.from('techniques').select().eq('id', id).maybeSingle();
      return row == null ? null : Technique.fromJson(row);
    } on PostgrestException catch (e) {
      AppLog.w('recipes', 'fetchById($id) de técnica falhou: ${e.code}');
      return null;
    }
  }

  /// Cria deduplicando pelo slug (upsert em user_id+slug) e devolve o id.
  /// Antes de criar, consulta technique_aliases: 'dourar a carne' vira 'selar'.
  /// Usada por: autocomplete da edição de passo e importação (Gemini).
  @override
  Future<String> createTechnique(Technique technique) async {
    final slug = await _canonicalSlug(slugify(technique.name));
    final row = await _db
        .from('techniques')
        .upsert(
          {'slug': slug, 'name': technique.name, 'notion': technique.notion},
          onConflict: 'user_id, slug',
          ignoreDuplicates: false,
        )
        .select('id')
        .single();
    final id = row['id'] as String;
    AppLog.i('recipes', 'técnica criada (supabase): $slug');
    return id;
  }

  /// Slug canônico via technique_aliases (o próprio [slug] se não houver alias).
  /// Usada por: [createTechnique].
  Future<String> _canonicalSlug(String slug) async {
    try {
      final row = await _db
          .from('technique_aliases')
          .select('canonical')
          .eq('term', slug)
          .maybeSingle();
      return (row?['canonical'] as String?) ?? slug;
    } on PostgrestException {
      return slug;
    }
  }

  /// Substitui a técnica de mesmo id. Usada por: página de técnica.
  @override
  Future<void> updateTechnique(Technique technique) async {
    await _db.from('techniques').update({
      'name': technique.name,
      'notion': technique.notion,
    }).eq('id', technique.id);
    AppLog.i('recipes', 'técnica atualizada (supabase): ${technique.slug}');
  }
}
