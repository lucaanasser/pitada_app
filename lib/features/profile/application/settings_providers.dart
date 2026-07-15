// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/application/settings_providers.dart
// O QUÊ:     Estado das configurações do app (cozinha + notificações). Em memória
//            hoje; ganha persistência local quando houver backend.
// USA:       flutter_riverpod (StateProvider).
// USADO POR: settings_screen (lê/escreve); futuramente plans (porções padrão) e
//            recipes (dicas de técnica nos passos).
// SPEC:      specs/features/profile.yaml (application.providers — configurações)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Porções padrão ao adicionar uma receita ao plano (1..8).
/// Usada por: SettingsScreen (stepper); plans consumirá depois.
final defaultServingsProvider = StateProvider<int>((ref) => 2);

/// Mostrar os callouts "Por quê" (dicas de técnica) nos passos das receitas.
/// Usada por: SettingsScreen (toggle); recipes consumirá depois.
final techniqueTipsProvider = StateProvider<bool>((ref) => true);

/// Notificação: lembrete diário de cozinhar. Usada por: SettingsScreen.
final notifyCookReminderProvider = StateProvider<bool>((ref) => false);

/// Notificação: alertas de validade da despensa. Usada por: SettingsScreen.
final notifyExpiryProvider = StateProvider<bool>((ref) => true);

/// Notificação: montar o plano da semana (domingo). Usada por: SettingsScreen.
final notifyWeeklyPlanProvider = StateProvider<bool>((ref) => false);
