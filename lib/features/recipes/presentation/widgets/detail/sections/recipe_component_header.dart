// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/sections/recipe_component_header.dart
// O QUÊ:     Subcabeçalho de componente (massa/cobertura) dentro de uma seção do
//            detalhe — versalete cinza + filete. Variante VINCULADA carrega o
//            selo "1,5× · em 2 receitas" (tocável -> subreceita).
// USA:       core/widgets/section_header, core/widgets/editable, core/theme
//            (AppSpacing), core/utils/scaling (formatFactor).
// USADO POR: recipe_ingredients_section, recipe_steps_section, recipe_edit_screen,
//            import_preview.
// SPEC:      specs/features/recipes.yaml (componentes_na_tela) +
//            specs/features/sub_recipes.yaml (ui.no_prato)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/utils/scaling.dart';
import '../../../../../../core/widgets/controls/editable.dart';
import '../../../../../../core/widgets/layout/section_header.dart';

/// Nome do componente como subcabeçalho versalete com filete dentro da seção
/// (seção, nunca aba). Com [linkScale]/[linkUsedBy] vira o cabeçalho VINCULADO:
/// selo sóbrio no action ('1,5× · em 2 receitas', toca -> [onOpen]); segurar/
/// duplo-clique ([onEdit]) abre as ações do componente. Usada por: seções de
/// ingredientes e passos.
class RecipeComponentHeader extends StatelessWidget {
  const RecipeComponentHeader({
    super.key,
    required this.name,
    this.linkScale,
    this.linkUsedBy,
    this.onOpen,
    this.onEdit,
  });

  final String name;
  final num? linkScale;
  final int? linkUsedBy;
  final VoidCallback? onOpen;
  final VoidCallback? onEdit;

  /// Monta o nome via SectionHeader (+ selo de vínculo quando houver), com
  /// respiro reduzido por ser aninhado. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Editable(
      onEdit: onEdit,
      child: SectionHeader(
        label: name,
        topGap: AppSpacing.lg,
        action: _linkLabel(),
        onAction: onOpen,
      ),
    );
  }

  /// Selo do vínculo: fator (quando != 1) + "em N receitas". Null = local.
  /// Usada por: [build].
  String? _linkLabel() {
    if (linkScale == null) return null;
    final uses = linkUsedBy ?? 0;
    final count = uses == 1 ? 'em 1 receita' : 'em $uses receitas';
    return linkScale == 1 ? count : '${formatFactor(linkScale!)} · $count';
  }
}
