// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/app_shell.dart
// O QUÊ:     Casca de navegação com as 5 abas (mantém o estado de cada aba).
// USA:       go_router (StatefulNavigationShell), core/theme/app_icons,
//            core/widgets/pitada_tab_bar.
// USADO POR: core/router/router.dart (StatefulShellRoute).
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_icons.dart';
import '../theme/colors.dart';
import '../widgets/pitada_tab_bar.dart';

/// As 5 abas do app, na ordem da barra inferior. Ícone regular (inativo) + fill (ativo).
const kPitadaTabs = <PitadaTab>[
  PitadaTab(AppIcons.recipes, AppIcons.recipesFill, 'Receitas'),
  PitadaTab(AppIcons.notebook, AppIcons.notebookFill, 'Caderno'),
  PitadaTab(AppIcons.home, AppIcons.homeFill, 'Home'),
  PitadaTab(AppIcons.plans, AppIcons.plansFill, 'Planos'),
  PitadaTab(AppIcons.shopping, AppIcons.shoppingFill, 'Compras'),
];

/// Envolve as abas: mostra o conteúdo da aba atual + a barra inferior.
/// Usada por: router.dart. [shell] é fornecido pelo StatefulShellRoute.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: shell,
      bottomNavigationBar: PitadaTabBar(
        tabs: kPitadaTabs,
        currentIndex: shell.currentIndex,
        onSelect: _goBranch,
      ),
    );
  }

  /// Troca de aba preservando o estado da pilha de cada uma. Usada por: a barra.
  void _goBranch(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }
}
