// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/data/home_repository.dart
// O QUÊ:     Fonte de dados de Home+Perfil. Hoje em memória (seed); depois, Supabase.
// USA:       profile.dart, activity_day.dart, community_post.dart, home_seed.dart,
//            core/utils/app_log.
// USADO POR: home_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/home.yaml (repository: HomeRepository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/utils/app_log.dart';
import 'activity_day.dart';
import 'community_post.dart';
import 'home_seed.dart';
import 'profile.dart';

/// Repositório de Home+Perfil. Implementação atual serve os dados de exemplo.
/// Usada por: home_providers. Trocar por versão Supabase mantém a mesma API.
class HomeRepository {
  const HomeRepository();

  /// Carrega o perfil do usuário. Usada por: profileProvider.
  Future<Profile> fetchProfile() async {
    AppLog.d('home', 'carregando perfil (seed)');
    return kSeedProfile;
  }

  /// Carrega as ~22 semanas de atividade da cozinha. Usada por: activityProvider.
  Future<List<ActivityDay>> fetchActivity() async {
    AppLog.d('home', 'gerando atividade (seed determinístico)');
    return buildSeedActivity();
  }

  /// Carrega o feed da comunidade. Usada por: feedProvider.
  Future<List<CommunityPost>> fetchFeed() async {
    AppLog.d('home', 'carregando feed da comunidade (seed)');
    return kSeedFeed;
  }
}
