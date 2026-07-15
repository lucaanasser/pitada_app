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

/// Ícones nomeados por significado. `*Fill` = variante preenchida (estado ativo).
/// Usada por: qualquer widget que mostre um ícone.
class AppIcons {
  AppIcons._();

  // —— Navegação (regular = inativo · fill = ativo), na ordem da barra ——
  static const recipes = PhosphorIconsRegular.forkKnife;
  static const recipesFill = PhosphorIconsFill.forkKnife;
  static const learning = PhosphorIconsRegular.chefHat;
  static const learningFill = PhosphorIconsFill.chefHat;
  // Plano = prancheta com o plano escrito (bowlSteam era o 4º ícone de comida
  // na barra e confundia com Receitas — pedido do dono).
  static const plans = PhosphorIconsRegular.clipboardText;
  static const plansFill = PhosphorIconsFill.clipboardText;
  static const ingredients = PhosphorIconsRegular.carrot;
  static const ingredientsFill = PhosphorIconsFill.carrot;
  // Perfil é aba; o regular também serve de chip de pessoa (note_row).
  static const profile = PhosphorIconsRegular.user;
  static const profileFill = PhosphorIconsFill.user;

  // —— Ações / meta ——
  static const back = PhosphorIconsRegular.arrowLeft;
  static const edit = PhosphorIconsRegular.pencilSimple;
  static const favorite = PhosphorIconsRegular.heart;
  static const favoriteFill = PhosphorIconsFill.heart;
  static const cook = PhosphorIconsRegular.fire;
  static const addToList = PhosphorIconsRegular.shoppingCartSimple;
  static const addToPlan = PhosphorIconsRegular.calendarPlus;
  static const add = PhosphorIconsRegular.plus;
  static const search = PhosphorIconsRegular.magnifyingGlass;
  static const chevron = PhosphorIconsRegular.caretRight;
  static const expand = PhosphorIconsRegular.caretDown; // título que abre sheet
  static const link = PhosphorIconsRegular.link;
  static const folder = PhosphorIconsRegular.folderOpen;
  static const dragHandle = PhosphorIconsRegular.dotsSixVertical;
  static const viewSingle = PhosphorIconsRegular.square;
  static const viewGrid = PhosphorIconsRegular.squaresFour;
  static const viewList = PhosphorIconsRegular.list;

  // —— Domínio (receita) ——
  static const dish = PhosphorIconsRegular.cookingPot;
  static const servings = PhosphorIconsRegular.users;
  static const time = PhosphorIconsRegular.clock;
  static const difficulty = PhosphorIconsRegular.chartBar;
  static const technique = PhosphorIconsRegular.graduationCap;

  // —— Geral (demais telas) ——
  static const check = PhosphorIconsRegular.check;
  static const checkCircle = PhosphorIconsRegular.checkCircle;
  static const close = PhosphorIconsRegular.x;
  static const remove = PhosphorIconsRegular.minus;
  static const removeCircle = PhosphorIconsRegular.minusCircle;
  static const forward = PhosphorIconsRegular.arrowRight;
  static const swap = PhosphorIconsRegular.arrowsLeftRight;
  static const book = PhosphorIconsRegular.book;
  static const notebook =
      PhosphorIconsRegular.notebook; // ilustração de EmptyState (recipes)
  static const editNote = PhosphorIconsRegular.notePencil;
  static const bookmark = PhosphorIconsRegular.bookmarkSimple;
  static const history = PhosphorIconsRegular.clockCounterClockwise;
  static const timeline = PhosphorIconsRegular.chartLineUp;
  static const school = PhosphorIconsRegular.graduationCap;
  static const science = PhosphorIconsRegular.flask;
  static const hub = PhosphorIconsRegular.treeStructure;
  // Peso corporal: gauge lembra o mostrador da balança de banheiro (scales,
  // a balança de pratos, lia como "justiça" — trocado a pedido do dono).
  static const weight = PhosphorIconsRegular.gauge;
  static const logDay = PhosphorIconsRegular.calendarCheck;
  static const calendarPattern = PhosphorIconsRegular.calendarDots;
  static const error = PhosphorIconsRegular.warningCircle;
  static const tune = PhosphorIconsRegular.slidersHorizontal;
  static const settings = PhosphorIconsRegular.gear;
  static const basket = PhosphorIconsRegular.basket;
  static const play = PhosphorIconsRegular.playCircle;
  static const pdf = PhosphorIconsRegular.filePdf;
  static const photo = PhosphorIconsRegular.image;
  static const camera = PhosphorIconsRegular.camera;
  static const scan = PhosphorIconsRegular.scan;
  static const qrCode = PhosphorIconsRegular.qrCode;
}
