// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/application/food_estimate_service.dart
// O QUÊ:     Service de estimativa de calorias por linguagem natural, atrás de uma
//            interface (real + mock, como ScannerService). O mock roda no preview:
//            interpreta "5 colheres de brigadeiro" casando a comida na base curada
//            e escalando pela quantidade. O real (Gemini) fica em outro arquivo.
// USA:       day_log (ExtraEntry), foods_seed (base do mock), riverpod, app_log.
// USADO POR: EstimateFoodSheet (via foodEstimateServiceProvider).
// SPEC:      specs/features/plans_progress.yaml (services.FoodEstimateService)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/day_log.dart';
import '../data/food_item.dart';
import '../data/foods_seed.dart';

/// Estima calorias/macros a partir de um texto livre ("2 latas de cerveja").
/// Interface única: no preview usa o mock; com Supabase, a impl. Gemini.
/// Usada por: EstimateFoodSheet.
abstract class FoodEstimateService {
  /// Estima um ExtraEntry a partir da descrição em linguagem natural.
  /// Usada por: EstimateFoodSheet ("Estimar").
  Future<ExtraEntry> estimate(String description);
}

/// Estimativa offline p/ preview: casa a comida na base curada e escala pela
/// quantidade detectada no texto. Aproximação — o Gemini melhora depois.
/// Usada por: foodEstimateServiceProvider (padrão).
class MockFoodEstimateService implements FoodEstimateService {
  const MockFoodEstimateService();

  /// Delay curto p/ dar a sensação de "processando" (como o import mockado).
  static const _delay = Duration(milliseconds: 650);

  /// Estima a partir do texto: quantidade × comida casada na base (ou genérico).
  /// Usada por: EstimateFoodSheet.
  @override
  Future<ExtraEntry> estimate(String description) async {
    await Future<void>.delayed(_delay);
    final text = _norm(description);
    final qty = _quantity(text);
    final base = _match(text);
    if (base == null) {
      // Sem correspondência: chute genérico por porção (~140 kcal) × quantidade.
      final kcal = (qty * 140).round();
      AppLog.i(
          'plans', 'estimativa mock (genérica): "$description" ~$kcal kcal');
      return ExtraEntry(
        name: description.trim(),
        portion: 'estimativa',
        kcal: kcal,
        carb: (qty * 18),
        protein: (qty * 3),
        fat: (qty * 5),
      );
    }
    final kcal = (base.kcal * qty).round();
    AppLog.i(
        'plans', 'estimativa mock: "$description" -> ${base.name} ~$kcal kcal');
    return ExtraEntry(
      foodId: base.id,
      name: base.name,
      portion: description.trim(),
      kcal: kcal,
      protein: base.protein * qty,
      carb: base.carb * qty,
      fat: base.fat * qty,
    );
  }

  /// Detecta a quantidade no texto: número explícito ou por extenso (default 1).
  /// Usada por: [estimate].
  double _quantity(String text) {
    final m = RegExp(r'(\d+[.,]?\d*)').firstMatch(text);
    if (m != null) return double.parse(m.group(1)!.replaceAll(',', '.'));
    // Ordem importa: "meia dúzia" antes de "duzia".
    const words = <String, double>{
      'meia duzia': 6,
      'meio': 0.5,
      'meia': 0.5,
      'uma': 1,
      'um': 1,
      'duas': 2,
      'dois': 2,
      'tres': 3,
      'quatro': 4,
      'cinco': 5,
      'seis': 6,
      'duzia': 12,
    };
    for (final e in words.entries) {
      if (text.contains(e.key)) return e.value;
    }
    return 1;
  }

  /// Melhor comida da base para o texto (por sobreposição de palavras do nome).
  /// Usada por: [estimate].
  FoodItem? _match(String text) {
    FoodItem? best;
    var bestScore = 0;
    for (final f in kSeedFoods) {
      var score = 0;
      for (final word in _norm(f.name).split(' ')) {
        if (word.length >= 3 && text.contains(word)) score++;
      }
      if (score > bestScore) {
        bestScore = score;
        best = f;
      }
    }
    return bestScore > 0 ? best : null;
  }

  /// Normaliza p/ comparação: minúsculas e sem acentos. Usada por: [estimate]/[_match].
  String _norm(String s) {
    var t = s.toLowerCase();
    const from = 'áàâãäéèêëíìîïóòôõöúùûüç';
    const to = 'aaaaaeeeeiiiiooooouuuuc';
    for (var i = 0; i < from.length; i++) {
      t = t.replaceAll(from[i], to[i]);
    }
    return t;
  }
}

/// Injeta a estimativa em uso. Padrão: mock (preview). Override p/ o Gemini real
/// (GeminiFoodEstimateService) quando o Supabase estiver configurado.
/// Usada por: EstimateFoodSheet.
final foodEstimateServiceProvider =
    Provider<FoodEstimateService>((ref) => const MockFoodEstimateService());
