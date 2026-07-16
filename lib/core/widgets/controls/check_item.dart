// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/controls/check_item.dart
// O QUÊ:     Caixa de seleção do app (círculo terracota ou quadrado verde).
// USA:       theme/colors, theme/spacing.
// USADO POR: groceries (lista de compras = círculo) e recipes
//            (cook_feedback_options = quadrado).
// SPEC:      specs/components/controls/check_item.yaml
// ─────────────────────────────────────────────────────────────────────────────
import '../../theme/app_icons.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Formato da caixa: círculo (lista de compras) ou quadrado (checklist).
enum CheckShape { circle, square }

/// Caixa de seleção só-visual (o rótulo fica na HairlineRow que a contém).
/// Usada por: itens da lista de compras e checklists.
class CheckItem extends StatelessWidget {
  const CheckItem({
    super.key,
    required this.checked,
    required this.onChanged,
    this.shape = CheckShape.circle,
    this.color,
  });

  final bool checked;
  final ValueChanged<bool> onChanged;
  final CheckShape shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isCircle = shape == CheckShape.circle;
    final fill = color ?? (isCircle ? AppColors.accent : AppColors.sage);
    final size = isCircle ? 22.0 : 23.0;
    return GestureDetector(
      onTap: () => onChanged(!checked),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: checked ? fill : Colors.transparent,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : AppSpacing.br(AppSpacing.radiusSm),
          border: Border.all(
            color: checked ? fill : context.pit.line2,
            width: AppSpacing.borderThick,
          ),
        ),
        child: checked
            ? const Icon(AppIcons.check, size: 14, color: AppColors.onAccent)
            : null,
      ),
    );
  }
}
