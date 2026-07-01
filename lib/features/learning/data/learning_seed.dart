// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/learning_seed.dart
// O QUÊ:     Dados de exemplo do Caderno: agrega as fichas e traz prática/repertório.
// USA:       modelos do Caderno + os seeds de fichas (lessons/guides/flavors).
// USADO POR: learning_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/learning.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'diary_entry.dart';
import 'learning_seed_flavors.dart';
import 'learning_seed_guides.dart';
import 'learning_seed_herbs.dart';
import 'learning_seed_lessons.dart';
import 'lesson.dart';
import 'process_log.dart';
import 'recipe_version.dart';
import 'repertoire.dart';
import 'source_note.dart';

/// Todas as fichas do Caderno (técnicas + frameworks + guias). Usada por: repository.
const kSeedLessons = <Lesson>[
  ...kSeedTechniques,
  ...kSeedFrameworks,
  ...kSeedGuideIngredients,
  ...kSeedGuideFlavors,
  ...kSeedGuideHerbs,
];

/// Notas de fonte de exemplo. Usada por: learning_repository.
const kSeedNotes = <SourceNote>[
  SourceNote(
    id: 'nota-salt-fat',
    title: 'Sal, Gordura, Ácido, Calor',
    kind: 'Livro',
    meta: 'Samin Nosrat',
    takeaways: [
      'Sal realça e equilibra — tempere em camadas, não só no fim.',
      'Ácido é o contraponto que dá frescor e vida ao prato.',
      'Calor é técnica: controla textura tanto quanto sabor.',
    ],
    recipeIds: ['frango-xadrez'],
  ),
  SourceNote(
    id: 'nota-kenji',
    title: 'The Food Lab — ciência do dourado',
    kind: 'Vídeo',
    meta: 'J. Kenji López-Alt',
    takeaways: [
      'Reação de Maillard precisa de superfície seca e calor alto.',
      'Descansar a carne redistribui os líquidos antes de cortar.',
    ],
    recipeIds: ['strogonoff'],
  ),
  SourceNote(
    id: 'nota-wok',
    title: 'Wok — o segredo do fogo alto',
    kind: 'Curso',
    meta: 'Grace Young',
    takeaways: [
      'Wok bem quente antes do óleo evita que a comida grude.',
      'Cozinhe em pequenas porções para não derrubar a temperatura.',
    ],
    recipeIds: ['frango-xadrez'],
  ),
];

/// Entradas de diário de exemplo. `final` (não `const`) porque `DateTime` não é
/// construtor const. Usada por: learning_repository.
final kSeedDiary = <DiaryEntry>[
  DiaryEntry(
    id: 'diario-xadrez',
    recipeName: 'Frango xadrez',
    date: DateTime(2026, 6, 20),
    label: 'Refazer',
    body: 'Selei em duas levas e ficou muito melhor — a crosta apareceu. '
        'Da próxima, mais amendoim e menos shoyu.',
    recipeIds: ['frango-xadrez'],
  ),
  DiaryEntry(
    id: 'diario-strog',
    recipeName: 'Strogonoff de carne',
    date: DateTime(2026, 6, 12),
    label: 'Ajustar',
    body: 'Molho ficou aguado — reduzi pouco. Aprendi a não colocar o creme '
        'de leite com o fogo alto para não talhar.',
    recipeIds: ['strogonoff'],
  ),
];

/// Versões de receita de exemplo. Usada por: learning_repository.
const kSeedVersions = <RecipeVersion>[
  RecipeVersion(
    id: 'ver-xadrez',
    recipeName: 'Frango xadrez',
    recipeId: 'frango-xadrez',
    timeline: [
      VersionStep(
          label: 'v1', change: 'Receita original, tudo na panela de uma vez.'),
      VersionStep(
          label: 'v2',
          change: 'Selei o frango em levas — crosta muito melhor.'),
      VersionStep(
          label: 'v3',
          change: 'Menos shoyu, mais amendoim. Versão definitiva.'),
    ],
  ),
  RecipeVersion(
    id: 'ver-strog',
    recipeName: 'Strogonoff de carne',
    recipeId: 'strogonoff',
    timeline: [
      VersionStep(
          label: 'v1', change: 'Base clássica com creme de leite de lata.'),
      VersionStep(
          label: 'v2', change: 'Reduzi o molho antes do creme — encorpou.'),
    ],
  ),
];

/// Logs de processo de exemplo. `final` (não `const`) porque `DateTime` não é
/// construtor const. Usada por: learning_repository.
final kSeedLogs = <ProcessLog>[
  ProcessLog(
    id: 'log-pao',
    type: 'Fermentação',
    title: 'Pão de fermentação natural',
    date: DateTime(2026, 6, 14),
    params: {'Hidratação': '75%', 'Fermento': '20%', 'Sal': '2%'},
    timeline: [
      const LogEvent(
          date: 'Sáb · 08h',
          text: 'Autólise por 40 min antes de misturar o sal.'),
      const LogEvent(
          date: 'Sáb · 12h',
          text: '4 dobras a cada 30 min; massa ganhou força.'),
      const LogEvent(
          date: 'Dom · 08h',
          text: 'Fermentação lenta na geladeira; assei em panela de ferro.'),
    ],
    note: 'Miolo mais aberto que da última vez — a autólise fez diferença.',
  ),
];

/// Rácios de confiança de exemplo. Usada por: learning_repository.
const kSeedRatios = <Ratio>[
  Ratio(name: 'Vinagrete', ratio: '3 : 1', note: 'óleo : ácido'),
  Ratio(name: 'Arroz branco', ratio: '1 : 2', note: 'arroz : água'),
  Ratio(name: 'Salmoura rápida', ratio: '1 L : 60 g', note: 'água : sal'),
  Ratio(
      name: 'Massa de panqueca',
      ratio: '1 : 1 : 1',
      note: 'farinha : leite : ovo'),
];

/// Substituições testadas de exemplo. Usada por: learning_repository.
const kSeedSubstitutions = <Substitution>[
  Substitution(
      missing: 'Sem shoyu', use: 'Molho inglês + sal', note: 'marinadas'),
  Substitution(
      missing: 'Sem creme de leite',
      use: 'Iogurte natural encorpado',
      note: 'molhos'),
  Substitution(
      missing: 'Sem manjericão',
      use: 'Salsinha + raspa de limão',
      note: 'finalização'),
];

/// Harmonizações de exemplo. Usada por: learning_repository.
const kSeedPairings = <Pairing>[
  Pairing(
    id: 'harm-tomate',
    ingredient: 'Tomate',
    recipeIds: ['frango-xadrez'],
    items: [
      PairingItem(name: 'Manjericão', rating: PairingRating.classico),
      PairingItem(name: 'Azeite', rating: PairingRating.classico),
      PairingItem(name: 'Alho', rating: PairingRating.adoro),
      PairingItem(name: 'Muçarela', rating: PairingRating.testei),
    ],
  ),
  Pairing(
    id: 'harm-limao',
    ingredient: 'Limão',
    items: [
      PairingItem(name: 'Peixe', rating: PairingRating.classico),
      PairingItem(name: 'Manteiga', rating: PairingRating.adoro),
      PairingItem(name: 'Alecrim', rating: PairingRating.testei),
    ],
  ),
];
