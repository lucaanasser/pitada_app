// ─────────────────────────────────────────────────────────────────────────────
// lib/main.dart
// O QUÊ:     Ponto de entrada. Inicializa Supabase (se houver chaves) e sobe o app.
// USA:       core/supabase (init), core/utils/app_log, app.dart (PitadaApp), riverpod.
// USADO POR: o runtime do Flutter (função main).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/supabase/supabase.dart';
import 'core/utils/app_log.dart';

/// Sobe o Pitada. Inicializa o backend quando configurado e injeta os providers.
/// Usada por: o runtime do Flutter.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final online = await SupabaseService.initIfConfigured();
  AppLog.i('core', 'app iniciando (online=$online)');

  // Sem overrides por enquanto: os repositórios usam dados de exemplo em memória.
  // No futuro, aqui entram os overrides de services de hardware (mock no PC).
  runApp(const ProviderScope(child: PitadaApp()));
}
