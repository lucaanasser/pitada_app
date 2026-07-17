// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/detail/items/step_text_view.dart
// O QUÊ:     Texto de um passo com as técnicas GRIFADAS (accent, clicáveis ->
//            /technique/:id). Âncora que não casa (ou nula) vira linha sóbria
//            "técnica: nome" sob o texto — clicável, nunca cápsula.
// USA:       core/theme (AppColors, PitadaColors), technique_providers,
//            RecipeStep/StepTechnique, go_router.
// USADO POR: step_tile (detalhe da receita).
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/pitada_colors.dart';
import '../../../../../../core/theme/spacing.dart';
import '../../../../../../core/theme/typography.dart';
import '../../../../application/technique_providers.dart';
import '../../../../data/models/recipe/recipe_step.dart';

/// Texto do passo com grifo de técnica. Stateful só para dar dispose nos
/// TapGestureRecognizer dos spans. Usada por: StepTile.
class StepTextView extends ConsumerStatefulWidget {
  const StepTextView({super.key, required this.step});

  final RecipeStep step;

  @override
  ConsumerState<StepTextView> createState() => _StepTextViewState();
}

class _StepTextViewState extends ConsumerState<StepTextView> {
  final _recognizers = <TapGestureRecognizer>[];

  /// Libera os recognizers dos spans. Usada por: framework.
  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  /// Cria (e registra p/ dispose) o gesto que abre a página da técnica.
  /// Usada por: [build].
  TapGestureRecognizer _open(String techniqueId) {
    final r = TapGestureRecognizer()
      ..onTap = () => context.push('/technique/$techniqueId');
    _recognizers.add(r);
    return r;
  }

  /// Monta o texto com grifos + a linha sóbria das técnicas sem âncora.
  /// Usada por: framework.
  @override
  Widget build(BuildContext context) {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final pit = context.pit;
    final base = AppType.on(AppType.body, pit.text2).copyWith(height: 1.55);
    final text = widget.step.text;

    final anchored = <(int, String, StepTechnique)>[];
    final orphan = <StepTechnique>[];
    for (final t in widget.step.techniques) {
      final a = t.anchor;
      final i = a == null || a.isEmpty ? -1 : text.indexOf(a);
      i < 0 ? orphan.add(t) : anchored.add((i, a!, t));
    }
    anchored.sort((x, y) => x.$1.compareTo(y.$1));

    final spans = <TextSpan>[];
    var cursor = 0;
    for (final (i, anchor, t) in anchored) {
      if (i < cursor) continue;
      if (i > cursor) spans.add(TextSpan(text: text.substring(cursor, i)));
      spans.add(
        TextSpan(
          text: anchor,
          style: AppType.on(base, AppColors.accent),
          recognizer: _open(t.techniqueId),
        ),
      );
      cursor = i + anchor.length;
    }
    if (cursor < text.length) spans.add(TextSpan(text: text.substring(cursor)));

    final known = ref.watch(techniquesProvider).valueOrNull ?? const [];
    String nameOf(String id) {
      for (final t in known) {
        if (t.id == id) return t.name.toLowerCase();
      }
      return 'técnica';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(style: base, children: spans)),
        if (orphan.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text.rich(
              TextSpan(
                style: AppType.on(AppType.captionSm, pit.muted),
                children: [
                  const TextSpan(text: 'técnica: '),
                  for (final (i, t) in orphan.indexed) ...[
                    if (i > 0) const TextSpan(text: ' · '),
                    TextSpan(
                      text: nameOf(t.techniqueId),
                      style: AppType.on(AppType.captionSm, AppColors.accent),
                      recognizer: _open(t.techniqueId),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
