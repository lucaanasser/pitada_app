// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/recipe_seed.dart
// O QUÊ:     Pastas de exemplo + agregação das receitas DEFINITIVAS do protótipo
//            (grupos em seed/recipe/). Snapshots antigos: recipe_versions_seed.
// USA:       folder.dart, recipe.dart, recipe/dinner_seed, recipe/fit_seed.
// USADO POR: seed_recipe_repository e seed_folder_store (fonte em memória).
// SPEC:      specs/features/recipes.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/folder.dart';
import '../models/recipe/recipe.dart';
import 'recipe/dinner_seed.dart';
import 'recipe/fit_seed.dart';

/// Pastas de exemplo (capítulos), cada uma com seu pastel. Usada por: seed_recipe_repository.
const kSeedFolders = <Folder>[
  Folder(id: 'marinadas', name: 'Marinadas de frango', heroColor: 'terra'),
  Folder(id: 'rapidos', name: 'Jantares rápidos', heroColor: 'teal'),
  Folder(id: 'fit', name: 'Fit', heroColor: 'moss'),
  Folder(id: 'doces', name: 'Doces', heroColor: 'plum'),
];

/// Receitas de exemplo (todos os grupos). Usada por: seed_recipe_repository (preview sem backend).
const kSeedRecipes = <Recipe>[...kSeedDinnerRecipes, ...kSeedFitRecipes];
