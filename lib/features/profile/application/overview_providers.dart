// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/application/overview_providers.dart
// O QUÊ:     Agregadores cross-feature do Perfil: atividade derivada do fio
//            real (ActivityDay), números reais (ProfileCounts) e o radar de
//            pendências acionáveis (RadarItem). O Perfil é um agregador de
//            propósito — a UI dele só lê providers desta feature.
// USA:       caderno_providers (fio, cozinha pendente), learning_providers
//            (diário), recipes_providers (receitas), shopping_providers
//            (despensa), activity_builder, activity_entry, profile_counts,
//            radar_item, fio_entry (modelo), riverpod.
// USADO POR: ProfileHeader, ProfileStats, ActivityGraph e KitchenRadar.
// SPEC:      specs/features/profile.yaml (application.providers — agregadores)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../notebook/application/hub_providers.dart';
import '../../notebook/application/providers.dart';
import '../../notebook/data/fio_entry.dart';
import '../../recipes/application/recipes_providers.dart';
import '../../groceries/application/providers.dart';
import '../data/activity_builder.dart';
import '../data/activity_day.dart';
import '../data/activity_entry.dart';
import '../data/profile_counts.dart';
import '../data/radar_item.dart';

/// Rótulo pt-BR de um tipo de captura do fio. Usada por: [activityProvider].
String _fioLabel(FioKind kind) => switch (kind) {
      FioKind.diary => 'Diário',
      FioKind.note => 'Nota',
      FioKind.version => 'Versão',
      FioKind.log => 'Log',
    };

/// Atividade da cozinha (22 semanas) derivada do fio REAL do Caderno: agrupa
/// os registros por dia e completa o passado pré-registro com o padrão de
/// exemplo. Fonte do gráfico, do streak e do drill-down por dia.
/// Usada por: ActivityGraph, ActivityGrid e ProfileHeader.
final activityProvider = Provider<List<ActivityDay>>((ref) {
  final byDate = <DateTime, List<ActivityEntry>>{};
  for (final e in ref.watch(fioProvider)) {
    final day = DateTime(e.date.year, e.date.month, e.date.day);
    byDate.putIfAbsent(day, () => []).add(
          ActivityEntry(
            label: _fioLabel(e.kind),
            title: e.title,
            route: e.route,
          ),
        );
  }
  return buildActivityDays(DateTime.now(), byDate);
});

/// Números reais do perfil, um por feature dona do dado: receitas salvas,
/// capturas no caderno (diário+notas+versões+logs) e preparos no diário.
/// Enquanto as fontes carregam, os contadores valem 0. Usada por: ProfileStats.
final profileCountsProvider = Provider<ProfileCounts>((ref) {
  return ProfileCounts(
    recipes: (ref.watch(recipesProvider).valueOrNull ?? const []).length,
    captures: ref.watch(fioProvider).length,
    cooks: (ref.watch(diaryProvider).valueOrNull ?? const []).length,
  );
});

/// Pendências acionáveis do radar, em ordem: cozinha sem registro no diário ->
/// itens vencendo em ≤5 dias (mesmo limiar da ExpiryTag, mais urgente
/// primeiro) -> itens acabando -> refazer pendente (label "Refazer" há >5
/// dias). Máx. 5 (usabilidade > completude). Usada por: KitchenRadar.
final kitchenRadarProvider = Provider<List<RadarItem>>((ref) {
  final items = <RadarItem>[];

  final cook = ref.watch(pendingCookProvider).valueOrNull;
  if (cook != null) {
    items.add(
      RadarItem(
        kind: RadarKind.cook,
        title: cook.recipeName,
        detail: 'cozinha sem registro no diário',
        route: '/learning',
      ),
    );
  }

  final pantry = ref.watch(pantryProvider).valueOrNull ?? const [];
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final expiring = pantry
      .where(
        (p) =>
            p.expiresOn != null && p.expiresOn!.difference(today).inDays <= 5,
      )
      .toList()
    ..sort((a, b) => a.expiresOn!.compareTo(b.expiresOn!));
  for (final p in expiring) {
    items.add(
      RadarItem(
        kind: RadarKind.expiry,
        title: p.name,
        expiresOn: p.expiresOn,
        route: '/shopping',
      ),
    );
  }

  for (final p in pantry.where((p) => p.low && !expiring.contains(p))) {
    items.add(
      RadarItem(kind: RadarKind.low, title: p.name, route: '/shopping'),
    );
  }

  final diary = ref.watch(diaryProvider).valueOrNull ?? [];
  for (final d in diary) {
    final days = now.difference(d.date).inDays;
    if (d.label == 'Refazer' && days > 5) {
      items.add(
        RadarItem(
          kind: RadarKind.redo,
          title: d.recipeName,
          detail: 'marcado para refazer há $days dias',
          route: d.recipeIds.isEmpty
              ? '/diary/${d.id}'
              : '/recipe/${d.recipeIds.first}',
          push: true,
        ),
      );
      break;
    }
  }

  return items.take(5).toList();
});
