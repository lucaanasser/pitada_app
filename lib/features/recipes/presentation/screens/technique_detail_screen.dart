// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/technique_detail_screen.dart
// O QUÊ:     Página de uma técnica no desenho do framework: rótulo TÉCNICA +
//            nome + noção (editável; convite quando vazia) + receitas onde usei.
// USA:       technique_providers, recipe_list_providers (maestria),
//            quick_edit_sheet, RecipeRow, core/widgets, theme.
// USADO POR: core/router (/technique/:id) — via grifo no passo.
// SPEC:      specs/features/recipes.yaml (TechniqueDetailScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/controls/editable.dart';
import '../../../../core/widgets/layout/section_header.dart';
import '../../application/recipe_list_providers.dart';
import '../../application/technique_providers.dart';
import '../../data/models/recipe/recipe.dart';
import '../../data/models/technique.dart';
import '../sheets/quick_edit_sheet.dart';
import '../widgets/list/recipe_row.dart';

/// Página de detalhe de uma técnica. Usada por: router (/technique/:id).
class TechniqueDetailScreen extends ConsumerWidget {
  const TechniqueDetailScreen({super.key, required this.techniqueId});

  final String techniqueId;

  /// Observa a técnica e monta noção + receitas instância. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final technique =
        ref.watch(techniqueByIdProvider(techniqueId)).valueOrNull;
    final used = ref.watch(recipesUsingTechniqueProvider(techniqueId));

    if (technique == null) {
      return Scaffold(
        backgroundColor: pit.bg,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    final recipes = used.valueOrNull ?? const <Recipe>[];

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.xxl,
          ),
          children: [
            _top(context, pit),
            const SizedBox(height: AppSpacing.lg),
            Text(
              technique.name,
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
            const SizedBox(height: AppSpacing.md),
            Editable(
              onEdit: () => _editNotion(context, ref, technique),
              child: _notion(pit, technique),
            ),
            if (recipes.isNotEmpty) ...[
              const SectionHeader(
                label: 'Receitas onde usei',
                topGap: AppSpacing.xl,
              ),
              for (var i = 0; i < recipes.length; i++)
                RecipeRow(
                  recipe: recipes[i],
                  mastery: ref.watch(recipeMasteryProvider(recipes[i].id)),
                  showDivider: i != recipes.length - 1,
                  onTap: () => context.push('/recipe/${recipes[i].id}'),
                ),
            ],
          ],
        ),
      ),
    );
  }

  /// Linha do topo: voltar + rótulo TÉCNICA. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Text('TÉCNICA', style: AppType.on(AppType.label, AppColors.accent)),
      ],
    );
  }

  /// A noção da técnica, ou o convite a escrevê-la. Usada por: [build].
  Widget _notion(PitadaColors pit, Technique technique) {
    final has = technique.notion != null && technique.notion!.trim().isNotEmpty;
    return Text(
      has
          ? technique.notion!
          : 'O que é? Como saber o ponto? Segure para escrever a sua noção.',
      style: AppType.on(AppType.tip, has ? pit.text2 : pit.faint)
          .copyWith(height: 1.5),
    );
  }

  /// Abre a edição da noção (sheet de 1 campo, sem switch de versão).
  /// Usada por: gesto Editable da noção.
  Future<void> _editNotion(
    BuildContext context,
    WidgetRef ref,
    Technique technique,
  ) async {
    final res = await showQuickEditSheet(
      context,
      title: technique.name,
      fields: [
        QuickEditField(
          label: 'Noção',
          initial: technique.notion ?? '',
          hint: 'O que é, quando usar, como saber o ponto…',
          multiline: true,
        ),
      ],
    );
    if (res == null) return;
    await ref
        .read(techniqueEditControllerProvider)
        .update(technique.copyWith(notion: res.values.first.trim()));
  }
}
