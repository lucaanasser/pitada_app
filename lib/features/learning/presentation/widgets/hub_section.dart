// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/hub_section.dart
// O QUÊ:     Seção do hub do Caderno: SectionHeader + linhas HairlineRow que
//            navegam para os destinos (Fichas, Notas, Diário, Rácios…).
// USA:       core/widgets (SectionHeader, HairlineRow, RecipeThumb), theme/*,
//            go_router (navegação entre destinos).
// USADO POR: LearningScreen (as 3 seções Conhecimento/Prática/Repertório).
// SPEC:      specs/features/learning.yaml (screens.LearningScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/recipe_thumb.dart';
import '../../../../core/widgets/section_header.dart';

/// Um destino navegável do hub: rótulo, subtítulo, cor da miniatura e rota.
/// Usada por: [HubSection] para montar cada linha.
class HubDestination {
  final String title;
  final String subtitle;
  final String heroColor; // nome em AppColors.hero
  final IconData icon;
  final String route;

  const HubDestination({
    required this.title,
    required this.subtitle,
    required this.heroColor,
    required this.icon,
    required this.route,
  });
}

/// Uma seção do hub: cabeçalho em versalete + lista de destinos com filete.
/// Usada por: LearningScreen (Conhecimento, Prática, Repertório).
class HubSection extends StatelessWidget {
  const HubSection({
    super.key,
    required this.label,
    required this.destinations,
    this.topGap = AppSpacing.xxxl,
  });

  final String label;
  final List<HubDestination> destinations;
  final double topGap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: label, topGap: topGap),
        for (var i = 0; i < destinations.length; i++)
          HairlineRow(
            leading: RecipeThumb(
              color: AppColors.heroOf(destinations[i].heroColor),
              size: 44,
              icon: destinations[i].icon,
            ),
            title: Text(destinations[i].title, style: AppType.title),
            subtitle: Text(destinations[i].subtitle, style: AppType.caption),
            trailing: const Icon(Icons.chevron_right,
                size: 20, color: AppColors.faint),
            showDivider: i != destinations.length - 1,
            onTap: () => context.push(destinations[i].route),
          ),
      ],
    );
  }
}
