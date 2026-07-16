// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/category_group.dart
// O QUÊ:     Grupo de uma categoria: rótulo em versalete + linhas filhas (filete).
// USA:       core/widgets/section_header, theme/spacing.
// USADO POR: grocery_list_view e pantry_view (agrupam itens por categoria).
// SPEC:      specs/features/groceries.yaml (screens.GroceriesScreen — grupos por categoria)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/layout/section_header.dart';

/// Bloco de uma categoria: [label] como SectionHeader + [children] em coluna.
/// Reutilizado entre a Lista de compras e a Despensa (evita duplicar o layout).
/// Usada por: grocery_list_view e pantry_view.
class CategoryGroup extends StatelessWidget {
  const CategoryGroup({
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
