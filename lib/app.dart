// ─────────────────────────────────────────────────────────────────────────────
// lib/app.dart
// O QUÊ:     Widget raiz (MaterialApp.router) com os temas claro/escuro e as rotas.
// USA:       core/theme/app_theme (temas), core/theme/theme_providers (modo),
//            core/router/router (rotas), riverpod.
// USADO POR: main.dart.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_providers.dart';

/// Raiz do Pitada: aplica os temas (claro + escuro) e liga o go_router.
/// Usada por: main.dart.
class PitadaApp extends ConsumerWidget {
  const PitadaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Pitada',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      routerConfig: router,
    );
  }
}
