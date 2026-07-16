// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed_herbs.dart
// O QUÊ:     Guias de Ervas & especiarias do Caderno (fichas de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega com técnicas, frameworks, ingredientes, sabores).
// SPEC:      specs/features/notebook.yaml (data.seed — guias ervas)
// ─────────────────────────────────────────────────────────────────────────────
import 'lesson.dart';
import 'lesson_section.dart';

/// Guias de Ervas & especiarias — aroma, momento certo e combinações.
/// Usada por: learning_seed (kSeedLessons).
const kSeedGuideHerbs = <Lesson>[
  Lesson(
    id: 'guia-manjericao',
    category: LessonKind.herb,
    title: 'Manjericão',
    summary: 'Fresco, doce e delicado.',
    lead: 'Perde o perfume no calor — entra no último instante.',
    sections: [
      LessonSection(
        label: 'Quando usar',
        kind: SectionKind.text,
        body: ['Cru ou no fim da cocção; o calor prolongado destrói o aroma.'],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Tomate', 'Azeite', 'Queijo', 'Alho', 'Limão'],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Rasgue com a mão em vez de cortar — a faca oxida e escurece.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-alecrim',
    category: LessonKind.herb,
    title: 'Alecrim',
    summary: 'Resinoso e potente.',
    lead: 'Aguenta o fogo — entra cedo e perfuma tudo.',
    sections: [
      LessonSection(
        label: 'Quando usar',
        kind: SectionKind.text,
        body: [
          'Cozinhas longas e assados; um ramo inteiro basta para o prato todo.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Batata', 'Cordeiro', 'Frango', 'Azeite', 'Alho'],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Use com moderação — em excesso vira remédio.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-cominho',
    category: LessonKind.herb,
    title: 'Cominho',
    summary: 'Terroso e quente.',
    lead: 'Ganha vida quando tostado antes de usar.',
    sections: [
      LessonSection(
        label: 'Quando usar',
        kind: SectionKind.text,
        body: ['Toste os grãos na panela seca até soltar aroma, depois moa.'],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Feijão', 'Carne', 'Coentro', 'Alho', 'Pimenta'],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Pouco vai longe — comece com menos do que acha que precisa.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-paprica',
    category: LessonKind.herb,
    title: 'Páprica defumada',
    summary: 'Cor e fumaça sem fogo.',
    lead: 'Traz o gosto de churrasco para qualquer prato.',
    sections: [
      LessonSection(
        label: 'Quando usar',
        kind: SectionKind.text,
        body: [
          'Dissolva em gordura quente para liberar cor e aroma; nunca deixe queimar.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Frango', 'Batata', 'Ovo', 'Grão-de-bico', 'Arroz'],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: [
          'Uma pitada engana o paladar: parece grelhado sem ter ido à brasa.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'guia-pimenta-reino',
    category: LessonKind.herb,
    title: 'Pimenta-do-reino',
    summary: 'Picância viva e aromática.',
    lead: 'Moída na hora não tem comparação com a pronta.',
    sections: [
      LessonSection(
        label: 'Quando usar',
        kind: SectionKind.text,
        body: ['Moa no fim: o aroma é volátil e o calor prolongado o dissipa.'],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Carne', 'Queijo', 'Ovo', 'Massa', 'Morango'],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Tostar rápido na gordura antes de moer abre um aroma extra.'],
      ),
    ],
  ),
];
