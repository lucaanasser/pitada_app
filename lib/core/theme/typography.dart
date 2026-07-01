// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/typography.dart
// O QUÊ:     Escala tipográfica nomeada (AppType). Cormorant (display) + Inter (ui).
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

  static const _disp = 'Cormorant Garamond'; // números, títulos, citações
  static const _ui = 'Inter'; // corpo, botões, rótulos

  // —— Display (Cormorant) ——
  static const displayXl = TextStyle(
    fontFamily: _disp,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 0.9,
    color: AppColors.text,
  );
  static const screenTitle = TextStyle(
    fontFamily: _disp,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 0.95,
    color: AppColors.text,
  );
  static const display = TextStyle(
    fontFamily: _disp,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.0,
    color: AppColors.text,
  );
  static const title = TextStyle(
    fontFamily: _disp,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.1,
    color: AppColors.text,
  );
  static const titleSm = TextStyle(
    fontFamily: _disp,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.1,
    color: AppColors.text,
  );
  static const numeralLg = TextStyle(
    fontFamily: _disp,
    fontSize: 27,
    fontWeight: FontWeight.w600,
    height: 0.9,
    color: AppColors.accent,
  );
  static const numeral = TextStyle(
    fontFamily: _disp,
    fontSize: 21,
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
    fontSize: 23,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: AppColors.text,
  );
  static const tip = TextStyle(
    fontFamily: _disp,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    height: 1.4,
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
    fontFamily: _ui,
    fontSize: 15,
    fontWeight: FontWeight.w600,
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
