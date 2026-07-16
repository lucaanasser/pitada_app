// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/profile_counts.dart
// O QUÊ:     Modelo dos números REAIS do perfil, agregados das outras features
//            (receitas, capturas no caderno, preparos no diário).
// USA:       nada (classe pura imutável, sem dependências).
// USADO POR: overview_providers (monta) e ProfileStats (exibe os tiles).
// SPEC:      specs/features/profile.yaml (models.ProfileCounts)
// ─────────────────────────────────────────────────────────────────────────────

/// Contadores reais exibidos nos tiles do perfil. Classe pura imutável.
/// Cada número vem do provider da feature dona do dado — nada de seed estático.
/// Usada por: ProfileStats (via profileCountsProvider).
class ProfileCounts {
  final int recipes;
  final int
      captures;
  final int cooks;

  const ProfileCounts({
    required this.recipes,
    required this.captures,
    required this.cooks,
  });
}
