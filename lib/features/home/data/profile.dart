// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/data/profile.dart
// O QUÊ:     Modelo do perfil pessoal (sequência, estatísticas e resumo da cozinha).
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: home_seed, home_repository, home_providers e a tela de Perfil.
// SPEC:      specs/features/home.yaml (models.Profile)
// ─────────────────────────────────────────────────────────────────────────────

/// Dados do perfil do usuário (single-user hoje). Classe pura imutável.
/// Reúne identidade (nome/inicial/bio), contadores e o resumo "Sua cozinha
/// ultimamente" (cozinha, tipo de prato, técnica em alta, prato mais feito).
/// Usada por: ProfileScreen (via profileProvider) para montar cabeçalho e resumo.
class Profile {
  final String name; // "Luca Naasser"
  final String initial; // inicial do avatar, ex.: "L"
  final int streak; // sequência de dias cozinhando
  final int recipesCount; // total de receitas
  final int notebookCount; // itens no caderno
  final int cooksCount; // preparos registrados
  final String bio; // frase curta do perfil
  final String cuisine; // cozinha predominante, ex.: "Brasileira"
  final String dishType; // tipo de prato mais comum, ex.: "Prato principal"
  final String topTechnique; // técnica em alta, ex.: "selar"
  final String mostCooked; // prato mais feito, ex.: "Frango xadrez · 4×"

  const Profile({
    required this.name,
    required this.initial,
    required this.streak,
    required this.recipesCount,
    required this.notebookCount,
    required this.cooksCount,
    required this.bio,
    required this.cuisine,
    required this.dishType,
    required this.topTechnique,
    required this.mostCooked,
  });
}
