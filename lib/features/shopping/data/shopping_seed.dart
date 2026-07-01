// ─────────────────────────────────────────────────────────────────────────────
// lib/features/shopping/data/shopping_seed.dart
// O QUÊ:     Dados de exemplo (lista de compras + despensa do protótipo) p/ preview.
// USA:       shopping_item.dart, pantry_item.dart (modelos imutáveis).
// USADO POR: shopping_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/shopping.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'pantry_item.dart';
import 'shopping_item.dart';

// Categorias fixas do protótipo, na ordem de exibição.
const kCatHortifruti = 'Hortifrúti';
const kCatAcougue = 'Açougue';
const kCatLaticinios = 'Laticínios & ovos';
const kCatMercearia = 'Mercearia';

/// Ordem canônica das categorias. Usada por: agrupadores de shopping_providers.
const kShoppingCategories = <String>[
  kCatHortifruti,
  kCatAcougue,
  kCatLaticinios,
  kCatMercearia,
];

/// Lista de compras de exemplo (já somada/subtraída). Usada por: shopping_repository.
const kSeedShopping = <ShoppingItem>[
  ShoppingItem(
    id: 'sh-pimentao',
    name: 'Pimentão',
    category: kCatHortifruti,
    humanQty: 3,
    humanUnit: 'un',
    grams: 360,
  ),
  ShoppingItem(
    id: 'sh-cebola',
    name: 'Cebola',
    category: kCatHortifruti,
    humanQty: 2,
    humanUnit: 'un',
    grams: 240,
  ),
  ShoppingItem(
    id: 'sh-frango',
    name: 'Peito de frango',
    category: kCatAcougue,
    humanQty: 800,
    humanUnit: 'g',
    grams: 800,
  ),
  ShoppingItem(
    id: 'sh-ovos',
    name: 'Ovos',
    category: kCatLaticinios,
    humanQty: 2,
    humanUnit: 'un',
    grams: 80,
  ),
  ShoppingItem(
    id: 'sh-shoyu',
    name: 'Shoyu',
    category: kCatMercearia,
    humanQty: 1,
    humanUnit: 'un',
    checked: true,
  ),
  ShoppingItem(
    id: 'sh-amendoim',
    name: 'Amendoim',
    category: kCatMercearia,
    humanQty: 140,
    humanUnit: 'g',
    grams: 140,
  ),
];

// Datas de validade fixas, relativas a 2026-06-30 (hoje no protótipo).
final _pantryDates = <String, DateTime>{
  'tomate': DateTime(2026, 7, 1), // vence amanhã
  'cebola': DateTime(2026, 7, 14), // validade 14/07
  'frango': DateTime(2026, 7, 3), // vence em 3 dias
  'iogurte': DateTime(2026, 7, 2), // vence em 2 dias
  'ovos': DateTime(2026, 7, 9), // validade 09/07
};

/// Despensa de exemplo (o que já tenho, com validade). Usada por: shopping_repository.
/// `final` (não const) porque usa DateTime fixas relativas a 2026-06-30.
final kSeedPantry = <PantryItem>[
  PantryItem(
    id: 'pt-tomate',
    name: 'Tomate',
    category: kCatHortifruti,
    quantity: 6,
    unit: 'un',
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
    id: 'pt-iogurte',
    name: 'Iogurte natural',
    category: kCatLaticinios,
    quantity: 4,
    unit: 'un',
    expiresOn: _pantryDates['iogurte'],
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
    id: 'pt-arroz',
    name: 'Arroz',
    category: kCatMercearia,
    quantity: 1,
    unit: 'kg',
    grams: 1000,
  ),
  const PantryItem(
    id: 'pt-azeite',
    name: 'Azeite',
    category: kCatMercearia,
    quantity: 90,
    unit: 'ml',
    low: true, // acabando
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
    low: true, // acabando
  ),
];
