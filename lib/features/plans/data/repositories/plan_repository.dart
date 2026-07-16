// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/repositories/plan_repository.dart
// O QUÊ:     Fonte do plano ativo. Hoje em memória (seed); depois, Supabase.
// USA:       plan.dart, plans_seed.dart, core/utils/app_log.
// USADO POR: plans_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/plans.yaml (repository: PlansRepository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/utils/app_log.dart';
import '../models/plan.dart';
import '../seed/plan_seed.dart';

/// Repositório do plano. Implementação atual serve o plano de exemplo (seed).
/// Usada por: plans_providers. Trocar por versão Supabase mantém a mesma API.
class PlansRepository {
  const PlansRepository();

  /// Retorna o plano ativo do usuário. Usada por: planControllerProvider (estado inicial).
  Plan fetchPlan() {
    AppLog.d('plans', 'carregando plano ativo (seed): ${kSeedPlan.id}');
    return kSeedPlan;
  }
}
