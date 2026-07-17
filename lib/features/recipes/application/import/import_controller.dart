// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/application/import/import_controller.dart
// O QUÊ:     Controller Riverpod da importação de receita: dispara o service
//            (idle -> loading em 3 passos -> ready com preview | error com retry).
// USA:       recipe_import_service (real/mock), recipe_draft, recipe (RecipeSource), app_log.
// USADO POR: import_sheet (escolhe origem, mostra StepProgress, preview e erro).
// SPEC:      specs/features/recipes.yaml (SHEET-IMPORT) + backend/edge_functions.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_log.dart';
import '../../data/models/recipe.dart';
import '../../data/models/recipe_draft.dart';
import 'recipe_import_service.dart';

/// Fase do fluxo de importação. Espelha os estágios da SHEET-IMPORT.
/// Usada por: import_sheet para decidir o que renderizar.
enum ImportPhase { idle, loading, ready, error }

/// Rótulos dos 3 passos do StepProgress durante a extração (fase loading).
/// Usada por: import_sheet (StepProgress) e este controller (limite de passos).
const kImportSteps = <String>['Lendo', 'Extraindo', 'Estruturando'];

/// Estado imutável da importação: fase, passo atual, preview e mensagem de erro.
/// Usada por: import_sheet (via importControllerProvider).
class ImportState {
  final ImportPhase phase;
  final int stepIndex;
  final RecipeDraft? preview;
  final String? error;

  const ImportState({
    this.phase = ImportPhase.idle,
    this.stepIndex = 0,
    this.preview,
    this.error,
  });
}

/// Extrai uma receita a partir de uma fonte (site/instagram/pdf/manual) via
/// RecipeImportService. Anima os passos enquanto aguarda a resposta real.
/// Usada por: import_sheet (StateNotifierProvider abaixo).
class ImportController extends StateNotifier<ImportState> {
  ImportController(this._service) : super(const ImportState());

  final RecipeImportService _service;

  /// Duração de cada passo cosmético do StepProgress. Usada por: [startFrom].
  static const _stepDelay = Duration(milliseconds: 700);

  /// Última entrada, para o botão "Tentar de novo" repetir. Usada por: [retry].
  RecipeImportInput? _last;

  /// Importa a receita da [input]. manual abre um rascunho em branco na hora;
  /// as demais fontes chamam o service (com passos cosméticos) e caem em ready
  /// ou error. Usada por: import_sheet.
  Future<void> startFrom(RecipeImportInput input) async {
    _last = input;
    AppLog.d('recipes', 'import iniciado: ${input.source.name}');
    if (input.source == RecipeSource.manual) {
      state = ImportState(
        phase: ImportPhase.ready,
        preview: RecipeDraft(source: RecipeSource.manual),
      );
      return;
    }
    state = const ImportState(phase: ImportPhase.loading);
    final pending = _service.importFrom(input);
    for (var i = 1; i < kImportSteps.length; i++) {
      await Future<void>.delayed(_stepDelay);
      if (!mounted) return;
      if (state.phase != ImportPhase.loading) break;
      state = ImportState(phase: ImportPhase.loading, stepIndex: i);
    }
    try {
      final draft = await pending;
      if (!mounted) return;
      if (draft.title.trim().isEmpty && draft.ingredients.isEmpty) {
        state = const ImportState(
          phase: ImportPhase.error,
          error: 'Não encontrei uma receita aí.',
        );
        return;
      }
      AppLog.i('recipes', 'import pronto para preview: ${draft.title}');
      state = ImportState(phase: ImportPhase.ready, preview: draft);
    } catch (e) {
      if (!mounted) return;
      AppLog.w('recipes', 'import falhou: $e');
      state = ImportState(phase: ImportPhase.error, error: '$e');
    }
  }

  /// Repete a última importação (botão "Tentar de novo"). Usada por: import_sheet.
  void retry() {
    final last = _last;
    if (last != null) startFrom(last);
  }

  /// Volta o fluxo ao início (fase idle). Usada por: import_sheet ao reabrir/cancelar.
  void reset() {
    state = const ImportState();
  }
}

/// Estado do fluxo de importação de receita. Usada por: import_sheet.
final importControllerProvider =
    StateNotifierProvider<ImportController, ImportState>(
  (ref) => ImportController(ref.watch(recipeImportServiceProvider)),
);
