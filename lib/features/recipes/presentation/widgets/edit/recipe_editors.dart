// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/edit/recipe_editors.dart
// O QUÊ:     Blocos editores reutilizáveis: lista de ingredientes e lista de passos,
//            cada um com suas linhas + botão de contorno "adicionar".
// USA:       edit_ingredient_row, edit_step_row, core/widgets/pitada_button, modelos.
// USADO POR: recipe_edit_screen e import_preview (mesmo editor nos dois fluxos).
// SPEC:      specs/features/recipes.yaml (EditIngredientEditor, EditStepEditor)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../data/models/ingredient.dart';
import '../../../data/models/recipe_step.dart';
import 'edit_ingredient_row.dart';
import 'edit_step_row.dart';

/// Editor da lista de ingredientes: uma [EditIngredientRow] por item + "＋".
/// Muta a lista recebida via callbacks e chama [onDirty] para reconstruir o pai.
/// Mantém chaves estáveis por item (não por índice) para preservar o foco ao
/// digitar e casar o estado da linha certa ao remover. Usada por: telas de edição.
class IngredientsEditor extends StatefulWidget {
  const IngredientsEditor({
    super.key,
    required this.ingredients,
    required this.onDirty,
  });

  final List<Ingredient> ingredients;
  final VoidCallback onDirty;

  @override
  State<IngredientsEditor> createState() => _IngredientsEditorState();
}

class _IngredientsEditorState extends State<IngredientsEditor> {
  late final List<Key> _keys =
      List.generate(widget.ingredients.length, (_) => UniqueKey());

  /// Monta as linhas + botão adicionar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final items = widget.ingredients;
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          EditIngredientRow(
            key: _keys[i],
            ingredient: items[i],
            onChanged: (v) => items[i] = v,
            onRemove: () => setState(() {
              items.removeAt(i);
              _keys.removeAt(i);
              widget.onDirty();
            }),
          ),
        const SizedBox(height: AppSpacing.sm),
        PitadaButton(
          label: 'Ingrediente',
          icon: AppIcons.add,
          variant: PitadaButtonVariant.outline,
          onPressed: () => setState(() {
            items.add(const Ingredient(name: ''));
            _keys.add(UniqueKey());
            widget.onDirty();
          }),
        ),
      ],
    );
  }
}

/// Editor da lista de passos: uma [EditStepRow] numerada por item + "＋".
/// Mesma estratégia de chaves estáveis do editor de ingredientes.
/// Usada por: recipe_edit_screen e import_preview.
class StepsEditor extends StatefulWidget {
  const StepsEditor({super.key, required this.steps, required this.onDirty});

  final List<RecipeStep> steps;
  final VoidCallback onDirty;

  @override
  State<StepsEditor> createState() => _StepsEditorState();
}

class _StepsEditorState extends State<StepsEditor> {
  late final List<Key> _keys =
      List.generate(widget.steps.length, (_) => UniqueKey());

  /// Monta os passos numerados + botão adicionar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final items = widget.steps;
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          EditStepRow(
            key: _keys[i],
            number: i + 1,
            step: items[i],
            onChanged: (v) => items[i] = v,
            onRemove: () => setState(() {
              items.removeAt(i);
              _keys.removeAt(i);
              widget.onDirty();
            }),
          ),
        const SizedBox(height: AppSpacing.sm),
        PitadaButton(
          label: 'Passo',
          icon: AppIcons.add,
          variant: PitadaButtonVariant.outline,
          onPressed: () => setState(() {
            items.add(const RecipeStep(text: ''));
            _keys.add(UniqueKey());
            widget.onDirty();
          }),
        ),
      ],
    );
  }
}
