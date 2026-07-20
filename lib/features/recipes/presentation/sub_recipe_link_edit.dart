// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/sub_recipe_link_edit.dart
// O QUÊ:     Parte de recipe_quick_edit.dart: ações de VÍNCULO do componente —
//            promover a subreceita, vincular existente, desvincular e escala.
// USA:       (herda os imports de recipe_quick_edit.dart) QuickEditSheet,
//            AddOptionsSheet, sub_recipe_providers, modelos.
// USADO POR: gesto no RecipeComponentHeader e action da seção Ingredientes.
// SPEC:      specs/features/sub_recipes.yaml (ui.acoes)
// ─────────────────────────────────────────────────────────────────────────────
part of 'recipe_quick_edit.dart';

/// Ações de vínculo do componente (promover, vincular, desvincular, escala),
/// na mesma fachada dos gestos do detalhe.
/// Usada por: RecipeComponentHeader e a seção Ingredientes do detalhe.
extension SubRecipeLinkEdit on RecipeQuickEdit {
  /// Sheet de ações do componente [index]: local nomeado -> promover;
  /// vinculado -> abrir / escala / desvincular. Usada por: gesto no
  /// RecipeComponentHeader.
  void componentActions(Recipe r, int index) {
    final c = r.components[index];
    if (c.isLinked) {
      final id = c.subRecipeId!;
      showAddOptionsSheet(
        context,
        title: c.name ?? 'Subreceita',
        options: [
          AddSheetOption(
            'Abrir subreceita',
            'ver e editar na biblioteca — editar propaga',
            'teal',
            AppIcons.link,
            (ctx) => ctx.push('/sub-recipe/$id'),
          ),
          AddSheetOption(
            'Alterar escala',
            'só nesta receita (hoje ${formatFactor(c.scale)})',
            'ochre',
            AppIcons.tune,
            (_) => _linkScale(r, index),
          ),
          AddSheetOption(
            'Desvincular',
            'vira cópia local — edições param de propagar',
            'clay',
            AppIcons.unlink,
            (_) => ref.read(subRecipeEditControllerProvider).unlink(r, index),
          ),
        ],
      );
      return;
    }
    if (c.name == null) return;
    showAddOptionsSheet(
      context,
      title: c.name!,
      options: [
        AddSheetOption(
          'Tornar subreceita',
          'reutilizável em outras receitas — editar propaga',
          'teal',
          AppIcons.link,
          (_) => _promote(r, index),
        ),
        AddSheetOption(
          'Unificar parecidas',
          'juntar componentes quase iguais de outras receitas',
          'plum',
          AppIcons.swap,
          (ctx) => ctx.push('/unify/${r.id}/$index'),
        ),
      ],
    );
  }

  /// Seletor "usar subreceita": vincula uma existente ao fim da receita.
  /// Usada por: action da seção Ingredientes.
  Future<void> linkSubRecipe(Recipe r) async {
    final subs = await ref.read(subRecipesProvider.future);
    final usage = await ref.read(subRecipeUsageProvider.future);
    if (!context.mounted) return;
    showAddOptionsSheet(
      context,
      title: 'Usar subreceita',
      options: [
        for (final s in subs)
          AddSheetOption(
            s.name,
            _usesLabel(usage[s.id] ?? 0),
            'teal',
            AppIcons.link,
            (_) => ref.read(subRecipeEditControllerProvider).link(r, s.id),
          ),
        AddSheetOption(
          'Ver biblioteca',
          'todas as subreceitas',
          'moss',
          AppIcons.book,
          (ctx) => ctx.push('/sub-recipes'),
        ),
      ],
    );
  }

  /// Confirma o nome e promove o componente a subreceita compartilhada.
  /// Usada por: [componentActions].
  Future<void> _promote(Recipe r, int index) async {
    final res = await showQuickEditSheet(
      context,
      title: 'Tornar subreceita',
      fields: [
        QuickEditField(
          label: 'Nome da subreceita',
          initial: r.components[index].name ?? '',
          hint: 'ex.: Cobertura de chocolate',
        ),
      ],
    );
    if (res == null) return;
    final name = res.values.first.trim();
    if (name.isEmpty) return;
    await ref.read(subRecipeEditControllerProvider).promote(r, index, name);
  }

  /// Edita o fator de escala do vínculo (ex.: 1,5). Usada por: [componentActions].
  Future<void> _linkScale(Recipe r, int index) async {
    final res = await showQuickEditSheet(
      context,
      title: 'Escala nesta receita',
      fields: [
        QuickEditField(
          label: 'Fator (ex.: 1,5)',
          initial: _numStr(r.components[index].scale),
          keyboardType: _num,
        ),
      ],
    );
    if (res == null) return;
    final v = _toNum(res.values.first);
    if (v == null || v <= 0) return;
    await ref.read(subRecipeEditControllerProvider).setScale(r, index, v);
  }
}

/// Rótulo "em N receitas" do seletor. Usada por: [SubRecipeLinkEdit.linkSubRecipe].
String _usesLabel(int uses) => switch (uses) {
      0 => 'ainda sem uso',
      1 => 'em 1 receita',
      _ => 'em $uses receitas',
    };
