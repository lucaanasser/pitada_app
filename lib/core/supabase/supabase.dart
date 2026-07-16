// ─────────────────────────────────────────────────────────────────────────────
// lib/core/supabase/supabase.dart
// O QUÊ:     Ponto único de acesso ao cliente Supabase (inicialização + getter).
// USA:       supabase_flutter (SDK), core/config/env (chaves), core/utils/app_log.
// USADO POR: main.dart (init) e os repositórios em features/*/data (quando online).
// NOTA:      Sem chaves (preview no PC), o app usa repositórios em memória (seed).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env.dart';
import '../utils/app_log.dart';

/// Gerencia o ciclo de vida do cliente Supabase de forma centralizada.
/// Usada por: main.dart (initIfConfigured) e repositórios (client).
class SupabaseService {
  SupabaseService._();

  /// Inicializa o Supabase somente se as chaves existirem (Env.hasSupabase).
  /// Devolve true se ficou online. Usada por: main.dart antes de runApp.
  static Future<bool> initIfConfigured() async {
    if (!Env.hasSupabase) {
      AppLog.i('core', 'sem chaves Supabase — rodando com dados de exemplo');
      return false;
    }
    await Supabase.initialize(
      url: Env.supabaseUrl,
      // ignore: deprecated_member_use
      anonKey: Env.supabaseAnonKey,
    );
    AppLog.i('core', 'Supabase inicializado');
    return true;
  }

  /// Cliente Supabase pronto para consultas. Só use quando [initIfConfigured]
  /// retornou true. Usada por: repositórios online em features/*/data.
  static SupabaseClient get client => Supabase.instance.client;
}
