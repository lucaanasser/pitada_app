// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/application/providers.dart
// O QUÊ:     Providers Riverpod do Caderno (fichas, notas, diário, versões, logs, repertório).
// USA:       learning_repository e os modelos do Caderno, riverpod.
// USADO POR: as telas do Caderno (camada de apresentação).
// SPEC:      specs/features/notebook.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/diary_entry.dart';
import '../data/repository.dart';
import '../data/lesson.dart';
import '../data/process_log.dart';
import '../data/recipe_version.dart';
import '../data/repertoire.dart';
import '../data/source_note.dart';

/// Instância do repositório do Caderno. Usada por: os providers abaixo.
final notebookRepositoryProvider =
    Provider<NotebookRepository>((ref) => const NotebookRepository());

/// Todas as fichas (técnicas, frameworks, guias). Usada por: LessonCardsScreen.
final lessonsProvider = FutureProvider<List<Lesson>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchLessons();
});

/// Uma ficha por id, para o detalhe. Usada por: LessonDetailScreen.
final lessonByIdProvider = FutureProvider.family<Lesson?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).lessonById(id);
});

/// Índice da aba/categoria de ficha selecionada (0 = Técnicas). Usada por: abas das Fichas.
final selectedLessonCategoryProvider = StateProvider<int>((ref) => 0);

/// Todas as notas de fonte. Usada por: NotesScreen.
final notesProvider = FutureProvider<List<SourceNote>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchNotes();
});

/// Uma nota por id, para o detalhe. Usada por: NoteDetailScreen.
final noteByIdProvider = FutureProvider.family<SourceNote?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).noteById(id);
});

/// Todas as entradas do diário. Usada por: DiaryScreen.
final diaryProvider = FutureProvider<List<DiaryEntry>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchDiary();
});

/// Uma entrada de diário por id, para o detalhe. Usada por: DiaryEntryScreen.
final diaryByIdProvider = FutureProvider.family<DiaryEntry?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).diaryById(id);
});

/// Todos os históricos de versão. Usada por: VersionsScreen.
final versionsProvider = FutureProvider<List<RecipeVersion>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchVersions();
});

/// Um histórico de versão por id, para o detalhe. Usada por: VersionHistoryScreen.
final versionByIdProvider =
    FutureProvider.family<RecipeVersion?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).versionById(id);
});

/// O histórico de versões de UMA receita (por recipeId), ou null se não houver.
/// Fonte única das notas "o que mudou". Usada por: RecipeVersionSheet (feature Receitas)
/// — o seletor de versão da receita mostra a MESMA nota que o Caderno.
final versionForRecipeProvider =
    FutureProvider.family<RecipeVersion?, String>((ref, recipeId) async {
  final all = await ref.watch(versionsProvider.future);
  for (final v in all) {
    if (v.recipeId == recipeId) return v;
  }
  return null;
});

/// Todos os logs de processo. Usada por: ProcessLogsScreen.
final logsProvider = FutureProvider<List<ProcessLog>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchLogs();
});

/// Um log de processo por id, para o detalhe. Usada por: ProcessLogScreen.
final logByIdProvider = FutureProvider.family<ProcessLog?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).logById(id);
});

/// Todos os rácios de confiança. Usada por: RepertoireScreen (kind ratio).
final ratiosProvider = FutureProvider<List<Ratio>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchRatios();
});

/// Todas as substituições testadas. Usada por: RepertoireScreen (kind substitution).
final subsProvider = FutureProvider<List<Substitution>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchSubstitutions();
});

/// Todas as harmonizações. Usada por: HarmScreen.
final pairingsProvider = FutureProvider<List<Pairing>>((ref) {
  return ref.watch(notebookRepositoryProvider).fetchPairings();
});

/// Uma harmonização por id, para o detalhe. Usada por: PairingDetailScreen.
final pairingByIdProvider = FutureProvider.family<Pairing?, String>((ref, id) {
  return ref.watch(notebookRepositoryProvider).pairingById(id);
});
