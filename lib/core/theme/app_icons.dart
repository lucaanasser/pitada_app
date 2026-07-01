// ─────────────────────────────────────────────────────────────────────────────
// lib/core/theme/app_icons.dart
// O QUÊ:     Tokens de ícone do app (família Phosphor). Fonte única — nenhum
//            `Icons.*`/ícone solto fora daqui. Se a API do pacote mudar de versão,
//            o conserto é só neste arquivo.
// USA:       phosphoricons_flutter (PhosphorIconsRegular / PhosphorIconsFill).
//            Fork compatível com Dart 3 (IconData virou `final`); mesma API do
//            phosphor_flutter 2.x, mas sem estender IconData.
// USADO POR: navbar, telas e widgets — todos os ícones do app.
// SPEC:      specs/design-system/icons.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:flutter/widgets.dart' show IconData;

/// Ícones nomeados por significado. `*Fill` = variante preenchida (estado ativo).
/// Usada por: qualquer widget que mostre um ícone.
class AppIcons {
  AppIcons._();

  // —— Navegação (regular = inativo · fill = ativo) ——
  static const recipes = PhosphorIconsRegular.forkKnife;
  static const recipesFill = PhosphorIconsFill.forkKnife;
  static const notebook = PhosphorIconsRegular.notebook;
  static const notebookFill = PhosphorIconsFill.notebook;
  static const home = PhosphorIconsRegular.house;
  static const homeFill = PhosphorIconsFill.house;
  static const plans = PhosphorIconsRegular.calendarBlank;
  static const plansFill = PhosphorIconsFill.calendarBlank;
  static const shopping = PhosphorIconsRegular.shoppingCart;
  static const shoppingFill = PhosphorIconsFill.shoppingCart;

  // —— Ações / meta ——
  static const back = PhosphorIconsRegular.arrowLeft;
  static const edit = PhosphorIconsRegular.pencilSimple;
  static const favorite = PhosphorIconsRegular.heart;
  static const favoriteFill = PhosphorIconsFill.heart;
  static const cook = PhosphorIconsRegular.fire;
  static const addToList = PhosphorIconsRegular.shoppingCartSimple;
  static const addToPlan = PhosphorIconsRegular.calendarPlus;
  static const add = PhosphorIconsRegular.plus;
  static const profile = PhosphorIconsRegular.user;
  static const search = PhosphorIconsRegular.magnifyingGlass;
  static const chevron = PhosphorIconsRegular.caretRight;
  static const link = PhosphorIconsRegular.link;
  static const folder = PhosphorIconsRegular.folderOpen;

  // —— Domínio (receita) ——
  static const dish = PhosphorIconsRegular.cookingPot;
  static const servings = PhosphorIconsRegular.users;
  static const time = PhosphorIconsRegular.clock;
  static const difficulty = PhosphorIconsRegular.chartBar;
  static const technique = PhosphorIconsRegular.graduationCap;
}
