// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/router.dart
// O QUÊ:     Configuração do go_router: shell das 5 abas + rotas full-screen +
//            gate de auth (online sem sessão -> /entrar; offline nunca barra).
// USA:       go_router, app_shell, routes.dart, features/auth (gate), config/env.
// USADO POR: app.dart (routerProvider -> MaterialApp.router).
// SPEC:      specs/features/app_shell.yaml + specs/features/auth.yaml (router_gate)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/notebook/presentation/screens/notebook_screen.dart';
import '../../features/plans/presentation/plans_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/recipes/presentation/screens/recipes_screen.dart';
import '../../features/groceries/presentation/groceries_screen.dart';
import '../config/env.dart';
import 'app_shell.dart';
import 'routes.dart';

/// Navigator raiz — usado pelas rotas full-screen que cobrem a barra de abas.
final _rootKey = GlobalKey<NavigatorState>();

/// Cria um branch de aba com uma única rota-raiz. Usada por: [routerProvider].
StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (_, __) => screen)],
  );
}

/// Faz o router reavaliar o redirect quando a sessão muda (login/logout).
/// Usada por: routerProvider (refreshListenable).
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Stream<bool> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<bool> _sub;

  /// Cancela a escuta do stream junto com o provider. Usada por: ref.onDispose.
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Fornece o GoRouter do app, com o gate de auth (specs/features/auth.yaml).
/// Usada por: app.dart.
final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  final refresh = _AuthRefresh(auth.authStateChanges);
  ref.onDispose(refresh.dispose);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/recipes',
    refreshListenable: refresh,
    redirect: (context, state) {
      if (!Env.hasSupabase) return null;
      final atSignIn = state.matchedLocation == '/entrar';
      if (!auth.isSignedIn) return atSignIn ? null : '/entrar';
      return atSignIn ? '/recipes' : null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          _branch('/recipes', const RecipesScreen()),
          _branch('/learning', const NotebookScreen()),
          _branch('/plans', const PlansScreen()),
          _branch('/shopping', const GroceriesScreen()),
          _branch('/profile', const ProfileScreen()),
        ],
      ),

      ...buildFullscreenRoutes(_rootKey),
    ],
  );
});
