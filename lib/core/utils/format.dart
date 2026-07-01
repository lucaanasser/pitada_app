// ─────────────────────────────────────────────────────────────────────────────
// lib/core/utils/format.dart
// O QUÊ:     Formatação de números/medidas para exibição (gramas, kcal, tempo...).
// USA:       nada (funções puras). Mantém a UI livre de lógica de formatação.
// USADO POR: RecipeDetail, IngredientRow, NutritionCard, Compras, Planos.
// ─────────────────────────────────────────────────────────────────────────────

/// Formata gramas para exibição: usa kg acima de 1000 g. Ex.: 500 -> "500 g".
/// Usada por: IngredientRow, HairlineRow de compras/despensa.
String formatGrams(num? grams) {
  if (grams == null) return '';
  if (grams >= 1000) {
    final kg = grams / 1000;
    return '${_trim(kg)} kg';
  }
  return '${_trim(grams)} g';
}

/// Formata mililitros (ex.: azeite): usa L acima de 1000 ml. Usada por: Despensa.
String formatMl(num? ml) {
  if (ml == null) return '';
  if (ml >= 1000) return '${_trim(ml / 1000)} L';
  return '${_trim(ml)} ml';
}

/// Formata kcal como inteiro. Ex.: 512.0 -> "512". Usada por: NutritionCard, Planos.
String formatKcal(num? kcal) => kcal == null ? '' : '${kcal.round()}';

/// Formata macro em gramas curtinho. Ex.: 42 -> "42 g". Usada por: NutritionCard.
String formatMacro(num? grams) => grams == null ? '' : '${_trim(grams)} g';

/// Formata tempo de preparo. Ex.: 25 -> "25 min". Usada por: RecipeRow, RecipeDetail.
String formatMinutes(int? minutes) => minutes == null ? '' : '$minutes min';

/// Formata quantidade humana + unidade. Ex.: (2,'un') -> "2 un". Usada por: Compras.
String formatHuman(num? qty, String? unit) {
  if (qty == null) return unit ?? '';
  final q = _trim(qty);
  return unit == null || unit.isEmpty ? q : '$q $unit';
}

/// Formata data como dd/MM. Ex.: 2026-07-14 -> "14/07". Usada por: ExpiryTag/Despensa.
String formatDayMonth(DateTime? date) {
  if (date == null) return '';
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m';
}

/// Remove ".0" de números redondos. Ex.: 3.0 -> "3", 1.5 -> "1.5".
/// Usada por: os formatadores acima.
String _trim(num n) {
  final s = n.toStringAsFixed(n == n.roundToDouble() ? 0 : 1);
  return s;
}
