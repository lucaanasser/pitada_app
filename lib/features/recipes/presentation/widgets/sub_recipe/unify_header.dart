// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/sub_recipe/unify_header.dart
// O QUÊ:     Topo da tela de unificação: voltar + rótulo UNIFICAR, título,
//            explicação com a receita de origem e o campo de nome.
// USA:       core/widgets/edit_field (EditTextField), core/theme, go_router.
// USADO POR: unify_screen.
// SPEC:      specs/features/sub_recipes.yaml (unificacao.tela)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/edit_field.dart';

/// Cabeçalho da unificação: navegação, título, explicação e nome da
/// subreceita canônica. Usada por: UnifyScreen.
class UnifyHeader extends StatelessWidget {
  const UnifyHeader({
    super.key,
    required this.originTitle,
    required this.nameController,
  });

  final String originTitle;
  final TextEditingController nameController;

  /// Monta voltar + rótulo + título + explicação + campo de nome. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              behavior: HitTestBehavior.opaque,
              child: Icon(AppIcons.back, size: 22, color: pit.muted),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              'UNIFICAR',
              style: AppType.on(AppType.label, AppColors.accent),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Unificar em uma subreceita',
          style: AppType.on(AppType.screenTitle, pit.text),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A versão de "$originTitle" vira a subreceita; as marcadas '
          'viram vínculos com a escala sugerida.',
          style: AppType.on(AppType.caption, pit.muted),
        ),
        const SizedBox(height: AppSpacing.lg),
        EditTextField(
          label: 'Nome',
          controller: nameController,
          hint: 'Cobertura…',
        ),
      ],
    );
  }
}
