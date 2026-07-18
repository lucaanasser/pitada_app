// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/repositories/sub_recipe/supabase_sub_recipe_repository.dart
// O QUÊ:     Implementação ONLINE do SubRecipesRepository. A linha própria é
//            upsert (id ESTÁVEL — vínculos sobrevivem); só as filhas regravam.
// USA:       sub_recipe_repository (contrato), sub_recipe_row_mapper,
//            core/supabase (cliente), core/utils/app_log.
// USADO POR: main.dart (override do subRecipesRepositoryProvider quando online).
// SPEC:      specs/features/sub_recipes.yaml (data.repository)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/supabase/supabase.dart';
import '../../../../../core/utils/app_log.dart';
import '../../models/recipe/sub_recipe.dart';
import 'sub_recipe_repository.dart';
import 'sub_recipe_row_mapper.dart';

/// Repositório online de subreceitas. A RLS garante que só as linhas do
/// usuário chegam aqui. Usada por: main.dart (override).
class SupabaseSubRecipesRepository implements SubRecipesRepository {
  const SupabaseSubRecipesRepository();

  SupabaseClient get _db => SupabaseService.client;

  /// Embedding padrão: subreceita + filhas numa query só.
  static const _select = '*, sub_recipe_ingredients(*), '
      'sub_recipe_steps(*, sub_recipe_step_techniques(*))';

  /// Biblioteca inteira, por nome. Usada por: subRecipesProvider.
  @override
  Future<List<SubRecipe>> fetchSubRecipes() async {
    final rows = await _db
        .from('sub_recipes')
        .select(_select)
        .order('name', ascending: true);
    AppLog.d('recipes', 'carregadas ${rows.length} subreceitas (supabase)');
    return rows.map(subRecipeFromRow).toList();
  }

  /// Uma subreceita pelo id. Id malformado vira null + warn.
  /// Usada por: subRecipeByIdProvider.
  @override
  Future<SubRecipe?> fetchById(String id) async {
    try {
      final row = await _db
          .from('sub_recipes')
          .select(_select)
          .eq('id', id)
          .maybeSingle();
      if (row == null) AppLog.w('recipes', 'subreceita não encontrada: $id');
      return row == null ? null : subRecipeFromRow(row);
    } on PostgrestException catch (e) {
      AppLog.w('recipes', 'fetchById sub($id) falhou: ${e.code}');
      return null;
    }
  }

  /// Insere subreceita NOVA (Postgres gera o uuid) + filhas; devolve o id.
  /// Usada por: SubRecipeEditController.promote.
  @override
  Future<String> createSubRecipe(SubRecipe subRecipe) async {
    final inserted = await _db
        .from('sub_recipes')
        .insert(subRecipeToRow(subRecipe, withId: false))
        .select('id')
        .single();
    final id = inserted['id'] as String;
    await _writeChildren(subRecipe, id);
    AppLog.i('recipes', 'subreceita criada (supabase): $id');
    return id;
  }

  /// Upsert da linha própria (id intacto) + troca das filhas — os vínculos das
  /// receitas continuam apontando pro mesmo id e refletem a edição na leitura.
  /// Usada por: SubRecipeEditController.save.
  @override
  Future<void> updateSubRecipe(SubRecipe subRecipe) async {
    await _db.from('sub_recipes').upsert(subRecipeToRow(subRecipe));
    await _writeChildren(subRecipe, subRecipe.id);
    AppLog.i('recipes', 'subreceita salva (supabase): ${subRecipe.id}');
  }

  /// Regrava as filhas de [subRecipeId] (delete + insert; position = ordem).
  /// Usada por: createSubRecipe e updateSubRecipe.
  Future<void> _writeChildren(SubRecipe sub, String subRecipeId) async {
    await _db
        .from('sub_recipe_ingredients')
        .delete()
        .eq('sub_recipe_id', subRecipeId);
    await _db.from('sub_recipe_steps').delete().eq('sub_recipe_id', subRecipeId);
    final ings = subIngredientRows(sub, subRecipeId);
    final steps = subStepRows(sub, subRecipeId);
    if (ings.isNotEmpty) {
      await _db.from('sub_recipe_ingredients').insert(ings);
    }
    if (steps.isNotEmpty) {
      final inserted = await _db
          .from('sub_recipe_steps')
          .insert(steps)
          .select('id, position');
      inserted.sort(
        (a, b) => ((a['position'] ?? 0) as num)
            .compareTo((b['position'] ?? 0) as num),
      );
      final stepIds = [for (final row in inserted) row['id'] as String];
      final links = subStepTechniqueRows(sub, stepIds);
      if (links.isNotEmpty) {
        await _db.from('sub_recipe_step_techniques').insert(links);
      }
    }
  }
}
