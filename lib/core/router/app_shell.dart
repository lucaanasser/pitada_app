// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/app_shell.dart
// O QUÊ:     Casca de navegação com as 5 abas (mantém o estado de cada aba).
// USA:       go_router (StatefulNavigationShell), core/widgets/pitada_tab_bar.
// USADO POR: core/router/router.dart (StatefulShellRoute).
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors.dart';
import '../widgets/pitada_tab_bar.dart';

/// As 5 abas do app, na ordem da barra inferior (Home ao centro).
const kPitadaTabs = <PitadaTab>[
  PitadaTab(Icons.menu_book_outlined, 'Receitas'),
  PitadaTab(Icons.edit_note_outlined, 'Caderno'),
  PitadaTab(Icons.groups, 'Home',
      raised: true), // Comunidade — destaque central
  PitadaTab(Icons.event_note_outlined, 'Planos'),
  PitadaTab(Icons.shopping_basket_outlined, 'Compras'),
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
