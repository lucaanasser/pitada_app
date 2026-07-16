// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed.dart
// O QUÊ:     Dados de exemplo do Caderno: agrega as fichas + repertório e
//            re-exporta os seeds de atividade (notas/diário/versões/logs).
// USA:       modelos do Caderno + seeds de fichas e de atividade.
// USADO POR: learning_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/notebook.yaml (data.seed)
// ─────────────────────────────────────────────────────────────────────────────
import 'seed_flavors.dart';
import 'seed_guides.dart';
import 'seed_herbs.dart';
import 'seed_lessons.dart';
import 'lesson.dart';
import 'repertoire.dart';

export 'seed_activity.dart'
    show kSeedNotes, kSeedDiary, kSeedVersions, kSeedLogs, kSeedPendingCook;

/// Todas as fichas do Caderno (técnicas + frameworks + guias). Usada por: repository.
const kSeedLessons = <Lesson>[
  ...kSeedTechniques,
  ...kSeedFrameworks,
  ...kSeedGuideIngredients,
  ...kSeedGuideFlavors,
  ...kSeedGuideHerbs,
];

/// Rácios de confiança de exemplo. Usada por: learning_repository.
const kSeedRatios = <Ratio>[
  Ratio(name: 'Vinagrete', ratio: '3 : 1', note: 'óleo : ácido'),
  Ratio(name: 'Arroz branco', ratio: '1 : 2', note: 'arroz : água'),
  Ratio(name: 'Salmoura rápida', ratio: '1 L : 60 g', note: 'água : sal'),
  Ratio(
    name: 'Massa de panqueca',
    ratio: '1 : 1 : 1',
    note: 'farinha : leite : ovo',
  ),
];

/// Substituições testadas de exemplo. Usada por: learning_repository.
const kSeedSubstitutions = <Substitution>[
  Substitution(
    missing: 'Sem shoyu',
    use: 'Molho inglês + sal',
    note: 'marinadas',
  ),
  Substitution(
    missing: 'Sem creme de leite',
    use: 'Iogurte natural encorpado',
    note: 'molhos',
  ),
  Substitution(
    missing: 'Sem manjericão',
    use: 'Salsinha + raspa de limão',
    note: 'finalização',
  ),
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
