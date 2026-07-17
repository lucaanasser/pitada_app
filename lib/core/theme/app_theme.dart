// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/app_theme.dart
// O QUÊ:     Monta os ThemeData claro e escuro do Pitada a partir dos tokens.
// USA:       theme/colors, theme/pitada_colors, theme/spacing, theme/typography.
// USADO POR: app.dart (MaterialApp.theme / darkTheme). Temas globais do app.
// SPEC:      specs/design-system/*.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'colors.dart';
import 'pitada_colors.dart';
import 'spacing.dart';
import 'typography.dart';

/// Fábrica dos temas visuais do Pitada (claro + escuro).
/// Usada por: app.dart.
class AppTheme {
  AppTheme._();

  /// Tema escuro (base grafite frio, texto branco).
  /// Usada por: PitadaApp (darkTheme).
  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        scheme: const ColorScheme.dark(
          surface: AppColors.bg,
          primary: AppColors.accent,
          onPrimary: AppColors.onAccent,
          secondary: AppColors.accent2,
          onSurface: AppColors.text,
          error: AppColors.accent2,
        ),
        ext: PitadaColors.dark,
        scaffold: AppColors.bg,
        textTheme: _textTheme,
        inputFill: AppColors.surf2,
        inputBorder: AppColors.line2,
      );

  /// Tema claro (base creme, pastel).
  /// Usada por: PitadaApp (theme).
  static ThemeData get light => _build(
        brightness: Brightness.light,
        scheme: const ColorScheme.light(
          surface: AppColors.bgLight,
          primary: AppColors.accent,
          onPrimary: AppColors.onAccent,
          secondary: AppColors.accent2,
          onSurface: AppColors.textLight,
          error: AppColors.accent2,
        ),
        ext: PitadaColors.light,
        scaffold: AppColors.bgLight,
        textTheme: _textTheme.apply(
          bodyColor: AppColors.textLight,
          displayColor: AppColors.textLight,
        ),
        inputFill: AppColors.surf2Light,
        inputBorder: AppColors.line2Light,
      );

  /// Monta um ThemeData a partir dos tokens de um tema. Usada por: [dark], [light].
  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required PitadaColors ext,
    required Color scaffold,
    required TextTheme textTheme,
    required Color inputFill,
    required Color inputBorder,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: 'Inter',
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[ext],
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: AppColors.accentLine,
        selectionHandleColor: AppColors.accent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        hintStyle: TextStyle(color: ext.faint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.accentLine),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: ext.line,
        thickness: AppSpacing.hair,
        space: AppSpacing.hair,
      ),
    );
  }

  /// Mapeia os estilos nomeados do AppType para o TextTheme do Material.
  /// Usada por: [dark]/[light]. Widgets devem preferir AppType.* diretamente.
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
}
