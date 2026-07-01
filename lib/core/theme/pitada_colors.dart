// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/pitada_colors.dart
// O QUÊ:     ThemeExtension com as cores que MUDAM entre claro e escuro, mais
//            helpers de fundo por aba e de cor de card. Acesso via `context.pit`.
// USA:       theme/colors (tokens crus), material (ThemeExtension).
// USADO POR: widgets migrados para os 2 temas (detalhe da receita, cards, etc.).
// SPEC:      specs/design-system/colors.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'colors.dart';

/// Cores dependentes do tema. Widgets migrados leem via `context.pit.<token>`.
/// Marca (accent/sage) continua em AppColors — não muda entre temas.
@immutable
class PitadaColors extends ThemeExtension<PitadaColors> {
  const PitadaColors({
    required this.brightness,
    required this.bg,
    required this.surf,
    required this.surf2,
    required this.line,
    required this.line2,
    required this.border,
    required this.text,
    required this.text2,
    required this.muted,
    required this.faint,
  });

  final Brightness brightness;
  final Color bg, surf, surf2, line, line2, border, text, text2, muted, faint;

  /// Instância do tema escuro (base histórica do Pitada).
  static const dark = PitadaColors(
    brightness: Brightness.dark,
    bg: AppColors.bg,
    surf: AppColors.surf,
    surf2: AppColors.surf2,
    line: AppColors.line,
    line2: AppColors.line2,
    border: AppColors.inkDark,
    text: AppColors.text,
    text2: AppColors.text2,
    muted: AppColors.muted,
    faint: AppColors.faint,
  );

  /// Instância do tema claro (base creme).
  static const light = PitadaColors(
    brightness: Brightness.light,
    bg: AppColors.bgLight,
    surf: AppColors.surfLight,
    surf2: AppColors.surf2Light,
    line: AppColors.lineLight,
    line2: AppColors.line2Light,
    border: AppColors.inkLight,
    text: AppColors.textLight,
    text2: AppColors.text2Light,
    muted: AppColors.mutedLight,
    faint: AppColors.faintLight,
  );

  bool get isDark => brightness == Brightness.dark;

  /// Cor pastel do bloco de foto de uma receita, pelo nome hero. Usada por: card/galeria.
  Color card(String hero) {
    final map = isDark ? AppColors.cardDark : AppColors.cardLight;
    return map[hero] ?? map['clay']!;
  }

  /// Fundo tingido de uma aba pelo índice (0..4). Usada por: scaffolds das abas.
  Color tabBg(int index) {
    final list = isDark ? AppColors.tabBgDark : AppColors.tabBgLight;
    return list[index % list.length];
  }

  @override
  PitadaColors copyWith({
    Brightness? brightness,
    Color? bg,
    Color? surf,
    Color? surf2,
    Color? line,
    Color? line2,
    Color? border,
    Color? text,
    Color? text2,
    Color? muted,
    Color? faint,
  }) {
    return PitadaColors(
      brightness: brightness ?? this.brightness,
      bg: bg ?? this.bg,
      surf: surf ?? this.surf,
      surf2: surf2 ?? this.surf2,
      line: line ?? this.line,
      line2: line2 ?? this.line2,
      border: border ?? this.border,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
    );
  }

  @override
  PitadaColors lerp(ThemeExtension<PitadaColors>? other, double t) {
    if (other is! PitadaColors) return this;
    return PitadaColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      bg: Color.lerp(bg, other.bg, t)!,
      surf: Color.lerp(surf, other.surf, t)!,
      surf2: Color.lerp(surf2, other.surf2, t)!,
      line: Color.lerp(line, other.line, t)!,
      line2: Color.lerp(line2, other.line2, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
    );
  }
}

/// Açúcar para ler as cores do tema atual: `context.pit.bg`, `context.pit.text`...
/// Usada por: todo widget que precisa reagir ao tema claro/escuro.
extension PitadaColorsX on BuildContext {
  PitadaColors get pit =>
      Theme.of(this).extension<PitadaColors>() ?? PitadaColors.dark;
}
