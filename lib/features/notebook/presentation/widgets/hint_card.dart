// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/hint_card.dart
// O QUÊ:     Caixa de dica discreta (fundo suave + texto em itálico serifa).
// USA:       theme/colors, theme/spacing, theme/typography.
// USADO POR: ProcessLogsScreen (aviso de recurso avançado) e telas do Caderno.
// SPEC:      specs/features/notebook.yaml (layout "hintcard(...)")
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Bloco de dica com fundo `surf2` e filete `line`: contextualiza um recurso
/// sem competir com o conteúdo. Usada por: listas do Caderno (Logs/Diário).
class HintCard extends StatelessWidget {
  const HintCard({super.key, required this.text});

  final String text;

  /// Renderiza a dica em uma caixa arredondada. Usada por: ProcessLogsScreen.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: pit.surf2,
        borderRadius: AppSpacing.br(AppSpacing.radiusMd),
        border: Border.all(color: pit.line, width: AppSpacing.hair),
      ),
      child: Text(text, style: AppType.on(AppType.tip, pit.text2)),
    );
  }
}
