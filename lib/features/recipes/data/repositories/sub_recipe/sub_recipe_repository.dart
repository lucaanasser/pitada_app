// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/sub_recipe/sub_recipe_repository.dart
// O QUÊ:     CONTRATO do repositório de subreceitas compartilhadas. Impls: seed
//            (preview) e Supabase (online) — main.dart escolhe via override.
// USA:       sub_recipe.dart (modelo).
// USADO POR: sub_recipe_providers (application), seed_sub_recipe_repository,
//            supabase_sub_recipe_repository. A UI nunca chama isto direto.
// SPEC:      specs/features/sub_recipes.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import '../../models/recipe/sub_recipe.dart';

/// Contrato da fonte de subreceitas. O id de uma subreceita é ESTÁVEL: editar
/// nunca o troca (é ele que os vínculos apontam). Usada por: sub_recipe_providers.
abstract class SubRecipesRepository {
  /// Lista as subreceitas da biblioteca, ordenadas por nome.
  /// Usada por: subRecipesProvider.
  Future<List<SubRecipe>> fetchSubRecipes();

  /// Busca uma subreceita por id. null quando não existe.
  /// Usada por: subRecipeByIdProvider (detalhe da biblioteca).
  Future<SubRecipe?> fetchById(String id);

  /// Cria uma subreceita NOVA e devolve o id final gerado (online o Postgres
  /// gera o uuid; no seed é um id local). Usada por: promover componente.
  Future<String> createSubRecipe(SubRecipe subRecipe);

  /// Grava uma edição NO LUGAR (mesmo id — os vínculos continuam válidos e
  /// todos os pratos refletem). Usada por: SubRecipeEditController.save.
  Future<void> updateSubRecipe(SubRecipe subRecipe);
}
