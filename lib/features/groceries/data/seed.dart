// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/seed.dart
// O QUÊ:     Dados de exemplo p/ preview: DUAS listas de compras (quantidades
//            CRUAS — 'Semana' desconta a despensa, 'Praia' não) + a despensa.
// USA:       grocery_list.dart, grocery_item.dart, pantry_item.dart.
// USADO POR: repository (fonte em memória enquanto não há Supabase) e providers
//            (ordem das categorias).
// SPEC:      specs/features/groceries.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'pantry_item.dart';
import 'grocery_item.dart';
import 'grocery_list.dart';

const kCatHortifruti = 'Hortifrúti';
const kCatAcougue = 'Açougue';
const kCatLaticinios = 'Laticínios & ovos';
const kCatMercearia = 'Mercearia';

/// Ordem canônica das categorias. Usada por: agrupadores de providers.
const kGroceryCategories = <String>[
  kCatHortifruti,
  kCatAcougue,
  kCatLaticinios,
  kCatMercearia,
];

/// Listas de exemplo com quantidades CRUAS (somadas, sem subtrair a despensa).
/// 'Semana' desconta a despensa na exibição (cebola 6-4=2 un...); 'Praia' não
/// (o caso "estou fora de casa, quero a lista completa").
/// Usada por: repository (fetchLists) / groceryListsProvider.
const kSeedLists = <GroceryList>[
  GroceryList(
    id: 'list-semana',
    name: 'Semana',
    usePantry: true,
    items: [
      GroceryItem(
        id: 'sh-pimentao',
        name: 'Pimentão',
        category: kCatHortifruti,
        humanQty: 3,
        humanUnit: 'un',
        grams: 360,
      ),
      GroceryItem(
        id: 'sh-cebola',
        name: 'Cebola',
        category: kCatHortifruti,
        humanQty: 6,
        humanUnit: 'un',
        grams: 720,
      ),
      GroceryItem(
        id: 'sh-frango',
        name: 'Peito de frango',
        category: kCatAcougue,
        humanQty: 1600,
        humanUnit: 'g',
        grams: 1600,
      ),
      GroceryItem(
        id: 'sh-ovos',
        name: 'Ovos',
        category: kCatLaticinios,
        humanQty: 8,
        humanUnit: 'un',
        grams: 320,
      ),
      GroceryItem(
        id: 'sh-shoyu',
        name: 'Shoyu',
        category: kCatMercearia,
        humanQty: 2,
        humanUnit: 'un',
        checked: true,
      ),
      GroceryItem(
        id: 'sh-amendoim',
        name: 'Amendoim',
        category: kCatMercearia,
        humanQty: 160,
        humanUnit: 'g',
        grams: 160,
      ),
    ],
  ),
  GroceryList(
    id: 'list-praia',
    name: 'Praia',
    usePantry: false,
    items: [
      GroceryItem(
        id: 'pr-limao',
        name: 'Limão',
        category: kCatHortifruti,
        humanQty: 4,
        humanUnit: 'un',
        grams: 400,
      ),
      GroceryItem(
        id: 'pr-tilapia',
        name: 'Filé de tilápia',
        category: kCatAcougue,
        humanQty: 600,
        humanUnit: 'g',
        grams: 600,
      ),
      GroceryItem(
        id: 'pr-coalho',
        name: 'Queijo coalho',
        category: kCatLaticinios,
        humanQty: 400,
        humanUnit: 'g',
        grams: 400,
      ),
      GroceryItem(
        id: 'pr-paoalho',
        name: 'Pão de alho',
        category: kCatMercearia,
        humanQty: 2,
        humanUnit: 'un',
      ),
    ],
  ),
];

final _pantryDates = <String, DateTime>{
  'tomate': DateTime(2026, 7, 1),
  'cebola': DateTime(2026, 7, 14),
  'frango': DateTime(2026, 7, 3),
  'iogurte': DateTime(2026, 7, 2),
  'ovos': DateTime(2026, 7, 9),
};

/// Despensa de exemplo (o que já tenho, com validade). Usada por: repository.
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
