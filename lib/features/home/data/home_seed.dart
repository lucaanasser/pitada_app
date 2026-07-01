// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/data/home_seed.dart
// O QUÊ:     Dados de exemplo de Home+Perfil (perfil do Luca, atividade e feed).
// USA:       profile.dart, activity_day.dart, community_post.dart.
// USADO POR: home_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/home.yaml (seed: home_seed.dart)
// ─────────────────────────────────────────────────────────────────────────────
import 'activity_day.dart';
import 'community_post.dart';
import 'profile.dart';

/// Quantas semanas o gráfico de atividade cobre (~1 semestre). Usada por: buildSeedActivity.
const int kActivityWeeks = 22;

/// Categorias possíveis de um dia, na ordem usada pelo gerador determinístico.
/// Usada por: buildSeedActivity (rotação por índice).
const List<String> _kActivityKinds = ['receitas', 'caderno', 'cozinha'];

/// Perfil de exemplo (Luca Naasser). Usada por: home_repository.fetchProfile.
const Profile kSeedProfile = Profile(
  name: 'Luca Naasser',
  initial: 'L',
  streak: 12,
  recipesCount: 23,
  notebookCount: 41,
  cooksCount: 128,
  bio: 'Perseguindo o frango xadrez definitivo.',
  cuisine: 'Brasileira',
  dishType: 'Prato principal',
  topTechnique: 'selar',
  mostCooked: 'Frango xadrez · 4×',
);

/// Feed de exemplo (5 posts de amigos). Usada por: home_repository.fetchFeed.
const List<CommunityPost> kSeedFeed = <CommunityPost>[
  CommunityPost(
    id: 'post-marina-frango',
    author: 'Marina',
    authorInitial: 'M',
    kind: 'receita',
    title: 'Frango xadrez',
    subtitle: '25 min · 512 kcal · Intermediário',
    heroColor: 'terra',
  ),
  CommunityPost(
    id: 'post-rafael-selar',
    author: 'Rafael',
    authorInitial: 'R',
    kind: 'técnica',
    title: 'Selar a carne sem cozinhar no vapor',
    subtitle: 'Técnica · 6 min de leitura',
    heroColor: 'clay',
  ),
  CommunityPost(
    id: 'post-bea-mise',
    author: 'Beatriz',
    authorInitial: 'B',
    kind: 'framework',
    title: 'Mise en place para jantares rápidos',
    subtitle: 'Framework · 5 passos',
    heroColor: 'moss',
  ),
  CommunityPost(
    id: 'post-tiago-fermento',
    author: 'Tiago',
    authorInitial: 'T',
    kind: 'log',
    title: 'Fermentação natural — dia 4',
    subtitle: 'Log · levain borbulhando',
    heroColor: 'ochre',
  ),
  CommunityPost(
    id: 'post-livia-nota',
    author: 'Lívia',
    authorInitial: 'L',
    kind: 'nota',
    title: 'Salgar a berinjela antes de fritar',
    subtitle: 'Nota · do livro do Kenji',
    heroColor: 'plum',
  ),
];

/// Gera ~22 semanas de atividade de forma determinística (sem random), a partir
/// dos índices de semana/dia. O mesmo índice sempre produz a mesma célula, então
/// o preview fica estável entre execuções.
/// Usada por: home_repository.fetchActivity.
List<ActivityDay> buildSeedActivity() {
  final days = <ActivityDay>[];
  for (var week = 0; week < kActivityWeeks; week++) {
    for (var day = 0; day < 7; day++) {
      // "Semente" só a partir dos índices: mistura semana e dia para variar.
      final seed = week * 7 + day;
      // Alguns dias ficam sem registro (intensity 0) num padrão fixo,
      // dando o aspecto esparso do gráfico estilo GitHub.
      final isRest = (seed * 3 + week) % 5 == 0;
      final intensity = isRest ? 0 : 1 + (seed * 7 + day * 3) % 4; // 1..4
      final kind = _kActivityKinds[seed % _kActivityKinds.length];
      days.add(
        ActivityDay(
          weekIndex: week,
          dayIndex: day,
          intensity: intensity,
          kind: kind,
        ),
      );
    }
  }
  return days;
}
