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
/// Superfícies/texto existem em duas versões (escuro = base histórica; claro = novo).
/// Marca (accent/sage) e cores hero são iguais nos dois temas.
/// Usada por: todo o app (tema, widgets compartilhados, telas).
class AppColors {
  AppColors._(); // sem instância — só tokens estáticos.

  // —— Superfícies e filetes (TEMA ESCURO) ——
  static const bg = Color(0xFF15130E); // fundo geral
  static const surf = Color(0xFF1D1A13); // card / campo
  static const surf2 = Color(0xFF242017); // input
  static const line = Color(0xFF29251A); // filete divisor
  static const line2 = Color(0xFF383223); // borda / filete forte

  // —— Texto (TEMA ESCURO) ——
  static const text = Color(0xFFF2EDE1); // principal
  static const text2 = Color(0xFFC5BEAD); // secundário
  static const muted = Color(0xFF8E8674); // rótulos
  static const faint = Color(0xFF605948); // placeholder / desabilitado

  // —— Superfícies e filetes (TEMA CLARO — base creme, warmth do GOYA) ——
  static const bgLight = Color(0xFFF5EFE3);
  static const surfLight = Color(0xFFFBF7EE);
  static const surf2Light = Color(0xFFF1EADE);
  static const lineLight = Color(0xFFE8DFCF);
  static const line2Light = Color(0xFFD9CFBB);

  // —— Texto (TEMA CLARO) ——
  static const textLight = Color(0xFF221E17);
  static const text2Light = Color(0xFF6A6252);
  static const mutedLight = Color(0xFF938A78);
  static const faintLight = Color(0xFFB4AB98);

  // Tinta/borda "neo-brutalista": quase-preta nos dois temas — o marrom médio
  // antigo (#3A3324) lia como "borda cinza" no escuro.
  static const inkLight = Color(0xFF221E17);
  static const inkDark = Color(0xFF0E0C08);

  // Sombra funcional (exceção pontual à regra "flat": profundidade de bolso/
  // papéis da pasta). Uso parcimonioso e sempre via este token.
  static const shadow = Color(0x59000000);

  // —— Marca (iguais nos dois temas) ——
  static const accent = Color(0xFFC2703F); // terracota (primário/destaque)
  static const accent2 = Color(0xFFD98C5A); // terracota claro (links, "acima")
  static const sage = Color(0xFFA9B26C); // verde (sucesso, "dentro da meta")
  static const onAccent = Color(0xFF1F0D04); // tinta sobre o accent
  static const accentSoft = Color.fromRGBO(194, 112, 63, 0.12); // fundo suave
  static const accentLine = Color.fromRGBO(194, 112, 63, 0.32); // borda suave
  static const sageSoft = Color.fromRGBO(169, 178, 108, 0.13); // fundo verde

  // —— Cores de miniatura editorial (nome hero da receita) ——
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

  // —— Fundos tingidos por aba (índice 0..4, ordem da navbar) ——
  // Pastéis quentes de mesma luminosidade — dão identidade sem sobrecarregar.
  static const List<Color> tabBgLight = [
    Color(0xFFF1E3D4), // Receitas
    Color(0xFFE7EAD3), // Caderno
    Color(0xFFEEDFE0), // Home (comunidade)
    Color(0xFFF3E9CF), // Planos
    Color(0xFFDCE7DF), // Compras
  ];
  static const List<Color> tabBgDark = [
    Color(0xFF1C1611), // Receitas
    Color(0xFF171A10), // Caderno
    Color(0xFF1B1319), // Home (comunidade)
    Color(0xFF1D1810), // Planos
    Color(0xFF121A16), // Compras
  ];

  // —— Cor do bloco de foto (card) por hero, em cada tema (pastéis / escuros) ——
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
