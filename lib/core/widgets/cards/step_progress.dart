// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/cards/step_progress.dart
// O QUÊ:     Lista de passos com bolinha marcada — feedback de processamento da IA.
// USA:       theme/app_icons, theme/colors, theme/pitada_colors, theme/spacing,
//            theme/typography.
// USADO POR: import_sheet e cook_mode_screen (recipes), add_pantry_sheet (groceries).
// SPEC:      specs/components/cards/step_progress.yaml
// ─────────────────────────────────────────────────────────────────────────────
import '../../theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

/// Passos de carregamento; os índices <= [activeIndex] aparecem concluídos.
/// Usada por: fluxos de importação (receita e nota fiscal).
class StepProgress extends StatelessWidget {
  const StepProgress({
    super.key,
    required this.steps,
    required this.activeIndex,
  });

  final List<String> steps;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          _row(pit, steps[i], i <= activeIndex),
      ],
    );
  }

  /// Uma linha de passo: bolinha (marcada ou não) + texto. Usada por: [build].
  Widget _row(PitadaColors pit, String text, bool done) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? AppColors.sage : Colors.transparent,
              border: Border.all(
                color: done ? AppColors.sage : pit.line2,
                width: 2,
              ),
            ),
            child: done
                ? const Icon(
                    AppIcons.check,
                    size: 10,
                    color: AppColors.onAccent,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: AppType.on(
                AppType.bodySm,
                done ? pit.text2 : pit.faint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
