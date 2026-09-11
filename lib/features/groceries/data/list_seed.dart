// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/data/list_seed.dart
// O QUÊ:     Categorias canônicas + DOIS carrinhos de exemplo (quantidades
//            CRUAS — 'Compras da semana' desconta a despensa na exibição,
//            'Feira' não).
// USA:       grocery_item.dart, grocery_list.dart.
// USADO POR: repository (fetchLists), providers (ordem das categorias) e
//            pantry_seed (categorias).
// SPEC:      specs/features/groceries.yaml (data.list_seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'grocery_item.dart';
import 'grocery_list.dart';

const kCatHortifruti = 'Hortifrúti';
const kCatAcougue = 'Açougue';
const kCatLaticinios = 'Laticínios';
const kCatMercearia = 'Mercearia';

/// Ordem canônica das categorias. Usada por: agrupadores de providers.
const kGroceryCategories = <String>[
  kCatHortifruti,
  kCatAcougue,
  kCatLaticinios,
  kCatMercearia,
];

/// Carrinhos de exemplo com quantidades CRUAS (somadas, sem subtrair a
/// despensa). 'Compras da semana' desconta a despensa na exibição (tomate
/// 800 g − 300 g = 500 g); 'Feira' não (o caso "estou fora de casa, quero a
/// lista completa"). Usada por: repository (fetchLists) / groceryListsProvider.
const kSeedLists = <GroceryList>[
  GroceryList(
    id: 'list-semana',
    name: 'Compras da semana',
    label: 'Semana',
    usePantry: true,
    items: [
      GroceryItem(
        id: 'sh-tomate',
        name: 'Tomate',
        category: kCatHortifruti,
        humanQty: 800,
        humanUnit: 'g',
        grams: 800,
      ),
      GroceryItem(
        id: 'sh-banana',
        name: 'Banana',
        category: kCatHortifruti,
        humanQty: 6,
        humanUnit: 'un',
        grams: 600,
      ),
      GroceryItem(
        id: 'sh-cenoura',
        name: 'Cenoura',
        category: kCatHortifruti,
        humanQty: 3,
        humanUnit: 'un',
        grams: 210,
      ),
      GroceryItem(
        id: 'sh-maca',
        name: 'Maçã',
        category: kCatHortifruti,
        humanQty: 4,
        humanUnit: 'un',
        grams: 520,
        checked: true,
      ),
      GroceryItem(
        id: 'sh-iogurte',
        name: 'Iogurte natural',
        category: kCatLaticinios,
        humanQty: 4,
        humanUnit: 'un',
      ),
      GroceryItem(
        id: 'sh-leite',
        name: 'Leite',
        category: kCatLaticinios,
        humanQty: 1,
        humanUnit: 'L',
      ),
      GroceryItem(
        id: 'sh-queijo',
        name: 'Queijo',
        category: kCatLaticinios,
        humanQty: 200,
        humanUnit: 'g',
        grams: 200,
        checked: true,
      ),
      GroceryItem(
        id: 'sh-arroz',
        name: 'Arroz',
        category: kCatMercearia,
        humanQty: 1,
        humanUnit: 'kg',
        grams: 1000,
      ),
    ],
  ),
  GroceryList(
    id: 'list-feira',
    name: 'Feira',
    usePantry: false,
    items: [
      GroceryItem(
        id: 'fr-limao',
        name: 'Limão',
        category: kCatHortifruti,
        humanQty: 4,
        humanUnit: 'un',
        grams: 400,
      ),
      GroceryItem(
        id: 'fr-tilapia',
        name: 'Filé de tilápia',
        category: kCatAcougue,
        humanQty: 600,
        humanUnit: 'g',
        grams: 600,
      ),
      GroceryItem(
        id: 'fr-coalho',
        name: 'Queijo coalho',
        category: kCatLaticinios,
        humanQty: 400,
        humanUnit: 'g',
        grams: 400,
      ),
      GroceryItem(
        id: 'fr-paoalho',
        name: 'Pão de alho',
        category: kCatMercearia,
        humanQty: 2,
        humanUnit: 'un',
      ),
    ],
  ),
];
