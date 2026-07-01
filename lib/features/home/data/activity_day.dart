// ─────────────────────────────────────────────────────────────────────────────
// lib/features/home/data/activity_day.dart
// O QUÊ:     Modelo de uma célula do gráfico de atividade (um dia estilo GitHub).
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: home_seed, home_repository, home_providers e o ActivityGraph do Perfil.
// SPEC:      specs/features/home.yaml (models.ActivityDay)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma célula (dia) do gráfico de atividade da cozinha. Classe pura imutável.
/// A posição na grade vem de weekIndex (coluna) e dayIndex (linha 0..6). A cor
/// deriva de kind e a opacidade de intensity (0 = vazio, 4 = cheio).
/// Usada por: ActivityGraph (via activityProvider) para pintar cada quadradinho.
class ActivityDay {
  final int weekIndex; // coluna: 0 = semana mais antiga
  final int dayIndex; // linha: 0..6 (dia da semana)
  final int intensity; // 0..4 — quantidade de registros no dia (teto 4)
  final String kind; // categoria dominante: 'receitas' | 'caderno' | 'cozinha'

  const ActivityDay({
    required this.weekIndex,
    required this.dayIndex,
    required this.intensity,
    required this.kind,
  });
}
