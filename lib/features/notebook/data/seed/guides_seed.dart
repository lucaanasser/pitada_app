// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed/guides_seed.dart
// O QUÊ:     Guias de Ingredientes do Caderno (fichas de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega com técnicas, frameworks, sabores e ervas).
// SPEC:      specs/features/notebook.yaml (data.seed — guias ingredientes)
// ─────────────────────────────────────────────────────────────────────────────
import '../models/knowledge/lesson.dart';
import '../models/knowledge/lesson_section.dart';

/// Guias de Ingredientes — como tratar cada base do dia a dia.
/// Usada por: seed (kSeedLessons).
const kSeedGuideIngredients = <Lesson>[
  Lesson(
    id: 'guia-alho',
    category: LessonKind.ingredient,
    title: 'Alho',
    summary: 'A base aromática de quase tudo.',
    lead: 'Quanto mais picado, mais forte; quanto mais inteiro, mais doce.',
    sections: [
      LessonSection(
        label: 'Como muda o sabor',
        kind: SectionKind.text,
        body: [
          'Fatiado é suave; amassado é intenso; assado inteiro fica doce e cremoso.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Azeite', 'Manteiga', 'Tomate', 'Limão', 'Ervas'],
      ),
      LessonSection(
        label: 'Cuidados',
        kind: SectionKind.keys,
        body: [
          'Nunca deixe queimar — vira amargo em segundos.',
          'Adicione tarde no refogado, depois da cebola.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Esmague com a faca e a casca sai sozinha.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-cebola',
    category: LessonKind.ingredient,
    title: 'Cebola',
    summary: 'Doçura e corpo para o prato inteiro.',
    lead: 'Crua é picante; cozida devagar vira caramelo salgado.',
    sections: [
      LessonSection(
        label: 'Como muda o sabor',
        kind: SectionKind.text,
        body: [
          'Refogada rápido fica adocicada; caramelizada devagar fica profunda e doce.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Alho', 'Manteiga', 'Vinho', 'Carne', 'Queijo'],
      ),
      LessonSection(
        label: 'Cuidados',
        kind: SectionKind.keys,
        body: [
          'Corte no sentido das fibras para ela segurar na panela.',
          'Sal ajuda a soltar a água e acelera o dourado.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Gele a cebola antes de cortar para lacrimejar menos.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-tomate',
    category: LessonKind.ingredient,
    title: 'Tomate',
    summary: 'Acidez e umami em qualquer estação.',
    lead: 'Cru refresca; cozido concentra e vira molho.',
    sections: [
      LessonSection(
        label: 'Como muda o sabor',
        kind: SectionKind.text,
        body: [
          'Fresco é ácido e leve; reduzido no fogo fica doce, denso e cheio de umami.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Manjericão', 'Alho', 'Azeite', 'Queijo', 'Cebola'],
      ),
      LessonSection(
        label: 'Cuidados',
        kind: SectionKind.keys,
        body: [
          'Uma pitada de açúcar corrige a acidez sem mascarar.',
          'Retire as sementes se quiser um molho menos aguado.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Nunca guarde na geladeira — o frio mata o sabor.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-limao',
    category: LessonKind.ingredient,
    title: 'Limão',
    summary: 'O ácido que acende o prato no fim.',
    lead: 'Suco ilumina; raspa perfuma sem azedar.',
    sections: [
      LessonSection(
        label: 'Como muda o sabor',
        kind: SectionKind.text,
        body: [
          'O ácido equilibra gordura e sal; a raspa traz aroma sem acrescentar acidez.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Peixe', 'Frango', 'Azeite', 'Ervas', 'Manteiga'],
      ),
      LessonSection(
        label: 'Cuidados',
        kind: SectionKind.keys,
        body: [
          'Adicione o suco no fim — o calor apaga o frescor.',
          'Rale só a parte amarela; o branco é amargo.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Role o limão na bancada antes de espremer — sai mais suco.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-ovo',
    category: LessonKind.ingredient,
    title: 'Ovo',
    summary: 'O ingrediente mais versátil da cozinha.',
    lead: 'Liga, aera, emulsiona e vira prato sozinho.',
    sections: [
      LessonSection(
        label: 'Como muda o sabor',
        kind: SectionKind.text,
        body: [
          'Mexido cremoso pede fogo baixo; frito crocante pede fogo alto e gordura quente.',
        ],
      ),
      LessonSection(
        label: 'Combina com',
        kind: SectionKind.pairs,
        body: ['Manteiga', 'Queijo', 'Ervas', 'Pão', 'Bacon'],
      ),
      LessonSection(
        label: 'Cuidados',
        kind: SectionKind.keys,
        body: [
          'A gema cozinha rápido — tire do fogo antes do ponto final.',
          'Sal na hora certa muda a textura do mexido.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Ovo em temperatura ambiente incorpora melhor em massas.'],
      ),
    ],
  ),
];
