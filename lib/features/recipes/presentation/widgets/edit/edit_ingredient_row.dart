// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/edit/edit_ingredient_row.dart
// O QUÊ:     Linha editável de ingrediente: nome + gramas + unidade humana + remover.
// USA:       theme/*, Ingredient (modelo). Campos de texto sobre superfície surf2.
// USADO POR: recipe_edit_screen e import_preview (editor de ingredientes).
// SPEC:      specs/features/recipes.yaml (EditIngredientEditor)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/models/ingredient.dart';

/// Linha de edição de um ingrediente. Notifica [onChanged] a cada tecla e
/// [onRemove] no ícone de lixeira. Usada por: editores de ingredientes.
class EditIngredientRow extends StatefulWidget {
  const EditIngredientRow({
    super.key,
    required this.ingredient,
    required this.onChanged,
    required this.onRemove,
  });

  final Ingredient ingredient;
  final ValueChanged<Ingredient> onChanged;
  final VoidCallback onRemove;

  @override
  State<EditIngredientRow> createState() => _EditIngredientRowState();
}

class _EditIngredientRowState extends State<EditIngredientRow> {
  late final TextEditingController _name;
  late final TextEditingController _grams;
  late final TextEditingController _unit;

  /// Cria os controllers a partir do ingrediente inicial. Usada por: framework.
  @override
  void initState() {
    super.initState();
    final ing = widget.ingredient;
    _name = TextEditingController(text: ing.name);
    _grams =
        TextEditingController(text: ing.grams == null ? '' : '${ing.grams}');
    _unit = TextEditingController(text: ing.humanUnit ?? '');
  }

  /// Libera os controllers de texto. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    _grams.dispose();
    _unit.dispose();
    super.dispose();
  }

  /// Reconstrói o Ingredient a partir dos campos e avisa o pai. Usada por: onChanged.
  void _emit() {
    widget.onChanged(
      Ingredient(
        name: _name.text,
        grams: num.tryParse(_grams.text.replaceAll(',', '.')),
        humanUnit: _unit.text.isEmpty ? null : _unit.text,
      ),
    );
  }

  /// Monta os três campos + botão remover numa linha. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: _box(pit, _name, 'Ingrediente')),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: _box(
              pit,
              _grams,
              'g',
              keyboard: TextInputType.number,
              alignEnd: true,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(flex: 2, child: _box(pit, _unit, 'un')),
          IconButton(
            onPressed: widget.onRemove,
            icon: Icon(AppIcons.close, size: 18, color: pit.faint),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }

  /// Caixa de texto padrão do editor (surf2, sem borda). Usada por: [build].
  Widget _box(
    PitadaColors pit,
    TextEditingController c,
    String hint, {
    TextInputType? keyboard,
    bool alignEnd = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: pit.surf2,
        borderRadius: AppSpacing.br(AppSpacing.radiusSm),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md - 2,
      ),
      child: TextField(
        controller: c,
        onChanged: (_) => _emit(),
        keyboardType: keyboard,
        textAlign: alignEnd ? TextAlign.end : TextAlign.start,
        style: AppType.on(AppType.bodySm, pit.text),
        cursorColor: AppColors.accent,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppType.on(AppType.bodySm, pit.faint),
        ),
      ),
    );
  }
}
