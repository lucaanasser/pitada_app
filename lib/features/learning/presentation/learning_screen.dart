// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/learning_screen.dart
// O QUÊ:     Aba Caderno — o hub. Marca, título, intro, botão '+' e 3 seções
//            (Conhecimento/Prática/Repertório) com destinos navegáveis.
// USA:       core/widgets (Masthead, PitadaScaffold, PitadaIconButton), theme/*,
//            HubSection (seções) e caderno_add_sheet (ação '+').
// USADO POR: core/router/router.dart (branch /learning).
// SPEC:      specs/features/learning.yaml (screens.LearningScreen)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import 'caderno_add_sheet.dart';
import 'widgets/hub_section.dart';

/// Tela principal do Caderno (hub). Reúne todos os destinos do aprendizado.
/// Usada por: router (/learning).
class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PitadaScaffold(
      top: const Masthead(),
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
        children: [
          _header(context),
          const Padding(
            padding: AppSpacing.screenH,
            child: HubSection(
              label: 'Conhecimento',
              topGap: AppSpacing.xxxl,
              destinations: _knowledge,
            ),
          ),
          const Padding(
            padding: AppSpacing.screenH,
            child: HubSection(label: 'Prática', destinations: _practice),
          ),
          const Padding(
            padding: AppSpacing.screenH,
            child: HubSection(label: 'Repertório', destinations: _repertoire),
          ),
        ],
      ),
    );
  }

  /// Cabeçalho do hub: título "Caderno", botão '+' e a citação de intro.
  /// Usada por: [build].
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                  child: Text('Caderno', style: AppType.screenTitle)),
              PitadaIconButton(
                icon: AppIcons.add,
                onPressed: () => showCadernoAddSheet(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Seu segundo cérebro na cozinha — o que você aprende, tudo ligado às receitas.',
            style: AppType.on(AppType.quote, AppColors.text2),
          ),
        ],
      ),
    );
  }
}

/// Seção Conhecimento: o que você aprende fora. Usada por: [LearningScreen].
const _knowledge = <HubDestination>[
  HubDestination(
    title: 'Fichas',
    subtitle: 'Técnicas, frameworks e guias de ingredientes',
    heroColor: 'clay',
    icon: AppIcons.book,
    route: '/learning/cards',
  ),
  HubDestination(
    title: 'Notas de fonte',
    subtitle: 'O que fica de livros, vídeos e chefs',
    heroColor: 'ochre',
    icon: AppIcons.bookmark,
    route: '/learning/notes',
  ),
];

/// Seção Prática: evoluir cozinhando. Usada por: [LearningScreen].
const _practice = <HubDestination>[
  HubDestination(
    title: 'Diário de cozinha',
    subtitle: 'Três perguntas depois de cozinhar',
    heroColor: 'moss',
    icon: AppIcons.editNote,
    route: '/learning/diary',
  ),
  HubDestination(
    title: 'Versões de receita',
    subtitle: 'A linha do tempo de cada ajuste',
    heroColor: 'teal',
    icon: AppIcons.timeline,
    route: '/learning/versions',
  ),
  HubDestination(
    title: 'Logs de processo',
    subtitle: 'Fermentação, sous-vide, cura — avançado',
    heroColor: 'plum',
    icon: AppIcons.science,
    route: '/learning/logs',
  ),
];

/// Seção Repertório: cozinhar sem receita. Usada por: [LearningScreen].
const _repertoire = <HubDestination>[
  HubDestination(
    title: 'Rácios',
    subtitle: 'Proporções de confiança',
    heroColor: 'terra',
    icon: AppIcons.balance,
    route: '/learning/repertoire/ratios',
  ),
  HubDestination(
    title: 'Substituições',
    subtitle: 'Trocas testadas na prática',
    heroColor: 'rust',
    icon: AppIcons.swap,
    route: '/learning/repertoire/subs',
  ),
  HubDestination(
    title: 'Harmonizações',
    subtitle: 'O que combina com o quê',
    heroColor: 'moss',
    icon: AppIcons.hub,
    route: '/learning/repertoire/pairings',
  ),
];
