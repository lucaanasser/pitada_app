// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/colors.dart
// O QUÊ:     Paleta única do app (AppColors). Espelha o :root de pitada.html.
// USA:       dart:ui/material (Color). Nada mais — é a base do design system.
// USADO POR: theme/typography, theme/app_theme, todos os widgets e telas.
//            Nenhuma cor pode ser declarada fora deste arquivo.
// SPEC:      specs/design-system/colors.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/painting.dart';

/// Tokens de cor do Pitada. Todos `static const` para uso em widgets const.
/// Usada por: todo o app (tema, widgets compartilhados, telas).
class AppColors {
  AppColors._(); // sem instância — só tokens estáticos.

  // —— Superfícies e filetes ——
  static const bg = Color(0xFF15130E); // fundo geral
  static const surf = Color(0xFF1D1A13); // card / campo
  static const surf2 = Color(0xFF242017); // input
  static const line = Color(0xFF29251A); // filete divisor
  static const line2 = Color(0xFF383223); // borda / filete forte

  // —— Texto ——
  static const text = Color(0xFFF2EDE1); // principal
  static const text2 = Color(0xFFC5BEAD); // secundário
  static const muted = Color(0xFF8E8674); // rótulos
  static const faint = Color(0xFF605948); // placeholder / desabilitado

  // —— Marca ——
  static const accent = Color(0xFFC2703F); // terracota (primário/destaque)
  static const accent2 = Color(0xFFD98C5A); // terracota claro (links, "acima")
  static const sage = Color(0xFFA9B26C); // verde (sucesso, "dentro da meta")
  static const onAccent = Color(0xFF1F0D04); // tinta sobre o accent
  static const accentSoft = Color.fromRGBO(194, 112, 63, 0.12); // fundo suave
  static const accentLine = Color.fromRGBO(194, 112, 63, 0.32); // borda suave
  static const sageSoft = Color.fromRGBO(169, 178, 108, 0.13); // fundo verde

  // —— Cores de miniatura editorial (hero de receita / bolinha de macro) ——
  static const clay = Color(0xFF8A5A43);
  static const moss = Color(0xFF5E6B45);
  static const ochre = Color(0xFF9A7B3C);
  static const terra = Color(0xFFA35C40);
  static const plum = Color(0xFF6E4A5A);
  static const teal = Color(0xFF3F6157);
  static const rust = Color(0xFF9E5236);

  /// Mapa nome→cor das miniaturas, para persistir/ler `hero_color` da receita.
  /// Usada por: RecipeRow, RecipeDetailScreen, NutritionCard (bolinhas de macro).
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
}
