// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/application/profile_providers.dart
// O QUÊ:     Providers Riverpod da feature Perfil (identidade e seleção no
//            gráfico). A atividade em si deriva do fio em overview_providers.
// USA:       profile_repository, profile.dart, activity_day.dart, riverpod.
// USADO POR: profile_screen, ProfileHeader, ActivityGraph/ActivityGrid.
// SPEC:      specs/features/profile.yaml (application.providers)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/activity_day.dart';
import '../data/profile.dart';
import '../data/profile_repository.dart';

/// Instância do repositório de Perfil. Usada por: profileProvider.
final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) => const ProfileRepository());

/// Perfil do usuário (identidade). Usada por: ProfileScreen.
final profileProvider = FutureProvider<Profile>((ref) {
  return ref.watch(profileRepositoryProvider).fetchProfile();
});

/// Dia tocado no gráfico de atividade (null = nenhum). O detalhe abaixo da
/// grade mostra os registros deste dia. Usada por: ActivityGrid (escreve),
/// ActivityGraph (lê).
final selectedActivityDayProvider = StateProvider<ActivityDay?>((ref) => null);
