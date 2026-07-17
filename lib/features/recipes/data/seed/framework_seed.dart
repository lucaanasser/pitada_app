// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/framework_seed.dart
// O QUÊ:     Frameworks de exemplo p/ PREVIEW VISUAL no PC — andaime temporário
//            p/ ver lista, planta baixa e detalhe com conteúdo real. NÃO é
//            produto: no app o primeiro framework nasce da pessoa, que nomeia
//            (a IA nunca rotula). Apagar este arquivo antes de valer.
// USA:       framework.dart; recipeIds apontam p/ recipe_seed.dart.
// USADO POR: seed_framework_repository (semente da sessão de preview).
// SPEC:      specs/features/recipes.yaml (frameworks.seed_de_preview)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/framework.dart';

/// Frameworks de exemplo (andaime de preview, some quando o seed for removido).
/// Usada por: SeedFrameworksRepository.
const kSeedFrameworks = <Framework>[
  Framework(
    id: 'fw-selar-e-molho',
    name: 'Selar e montar molho na mesma panela',
    skeleton: [
      'Secar a proteína e selar em panela bem quente, sem mexer',
      'Tirar a proteína e deixar descansar fora do fogo',
      'Refogar o aromático na gordura que ficou',
      'Deglaçar e raspar o fundo até soltar tudo',
      'Reduzir o líquido e emulsionar fora do fogo',
      'Devolver a proteína só para aquecer',
    ],
    slots: ['proteína', 'aromático', 'líquido', 'acidez'],
    rules: [
      'Panela cheia demais cozinha no vapor: selar em levas',
      'O fundo marrom é o molho — deglaçar antes que queime',
      'A gordura entra fora do fogo, senão o molho talha',
    ],
    recipeIds: ['frango-xadrez', 'strogonoff'],
    techniques: ['Selar a carne', 'Emulsionar um molho'],
  ),
  Framework(
    id: 'fw-bowl-montado',
    name: 'Bowl montado por camadas',
    skeleton: [
      'Cozinhar o grão e temperar ainda quente',
      'Assar ou grelhar o vegetal até dourar nas pontas',
      'Bater o molho cremoso à parte',
      'Montar em camadas: grão, vegetal, proteína',
      'Fechar com algo cru e algo crocante',
    ],
    slots: ['grão', 'vegetal', 'proteína', 'molho', 'crocante'],
    rules: [
      'Grão frio não pega tempero: temperar quente',
      'Cada camada tem que ter sal própria',
      'Sem contraste de textura o bowl vira mingau',
    ],
    recipeIds: ['bowl-quinoa'],
    techniques: ['Assar vegetais'],
  ),
  Framework(
    id: 'fw-massa-rapida-frigideira',
    name: 'Massa rápida de frigideira',
    skeleton: [
      'Misturar os secos de um lado e os úmidos do outro',
      'Juntar sem bater demais, até só sumir a farinha',
      'Descansar a massa enquanto a frigideira esquenta',
      'Cozinhar em fogo médio até formar bolhas na superfície',
      'Virar uma única vez',
    ],
    slots: ['base', 'líquido', 'adoçante', 'aroma'],
    rules: [
      'Massa batida demais fica borrachuda: misturar pouco',
      'Fogo alto queima fora e deixa cru dentro',
      'Virar uma vez só — cada virada murcha a panqueca',
    ],
    recipeIds: ['panqueca-banana'],
    techniques: [],
  ),
];
