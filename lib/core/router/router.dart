// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/router.dart
// O QUÊ:     Configuração do go_router: shell das 5 abas + rotas full-screen.
// USA:       go_router, app_shell, routes.dart (rotas full-screen), as telas de aba.
// USADO POR: app.dart (routerProvider -> MaterialApp.router).
// SPEC:      specs/features/app_shell.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/learning/presentation/learning_screen.dart';
import '../../features/plans/presentation/plans_screen.dart';
import '../../features/recipes/presentation/recipes_screen.dart';
import '../../features/shopping/presentation/shopping_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

/// Navigator raiz — usado pelas rotas full-screen que cobrem a barra de abas.
final _rootKey = GlobalKey<NavigatorState>();

/// Cria um branch de aba com uma única rota-raiz. Usada por: [routerProvider].
StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (_, __) => screen)]);
}

/// Fornece o GoRouter do app. Provider para permitir redirect por auth no futuro.
/// Usada por: app.dart.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/recipes',
    routes: [
      // —— Shell das 5 abas (cada aba mantém sua própria pilha) ——
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          _branch('/recipes', const RecipesScreen()),
          _branch('/learning', const LearningScreen()),
          _branch('/home', const HomeScreen()),
          _branch('/plans', const PlansScreen()),
          _branch('/shopping', const ShoppingScreen()),
        ],
      ),

      // —— Rotas full-screen (detalhe/edição, cobrem a barra) ——
      ...buildFullscreenRoutes(_rootKey),
    ],
  );
});
