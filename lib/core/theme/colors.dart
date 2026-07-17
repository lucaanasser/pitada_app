// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/colors.dart
// O QUÊ:     Paleta única do app (AppColors). Tokens crus dos temas claro e escuro.
// USA:       dart:ui/material (Color). Nada mais — é a base do design system.
// USADO POR: theme/pitada_colors (monta o ThemeExtension), theme/app_theme, widgets.
//            Nenhuma cor pode ser declarada fora deste arquivo.
// SPEC:      specs/design-system/colors.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/painting.dart';

/// Tokens de cor do Pitada. Todos `static const` para uso em widgets const.
/// Superfícies/texto existem em duas versões (escuro grafite frio; claro creme).
/// Marca (accent/sage) e cores hero são iguais nos dois temas.
/// Usada por: todo o app (tema, widgets compartilhados, telas).
class AppColors {
  AppColors._();

  static const bg = Color(0xFF17181B); // fundo geral (grafite frio)
  static const surf = Color(0xFF1E2023); // card / campo
  static const surf2 = Color(0xFF24262A); // input
  static const line = Color(0xFF282A2F); // filete divisor
  static const line2 = Color(0xFF35383E); // borda / filete forte

  static const text = Color(0xFFF2EDE1); // principal
  static const text2 = Color(0xFFC5BEAD); // secundário
  static const muted = Color(0xFF8E8674); // rótulos
  static const faint = Color(0xFF605948); // placeholder / desabilitado

  static const bgLight = Color(0xFFF4EDDE); // fundo geral (creme quente)
  static const surfLight = Color(0xFFFBF6EC); // card/campo (creme quase-branco)
  static const surf2Light = Color(0xFFEFE8D8); // input (um tom abaixo do fundo)
  static const lineLight = Color(0xFFE7DECD);
  static const line2Light = Color(0xFFD8CEB8);

  static const textLight = Color(0xFF221E17);
  static const text2Light = Color(0xFF6A6252);
  static const mutedLight = Color(0xFF938A78);
  static const faintLight = Color(0xFFB4AB98);

  static const inkLight = Color(0xFF221E17);
  static const inkDark = Color(0xFF090A0C);

  static const shadow = Color(0x59000000);

  static const accent = Color(0xFFC2703F); // terracota (primário/destaque)
  static const accent2 = Color(0xFFD98C5A); // terracota claro (links, "acima")
  static const sage = Color(0xFFA9B26C); // verde (sucesso, "dentro da meta")
  static const onAccent = Color(0xFF1F0D04); // tinta sobre o accent
  static const accentSoft = Color.fromRGBO(194, 112, 63, 0.12); // fundo suave
  static const accentLine = Color.fromRGBO(194, 112, 63, 0.32); // borda suave
  static const sageSoft = Color.fromRGBO(169, 178, 108, 0.13); // fundo verde

  static const clay = Color(0xFF8A5A43);
  static const moss = Color(0xFF5E6B45);
  static const ochre = Color(0xFF9A7B3C);
  static const terra = Color(0xFFA35C40);
  static const plum = Color(0xFF6E4A5A);
  static const teal = Color(0xFF3F6157);
  static const rust = Color(0xFF9E5236);

  /// Mapa nome→cor das miniaturas (cor "cheia", legado). Usada por: bolinha de macro.
  static const Map<String, Color> hero = {
    'clay': clay,
    'moss': moss,
    'ochre': ochre,
    'terra': terra,
    'plum': plum,
    'teal': teal,
    'rust': rust,
  };

  /// Devolve a cor de miniatura pelo nome; cai em `clay` se o nome for inválido.
  /// Usada por: qualquer widget que receba `hero_color` como String do banco.
  static Color heroOf(String? name) => hero[name] ?? clay;

  static const List<Color> tabBgLight = [bgLight]; // todas as abas: creme base
  static const List<Color> tabBgDark = [bg]; // todas as abas: grafite frio

  static const Map<String, Color> cardLight = {
    'clay': Color(0xFFF3D3BC),
    'moss': Color(0xFFD3E0B4),
    'ochre': Color(0xFFF0DFA9),
    'terra': Color(0xFFF2C9B4),
    'plum': Color(0xFFE7CBD6),
    'teal': Color(0xFFBFE0CE),
    'rust': Color(0xFFF1C4B0),
  };
  static const Map<String, Color> cardDark = {
    'clay': Color(0xFF5A3F2E),
    'moss': Color(0xFF46512F),
    'ochre': Color(0xFF55482A),
    'terra': Color(0xFF5E3D2C),
    'plum': Color(0xFF543742),
    'teal': Color(0xFF2F4A40),
    'rust': Color(0xFF5A3A2C),
  };
}
