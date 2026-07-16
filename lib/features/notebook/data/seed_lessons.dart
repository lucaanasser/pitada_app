// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed_lessons.dart
// O QUÊ:     Fichas de Técnicas e Frameworks do Caderno (dados de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega com os guias).
// SPEC:      specs/features/notebook.yaml (data.seed — técnicas e frameworks)
// ─────────────────────────────────────────────────────────────────────────────
import 'lesson.dart';
import 'lesson_section.dart';

/// Técnicas — cada uma com princípio (summary), 4 pontos-chave e o erro comum.
/// Usada por: learning_seed (kSeedLessons).
const kSeedTechniques = <Lesson>[
  Lesson(
    id: 'tec-selar',
    category: LessonKind.technique,
    title: 'Selar a carne',
    summary: 'Superfície seca + panela quente = crosta dourada cheia de sabor.',
    sections: [
      LessonSection(
        label: 'Os pontos-chave',
        kind: SectionKind.keys,
        body: [
          'Seque a carne com papel-toalha antes de ir à panela.',
          'Panela bem quente antes de colocar a proteína.',
          'Não amontoe — a água escapa e cozinha em vez de dourar.',
          'Não mexa: deixe formar crosta antes de virar.',
        ],
      ),
      LessonSection(
        label: 'Erro comum',
        kind: SectionKind.tip,
        body: [
          'Virar cedo demais rasga a crosta e a carne solta água.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'tec-cebola',
    category: LessonKind.technique,
    title: 'Caramelizar cebola',
    summary: 'Açúcar da cebola vira ouro no fogo baixo e paciente.',
    sections: [
      LessonSection(
        label: 'Os pontos-chave',
        kind: SectionKind.keys,
        body: [
          'Fogo baixo e tempo — 30 a 40 minutos, sem pressa.',
          'Uma pitada de sal solta a água e acelera o processo.',
          'Mexa de vez em quando, raspando o fundo.',
          'Um fio de água resgata o caramelo grudado.',
        ],
      ),
      LessonSection(
        label: 'Erro comum',
        kind: SectionKind.tip,
        body: [
          'Fogo alto queima por fora e deixa cru por dentro — vira amargo.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'tec-arroz',
    category: LessonKind.technique,
    title: 'Arroz soltinho',
    summary: 'Refogar o grão e medir a água certa faz cada grão ficar solto.',
    sections: [
      LessonSection(
        label: 'Os pontos-chave',
        kind: SectionKind.keys,
        body: [
          'Refogue o arroz no óleo até ficar translúcido.',
          'Proporção base: uma parte de arroz para duas de água.',
          'Água fervente entra de uma vez, depois fogo baixo e tampa.',
          'Descanse tampado 5 minutos antes de soltar com o garfo.',
        ],
      ),
      LessonSection(
        label: 'Erro comum',
        kind: SectionKind.tip,
        body: [
          'Mexer durante o cozimento libera amido e empapa tudo.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'tec-emulsionar',
    category: LessonKind.technique,
    title: 'Emulsionar um molho',
    summary: 'Gordura e água só se unem com agitação e um elo no meio.',
    sections: [
      LessonSection(
        label: 'Os pontos-chave',
        kind: SectionKind.keys,
        body: [
          'Adicione a gordura em fio, batendo sem parar.',
          'Um emulsificante (mostarda, gema) segura a mistura.',
          'Tudo em temperatura parecida emulsiona melhor.',
          'Se talhar, recomece com uma gema e vá incorporando.',
        ],
      ),
      LessonSection(
        label: 'Erro comum',
        kind: SectionKind.tip,
        body: [
          'Jogar toda a gordura de uma vez quebra a emulsão na hora.',
        ],
      ),
    ],
  ),
];

/// Frameworks — receita-esqueleto: uma fórmula, a ordem e como aplicar.
/// Usada por: learning_seed (kSeedLessons).
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
