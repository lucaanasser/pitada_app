// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/version_row.dart
// O QUÊ:     Linha de "Versões de receita" (miniatura + receita + "N versões · def. vX").
// USA:       core/widgets (HairlineRow, RecipeThumb), theme/*, RecipeVersion.
// USADO POR: VersionsScreen.
// SPEC:      specs/features/learning.yaml (VersionsScreen: HairlineRow "N versões · def.")
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/recipe_thumb.dart';
import '../../data/recipe_version.dart';

/// Um histórico de versões como linha de lista. Usada por: VersionsScreen.
class VersionRow extends StatelessWidget {
  const VersionRow({
    super.key,
    required this.version,
    this.onTap,
    this.showDivider = true,
  });

  final RecipeVersion version;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha: miniatura, receita e resumo "N versões · definitiva vX".
  /// Usada por: VersionsScreen.
  @override
  Widget build(BuildContext context) {
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading:
          RecipeThumb(color: AppColors.heroOf('ochre'), icon: AppIcons.history),
      title: Text(version.recipeName, style: AppType.titleSm),
      subtitle:
          Text(_meta(), style: AppType.on(AppType.caption, AppColors.muted)),
      trailing:
          const Icon(AppIcons.chevron, size: 16, color: AppColors.faint),
    );
  }

  /// "N versões · definitiva vX" — a definitiva é a última da linha do tempo.
  /// Usada por: [build].
  String _meta() {
    final n = version.timeline.length;
    final plural = n == 1 ? 'versão' : 'versões';
    if (version.timeline.isEmpty) return '$n $plural';
    final last = version.timeline.last.label;
    return '$n $plural  ·  definitiva $last';
  }
}
