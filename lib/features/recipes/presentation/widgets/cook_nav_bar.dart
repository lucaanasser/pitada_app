// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/cook_nav_bar.dart
// O QUÊ:     Rodapé do modo cozinhar: "Voltar" (contorno) + "Próximo"/"Concluir".
//            Voltar fica desabilitado no primeiro passo; o último vira "Concluir".
// USA:       core/widgets/pitada_button, theme/*.
// USADO POR: cook_mode_screen (barra inferior fixa).
// SPEC:      specs/features/recipes.yaml (CookModeScreen: CookNavBar)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/pitada_button.dart';

/// Barra de navegação entre passos. [isFirst] desabilita Voltar; [isLast] troca
/// o botão principal para "Concluir". Usada por: cook_mode_screen.
class CookNavBar extends StatelessWidget {
  const CookNavBar({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onBack,
    required this.onNext,
  });

  final bool isFirst;
  final bool isLast;
  final VoidCallback onBack;
  final VoidCallback onNext;

  /// Monta os dois botões lado a lado sobre o filete superior. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(
            top: BorderSide(color: AppColors.line, width: AppSpacing.hair)),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.lg,
        AppSpacing.gutter,
        AppSpacing.lg,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: PitadaButton(
                label: 'Voltar',
                icon: AppIcons.back,
                variant: PitadaButtonVariant.outline,
                // Sem callback = desabilitado no primeiro passo.
                onPressed: isFirst ? null : onBack,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: PitadaButton(
                label: isLast ? 'Concluir' : 'Próximo',
                icon: isLast ? AppIcons.check : AppIcons.forward,
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
