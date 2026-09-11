// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/category_section.dart
// O QUÊ:     Grupo de uma categoria: rótulo em versalete + linhas filhas (filete).
// USA:       core/widgets/layout/section_header, theme/spacing.
// USADO POR: pantry_view (agrupa itens por categoria; o card de compras usa
//            título em destaque próprio).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen — grupos por categoria)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/layout/section_header.dart';

/// Bloco de uma categoria: [label] como SectionHeader + [children] em coluna.
/// Reutilizado entre a Lista de compras e a Despensa (evita duplicar o layout).
/// Usada por: grocery_list_view e pantry_view.
class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.label,
    required this.children,
    this.topGap = AppSpacing.xxxl,
  });

  final String label;
  final List<Widget> children;
  final double topGap;

  /// Monta rótulo + filhos, com respiro superior configurável. Usada por: [build].
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(label: label, topGap: topGap),
          ...children,
        ],
      ),
    );
  }
}
