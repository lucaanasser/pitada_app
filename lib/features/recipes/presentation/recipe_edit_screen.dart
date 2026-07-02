// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipe_edit_screen.dart
// O QUÊ:     Tela de edição/criação de receita: fotos, campos, ingredientes e passos.
//            Mantém um rascunho local (RecipeDraft) e salva via mock (AppLog + pop).
// USA:       recipes_providers, RecipeDraft, os widgets de edição, core/widgets, theme.
// USADO POR: core/router (/recipe/:id/edit) — via ícone lápis do detalhe.
// SPEC:      specs/features/recipes.yaml (RecipeEditScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/pitada_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import '../data/recipe_draft.dart';
import 'widgets/edit_field.dart';
import 'widgets/photo_grid.dart';
import 'widgets/recipe_editors.dart';

/// Editor de uma receita. Carrega o rascunho de recipeByIdProvider (ou em branco
/// se não achar) e edita em memória. Usada por: router (/recipe/:id/edit).
class RecipeEditScreen extends ConsumerStatefulWidget {
  const RecipeEditScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  ConsumerState<RecipeEditScreen> createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends ConsumerState<RecipeEditScreen> {
  RecipeDraft? _draft;
  final _name = TextEditingController();
  int _photoCount = 1;

  /// Libera o controller do nome. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Pina o rascunho uma única vez, já com o provider resolvido (dado ou erro).
  /// [recipe] nulo = criar receita nova. Usada por: [build].
  void _ensureDraft(Recipe? recipe) {
    _draft ??= recipe == null ? RecipeDraft() : RecipeDraft.fromRecipe(recipe);
    if (_name.text.isEmpty) _name.text = _draft!.title;
  }

  /// Congela o rascunho e "salva" (mock: log). Usada por: botão Salvar.
  void _save() {
    final draft = _draft;
    if (draft == null) return;
    draft.title = _name.text;
    AppLog.i(
      'recipes',
      'receita salva: ${draft.id.isEmpty ? "(nova)" : draft.id}',
    );
    context.pop();
  }

  /// Constrói a tela via PitadaScaffold (top fixo + corpo rolável). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final async = ref.watch(recipeByIdProvider(widget.recipeId));
    // Enquanto o provider carrega, aguarda para não pinar um rascunho em branco.
    if (async.isLoading && _draft == null) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
      );
    }
    final recipe = async.valueOrNull;
    _ensureDraft(recipe);
    final draft = _draft!;

    return PitadaScaffold(
      top: _header(context, isNew: recipe == null),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.lg,
          AppSpacing.gutter,
          AppSpacing.xxxl,
        ),
        children: [
          PhotoGrid(
            count: _photoCount,
            heroColor: draft.heroColor,
            onAdd: () => setState(() => _photoCount++),
          ),
          const SizedBox(height: AppSpacing.xl),
          EditTextField(
            label: 'Nome',
            controller: _name,
            hint: 'Nome da receita',
          ),
          EditStepperField(
            label: 'Porções',
            value: draft.servings,
            min: 1,
            onChanged: (v) => setState(() => draft.servings = v),
          ),
          EditStepperField(
            label: 'Tempo (min)',
            value: draft.timeMinutes ?? 0,
            suffix: 'min',
            onChanged: (v) => setState(() => draft.timeMinutes = v),
          ),
          const SectionHeader(label: 'Ingredientes'),
          IngredientsEditor(
            ingredients: draft.ingredients,
            onDirty: () => setState(() {}),
          ),
          const SectionHeader(label: 'Modo de preparo'),
          StepsEditor(steps: draft.steps, onDirty: () => setState(() {})),
        ],
      ),
    );
  }

  /// Cabeçalho fixo: Cancelar (esq) + título (centro) + Salvar (dir, accent).
  /// Usada por: [build].
  Widget _header(BuildContext context, {required bool isNew}) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.md,
          AppSpacing.gutter,
          AppSpacing.md,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.line, width: AppSpacing.hair),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Cancelar',
                style: AppType.on(AppType.button, AppColors.muted),
              ),
            ),
            Expanded(
              child: Text(
                isNew ? 'Nova receita' : 'Editar receita',
                style: AppType.title,
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: _save,
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Salvar',
                style: AppType.on(AppType.button, AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
