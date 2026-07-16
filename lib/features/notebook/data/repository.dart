// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/repository.dart
// O QUÊ:     Fonte do Caderno (fichas, notas, diário, versões, logs, repertório).
// USA:       modelos do Caderno, seed.dart, core/utils/app_log.
// USADO POR: learning_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/notebook.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'diary_entry.dart';
import 'seed.dart';
import 'lesson.dart';
import 'pending_cook.dart';
import 'process_log.dart';
import 'recipe_version.dart';
import 'repertoire.dart';
import 'source_note.dart';

/// Repositório do Caderno. Hoje serve os dados de exemplo (seed); trocar por
/// versão Supabase mantém a mesma API. Usada por: learning_providers.
class NotebookRepository {
  const NotebookRepository();

  /// Lista todas as fichas (técnicas, frameworks, guias). Usada por: lessonsProvider.
  Future<List<Lesson>> fetchLessons() async {
    AppLog.d('notebook', 'carregando fichas (seed)');
    return kSeedLessons;
  }

  /// Busca uma ficha por id (ou null). Usada por: lessonByIdProvider.
  Future<Lesson?> lessonById(String id) async {
    final found = _firstOrNull(kSeedLessons, (l) => l.id == id);
    if (found == null) AppLog.w('notebook', 'ficha não encontrada: $id');
    return found;
  }

  /// Lista as notas de fonte. Usada por: notesProvider.
  Future<List<SourceNote>> fetchNotes() async => kSeedNotes;

  /// Busca uma nota por id (ou null). Usada por: noteByIdProvider.
  Future<SourceNote?> noteById(String id) async =>
      _firstOrNull(kSeedNotes, (n) => n.id == id);

  /// Lista as entradas do diário. Usada por: diaryProvider.
  Future<List<DiaryEntry>> fetchDiary() async => kSeedDiary;

  /// Busca uma entrada de diário por id (ou null). Usada por: diaryByIdProvider.
  Future<DiaryEntry?> diaryById(String id) async =>
      _firstOrNull(kSeedDiary, (d) => d.id == id);

  /// Lista os históricos de versão. Usada por: versionsProvider.
  Future<List<RecipeVersion>> fetchVersions() async => kSeedVersions;

  /// Busca um histórico de versão por id (ou null). Usada por: versionByIdProvider.
  Future<RecipeVersion?> versionById(String id) async =>
      _firstOrNull(kSeedVersions, (v) => v.id == id);

  /// Lista os logs de processo. Usada por: logsProvider.
  Future<List<ProcessLog>> fetchLogs() async => kSeedLogs;

  /// Busca um log de processo por id (ou null). Usada por: logByIdProvider.
  Future<ProcessLog?> logById(String id) async =>
      _firstOrNull(kSeedLogs, (l) => l.id == id);

  /// Lista os rácios de confiança. Usada por: ratiosProvider.
  Future<List<Ratio>> fetchRatios() async => kSeedRatios;

  /// Lista as substituições testadas. Usada por: subsProvider.
  Future<List<Substitution>> fetchSubstitutions() async => kSeedSubstitutions;

  /// Lista as harmonizações. Usada por: pairingsProvider.
  Future<List<Pairing>> fetchPairings() async => kSeedPairings;

  /// Busca uma harmonização por id (ou null). Usada por: pairingByIdProvider.
  Future<Pairing?> pairingById(String id) async =>
      _firstOrNull(kSeedPairings, (p) => p.id == id);

  /// Cozinha ainda sem registro no diário (ou null). Usada por: pendingCookProvider.
  Future<PendingCook?> fetchPendingCook() async => kSeedPendingCook;

  /// Retorna o primeiro item que casa com `test`, ou null. Usada internamente.
  T? _firstOrNull<T>(List<T> items, bool Function(T) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }
}
