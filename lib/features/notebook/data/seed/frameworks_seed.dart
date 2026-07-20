// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed/frameworks_seed.dart
// O QUÊ:     Fichas de Frameworks do Caderno (dados de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega em kSeedLessons).
// SPEC:      specs/features/notebook.yaml (data.seed — frameworks)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/knowledge/lesson.dart';
import '../models/knowledge/lesson_section.dart';

/// Frameworks — receita-esqueleto: uma fórmula, a ordem e como aplicar.
/// Usada por: seed (kSeedLessons).
const kSeedFrameworks = <Lesson>[
  Lesson(
    id: 'fwk-stirfry',
    category: LessonKind.framework,
    title: 'Stir-fry',
    summary:
        'Fogo alto, ingredientes cortados e uma ordem que respeita cada tempo.',
    lead: 'proteína x2 · aromáticos x½ · legume x2 · molho',
    sections: [
      LessonSection(
        label: 'A fórmula',
        kind: SectionKind.pairs,
        body: [
          'Proteína ×2',
          'Aromáticos ×½',
          'Legume ×2',
          'Molho',
        ],
      ),
      LessonSection(
        label: 'A ordem',
        kind: SectionKind.keys,
        body: [
          'Sele a proteína e reserve.',
          'Aromáticos rápidos (alho, gengibre).',
          'Legumes do mais duro ao mais macio.',
          'Volte a proteína e finalize com o molho.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'fwk-bowl',
    category: LessonKind.framework,
    title: 'Bowl montável',
    summary: 'Uma base, uma proteína, um vegetal, um molho e um crocante.',
    lead: 'base · proteína · vegetal · molho · crocante',
    sections: [
      LessonSection(
        label: 'A fórmula',
        kind: SectionKind.pairs,
        body: [
          'Base',
          'Proteína',
          'Vegetal',
          'Molho',
          'Crocante',
        ],
      ),
      LessonSection(
        label: 'Como montar',
        kind: SectionKind.keys,
        body: [
          'Base neutra: arroz, quinoa ou folhas.',
          'Proteína temperada por cima.',
          'Vegetal cru ou assado para textura.',
          'Molho amarra tudo; crocante fecha.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'fwk-sopa',
    category: LessonKind.framework,
    title: 'Sopa de quase tudo',
    summary: 'Aromáticos, o que sobrou, líquido e tempo — vira jantar.',
    lead: 'aromáticos · base · líquido · finalização',
    sections: [
      LessonSection(
        label: 'A fórmula',
        kind: SectionKind.pairs,
        body: [
          'Aromáticos',
          'Base',
          'Líquido',
          'Finalização',
        ],
      ),
      LessonSection(
        label: 'O caminho',
        kind: SectionKind.keys,
        body: [
          'Refogue cebola e alho para a base.',
          'Junte legumes e o que precisa gastar.',
          'Cubra com caldo e cozinhe até macio.',
          'Ajuste sal e ácido; finalize com ervas.',
        ],
      ),
    ],
  ),
];
