// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/gemini_food_estimate_service.dart
// O QUÊ:     Implementação REAL da estimativa: chama a Edge Function `estimate-food`
//            (que fala com o Gemini) e converte a resposta em ExtraEntry. Só roda
//            com Supabase configurado; no preview usa-se o mock. Para ligar, faça
//            override de foodEstimateServiceProvider com esta classe.
// USA:       core/supabase (client.functions.invoke), day_log (ExtraEntry), app_log.
// USADO POR: foodEstimateServiceProvider (quando Env.hasSupabase — override futuro).
// SPEC:      specs/features/plans_progress.yaml (services.GeminiFoodEstimateService)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/supabase/supabase.dart';
import '../../../core/utils/app_log.dart';
import '../data/models/day_log.dart';
import 'food_estimate_service.dart';

/// Estimativa via Gemini na Edge Function `estimate-food`. Contrato esperado:
///   entrada:  { "text": "<descrição em linguagem natural>" }
///   saída:    { "name", "portion", "kcal", "protein", "carb", "fat" }
/// Usada por: foodEstimateServiceProvider quando online (override).
class GeminiFoodEstimateService implements FoodEstimateService {
  const GeminiFoodEstimateService();

  /// Invoca a Edge Function e mapeia a resposta em ExtraEntry. Usada por: EstimateFoodSheet.
  @override
  Future<ExtraEntry> estimate(String description) async {
    AppLog.d('plans', 'estimate-food (gemini): "$description"');
    final res = await SupabaseService.client.functions.invoke(
      'estimate-food',
      body: {'text': description},
    );
    final data = (res.data as Map).cast<String, dynamic>();
    return ExtraEntry(
      name: (data['name'] as String?)?.trim().isNotEmpty == true
          ? data['name'] as String
          : description.trim(),
      portion: (data['portion'] as String?) ?? description.trim(),
      kcal: (data['kcal'] as num?)?.round() ?? 0,
      protein: (data['protein'] as num?) ?? 0,
      carb: (data['carb'] as num?) ?? 0,
      fat: (data['fat'] as num?) ?? 0,
    );
  }
}
