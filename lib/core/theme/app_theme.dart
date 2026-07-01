// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/app_theme.dart
// O QUÊ:     Monta o ThemeData escuro do Pitada juntando os tokens do design system.
// USA:       theme/colors, theme/typography, theme/spacing (os três tokens).
// USADO POR: app.dart (MaterialApp.theme). É o tema global do app.
// SPEC:      specs/design-system/*.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';

/// Fábrica do tema visual do Pitada (só modo escuro — o app é sempre escuro).
/// Usada por: app.dart.
class AppTheme {
  AppTheme._();

  /// Devolve o ThemeData escuro padrão, alinhado ao protótipo pitada.html.
  /// Usada por: PitadaApp em app.dart.
  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      surface: AppColors.bg,
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.accent2,
      onSurface: AppColors.text,
      error: AppColors.accent2,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.bg,
      fontFamily: 'Inter',
      splashFactory: NoSplash.splashFactory, // sem brilho: visual editorial
      highlightColor: Colors.transparent,
      textTheme: _textTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: AppColors.accentLine,
        selectionHandleColor: AppColors.accent,
      ),
      inputDecorationTheme: _inputTheme,
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: AppSpacing.hair,
        space: AppSpacing.hair,
      ),
    );
  }

  /// Mapeia os estilos nomeados do AppType para o TextTheme do Material.
  /// Usada por: [dark]. Widgets devem preferir AppType.* diretamente.
  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppType.displayXl,
    headlineLarge: AppType.screenTitle,
    headlineMedium: AppType.display,
    titleLarge: AppType.title,
    titleMedium: AppType.titleSm,
    bodyLarge: AppType.bodyLg,
    bodyMedium: AppType.body,
    bodySmall: AppType.bodySm,
    labelLarge: AppType.button,
    labelSmall: AppType.label,
  );

  /// Estilo padrão dos campos de texto (.inp do protótipo).
  /// Usada por: [dark]; qualquer TextField herda daqui.
  static const InputDecorationTheme _inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surf2,
    hintStyle: TextStyle(color: AppColors.faint),
    contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg, vertical: AppSpacing.md),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusMd)),
      borderSide: BorderSide(color: AppColors.line2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusMd)),
      borderSide: BorderSide(color: AppColors.line2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusMd)),
      borderSide: BorderSide(color: AppColors.accentLine),
    ),
  );
}
