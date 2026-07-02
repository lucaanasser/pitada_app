// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/import_controller.dart
// O QUÊ:     Controller Riverpod que simula a importação de receita por IA
//            (idle -> loading em 3 passos -> ready com preview editável).
// USA:       recipe.dart, recipe_draft.dart, app_log, riverpod.
// USADO POR: import_sheet (escolhe origem, mostra StepProgress e o preview).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT: choose/loading/preview)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';
import '../data/ingredient.dart';
import '../data/recipe.dart';
import '../data/recipe_draft.dart';
import '../data/recipe_step.dart';

/// Fase do fluxo de importação. Espelha os estágios da SHEET-IMPORT.
/// Usada por: import_sheet para decidir o que renderizar.
enum ImportPhase { idle, loading, ready }

/// Rótulos dos 3 passos do StepProgress durante a extração (fase loading).
/// Usada por: import_sheet (StepProgress) e este controller (limite de passos).
const kImportSteps = <String>['Lendo', 'Extraindo', 'Estruturando'];

/// Estado imutável da importação: fase, passo atual e o rascunho de preview.
/// Usada por: import_sheet (via importControllerProvider).
class ImportState {
  final ImportPhase phase;
  final int stepIndex; // 0..kImportSteps.length-1, só relevante em loading
  final RecipeDraft? preview; // preenchido quando phase == ready

  const ImportState({
    this.phase = ImportPhase.idle,
    this.stepIndex = 0,
    this.preview,
  });

  /// Copia o estado trocando só os campos informados. Usada por: o controller.
  ImportState copyWith({
    ImportPhase? phase,
    int? stepIndex,
    RecipeDraft? preview,
  }) {
    return ImportState(
      phase: phase ?? this.phase,
      stepIndex: stepIndex ?? this.stepIndex,
      preview: preview ?? this.preview,
    );
  }
}

/// Simula a extração de receita a partir de uma origem (link/foto/pdf).
/// Sem rede: avança os passos com Future.delayed e devolve um rascunho fixo.
/// Usada por: import_sheet (StateNotifierProvider abaixo).
class ImportController extends StateNotifier<ImportState> {
  ImportController() : super(const ImportState());

  /// Duração de cada passo simulado da extração. Usada por: [startFrom].
  static const _stepDelay = Duration(milliseconds: 700);

  /// Inicia a importação a partir de [origem] (ex.: 'youtube', 'foto', 'pdf').
  /// Percorre os 3 passos e termina em `ready` com o preview. Usada por: import_sheet.
  Future<void> startFrom(String origem) async {
    AppLog.d('recipes', 'import iniciado: $origem');
    state = const ImportState(phase: ImportPhase.loading, stepIndex: 0);
    for (var i = 0; i < kImportSteps.length; i++) {
      await Future<void>.delayed(_stepDelay);
      if (!mounted) return; // sheet fechada no meio da simulação
      final isLast = i == kImportSteps.length - 1;
      if (isLast) {
        state = ImportState(
          phase: ImportPhase.ready,
          stepIndex: i,
          preview: _mockDraft(origem),
        );
        AppLog.i('recipes', 'import pronto para preview: $origem');
      } else {
        state = state.copyWith(stepIndex: i + 1);
      }
    }
  }

  /// Volta o fluxo ao início (fase idle, sem preview). Usada por: import_sheet
  /// ao reabrir ou ao cancelar/refazer a importação.
  void reset() {
    state = const ImportState();
  }

  /// Monta o rascunho fixo do preview (Frango xadrez), como se a IA tivesse
  /// extraído a receita da [origem]. Usada por: [startFrom].
  RecipeDraft _mockDraft(String origem) => RecipeDraft(
        id: 'import-frango-xadrez',
        title: 'Frango xadrez',
        source: RecipeSource.youtube,
        sourceUrl: origem,
        servings: 4,
        timeMinutes: 25,
        kcal: 512,
        protein: 42,
        carb: 38,
        fat: 18,
        difficulty: 'Intermediário',
        heroColor: 'terra',
        techniques: <String>['Selar a carne', 'Emulsionar um molho'],
        ingredients: const <Ingredient>[
          Ingredient(
            name: 'Peito de frango',
            grams: 500,
            humanQty: 500,
            humanUnit: 'g',
          ),
          Ingredient(name: 'Ovo', grams: 80, humanQty: 2, humanUnit: 'unidade'),
          Ingredient(
            name: 'Pimentão',
            grams: 120,
            humanQty: 1,
            humanUnit: 'unidade',
          ),
          Ingredient(
            name: 'Shoyu',
            grams: 45,
            humanQty: 3,
            humanUnit: 'c. sopa',
          ),
          Ingredient(
            name: 'Amendoim',
            grams: 70,
            humanQty: 0.5,
            humanUnit: 'xícara',
          ),
          Ingredient(name: 'Alho', grams: 15, humanQty: 3, humanUnit: 'dentes'),
        ],
        steps: const <RecipeStep>[
          RecipeStep(
            text: 'Corte o frango em cubos e seque bem com papel-toalha.',
            tip:
                'Frango seco doura em vez de cozinhar na própria água — mais sabor.',
          ),
          RecipeStep(
            text: 'Sele os cubos em fogo alto, sem mexer demais, até dourar.',
            tip: 'Panela cheia demais esfria e cozinha; sele em levas.',
          ),
          RecipeStep(
            text:
                'Refogue alho e pimentão rapidamente para manterem a crocância.',
          ),
          RecipeStep(
            text: 'Volte o frango, junte o shoyu e o amendoim e finalize.',
            tip: 'O shoyu reduz e vira molho — desligue quando encorpar.',
          ),
        ],
      );
}

/// Estado do fluxo de importação de receita. Usada por: import_sheet.
final importControllerProvider =
    StateNotifierProvider<ImportController, ImportState>(
  (ref) => ImportController(),
);
