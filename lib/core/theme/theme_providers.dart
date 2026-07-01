// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/theme_providers.dart
// O QUÊ:     Estado do modo de tema (claro/escuro/sistema).
// USA:       flutter_riverpod (StateProvider), material (ThemeMode).
// USADO POR: app.dart (MaterialApp.themeMode) e o toggle de tema (Perfil, futuro).
// SPEC:      specs/design-system/colors.yaml (tema claro + escuro)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Modo de tema atual. Padrão: escuro (base do app enquanto o tema claro é
/// migrado tela-a-tela). Vira `ThemeMode.system` quando todas as telas estiverem
/// prontas para o claro. Usada por: app.dart.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);
