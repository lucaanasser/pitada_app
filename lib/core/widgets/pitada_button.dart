// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_button.dart
// O QUÊ:     Botões padrão: PitadaButton (primário/contorno) e PitadaIconButton (círculo).
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: recipe_detail (barra), sheets, shopping, headers — ações do app inteiro.
// SPEC:      specs/components/pitada_button.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Variações visuais do botão. primary = terracota cheio; outline = só contorno.
enum PitadaButtonVariant { primary, outline }

/// Botão padrão do app, com micro-animação de toque (scale .98). Sem sombra.
/// Usada por: barras de ação, sheets e formulários.
class PitadaButton extends StatefulWidget {
  const PitadaButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = PitadaButtonVariant.primary,
    this.expand = true,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final PitadaButtonVariant variant;
  final bool expand;

  @override
  State<PitadaButton> createState() => _PitadaButtonState();
}

class _PitadaButtonState extends State<PitadaButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.variant == PitadaButtonVariant.primary;
    final fg = primary ? AppColors.onAccent : AppColors.text;
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _down ? 0.98 : 1,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: AppSpacing.button,
          width: widget.expand ? double.infinity : null,
          padding: EdgeInsets.symmetric(
              horizontal: widget.expand ? 0 : AppSpacing.xl),
          decoration: BoxDecoration(
            color: primary ? AppColors.accent : Colors.transparent,
            borderRadius: AppSpacing.br(AppSpacing.radiusLg),
            border: primary ? null : Border.all(color: AppColors.line2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 19, color: fg),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(widget.label, style: AppType.on(AppType.button, fg)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Botão de ícone circular com contorno (.iconbtn / .btn-ic).
/// Usada por: headers de aba e barra do detalhe de receita.
class PitadaIconButton extends StatelessWidget {
  const PitadaIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppSpacing.iconButton,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.line2),
        ),
        child: Icon(icon, size: 19, color: AppColors.text),
      ),
    );
  }
}
