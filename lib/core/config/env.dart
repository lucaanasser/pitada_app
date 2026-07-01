// ─────────────────────────────────────────────────────────────────────────────
// lib/core/config/env.dart
// O QUÊ:     Configuração de ambiente (chaves do Supabase via --dart-define).
// USA:       nada — lê variáveis de compilação (String.fromEnvironment).
// USADO POR: main.dart (init do Supabase) e core/supabase/supabase.dart.
// ─────────────────────────────────────────────────────────────────────────────

/// Variáveis de ambiente do app, injetadas por `--dart-define` na build/run.
/// Ex.: flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
/// Usada por: main.dart e o cliente Supabase.
class Env {
  Env._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// True quando as chaves do Supabase foram passadas. Quando false, o app roda
  /// com dados de exemplo em memória (preview no PC, sem backend).
  /// Usada por: main.dart para decidir se inicializa o Supabase.
  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
