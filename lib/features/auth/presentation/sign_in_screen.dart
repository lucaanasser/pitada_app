// ─────────────────────────────────────────────────────────────────────────────
// lib/features/auth/presentation/sign_in_screen.dart
// O QUÊ:     Tela de entrar: e-mail -> código de 6 dígitos (OTP). Dois estágios
//            na mesma tela; ao confirmar, o gate do router leva para as abas.
// USA:       auth_providers (controller), core/widgets (Masthead, EditTextField,
//            PitadaButton), core/theme (tokens), core/utils/app_log.
// USADO POR: core/router/routes.dart (rota /entrar, full-screen).
// SPEC:      specs/features/auth.yaml (presentation)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/edit_field.dart';
import '../../../core/widgets/masthead.dart';
import '../../../core/widgets/pitada_button.dart';
import '../application/auth_providers.dart';

/// Estágio do fluxo: digitar o e-mail ou digitar o código recebido.
enum _Stage { email, code }

/// Tela de login por e-mail + código. Scaffold (rota full-screen precisa de
/// Material). Usada por: rota /entrar quando não há sessão (gate do router).
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  _Stage _stage = _Stage.email;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  /// Envia o código para o e-mail digitado e avança ao estágio do código.
  /// Usada por: botão "Receber código".
  Future<void> _sendCode() async {
    final email = _email.text.trim();
    if (!email.contains('@')) {
      setState(() => _error = 'Digite um e-mail válido.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(signInControllerProvider).sendCode(email);
      setState(() {
        _stage = _Stage.code;
        _busy = false;
      });
    } catch (e, s) {
      AppLog.e('auth', 'falha ao enviar código', e, s);
      setState(() {
        _busy = false;
        _error =
            'Não deu para enviar o código. Confira o e-mail e tente de novo.';
      });
    }
  }

  /// Confirma o código; com a sessão aberta, o gate do router troca de tela.
  /// Usada por: botão "Entrar".
  Future<void> _confirm() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(signInControllerProvider)
          .confirm(_email.text.trim(), _code.text.trim());
      // Sem navegação manual: o redirect do router reage à sessão nova.
    } catch (e, s) {
      AppLog.e('auth', 'código recusado', e, s);
      setState(() {
        _busy = false;
        _error = 'Código inválido ou vencido. Confira e tente de novo.';
      });
    }
  }

  /// Monta a tela (masthead + título + estágio atual). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screenH,
          children: [
            const Masthead(),
            const SizedBox(height: AppSpacing.titleGap),
            Text('Entrar', style: AppType.on(AppType.title, pit.text)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _stage == _Stage.email
                  ? 'Digite seu e-mail para receber um código de acesso.'
                  : 'Enviamos um código de 6 dígitos para ${_email.text.trim()}.',
              style: AppType.on(AppType.body, pit.text2),
            ),
            const SizedBox(height: AppSpacing.xxl),
            if (_stage == _Stage.email)
              EditTextField(
                label: 'E-mail',
                controller: _email,
                hint: 'voce@exemplo.com',
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
              )
            else
              EditTextField(
                label: 'Código',
                controller: _code,
                hint: '000000',
                keyboardType: TextInputType.number,
                autofocus: true,
                style: AppType.numeral, // 6 dígitos em Space Grotesk
              ),
            if (_error != null) ...[
              Text(
                _error!,
                style: AppType.on(AppType.caption, AppColors.accent),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            const SizedBox(height: AppSpacing.sm),
            PitadaButton(
              label: _stage == _Stage.email
                  ? (_busy ? 'Enviando…' : 'Receber código')
                  : (_busy ? 'Entrando…' : 'Entrar'),
              onPressed: _busy
                  ? null
                  : (_stage == _Stage.email ? _sendCode : _confirm),
            ),
            if (_stage == _Stage.code) ...[
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: GestureDetector(
                  onTap: _busy
                      ? null
                      : () => setState(() {
                            _stage = _Stage.email;
                            _error = null;
                            _code.clear();
                          }),
                  child: Text(
                    'trocar e-mail',
                    style: AppType.on(AppType.caption, pit.muted),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
