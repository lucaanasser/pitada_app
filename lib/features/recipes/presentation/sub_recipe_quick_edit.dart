// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/sub_recipe_quick_edit.dart
// O QUÊ:     Parte de recipe_quick_edit.dart: edição inline de SUBRECEITA
//            (propaga p/ todos os pratos). As ações de vínculo do componente
//            vivem na parte irmã sub_recipe_link_edit.dart.
// USA:       (herda os imports de recipe_quick_edit.dart) QuickEditSheet,
//            sub_recipe_providers, modelos.
// USADO POR: seções do detalhe (componente vinculado) e telas da biblioteca.
// SPEC:      specs/features/sub_recipes.yaml (ui.no_prato)
// ─────────────────────────────────────────────────────────────────────────────
part of 'recipe_quick_edit.dart';

/// Edição de subreceita na mesma fachada dos gestos do detalhe.
/// Toda edição de subreceita propaga (sem switch de versão).
/// Usada por: RecipeIngredientsSection, RecipeStepsSection, telas da biblioteca.
extension SubRecipeEdit on RecipeQuickEdit {
  /// Salva a subreceita editada (propaga p/ todos os pratos). Usada por: métodos abaixo.
  Future<void> _saveSub(SubRecipe sub) =>
      ref.read(subRecipeEditControllerProvider).save(sub);

  /// Estado atual da subreceita (valores BASE, não os escalados do prato).
  /// Usada por: subIngredient/subStep.
  Future<SubRecipe?> _sub(String id) =>
      ref.read(subRecipeByIdProvider(id).future);

  /// Sufixo do título das sheets: em quantos pratos a edição vai refletir.
  /// Usada por: subIngredient/subStep/subName.
  Future<String> _spread(String id) async {
    final uses = (await ref.read(subRecipeUsageProvider.future))[id] ?? 0;
    return uses <= 1 ? '' : ' — muda em $uses receitas';
  }

  /// Edita um ingrediente da SUBRECEITA (valores base; sabor preservado).
  /// Usada por: IngredientRow de componente vinculado e SubRecipeDetailScreen.
  Future<void> subIngredient(String subRecipeId, int index) async {
    final sub = await _sub(subRecipeId);
    final spread = await _spread(subRecipeId);
    if (sub == null || !context.mounted) return;
    final ing = sub.ingredients[index];
    final res = await showQuickEditSheet(
      context,
      title: 'Ingrediente$spread',
      fields: [
        QuickEditField(label: 'Ingrediente', initial: ing.name, hint: 'Nome'),
        QuickEditField(
          label: 'Gramas',
          initial: _numStr(ing.grams),
          keyboardType: _num,
          hint: 'g',
        ),
        QuickEditField(
          label: 'Quantidade',
          initial: _numStr(ing.humanQty),
          keyboardType: _num,
          hint: 'ex.: 2',
        ),
        QuickEditField(
          label: 'Unidade',
          initial: ing.humanUnit ?? '',
          hint: 'ex.: un, xíc.',
        ),
      ],
    );
    if (res == null) return;
    final v = res.values;
    final list = List<Ingredient>.of(sub.ingredients);
    list[index] = Ingredient(
      name: v[0].trim(),
      grams: _toNum(v[1]),
      humanQty: _toNum(v[2]),
      humanUnit: v[3].trim().isEmpty ? null : v[3].trim(),
      flavors: ing.flavors,
    );
    await _saveSub(sub.copyWith(ingredients: list));
  }

  /// Edita um passo da SUBRECEITA (texto + "Por quê"; técnicas preservadas).
  /// Usada por: StepTile de componente vinculado e SubRecipeDetailScreen.
  Future<void> subStep(String subRecipeId, int index,
      {required int number,}) async {
    final sub = await _sub(subRecipeId);
    final spread = await _spread(subRecipeId);
    if (sub == null || !context.mounted) return;
    final st = sub.steps[index];
    final res = await showQuickEditSheet(
      context,
      title: 'Passo $number$spread',
      fields: [
        QuickEditField(
          label: 'Passo',
          initial: st.text,
          hint: 'Descreva o passo',
          multiline: true,
        ),
        QuickEditField(
          label: 'Por quê (opcional)',
          initial: st.tip ?? '',
          hint: 'Dica de técnica',
          multiline: true,
        ),
      ],
    );
    if (res == null) return;
    final v = res.values;
    final list = List<RecipeStep>.of(sub.steps);
    list[index] = RecipeStep(
      text: v[0].trim(),
      tip: v[1].trim().isEmpty ? null : v[1].trim(),
      techniques: st.techniques,
    );
    await _saveSub(sub.copyWith(steps: list));
  }

  /// Renomeia a subreceita (o nome muda em todos os pratos).
  /// Usada por: SubRecipeDetailScreen (gesto no nome).
  Future<void> subName(SubRecipe sub) async {
    final spread = await _spread(sub.id);
    if (!context.mounted) return;
    final res = await showQuickEditSheet(
      context,
      title: 'Nome$spread',
      fields: [
        QuickEditField(label: 'Nome', initial: sub.name, hint: 'Subreceita'),
      ],
    );
    if (res == null) return;
    final name = res.values.first.trim();
    if (name.isEmpty) return;
    await _saveSub(sub.copyWith(name: name));
  }
}
