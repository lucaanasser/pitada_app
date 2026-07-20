// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/list_seed.dart
// O QUÊ:     Categorias canônicas + DUAS listas de compras de exemplo (quantidades
//            CRUAS — 'Semana' desconta a despensa na exibição, 'Praia' não).
// USA:       grocery_item.dart, grocery_list.dart.
// USADO POR: repository (fetchLists), providers (ordem das categorias) e
//            pantry_seed (categorias).
// SPEC:      specs/features/groceries.yaml (data.list_seed)
// ─────────────────────────────────────────────────────────────────────────────
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
