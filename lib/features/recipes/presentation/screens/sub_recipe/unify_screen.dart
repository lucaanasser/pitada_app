// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/sub_recipe/unify_screen.dart
// O QUÊ:     Reconciliação N->1: a partir de um componente local (origem),
//            lista os parecidos nas outras receitas, marca os que viram
//            vínculo e unifica todos numa subreceita canônica.
// USA:       unify_service (candidatas/escala/diffs), sub_recipe_providers
//            (controller), recipe_providers, core/widgets (CheckItem,
//            HairlineRow, EditTextField, PitadaButton, EmptyState), core/theme.
// USADO POR: core/router (/unify/:recipeId/:component) — via sheet de ações.
// SPEC:      specs/features/sub_recipes.yaml (unificacao.tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/utils/scaling.dart';
import '../../../../../core/widgets/cards/hairline_row.dart';
import '../../../../../core/widgets/controls/check_item.dart';
import '../../../../../core/widgets/controls/edit_field.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../application/recipe_providers.dart';
import '../../../application/sub_recipe/sub_recipe_providers.dart';
import '../../../application/sub_recipe/unify_service.dart';
import '../../../data/models/recipe/recipe.dart';

/// Tela de unificação de componentes parecidos numa subreceita canônica.
/// Usada por: router (/unify/:recipeId/:component).
class UnifyScreen extends ConsumerStatefulWidget {
  const UnifyScreen({
    super.key,
    required this.recipeId,
    required this.componentIndex,
  });

  final String recipeId;
  final int componentIndex;

  @override
  ConsumerState<UnifyScreen> createState() => _UnifyScreenState();
}

/// Estado: nome da subreceita + seleção de candidatas. Usada por: UnifyScreen.
class _UnifyScreenState extends ConsumerState<UnifyScreen> {
  final _name = TextEditingController();
  final _selected = <String>{};
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Chave estável de uma candidata na seleção. Usada por: [build]/[_unify].
  String _key(UnifyCandidate c) => '${c.recipeId}:${c.componentIndex}';

  /// Monta topo + nome + lista de candidatas + botão de unificar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final origin = ref.watch(recipeByIdProvider(widget.recipeId)).valueOrNull;
    final recipes = ref.watch(recipesProvider).valueOrNull;

    if (origin == null ||
        recipes == null ||
        widget.componentIndex >= origin.components.length) {
      return Scaffold(
        backgroundColor: pit.bg,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }
    final component = origin.components[widget.componentIndex];
    final candidates =
        findUnifyCandidates(recipes, origin, widget.componentIndex);
    if (!_initialized) {
      _initialized = true;
      _name.text = component.name ?? '';
      _selected.addAll([
        for (final c in candidates)
          if (c.preselected) _key(c),
      ]);
    }
    final count = _selected.length;

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
              'Unificar em uma subreceita',
              style: AppType.on(AppType.screenTitle, pit.text),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'A versão de "${origin.title}" vira a subreceita; as marcadas '
              'viram vínculos com a escala sugerida.',
              style: AppType.on(AppType.caption, pit.muted),
            ),
            const SizedBox(height: AppSpacing.lg),
            EditTextField(label: 'Nome', controller: _name, hint: 'Cobertura…'),
            const SectionHeader(label: 'Parecidas', accent: true),
            if (candidates.isEmpty)
              const EmptyState(
                icon: AppIcons.link,
                title: 'Nada parecido por aqui',
                message: 'Nenhum componente parecido nas outras receitas. '
                    'Dá para tornar subreceita mesmo assim.',
              )
            else
              for (var i = 0; i < candidates.length; i++)
                _candidateRow(pit, candidates[i], i == candidates.length - 1),
            const SizedBox(height: AppSpacing.xl),
            PitadaButton(
              label: count == 0
                  ? 'Tornar subreceita'
                  : 'Unificar ${count + 1} em 1',
              icon: AppIcons.link,
              onPressed: _saving ? null : () => _unify(origin, candidates),
            ),
          ],
        ),
      ),
    );
  }

  /// Linha de candidata: check + receita/componente + diffs e fator sugerido.
  /// Usada por: [build].
  Widget _candidateRow(PitadaColors pit, UnifyCandidate c, bool last) {
    final key = _key(c);
    final checked = _selected.contains(key);
    void toggle() => setState(
          () => checked ? _selected.remove(key) : _selected.add(key),
        );
    final details = [
      if (c.suggestedScale != 1) '≈${formatFactor(c.suggestedScale)}',
      ...c.diffs,
    ];
    return HairlineRow(
      showDivider: !last,
      onTap: toggle,
      leading: CheckItem(
        checked: checked,
        onChanged: (_) => toggle(),
        shape: CheckShape.square,
      ),
      title: Text(
        '${c.recipeTitle} · ${c.component.name}',
        style: AppType.on(AppType.body, pit.text),
      ),
      subtitle: Text(
        details.isEmpty ? 'idêntica' : details.join(' · '),
        style: AppType.on(AppType.caption, pit.muted),
      ),
    );
  }

  /// Executa a unificação com o nome e as marcadas; volta ao detalhe.
  /// Usada por: botão do rodapé.
  Future<void> _unify(Recipe origin, List<UnifyCandidate> candidates) async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);
    final targets = [
      for (final c in candidates)
        if (_selected.contains(_key(c)))
          (c.recipeId, c.componentIndex, c.suggestedScale),
    ];
    await ref.read(subRecipeEditControllerProvider).unify(
          origin,
          widget.componentIndex,
          name,
          targets,
        );
    if (mounted) context.pop();
  }

  /// Linha do topo: voltar + rótulo UNIFICAR. Usada por: [build].
  Widget _top(BuildContext context, PitadaColors pit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Icon(AppIcons.back, size: 22, color: pit.muted),
        ),
        const SizedBox(width: AppSpacing.md),
        Text('UNIFICAR', style: AppType.on(AppType.label, AppColors.accent)),
      ],
    );
  }
}
