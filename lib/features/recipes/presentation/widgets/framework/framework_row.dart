// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/framework_row.dart
// O QUÊ:     Linha de framework na lista, irmã do RecipeRow (mesmo ritmo):
//            tipografia pura — nome + lacunas em texto + seta, sem miniatura.
// USA:       core/theme (AppIcons, PitadaColors, AppType),
//            core/widgets (HairlineRow), Framework.
// USADO POR: frameworks_tab_view.
// SPEC:      specs/features/recipes.yaml (RecipesScreen: framework_row)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../data/models/framework.dart';

/// Um framework como linha de lista, no mesmo ritmo do RecipeRow: as lacunas
/// (slots) são o subtítulo; sem slots, entra "N passos · N receitas".
/// Usada por: FrameworksTabView.
class FrameworkRow extends StatelessWidget {
  const FrameworkRow({
    super.key,
    required this.framework,
    this.onTap,
    this.showDivider = true,
  });

  final Framework framework;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha (nome + lacunas + seta). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final steps = framework.skeleton.length;
    final uses = framework.recipeIds.length;
    final subtitle = framework.slots.isNotEmpty
        ? framework.slots.join(' · ')
        : '$steps ${steps == 1 ? 'passo' : 'passos'} · '
            '$uses ${uses == 1 ? 'receita' : 'receitas'}';
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      title: Text(framework.name, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        subtitle,
        style: AppType.on(AppType.caption, pit.muted),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }
}
