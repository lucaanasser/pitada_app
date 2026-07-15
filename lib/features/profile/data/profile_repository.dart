// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/profile_repository.dart
// O QUÊ:     Fonte de dados do Perfil (identidade). Hoje em memória (seed);
//            depois, Supabase. A atividade deriva do fio (overview_providers).
// USA:       profile.dart, profile_seed.dart, core/utils/app_log.
// USADO POR: profile_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/profile.yaml (repository: ProfileRepository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'profile.dart';
import 'profile_seed.dart';

/// Repositório do Perfil. Implementação atual serve os dados de exemplo.
/// Usada por: profile_providers. Trocar por versão Supabase mantém a mesma API.
class ProfileRepository {
  const ProfileRepository();

  /// Carrega o perfil do usuário. Usada por: profileProvider.
  Future<Profile> fetchProfile() async {
    AppLog.d('profile', 'carregando perfil (seed)');
    return kSeedProfile;
  }
}
