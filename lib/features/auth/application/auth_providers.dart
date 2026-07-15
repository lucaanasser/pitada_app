// ─────────────────────────────────────────────────────────────────────────────
// lib/features/auth/application/auth_providers.dart
// O QUÊ:     Providers Riverpod do auth: repositório (mock por padrão, Supabase
//            via override no main), estado de sessão e controller de login.
// USA:       auth_repository (data), riverpod, core/utils/app_log.
// USADO POR: sign_in_screen (presentation), core/router/router.dart (gate).
// SPEC:      specs/features/auth.yaml (application)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/auth_repository.dart';

/// Instância do repositório de auth. Default = mock (preview no PC, sem tela de
/// login); main.dart sobrescreve com SupabaseAuthRepository quando há chaves.
/// Usada por: authStateProvider, signInControllerProvider e o gate do router.
final authRepositoryProvider =
    Provider<AuthRepository>((ref) => const MockAuthRepository());

/// Estado de sessão (true = logado), reagindo a login/logout do repositório.
/// Usada por: telas que precisem reagir à sessão (Perfil, futuro).
final authStateProvider = StreamProvider<bool>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// Controller do fluxo de entrar: envia o código e confirma. Presentation nunca
/// fala com o repositório direto — passa por aqui. Usada por: SignInScreen.
class SignInController {
  const SignInController(this._ref);

  final Ref _ref;

  /// Dispara o e-mail com o código de 6 dígitos. Usada por: SignInScreen (estágio e-mail).
  Future<void> sendCode(String email) {
    AppLog.d('auth', 'enviando código para $email');
    return _ref.read(authRepositoryProvider).signInWithOtp(email);
  }

  /// Confirma o código e abre a sessão (o gate do router redireciona sozinho).
  /// Usada por: SignInScreen (estágio código).
  Future<void> confirm(String email, String code) {
    return _ref.read(authRepositoryProvider).verifyOtp(email, code);
  }

  /// Encerra a sessão. Usada por: tela de Perfil (futuro botão "Sair").
  Future<void> signOut() => _ref.read(authRepositoryProvider).signOut();
}

/// Instância do controller de login. Usada por: SignInScreen.
final signInControllerProvider =
    Provider<SignInController>(SignInController.new);
