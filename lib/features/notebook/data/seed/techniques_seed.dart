// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed/techniques_seed.dart
// O QUÊ:     Fichas de Técnicas do Caderno (dados de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega em kSeedLessons).
// SPEC:      specs/features/notebook.yaml (data.seed — técnicas)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/knowledge/lesson.dart';
import '../models/knowledge/lesson_section.dart';

/// Técnicas — cada uma com princípio (summary), 4 pontos-chave e o erro comum.
/// Usada por: seed (kSeedLessons).
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
