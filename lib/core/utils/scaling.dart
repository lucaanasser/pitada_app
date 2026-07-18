// ─────────────────────────────────────────────────────────────────────────────
// lib/core/utils/scaling.dart
// O QUÊ:     Escala de quantidades por um fator puro (porções da receita e
//            vínculo de subreceita). Grama é a base; arredondamento de cozinha.
// USA:       nada (funções puras).
// USADO POR: Ingredient.scaled (models/recipe), RecipeDetailBody (view por
//            porções), vínculos de subreceita.
// SPEC:      specs/core/utils/scaling.yaml
// ─────────────────────────────────────────────────────────────────────────────

/// Escala [qty] por [factor] com arredondamento de cozinha: >= 10 vira inteiro,
/// >= 1 fica com 1 casa, < 1 com 2 casas. Nulo passa; fator 1 devolve intacto.
/// Usada por: Ingredient.scaled, vínculos de subreceita.
num? scaleQty(num? qty, num factor) {
  if (qty == null) return null;
  if (factor == 1) return qty;
  final raw = qty * factor;
  if (raw >= 10) return raw.round();
  if (raw >= 1) return (raw * 10).round() / 10;
  return (raw * 100).round() / 100;
}

/// Formata um fator de escala para exibição pt-BR: 2 -> "2×", 1.2 -> "1,2×".
/// Usada por: selo de vínculo de subreceita (detalhe/editor da receita).
String formatFactor(num factor) {
  final rounded = (factor * 100).round() / 100;
  final isWhole = rounded == rounded.roundToDouble();
  final s = isWhole
      ? '${rounded.round()}'
      : rounded.toString().replaceAll('.', ',');
  return '$s×';
}
