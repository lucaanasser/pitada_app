// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/spacing.dart
// O QUÊ:     Escala de espaçamento, raios e filetes (AppSpacing) + atalhos úteis.
// USA:       material (EdgeInsets, BorderRadius). Base do design system.
// USADO POR: todos os widgets/telas. Nenhum número mágico de layout fora daqui.
// SPEC:      specs/design-system/spacing.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/widgets.dart';

/// Tokens de espaçamento, raio de borda, filete e alturas fixas do Pitada.
/// Usada por: todo padding/margin/gap/radius do app.
class AppSpacing {
  AppSpacing._();

  // —— Espaço (padding / gap / margin) ——
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 30;

  /// Padding horizontal padrão do conteúdo das telas (.thead/.rlist/.cgrp).
  static const double gutter = 24;

  // —— Raios de borda ——
  static const double radiusSm = 7; // tag / pill de rótulo
  static const double radiusMd = 11; // input, thumb de receita
  static const double radiusLg = 13; // botão, card de campo
  static const double radiusXl = 14; // card (.meal, .nutri)
  static const double radiusCard =
      18; // card de receita / caixa de macros (chunky)
  static const double radiusXxl = 24; // bottom sheet
  static const double radiusPill = 999; // chip totalmente arredondado

  // —— Filetes (larguras de borda) ——
  static const double hair = 1; // divisor padrão
  static const double borderThick = 1.5; // checkbox / destaque
  static const double borderAccent = 2; // aba ativa, borda-esquerda de callout
  // Borda de card/tag: neo-brutalismo com parcimônia — 1.5, não 2 (pedido do dono).
  static const double borderStrong = 1.5;

  // —— Alturas fixas de componentes ——
  static const double button = 52;
  static const double iconButton = 42;
  static const double searchBar = 46;
  static const double tabBar = 76;
  static const double statusBar = 46;

  // —— Atalhos de EdgeInsets recorrentes ——
  /// Padding horizontal do gutter (24) — usado em quase toda tela.
  static const EdgeInsets screenH = EdgeInsets.symmetric(horizontal: gutter);

  /// Devolve um BorderRadius circular a partir de um dos raios acima.
  /// Usada por: cards, botões, inputs, sheets — para não repetir BorderRadius.circular.
  static BorderRadius br(double radius) => BorderRadius.circular(radius);
}
