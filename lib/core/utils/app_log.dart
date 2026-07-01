// ─────────────────────────────────────────────────────────────────────────────
// lib/core/utils/app_log.dart
// O QUÊ:     Log padronizado do app. Formato único: [Pitada][<tag>] <mensagem>.
// USA:       dart:developer (log) e foundation (kDebugMode). Nada de print solto.
// USADO POR: repositórios, controllers e services de todas as features.
// REGRA:     .claude/rules/comentarios-e-logs.md
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Logger central do Pitada. Sempre passe a `tag` da feature como 1º argumento
/// (ex.: 'recipes', 'plans', 'shopping', 'learning', 'core').
/// Usada por: qualquer camada que precise registrar algo (nunca use print).
class AppLog {
  AppLog._();

  static const _prefix = 'Pitada';

  /// Log de depuração — some em release. Usada por: fluxos internos/diagnóstico.
  static void d(String tag, String message) {
    if (kDebugMode) dev.log(_fmt(tag, message), name: '$_prefix.debug');
  }

  /// Log informativo — eventos relevantes do app. Usada por: controllers/services.
  static void i(String tag, String message) {
    dev.log(_fmt(tag, message), name: '$_prefix.info');
  }

  /// Aviso — algo inesperado, mas recuperável. Usada por: repositórios/services.
  static void w(String tag, String message) {
    dev.log(_fmt(tag, message), name: '$_prefix.warn');
  }

  /// Erro — falha real, com objeto e stack opcionais. Usada por: try/catch.
  static void e(String tag, String message,
      [Object? error, StackTrace? stack]) {
    dev.log(_fmt(tag, message),
        name: '$_prefix.error', error: error, stackTrace: stack);
  }

  /// Monta a linha padrão `[Pitada][tag] mensagem`. Usada por: os métodos acima.
  static String _fmt(String tag, String message) => '[$_prefix][$tag] $message';
}
