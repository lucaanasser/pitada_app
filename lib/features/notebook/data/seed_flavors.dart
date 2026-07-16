// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/seed_flavors.dart
// O QUÊ:     Guias de Sabores do Caderno (fichas de exemplo).
// USA:       lesson.dart, lesson_section.dart (composição das fichas).
// USADO POR: seed.dart (agrega com técnicas, frameworks, ingredientes, ervas).
// SPEC:      specs/features/notebook.yaml (data.seed — guias sabores)
// ─────────────────────────────────────────────────────────────────────────────
import 'lesson.dart';
import 'lesson_section.dart';

/// Guias de Sabores — como pensar equilíbrio, camadas e harmonia.
/// Usada por: seed (kSeedLessons).
const kSeedGuideFlavors = <Lesson>[
  Lesson(
    id: 'guia-cinco-gostos',
    category: LessonKind.flavor,
    title: 'Os cinco gostos',
    summary: 'Doce, salgado, ácido, amargo e umami.',
    lead: 'Todo prato memorável equilibra pelo menos dois destes.',
    sections: [
      LessonSection(
        label: 'O mapa',
        kind: SectionKind.text,
        body: [
          'Cada gosto puxa o prato para um lado; o segredo é a tensão entre eles.',
        ],
      ),
      LessonSection(
        label: 'Onde encontrar',
        kind: SectionKind.pairs,
        body: [
          'Doce: açúcar',
          'Salgado: sal',
          'Ácido: limão',
          'Amargo: café',
          'Umami: shoyu',
        ],
      ),
      LessonSection(
        label: 'Como usar',
        kind: SectionKind.keys,
        body: [
          'Sem sal, nada aparece — é o volume do prato.',
          'Ácido e umami dão a sensação de "profundo".',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: ['Prato sem graça quase sempre pede ácido, não mais sal.'],
      ),
    ],
  ),
  Lesson(
    id: 'guia-equilibrar',
    category: LessonKind.flavor,
    title: 'Equilibrar um prato',
    summary: 'Provar, ajustar, provar de novo.',
    lead: 'Cozinhar bem é corrigir aos poucos, não acertar de primeira.',
    sections: [
      LessonSection(
        label: 'O método',
        kind: SectionKind.text,
        body: [
          'Prove, identifique o que falta e adicione o oposto em pequenas doses.',
        ],
      ),
      LessonSection(
        label: 'Os antídotos',
        kind: SectionKind.keys,
        body: [
          'Muito salgado? Ácido ou gordura ajudam a mascarar.',
          'Muito ácido? Uma pitada de açúcar arredonda.',
          'Sem graça? Sal e depois ácido, nessa ordem.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: [
          'Ajuste sempre em pequenas doses — dá para adicionar, não para tirar.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'guia-camadas',
    category: LessonKind.flavor,
    title: 'Camadas de sabor',
    summary: 'Sabor se constrói em etapas.',
    lead: 'Temperar do começo ao fim rende mais que temperar só no final.',
    sections: [
      LessonSection(
        label: 'A ideia',
        kind: SectionKind.text,
        body: [
          'Cada etapa da cocção deixa uma camada; empilhadas, criam profundidade.',
        ],
      ),
      LessonSection(
        label: 'As camadas',
        kind: SectionKind.keys,
        body: [
          'Base: aromáticos dourados no início.',
          'Corpo: caramelização e fundo de panela.',
          'Brilho: ervas e ácido no fim.',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: [
          'Sal em cada etapa tempera por dentro; sal só no fim tempera por cima.',
        ],
      ),
    ],
  ),
  Lesson(
    id: 'guia-harmonias',
    category: LessonKind.flavor,
    title: 'Harmonizações clássicas',
    summary: 'Duplas que sempre funcionam.',
    lead: 'Combinações testadas por gerações — atalhos confiáveis.',
    sections: [
      LessonSection(
        label: 'Por que funcionam',
        kind: SectionKind.text,
        body: [
          'Costumam compartilhar compostos aromáticos ou equilibrar gosto e gordura.',
        ],
      ),
      LessonSection(
        label: 'As duplas',
        kind: SectionKind.pairs,
        body: [
          'Tomate + manjericão',
          'Limão + peixe',
          'Alho + azeite',
          'Chocolate + café',
        ],
      ),
      LessonSection(
        label: 'Dica',
        kind: SectionKind.tip,
        body: [
          'Na dúvida, copie a natureza: o que cresce junto combina no prato.',
        ],
      ),
    ],
  ),
];
