// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/data/community_post.dart
// O QUÊ:     Modelo de um post do feed da comunidade (item compartilhado por amigo).
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: home_seed, home_repository, home_providers e o FeedPostCard da Home.
// SPEC:      specs/features/home.yaml (models.CommunityPost)
// ─────────────────────────────────────────────────────────────────────────────

/// Um post do feed da comunidade. Classe pura imutável.
/// Representa algo que um amigo publicou (receita, técnica, framework, log ou
/// nota). heroColor é um nome de AppColors.hero para a miniatura/avatar.
/// Usada por: FeedPostCard (via feedProvider) na aba Home.
class CommunityPost {
  final String id;
  final String author; // nome de quem publicou, ex.: "Marina"
  final String authorInitial; // inicial do avatar do autor
  final String
      kind; // tipo: 'receita' | 'técnica' | 'framework' | 'log' | 'nota'
  final String title; // título do item compartilhado
  final String subtitle; // meta/subtítulo, ex.: "25 min · 512 kcal"
  final String heroColor; // nome em AppColors.hero (cor da miniatura)

  const CommunityPost({
    required this.id,
    required this.author,
    required this.authorInitial,
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.heroColor,
  });
}
