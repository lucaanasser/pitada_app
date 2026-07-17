// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/seed/technique_seed.dart
// O QUÊ:     Técnicas de exemplo (com noção escrita) p/ preview — as mesmas que
//            as receitas do seed executam. O app vem cheio: o primeiro contato
//            com a página de técnica é uma edição, não uma página em branco.
// USA:       technique.dart.
// USADO POR: seed_technique_repository.
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/technique.dart';

/// Técnicas de exemplo. Usada por: seed_technique_repository (preview sem backend).
const kSeedTechniques = <Technique>[
  Technique(
    id: 'tq-selar',
    slug: 'selar',
    name: 'Selar',
    notion: 'Dourar a superfície da carne em fogo alto, sem mexer, até formar '
        'crosta (reação de Maillard — é ela que cria sabor). A panela precisa '
        'estar bem quente e a carne seca; panela cheia esfria e cozinha no '
        'vapor em vez de dourar.',
  ),
  Technique(
    id: 'tq-emulsionar',
    slug: 'emulsionar',
    name: 'Emulsionar',
    notion: 'Unir gordura e líquido numa mistura estável (molho encorpado, '
        'vinagrete que não separa). O segredo é adicionar a gordura aos poucos, '
        'mexendo sempre — despejar de uma vez separa.',
  ),
  Technique(
    id: 'tq-refogar',
    slug: 'refogar',
    name: 'Refogar',
    notion: 'Cozinhar rápido em pouca gordura, mexendo, para amaciar e '
        'perfumar sem dourar demais. O padrão clássico: gordura, aromático '
        '(alho/cebola), depois o resto — nessa ordem.',
  ),
];
