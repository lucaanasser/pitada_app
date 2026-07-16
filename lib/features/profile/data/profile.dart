// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/profile.dart
// O QUÊ:     Modelo do perfil pessoal — identidade mínima (nome + inicial).
//            Números e resumos saíram: hoje são derivados de dados reais.
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: profile_seed, profile_repository, profile_providers e ProfileHeader.
// SPEC:      specs/features/profile.yaml (models.Profile)
// ─────────────────────────────────────────────────────────────────────────────

/// Identidade do usuário (single-user hoje). Classe pura imutável.
/// Estatísticas NÃO moram aqui: os números do perfil vêm de ProfileCounts
/// (agregados reais) e a sequência vem de ActivityStats (derivada da atividade).
/// Usada por: ProfileScreen/ProfileHeader (via profileProvider).
class Profile {
  final String name;
  final String initial;

  const Profile({required this.name, required this.initial});
}
