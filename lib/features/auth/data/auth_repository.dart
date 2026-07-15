// ─────────────────────────────────────────────────────────────────────────────
// lib/features/auth/data/auth_repository.dart
// O QUÊ:     Fonte de autenticação: contrato + impl Supabase (OTP por e-mail) +
//            mock (preview no PC, sem chaves — sessão sempre ativa).
// USA:       supabase_flutter (GoTrue), core/supabase (cliente), core/utils/app_log.
// USADO POR: auth_providers (application). A UI nunca chama isto direto.
// SPEC:      specs/features/auth.yaml (data) + specs/backend/auth.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase.dart';
import '../../../core/utils/app_log.dart';

/// Contrato de autenticação do app (login por e-mail + código de 6 dígitos).
/// Usada por: auth_providers; implementada por SupabaseAuthRepository e
/// MockAuthRepository (main.dart escolhe via override do provider).
abstract class AuthRepository {
  /// Dispara o e-mail com o código de 6 dígitos. Usada por: SignInController.sendCode.
  Future<void> signInWithOtp(String email);

  /// Troca o código digitado por uma sessão. Usada por: SignInController.confirm.
  Future<void> verifyOtp(String email, String token);

  /// Encerra a sessão atual. Usada por: SignInController.signOut (Perfil, futuro).
  Future<void> signOut();

  /// True quando há sessão ativa. Usada por: redirect do router (gate).
  bool get isSignedIn;

  /// Emite true/false a cada mudança de sessão (login/logout/refresh).
  /// Usada por: authStateProvider e refreshListenable do router.
  Stream<bool> get authStateChanges;
}

/// Implementação online: delega ao GoTrue do Supabase (sessão persistida e
/// renovada pelo SDK). Usada por: main.dart quando initIfConfigured() == true.
class SupabaseAuthRepository implements AuthRepository {
  const SupabaseAuthRepository();

  GoTrueClient get _auth => SupabaseService.client.auth;

  /// Envia o código por e-mail; 1º login também cria a conta (signup implícito).
  /// Usada por: SignInController.sendCode.
  @override
  Future<void> signInWithOtp(String email) async {
    await _auth.signInWithOtp(email: email);
    AppLog.i('auth', 'código enviado para $email');
  }

  /// Valida o código de 6 dígitos e abre a sessão. Usada por: SignInController.confirm.
  @override
  Future<void> verifyOtp(String email, String token) async {
    await _auth.verifyOTP(type: OtpType.email, email: email, token: token);
    AppLog.i('auth', 'sessão aberta para $email');
  }

  /// Encerra a sessão no servidor e limpa o storage local. Usada por: SignInController.
  @override
  Future<void> signOut() async {
    await _auth.signOut();
    AppLog.i('auth', 'sessão encerrada');
  }

  @override
  bool get isSignedIn => _auth.currentSession != null;

  /// Mapeia o stream do GoTrue para bool (tem sessão?). O SDK emite também o
  /// estado inicial (initialSession) ao escutar — o gate acorda já certo.
  @override
  Stream<bool> get authStateChanges =>
      _auth.onAuthStateChange.map((s) => s.session != null);
}

/// Implementação de preview (PC, sem chaves): sessão fake sempre ativa — o app
/// nunca mostra a tela de entrar. Usada por: authRepositoryProvider (default).
class MockAuthRepository implements AuthRepository {
  const MockAuthRepository();

  /// No-op de preview (loga para o fluxo ficar visível no console).
  @override
  Future<void> signInWithOtp(String email) async {
    AppLog.d('auth', 'mock: código "enviado" para $email');
  }

  /// No-op de preview: qualquer código "funciona".
  @override
  Future<void> verifyOtp(String email, String token) async {
    AppLog.d('auth', 'mock: sessão aberta para $email');
  }

  /// No-op de preview.
  @override
  Future<void> signOut() async {
    AppLog.d('auth', 'mock: signOut ignorado');
  }

  @override
  bool get isSignedIn => true;

  /// Um único evento true — suficiente para providers/gate no preview.
  @override
  Stream<bool> get authStateChanges => Stream.value(true);
}
