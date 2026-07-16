// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed/seed_activity.dart
// O QUÊ:     Seeds de ATIVIDADE do Caderno (notas, diário, versões, logs e a
//            cozinha pendente). Datas relativas a hoje para o fio ficar vivo.
// USA:       modelos do Caderno (source_note, diary_entry, recipe_version,
//            process_log, pending_cook).
// USADO POR: seed (re-exporta), repository.
// ─────────────────────────────────────────────────────────────────────────────
import '../models/activity/diary_entry.dart';
import '../models/activity/pending_cook.dart';
import '../models/activity/process_log.dart';
import '../models/activity/recipe_version.dart';
import '../models/activity/source_note.dart';

/// Devolve a data de [days] dias atrás (demo sempre "viva", sem datas fixas).
/// Usada por: os seeds abaixo.
DateTime _daysAgo(int days) => DateTime.now().subtract(Duration(days: days));

/// Cozinha ainda sem registro no diário — alimenta o card "Ontem você cozinhou".
/// Usada por: repository.fetchPendingCook.
final kSeedPendingCook = PendingCook(
  recipeId: 'strogonoff',
  recipeName: 'Strogonoff de carne',
  when: _daysAgo(1),
);

/// Notas de fonte de exemplo. Usada por: repository.
final kSeedNotes = <SourceNote>[
  SourceNote(
    id: 'nota-salt-fat',
    title: 'Sal, Gordura, Ácido, Calor',
    kind: 'Livro',
    meta: 'Samin Nosrat',
    date: _daysAgo(5),
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
    date: _daysAgo(9),
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
    date: _daysAgo(16),
    takeaways: [
      'Wok bem quente antes do óleo evita que a comida grude.',
      'Cozinhe em pequenas porções para não derrubar a temperatura.',
    ],
    recipeIds: ['frango-xadrez'],
  ),
];

/// Entradas de diário de exemplo. Usada por: repository.
final kSeedDiary = <DiaryEntry>[
  DiaryEntry(
    id: 'diario-legumes',
    recipeName: 'Legumes assados',
    date: _daysAgo(3),
    label: 'Refazer',
    body: 'Forno bem alto e sem mexer no meio — caramelizou de verdade. '
        'Alecrim entra só nos últimos 10 minutos.',
    recipeIds: [],
  ),
  DiaryEntry(
    id: 'diario-xadrez',
    recipeName: 'Frango xadrez',
    date: _daysAgo(11),
    label: 'Refazer',
    body: 'Selei em duas levas e ficou muito melhor — a crosta apareceu. '
        'Da próxima, mais amendoim e menos shoyu.',
    recipeIds: ['frango-xadrez'],
  ),
  DiaryEntry(
    id: 'diario-strog',
    recipeName: 'Strogonoff de carne',
    date: _daysAgo(19),
    label: 'Ajustar',
    body: 'Molho ficou aguado — reduzi pouco. Aprendi a não colocar o creme '
        'de leite com o fogo alto para não talhar.',
    recipeIds: ['strogonoff'],
  ),
];

/// Versões de receita de exemplo. Usada por: repository.
final kSeedVersions = <RecipeVersion>[
  RecipeVersion(
    id: 'ver-xadrez',
    recipeName: 'Frango xadrez',
    recipeId: 'frango-xadrez',
    date: _daysAgo(7),
    timeline: const [
      VersionStep(
        label: 'v1',
        change: 'Receita original, tudo na panela de uma vez.',
      ),
      VersionStep(
        label: 'v2',
        change: 'Selei o frango em levas — crosta muito melhor.',
      ),
      VersionStep(
        label: 'v3',
        change: 'Menos shoyu, mais amendoim. Versão definitiva.',
      ),
    ],
  ),
  RecipeVersion(
    id: 'ver-strog',
    recipeName: 'Strogonoff de carne',
    recipeId: 'strogonoff',
    date: _daysAgo(14),
    timeline: const [
      VersionStep(
        label: 'v1',
        change: 'Base clássica com creme de leite de lata.',
      ),
      VersionStep(
        label: 'v2',
        change: 'Reduzi o molho antes do creme — encorpou.',
      ),
    ],
  ),
];

/// Logs de processo de exemplo. Usada por: repository.
final kSeedLogs = <ProcessLog>[
  ProcessLog(
    id: 'log-pao',
    type: 'Fermentação',
    title: 'Pão de fermentação natural',
    date: _daysAgo(21),
    params: const {'Hidratação': '75%', 'Fermento': '20%', 'Sal': '2%'},
    timeline: const [
      LogEvent(
        date: 'Sáb · 08h',
        text: 'Autólise por 40 min antes de misturar o sal.',
      ),
      LogEvent(
        date: 'Sáb · 12h',
        text: '4 dobras a cada 30 min; massa ganhou força.',
      ),
      LogEvent(
        date: 'Dom · 08h',
        text: 'Fermentação lenta na geladeira; assei em panela de ferro.',
      ),
    ],
    note: 'Miolo mais aberto que da última vez — a autólise fez diferença.',
  ),
];
