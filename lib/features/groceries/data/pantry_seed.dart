// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/pantry_seed.dart
// O QUÊ:     Despensa de exemplo p/ preview (o que já tenho, com validades
//            relativas a hoje — a demo fica sempre "viva").
// USA:       list_seed.dart (categorias), pantry_item.dart.
// USADO POR: repository (fetchPantry).
// SPEC:      specs/features/groceries.yaml (data.pantry_seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'list_seed.dart';
import 'pantry_item.dart';

/// Devolve a data de hoje + [days] dias (demo sempre "viva", sem datas fixas).
/// Usada por: _pantryDates.
DateTime _inDays(int days) => DateTime.now().add(Duration(days: days));

final _pantryDates = <String, DateTime>{
  'tomate': _inDays(1),
  'cebola': _inDays(14),
  'frango': _inDays(3),
  'ovos': _inDays(9),
};

/// Despensa de exemplo (o que já tenho, com validade). Tomate em gramas casa
/// com o carrinho da semana (gera o 'Precisa de 800 g · tem 300 g'); itens que
/// cobririam linhas inteiras do carrinho ficam fora. Usada por: repository.
/// `final` (não const) porque as validades são relativas a hoje.
final kSeedPantry = <PantryItem>[
  PantryItem(
    id: 'pt-tomate',
    name: 'Tomate',
    category: kCatHortifruti,
    quantity: 300,
    unit: 'g',
    grams: 300,
    expiresOn: _pantryDates['tomate'],
  ),
  PantryItem(
    id: 'pt-cebola',
    name: 'Cebola',
    category: kCatHortifruti,
    quantity: 4,
    unit: 'un',
    grams: 480,
    expiresOn: _pantryDates['cebola'],
  ),
  PantryItem(
    id: 'pt-frango',
    name: 'Peito de frango',
    category: kCatAcougue,
    quantity: 800,
    unit: 'g',
    grams: 800,
    expiresOn: _pantryDates['frango'],
  ),
  PantryItem(
    id: 'pt-ovos',
    name: 'Ovos',
    category: kCatLaticinios,
    quantity: 6,
    unit: 'un',
    grams: 240,
    expiresOn: _pantryDates['ovos'],
  ),
  const PantryItem(
    id: 'pt-azeite',
    name: 'Azeite',
    category: kCatMercearia,
    quantity: 90,
    unit: 'ml',
    low: true,
  ),
  const PantryItem(
    id: 'pt-shoyu',
    name: 'Shoyu',
    category: kCatMercearia,
    quantity: 1,
    unit: 'un',
  ),
  const PantryItem(
    id: 'pt-amendoim',
    name: 'Amendoim',
    category: kCatMercearia,
    quantity: 20,
    unit: 'g',
    grams: 20,
    low: true,
  ),
];
