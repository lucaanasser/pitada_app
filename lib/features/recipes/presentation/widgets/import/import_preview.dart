// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/import/import_preview.dart
// O QUÊ:     Preview editável do resultado da importação: nome, porções, ingredientes
//            e passos (reusa os editores da tela de edição) + "Salvar receita".
// USA:       edit_field, recipe_editors, core/widgets (SectionHeader, PitadaButton),
//            RecipeDraft (rascunho vindo do controller), theme/*.
// USADO POR: import_sheet (terceiro estágio: preview).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT: preview / ImportPreview)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../data/models/recipe/recipe_draft.dart';
import '../../../../../core/widgets/controls/edit_field.dart';
import '../detail/sections/recipe_component_header.dart';
import '../edit/recipe_editors.dart';

/// Rascunho editável da importação. Muta [draft] em memória e chama [onSave]
/// (que congela e fecha a sheet). Usada por: import_sheet.
class ImportPreview extends StatefulWidget {
  const ImportPreview({super.key, required this.draft, required this.onSave});

  final RecipeDraft draft;
  final VoidCallback onSave;

  @override
  State<ImportPreview> createState() => _ImportPreviewState();
}

class _ImportPreviewState extends State<ImportPreview> {
  late final TextEditingController _name;

  /// Cria o controller do nome a partir do rascunho. Usada por: framework.
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.draft.title);
  }

  /// Libera o controller do nome. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Monta os campos + editores + botão salvar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        EditTextField(
          label: 'Nome',
          controller: _name,
          hint: 'Nome da receita',
        ),
        EditStepperField(
          label: 'Porções',
          value: draft.servings,
          min: 1,
          onChanged: (v) => setState(() => draft.servings = v),
        ),
        const SectionHeader(label: 'Ingredientes'),
        for (final c in draft.components) ...[
          if (c.name != null) RecipeComponentHeader(name: c.name!),
          IngredientsEditor(
            ingredients: c.ingredients,
            onDirty: () => setState(() {}),
          ),
        ],
        const SectionHeader(label: 'Modo de preparo'),
        for (final c in draft.components) ...[
          if (c.name != null) RecipeComponentHeader(name: c.name!),
          StepsEditor(steps: c.steps, onDirty: () => setState(() {})),
        ],
        const SizedBox(height: AppSpacing.xl),
        PitadaButton(
          label: 'Salvar receita',
          icon: AppIcons.check,
          onPressed: () {
            draft.title = _name.text;
            widget.onSave();
          },
        ),
      ],
    );
  }
}
