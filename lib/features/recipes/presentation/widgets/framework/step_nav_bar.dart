// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/framework/step_nav_bar.dart
// O QUÊ:     Rodapé da criação guiada de framework: "Voltar" (contorno) +
//            "Próximo"/"Criar framework" lado a lado.
// USA:       core/widgets/pitada_button, core/theme/spacing.
// USADO POR: framework_create_screen.
// SPEC:      specs/features/recipes.yaml (FrameworkCreateScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';

/// Barra de navegação entre as perguntas. [onBack]/[onNext] nulos desabilitam
/// os botões; [isLast] troca o rótulo para "Criar framework".
/// Usada por: FrameworkCreateScreen.
class StepNavBar extends StatelessWidget {
  const StepNavBar({
    super.key,
    required this.isLast,
    required this.onBack,
    required this.onNext,
  });

  final bool isLast;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  /// Monta os dois botões lado a lado. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PitadaButton(
            label: 'Voltar',
            variant: PitadaButtonVariant.outline,
            onPressed: onBack,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: PitadaButton(
            label: isLast ? 'Criar framework' : 'Próximo',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
