// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/empty_state.dart
// O QUÊ:     Estado vazio/carregando com texto que orienta a próxima ação.
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: qualquer lista quando não há itens (regra de qualidade do guia).
// SPEC:      specs/components/atoms.yaml (EmptyState)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Bloco central com ícone opcional, título e mensagem de apoio.
/// Usada por: listas vazias e telas ainda sem conteúdo.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, this.message, this.icon});

  final String title;
  final String? message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 34, color: AppColors.faint),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text(title, style: AppType.title, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppType.on(AppType.bodySm, AppColors.muted),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
