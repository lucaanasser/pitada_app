// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/typography.dart
// O QUÊ:     Escala tipográfica nomeada (AppType). Space Grotesk (display/números) + Inter (ui).
// USA:       theme/colors (cor padrão de cada estilo) e material (TextStyle).
// USADO POR: todo texto do app. Nenhum TextStyle novo deve nascer fora daqui.
// SPEC:      specs/design-system/typography.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/painting.dart';
import 'colors.dart';

/// Estilos de texto do Pitada. Cor padrão embutida (troque com [on] no uso).
/// Usada por: todos os widgets e telas.
class AppType {
  AppType._();

  static const _disp = 'Space Grotesk'; // números, títulos (geométrica, chunky)
  static const _ui = 'Inter'; // corpo, botões, rótulos

  // —— Display (Space Grotesk) ——
  static const displayXl = TextStyle(
    fontFamily: _disp,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 0.95,
    color: AppColors.text,
  );
  static const screenTitle = TextStyle(
    fontFamily: _disp,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.0,
    color: AppColors.text,
  );
  static const display = TextStyle(
    fontFamily: _disp,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.05,
    color: AppColors.text,
  );
  static const title = TextStyle(
    fontFamily: _disp,
    fontSize: 21,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.15,
    color: AppColors.text,
  );
  static const titleSm = TextStyle(
    fontFamily: _disp,
    fontSize: 19,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.15,
    color: AppColors.text,
  );
  static const titleXs = TextStyle(
    fontFamily: _disp,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.15,
    color: AppColors.text,
  );
  static const numeralLg = TextStyle(
    fontFamily: _disp,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 0.95,
    color: AppColors.accent,
  );
  static const numeral = TextStyle(
    fontFamily: _disp,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.text,
  );
  static const numeralSm = TextStyle(
    fontFamily: _disp,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.0,
    color: AppColors.text,
  );
  static const quote = TextStyle(
    fontFamily: _disp,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.text,
  );
  static const tip = TextStyle(
    fontFamily: _ui,
    fontSize: 14.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 1.45,
    color: AppColors.text2,
  );

  // —— UI (Inter) ——
  static const bodyLg = TextStyle(
    fontFamily: _ui,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: AppColors.text2,
  );
  static const body = TextStyle(
    fontFamily: _ui,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: AppColors.text,
  );
  static const bodySm = TextStyle(
    fontFamily: _ui,
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.text2,
  );
  static const label = TextStyle(
    fontFamily: _ui,
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.1,
    height: 1.0,
    color: AppColors.muted,
  );
  static const button = TextStyle(
    fontFamily: _disp,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.0,
    color: AppColors.text,
  );
  static const caption = TextStyle(
    fontFamily: _ui,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.muted,
  );
  static const captionSm = TextStyle(
    fontFamily: _ui,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.faint,
  );

  /// Atalho ergonômico: mesmo estilo, outra cor. Ex.: `AppType.on(AppType.numeral, AppColors.sage)`.
  /// Usada por: telas/widgets que reaproveitam um estilo trocando só a cor.
  static TextStyle on(TextStyle style, Color color) =>
      style.copyWith(color: color);
}
