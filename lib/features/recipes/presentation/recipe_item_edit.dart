// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipe_item_edit.dart
// O QUÊ:     Parte de recipe_quick_edit.dart: edição inline dos ITENS de lista da
//            receita (um ingrediente, um passo) — sheets multi-campo. Fica à parte só
//            pelo limite de 200 linhas; compartilha a biblioteca (helpers privados).
// USA:       (herda os imports de recipe_quick_edit.dart) QuickEditSheet, modelos.
// USADO POR: recipe_detail_body (qe.ingredient / qe.step nos gestos Editable).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: edicao_inline)
// ─────────────────────────────────────────────────────────────────────────────
part of 'recipe_quick_edit.dart';

/// Edição inline dos itens de lista da receita. Métodos públicos usados no detalhe;
/// reusa os helpers privados da biblioteca (_save/_toNum/_numStr). Usada por: detalhe.
extension RecipeItemEdit on RecipeQuickEdit {
  /// Edita um ingrediente (nome + gramas + quantidade/unidade humana),
  /// endereçado por componente + índice. Usada por: IngredientRow.
  Future<void> ingredient(Recipe r, int component, int index) async {
    final comp = r.components[component];
    final ing = comp.ingredients[index];
    final res = await showQuickEditSheet(
      context,
      title: 'Ingrediente',
      toggleLabel: _versionLabel,
      toggleSubtitle: _versionSub,
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
    final list = List<Ingredient>.of(comp.ingredients);
    list[index] = Ingredient(
      name: v[0].trim(),
      grams: _toNum(v[1]),
      humanQty: _toNum(v[2]),
      humanUnit: v[3].trim().isEmpty ? null : v[3].trim(),
    );
    await _save(
      r.withComponent(component, comp.copyWith(ingredients: list)),
      asNewVersion: res.toggle,
    );
  }

  /// Edita um passo do preparo (texto + "Por quê" opcional), endereçado por
  /// componente + índice; [number] é o número CONTÍNUO exibido. Usada por: StepTile.
  Future<void> step(Recipe r, int component, int index,
      {required int number,}) async {
    final comp = r.components[component];
    final st = comp.steps[index];
    final res = await showQuickEditSheet(
      context,
      title: 'Passo $number',
      toggleLabel: _versionLabel,
      toggleSubtitle: _versionSub,
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
    final list = List<RecipeStep>.of(comp.steps);
    list[index] = RecipeStep(
      text: v[0].trim(),
      tip: v[1].trim().isEmpty ? null : v[1].trim(),
    );
    await _save(
      r.withComponent(component, comp.copyWith(steps: list)),
      asNewVersion: res.toggle,
    );
  }
}
