// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/sheets/pitada_sheet.dart
// O QUÊ:     Helper único p/ abrir bottom sheets no padrão do app (fundo surf, topo
//            arredondado, isScrollControlled) e SEMPRE no root navigator — assim o
//            sheet e seu scrim cobrem o shell inteiro, escondendo a navbar flutuante
//            (que, como bottomNavigationBar, ficaria na frente de um sheet do branch).
// USA:       theme/pitada_colors (context.pit.surf), theme/spacing (radiusXxl).
// USADO POR: todos os show*Sheet do app (plans, learning, recipes, shopping).
// SPEC:      specs/components/pitada_sheet.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../theme/pitada_colors.dart';
import '../../theme/spacing.dart';

/// Abre um bottom sheet padrão do app no root navigator (esconde a navbar).
/// [builder] monta o conteúdo; [background] sobrescreve o fundo (default surf).
/// Retorna o valor passado ao fechar (Navigator.pop) ou null se dispensado.
/// Usada por: todos os show*Sheet do app.
Future<T?> showPitadaSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  Color? background,
}) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    backgroundColor: background ?? context.pit.surf,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
    ),
    builder: builder,
  );
}
