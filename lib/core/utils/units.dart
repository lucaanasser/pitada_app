// ─────────────────────────────────────────────────────────────────────────────
// lib/core/utils/units.dart
// O QUÊ:     Regras de unidade humana e agregação da lista de compras por UNIDADE.
// USA:       nada (funções puras). Implementa a regra de dados do guia.
// USADO POR: shopping_repository (soma da lista), IngredientRow (rótulo).
// REGRA:     grama é base; lista soma por unidade humana (.claude/rules/arquitetura.md)
// ─────────────────────────────────────────────────────────────────────────────

/// Par (quantidade, unidade) agregável para a lista de compras.
/// Usada por: [sumByHumanUnit] e o repositório de compras.
class HumanQty {
  final String name;
  final String unit; // 'un', 'g', 'ml', 'c. sopa'...
  final num qty; // na unidade humana
  final num? grams; // referência (não some por aqui)

  const HumanQty({
    required this.name,
    required this.unit,
    required this.qty,
    this.grams,
  });
}

/// Soma itens agrupando por (nome, unidade humana): 2 receitas com 2 ovos = "4 un".
/// A grama fica só como referência (somada quando existir). Regra de dados do guia.
/// Usada por: shopping_repository ao montar a lista a partir das receitas do plano.
List<HumanQty> sumByHumanUnit(Iterable<HumanQty> items) {
  final byKey = <String, HumanQty>{};
  for (final it in items) {
    final key = '${it.name.toLowerCase()}|${it.unit.toLowerCase()}';
    final prev = byKey[key];
    if (prev == null) {
      byKey[key] = it;
    } else {
      byKey[key] = HumanQty(
        name: prev.name,
        unit: prev.unit,
        qty: prev.qty + it.qty,
        grams: (prev.grams ?? 0) + (it.grams ?? 0),
      );
    }
  }
  return byKey.values.toList();
}

/// Subtrai da lista o que já existe na despensa, casando por (nome, unidade).
/// Quantidade nunca fica negativa; itens zerados saem da lista. Usada por: compras.
List<HumanQty> subtractPantry(List<HumanQty> list, List<HumanQty> pantry) {
  final have = <String, num>{};
  for (final p in pantry) {
    have['${p.name.toLowerCase()}|${p.unit.toLowerCase()}'] = p.qty;
  }
  final result = <HumanQty>[];
  for (final it in list) {
    final key = '${it.name.toLowerCase()}|${it.unit.toLowerCase()}';
    final remaining = it.qty - (have[key] ?? 0);
    if (remaining > 0) {
      result.add(
        HumanQty(
          name: it.name,
          unit: it.unit,
          qty: remaining,
          grams: it.grams,
        ),
      );
    }
  }
  return result;
}
