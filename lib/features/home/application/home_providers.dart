// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/application/home_providers.dart
// O QUÊ:     Providers Riverpod da feature Home (perfil, atividade e feed).
// USA:       home_repository, profile.dart, activity_day.dart, community_post.dart,
//            riverpod.
// USADO POR: home_screen e profile_screen (camada de apresentação).
// SPEC:      specs/features/home.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/activity_day.dart';
import '../data/community_post.dart';
import '../data/home_repository.dart';
import '../data/profile.dart';

/// Instância do repositório de Home. Usada por: os providers abaixo.
final homeRepositoryProvider =
    Provider<HomeRepository>((ref) => const HomeRepository());

/// Perfil do usuário (identidade, contadores e resumo). Usada por: ProfileScreen.
final profileProvider = FutureProvider<Profile>((ref) {
  return ref.watch(homeRepositoryProvider).fetchProfile();
});

/// Atividade da cozinha (~22 semanas de células). Usada por: ActivityGraph no Perfil.
final activityProvider = FutureProvider<List<ActivityDay>>((ref) {
  return ref.watch(homeRepositoryProvider).fetchActivity();
});

/// Feed da comunidade (posts de amigos). Usada por: HomeScreen (lista de posts).
final feedProvider = FutureProvider<List<CommunityPost>>((ref) {
  return ref.watch(homeRepositoryProvider).fetchFeed();
});
