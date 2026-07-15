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

/// Formata peso corporal em kg (1 casa, vírgula pt-BR). Ex.: 78.4 -> "78,4 kg".
/// Usada por: WeightSection, LogWeightSheet.
String formatKg(num? kg) =>
    kg == null ? '' : '${kg.toStringAsFixed(1).replaceAll('.', ',')} kg';

/// Formata variação de peso com sinal (menos "−" p/ perda). Ex.: -2.1 -> "−2,1 kg".
/// Usada por: WeightSection (variação desde o início).
String formatKgDelta(num kg) {
  final sign = kg > 0 ? '+' : (kg < 0 ? '−' : '');
  final abs = kg.abs().toStringAsFixed(1).replaceAll('.', ',');
  return '$sign$abs kg';
}

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

/// Abreviações pt-BR dos meses (1..12). Usada por: formatMonthAbbr, formatDayLabel.
const _kMonthsAbbr = [
  'jan',
  'fev',
  'mar',
  'abr',
  'mai',
  'jun',
  'jul',
  'ago',
  'set',
  'out',
  'nov',
  'dez',
];

/// Abreviações pt-BR dos dias da semana (DateTime.weekday 1..7 = seg..dom).
/// Usada por: formatWeekdayAbbr, formatDayLabel, ActivityGrid (rótulos laterais).
const kWeekdaysAbbr = ['seg', 'ter', 'qua', 'qui', 'sex', 'sáb', 'dom'];

/// Mês abreviado pt-BR. Ex.: 2026-07-14 -> "jul". Usada por: ActivityGrid (meses).
String formatMonthAbbr(DateTime date) => _kMonthsAbbr[date.month - 1];

/// Dia da semana abreviado pt-BR. Ex.: 2026-07-14 -> "ter".
/// Usada por: formatDayLabel, readout do gráfico de atividade.
String formatWeekdayAbbr(DateTime date) => kWeekdaysAbbr[date.weekday - 1];

/// Rótulo completo de um dia. Ex.: 2026-07-14 -> "ter · 14 jul".
/// Usada por: ActivityGraph (readout do dia selecionado).
String formatDayLabel(DateTime date) =>
    '${formatWeekdayAbbr(date)} · ${date.day} ${formatMonthAbbr(date)}';

/// Remove ".0" de números redondos. Ex.: 3.0 -> "3", 1.5 -> "1.5".
/// Usada por: os formatadores acima.
String _trim(num n) {
  final s = n.toStringAsFixed(n == n.roundToDouble() ? 0 : 1);
  return s;
}
