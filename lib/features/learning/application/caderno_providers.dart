// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/application/caderno_providers.dart
// O QUÊ:     Providers do HUB do Caderno: fio cronológico unificado, cards de
//            reativação ("Para hoje") e cozinha pendente de registro.
// USA:       learning_providers (fontes), modelos fio_entry/reactivation_item/
//            pending_cook, riverpod.
// USADO POR: LearningScreen e widgets do hub (CaptureBar, ReactivationCard, Fio).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fio_entry.dart';
import '../data/pending_cook.dart';
import '../data/reactivation_item.dart';
import 'learning_providers.dart';

/// Cozinha ainda sem registro no diário. Usada por: reactivationItemsProvider.
final pendingCookProvider = FutureProvider<PendingCook?>((ref) {
  return ref.watch(learningRepositoryProvider).fetchPendingCook();
});

/// Ids de reativação dispensados ("depois") nesta sessão. Usada por: hub.
final dismissedReactivationsProvider =
    StateProvider<Set<String>>((ref) => const {});

/// Fio expandido (mostrar tudo) ou resumido (5 itens). Usada por: LearningScreen.
final fioExpandedProvider = StateProvider<bool>((ref) => false);

/// O fio do Caderno: diário + notas + versões + logs, do mais recente ao mais
/// antigo. Usada por: LearningScreen (seção "O fio").
final fioProvider = Provider<List<FioEntry>>((ref) {
  final entries = <FioEntry>[
    for (final d in ref.watch(diaryProvider).valueOrNull ?? [])
      FioEntry(
        id: d.id,
        kind: FioKind.diary,
        date: d.date,
        title: d.recipeName,
        excerpt: d.body,
        route: '/diary/${d.id}',
        tag: d.label.isEmpty ? null : d.label,
      ),
    for (final n in ref.watch(notesProvider).valueOrNull ?? [])
      if (n.date != null)
        FioEntry(
          id: n.id,
          kind: FioKind.note,
          date: n.date!,
          title: n.title,
          excerpt: n.takeaways.isEmpty ? n.meta : n.takeaways.first,
          route: '/note/${n.id}',
        ),
    for (final v in ref.watch(versionsProvider).valueOrNull ?? [])
      if (v.date != null && v.timeline.isNotEmpty)
        FioEntry(
          id: v.id,
          kind: FioKind.version,
          date: v.date!,
          title: v.recipeName,
          excerpt: v.timeline.last.change,
          route: '/versions/${v.id}',
          tag: v.timeline.last.label,
        ),
    for (final l in ref.watch(logsProvider).valueOrNull ?? [])
      FioEntry(
        id: l.id,
        kind: FioKind.log,
        date: l.date,
        title: l.title,
        excerpt: l.note.isEmpty ? l.type : l.note,
        route: '/log/${l.id}',
      ),
  ];
  entries.sort((a, b) => b.date.compareTo(a.date));
  return entries;
});

/// Cards de reativação do dia (máx. 2, disciplina anti-ruído): cozinha
/// pendente > refazer esquecido > revisão do dia. Usada por: LearningScreen.
final reactivationItemsProvider = Provider<List<ReactivationItem>>((ref) {
  final dismissed = ref.watch(dismissedReactivationsProvider);
  final items = <ReactivationItem>[];

  // 1. Cozinha sem registro — a captura de 20 segundos, empurrada.
  final cook = ref.watch(pendingCookProvider).valueOrNull;
  if (cook != null) {
    final days = DateTime.now().difference(cook.when).inDays;
    items.add(
      ReactivationItem(
        id: 'cook:${cook.recipeId}',
        kind: ReactivationKind.cook,
        kicker: days <= 1 ? 'Ontem você cozinhou' : 'Você cozinhou',
        title: cook.recipeName,
        body: 'Registrar as três perguntas leva 20 segundos.',
        hero: 'moss',
        actionLabel: 'Registrar agora',
      ),
    );
  }

  // 2. "Refazer" marcado e esquecido há mais de 5 dias — fecha o loop do diário.
  final diary = ref.watch(diaryProvider).valueOrNull ?? [];
  for (final d in diary) {
    final days = DateTime.now().difference(d.date).inDays;
    if (d.label == 'Refazer' && days > 5) {
      items.add(
        ReactivationItem(
          id: 'redo:${d.id}',
          kind: ReactivationKind.redo,
          kicker: 'Refazer pendente',
          title: d.recipeName,
          body: 'Você carimbou "refazer" há $days dias — bora?',
          hero: 'ochre',
          actionLabel: d.recipeIds.isEmpty ? 'Ver entrada' : 'Abrir receita',
          actionRoute: d.recipeIds.isEmpty
              ? '/diary/${d.id}'
              : '/recipe/${d.recipeIds.first}',
        ),
      );
      break; // um por dia basta
    }
  }

  // 3. Revisão do dia: uma ficha rotativa (estilo Readwise, determinística).
  final lessons = ref.watch(lessonsProvider).valueOrNull ?? [];
  if (lessons.isNotEmpty) {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    final i = dayOfYear % lessons.length;
    final lesson = lessons[i];
    items.add(
      ReactivationItem(
        id: 'review:${lesson.id}',
        kind: ReactivationKind.review,
        kicker: 'Revisão do dia',
        title: lesson.title,
        body: lesson.summary,
        hero: 'clay',
        actionLabel: 'Abrir ficha',
        actionRoute: '/lesson/${lesson.id}',
        trailing: '№ ${i + 1}/${lessons.length}',
      ),
    );
  }

  return items.where((i) => !dismissed.contains(i.id)).take(2).toList();
});
