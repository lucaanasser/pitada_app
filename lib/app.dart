// ─────────────────────────────────────────────────────────────────────────────
// lib/app.dart
// O QUÊ:     Widget raiz (MaterialApp.router) com o tema e as rotas do app.
// USA:       core/theme/app_theme (tema), core/router/router (rotas), riverpod.
// USADO POR: main.dart.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/theme/app_theme.dart';

/// Raiz do Pitada: aplica o tema escuro e liga o go_router.
/// Usada por: main.dart.
class PitadaApp extends ConsumerWidget {
  const PitadaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Pitada',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
