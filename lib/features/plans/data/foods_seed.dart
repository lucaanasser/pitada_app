// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/data/foods_seed.dart
// O QUÊ:     Dataset curado de comidas brasileiras comuns (aproximação por porção).
//            Parcialmente genérico: bom o bastante p/ logar o que se comeu fora do
//            plano em um toque, sem precisão de balança. Hoje local; depois Supabase.
// USA:       food_item.dart (modelo).
// USADO POR: progress_repository (fetchFoods). A UI busca via foodsProvider.
// SPEC:      specs/features/plans_progress.yaml (data.seeds: foods_seed.dart)
// ─────────────────────────────────────────────────────────────────────────────
import 'food_item.dart';

/// Atalho p/ declarar uma comida em uma linha (mantém o seed curto/legível).
/// Ordem: id, nome, porção, kcal, proteína, carbo, gordura, categoria.
/// Usada por: [kSeedFoods].
FoodItem _f(
  String id,
  String name,
  String portion,
  int kcal,
  num p,
  num c,
  num f,
  String cat,
) =>
    FoodItem(
      id: id,
      name: name,
      portion: portion,
      kcal: kcal,
      protein: p,
      carb: c,
      fat: f,
      category: cat,
    );

/// Lista curada de comidas comuns (kcal/macros aproximados por porção humana).
/// Ordem/valores pensados p/ o brasileiro; ajuste fino é aceitável (é estimativa).
/// Usada por: ProgressRepository.fetchFoods, FoodSearchSheet (busca + chips).
final List<FoodItem> kSeedFoods = [
  // —— Doces ——
  _f('brigadeiro', 'Brigadeiro', '1 un', 90, 1, 14, 4, 'doce'),
  _f('bolo_choco', 'Bolo de chocolate', '1 fatia', 260, 4, 38, 11, 'doce'),
  _f('sorvete', 'Sorvete', '1 bola', 130, 2, 16, 7, 'doce'),
  _f('chocolate', 'Chocolate', '1 barra 90g', 480, 6, 54, 27, 'doce'),
  _f('pudim', 'Pudim', '1 fatia', 230, 6, 34, 8, 'doce'),
  _f('acai', 'Açaí com granola', '300 ml', 380, 5, 58, 14, 'doce'),
  _f('doce_leite', 'Doce de leite', '1 colher', 120, 2, 20, 3, 'doce'),
  _f('paodemel', 'Pão de mel', '1 un', 210, 3, 32, 8, 'doce'),
  _f('cookie', 'Cookie', '1 un', 150, 2, 20, 7, 'doce'),
  _f('brownie', 'Brownie', '1 pedaço', 240, 3, 30, 12, 'doce'),
  // —— Salgados de padaria/lanchonete ——
  _f('coxinha', 'Coxinha', '1 un', 180, 6, 18, 9, 'salgado'),
  _f('paodequeijo', 'Pão de queijo', '1 un', 90, 2, 9, 5, 'salgado'),
  _f('pastel', 'Pastel de carne', '1 un', 280, 8, 26, 16, 'salgado'),
  _f('empada', 'Empada', '1 un', 180, 4, 18, 10, 'salgado'),
  _f('esfiha', 'Esfiha', '1 un', 170, 7, 20, 6, 'salgado'),
  _f('kibe', 'Quibe', '1 un', 190, 9, 14, 10, 'salgado'),
  _f('enroladinho', 'Enroladinho de salsicha', '1 un', 160, 5, 16, 8,
      'salgado'),
  _f('pao_frances', 'Pão francês', '1 un', 140, 4, 28, 1, 'salgado'),
  _f('pao_chapa', 'Pão na chapa', '1 un', 220, 4, 28, 10, 'salgado'),
  _f('misto', 'Misto quente', '1 un', 300, 14, 28, 15, 'salgado'),
  _f('salgadinho', 'Salgadinho de pacote', '1 pacote', 200, 2, 24, 12,
      'salgado'),
  _f('pipoca', 'Pipoca', '1 saco', 150, 3, 20, 7, 'salgado'),
  // —— Fast food ——
  _f('pizza', 'Pizza', '1 fatia', 285, 12, 30, 12, 'fastfood'),
  _f('hamburguer', 'Hambúrguer', '1 un', 500, 25, 40, 27, 'fastfood'),
  _f('x_bacon', 'X-bacon', '1 un', 650, 30, 42, 38, 'fastfood'),
  _f('batata_frita', 'Batata frita', '1 porção média', 340, 4, 44, 17,
      'fastfood'),
  _f('nuggets', 'Nuggets', '6 un', 270, 14, 16, 17, 'fastfood'),
  _f('hotdog', 'Cachorro-quente', '1 un', 350, 12, 34, 18, 'fastfood'),
  _f('temaki', 'Temaki de salmão', '1 un', 320, 14, 40, 11, 'fastfood'),
  _f('sushi', 'Sushi', '8 peças', 340, 12, 56, 6, 'fastfood'),
  _f('esfirra', 'Esfirra aberta', '1 un', 200, 8, 22, 8, 'fastfood'),
  // —— Bebidas ——
  _f('refri', 'Refrigerante', '1 lata', 140, 0, 37, 0, 'bebida'),
  _f('refri_zero', 'Refrigerante zero', '1 lata', 1, 0, 0, 0, 'bebida'),
  _f('suco', 'Suco de fruta', '1 copo', 120, 1, 28, 0, 'bebida'),
  _f('cafe_leite', 'Café com leite', '1 xícara', 90, 5, 9, 4, 'bebida'),
  _f('capuccino', 'Cappuccino', '1 copo', 180, 6, 24, 6, 'bebida'),
  _f('achocolatado', 'Achocolatado', '1 copo', 160, 6, 26, 4, 'bebida'),
  _f('agua_coco', 'Água de coco', '1 copo', 45, 0, 10, 0, 'bebida'),
  _f('energetico', 'Energético', '1 lata', 120, 0, 30, 0, 'bebida'),
  _f('vitamina', 'Vitamina de banana', '1 copo', 250, 8, 40, 6, 'bebida'),
  // —— Álcool ——
  _f('cerveja', 'Cerveja', '1 lata', 150, 1, 13, 0, 'alcool'),
  _f('chopp', 'Chopp', '1 copo', 120, 1, 10, 0, 'alcool'),
  _f('vinho', 'Vinho', '1 taça', 125, 0, 4, 0, 'alcool'),
  _f('caipirinha', 'Caipirinha', '1 copo', 250, 0, 25, 0, 'alcool'),
  _f('destilado', 'Dose de destilado', '1 dose', 100, 0, 0, 0, 'alcool'),
  _f('whisky_refri', 'Whisky com refri', '1 copo', 200, 0, 18, 0, 'alcool'),
  // —— Frutas ——
  _f('banana', 'Banana', '1 un', 105, 1, 27, 0, 'fruta'),
  _f('maca', 'Maçã', '1 un', 95, 0, 25, 0, 'fruta'),
  _f('laranja', 'Laranja', '1 un', 62, 1, 15, 0, 'fruta'),
  _f('mamao', 'Mamão', '1 fatia', 60, 1, 15, 0, 'fruta'),
  _f('manga', 'Manga', '1 un', 200, 2, 50, 1, 'fruta'),
  _f('uva', 'Uva', '1 cacho pequeno', 100, 1, 27, 0, 'fruta'),
  _f('morango', 'Morango', '1 xícara', 50, 1, 12, 0, 'fruta'),
  _f('abacate', 'Abacate', '1/2 un', 160, 2, 9, 15, 'fruta'),
  // —— Lanches / diversos ——
  _f('iogurte', 'Iogurte', '1 pote', 120, 6, 18, 3, 'lanche'),
  _f('iogurte_grego', 'Iogurte grego', '1 pote', 150, 10, 14, 5, 'lanche'),
  _f('barra_cereal', 'Barra de cereal', '1 un', 100, 2, 18, 3, 'lanche'),
  _f('granola', 'Granola', '2 colheres', 130, 3, 20, 5, 'lanche'),
  _f('castanhas', 'Mix de castanhas', '1 punhado', 180, 5, 6, 16, 'lanche'),
  _f('amendoim', 'Amendoim', '1 punhado', 170, 7, 5, 14, 'lanche'),
  _f('queijo', 'Queijo', '1 fatia', 80, 6, 1, 6, 'lanche'),
  _f('biscoito', 'Biscoito recheado', '3 un', 150, 2, 22, 6, 'lanche'),
  _f('tapioca', 'Tapioca', '1 un', 200, 6, 32, 5, 'lanche'),
  _f('ovo', 'Ovo', '1 un', 75, 6, 1, 5, 'lanche'),
  // —— Pratos ——
  _f('pf', 'Prato feito (PF)', '1 prato', 700, 35, 80, 25, 'prato'),
  _f('arroz_feijao', 'Arroz com feijão', '1 prato', 350, 12, 62, 6, 'prato'),
  _f('feijoada', 'Feijoada', '1 prato', 560, 30, 45, 28, 'prato'),
  _f('lasanha', 'Lasanha', '1 fatia', 400, 20, 34, 20, 'prato'),
  _f('macarrao', 'Macarrão ao sugo', '1 prato', 380, 12, 66, 8, 'prato'),
  _f('strogonoff', 'Strogonoff com arroz', '1 prato', 550, 28, 50, 26, 'prato'),
  _f('frango_grelhado', 'Frango grelhado', '1 filé', 200, 32, 0, 7, 'prato'),
  _f('salada', 'Salada', '1 prato', 120, 3, 12, 6, 'prato'),
  _f('sopa', 'Sopa de legumes', '1 prato', 180, 8, 24, 5, 'prato'),
  _f('omelete', 'Omelete', '1 un', 250, 18, 3, 18, 'prato'),
  _f('panqueca', 'Panqueca de carne', '2 un', 420, 22, 36, 20, 'prato'),
  _f('salada_frango', 'Salada com frango', '1 prato', 320, 30, 14, 15, 'prato'),
];
