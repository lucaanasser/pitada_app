// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/presentation/settings_screen.dart
// O QUÊ:     Configurações do app (rota full-screen aberta pelo Perfil), em
//            seções: Aparência (ThemePicker), Cozinha, Notificações e Sobre.
// USA:       core/theme (context.pit, spacing, type, icons), core/widgets
//            (PitadaScaffold, SectionHeader, HairlineRow, PitadaIconButton),
//            settings_providers, ThemePicker, SettingsRows, go_router, app_log.
// USADO POR: core/router/routes.dart (/profile/settings); Perfil (botão de config).
// SPEC:      specs/features/profile.yaml (screens.SettingsScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/hairline_row.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../application/settings_providers.dart';
import 'widgets/settings_rows.dart';
import 'widgets/theme_picker.dart';

/// Tela de configurações do app. Usada por: router (/profile/settings).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  /// Monta cabeçalho + seções de configuração. Usada por: router.
  /// Scaffold por fora: rota full-screen precisa do Material (como recipe_detail);
  /// sem ele, os textos ganham o sublinhado amarelo de debug.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    return Scaffold(
      backgroundColor: pit.bg,
      body: PitadaScaffold(
        background: pit.bg,
        child: ListView(
          padding: tabListPadding(context),
          children: [
            _header(context, pit),
            Padding(
              padding: AppSpacing.screenH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                      label: 'Aparência', topGap: AppSpacing.sm),
                  const SizedBox(height: AppSpacing.sm),
                  const ThemePicker(),
                  const SectionHeader(label: 'Cozinha'),
                  _kitchen(ref),
                  const SectionHeader(label: 'Notificações'),
                  _notifications(ref),
                  const SectionHeader(label: 'Sobre'),
                  _about(pit),
                  const SizedBox(height: AppSpacing.xxxl),
                  _footer(pit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Cabeçalho: botão de voltar + título grande "Configurações". Usada por: [build].
  Widget _header(BuildContext context, PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.md,
        AppSpacing.gutter,
        AppSpacing.titleGap,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PitadaIconButton(
            icon: AppIcons.back,
            onPressed: () => context.pop(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Configurações',
              style: AppType.on(AppType.screenTitle, pit.text)),
        ],
      ),
    );
  }

  /// Seção Cozinha: porções padrão + dicas de técnica. Usada por: [build].
  Widget _kitchen(WidgetRef ref) {
    return Column(
      children: [
        SettingsStepperRow(
          title: 'Porções padrão',
          subtitle: 'Usada ao adicionar receitas ao plano',
          value: ref.watch(defaultServingsProvider),
          onChanged: (v) {
            ref.read(defaultServingsProvider.notifier).state = v;
            AppLog.i('profile', 'porções padrão: $v');
          },
        ),
        SettingsSwitchRow(
          title: 'Dicas de técnica',
          subtitle: 'Mostra o "porquê" nos passos das receitas',
          value: ref.watch(techniqueTipsProvider),
          onChanged: (v) => ref.read(techniqueTipsProvider.notifier).state = v,
          showDivider: false,
        ),
      ],
    );
  }

  /// Seção Notificações: 3 toggles. Usada por: [build].
  Widget _notifications(WidgetRef ref) {
    return Column(
      children: [
        SettingsSwitchRow(
          title: 'Lembrete de cozinhar',
          subtitle: 'Um empurrãozinho diário para manter a sequência',
          value: ref.watch(notifyCookReminderProvider),
          onChanged: (v) =>
              ref.read(notifyCookReminderProvider.notifier).state = v,
        ),
        SettingsSwitchRow(
          title: 'Alertas de validade',
          subtitle: 'Avisa quando algo da despensa está para vencer',
          value: ref.watch(notifyExpiryProvider),
          onChanged: (v) => ref.read(notifyExpiryProvider.notifier).state = v,
        ),
        SettingsSwitchRow(
          title: 'Plano da semana',
          subtitle: 'Lembra de montar o plano no domingo',
          value: ref.watch(notifyWeeklyPlanProvider),
          onChanged: (v) =>
              ref.read(notifyWeeklyPlanProvider.notifier).state = v,
          showDivider: false,
        ),
      ],
    );
  }

  /// Seção Sobre: versão + guia de construção. Usada por: [build].
  Widget _about(PitadaColors pit) {
    return Column(
      children: [
        HairlineRow(
          title: Text('Versão', style: AppType.on(AppType.body, pit.text)),
          trailing: Text(
            '0.1 · protótipo',
            style: AppType.on(AppType.caption, pit.muted),
          ),
        ),
        SettingsLinkRow(
          title: 'Guia de construção',
          subtitle: 'Como o Pitada é feito, por dentro',
          onTap: () => AppLog.i('profile', 'abrir guia de construção'),
          showDivider: false,
        ),
      ],
    );
  }

  /// Rodapé afetivo centrado. Usada por: [build].
  Widget _footer(PitadaColors pit) {
    return Center(
      child: Text(
        'Feito em casa, como toda boa receita.',
        style: AppType.on(AppType.caption, pit.faint),
      ),
    );
  }
}
