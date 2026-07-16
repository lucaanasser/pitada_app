// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/presentation/widgets/add_pantry_data.dart
// O QUÊ:     Dados/estáticos do sheet "Adicionar à despensa": origens e preview de exemplo.
// USA:       pantry_item (modelo), material (IconData).
// USADO POR: add_pantry_sheet (mantém o sheet enxuto, < 200 linhas).
// SPEC:      specs/features/groceries.yaml (sheets.showAddPantrySheet)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';

import '../../data/pantry_item.dart';

/// Descreve uma origem de entrada (rótulo, ícone e se dispara leitura/scan).
/// Usada por: add_pantry_sheet (lista de origens no primeiro passo).
class PantrySource {
  final String label;
  final IconData icon;
  final bool scan;
  const PantrySource(this.label, this.icon, {required this.scan});
}

/// Origens oferecidas no primeiro passo do sheet. Usada por: add_pantry_sheet.
const kPantrySources = <PantrySource>[
  PantrySource('Código de barras', AppIcons.scan, scan: true),
  PantrySource('Cupom fiscal QR', AppIcons.qrCode, scan: true),
  PantrySource('Foto do cupom', AppIcons.camera, scan: true),
  PantrySource('À mão', AppIcons.edit, scan: false),
];

/// Itens reconhecidos de exemplo (preview do sheet). Trocados pelo service real depois.
/// Usada por: add_pantry_sheet (passo de conferência).
final kRecognizedPreview = <PantryItem>[
  PantryItem(
    id: 'add-leite',
    name: 'Leite integral',
    category: 'Laticínios & ovos',
    quantity: 1,
    unit: 'L',
    expiresOn: DateTime(2026, 7, 12),
  ),
  const PantryItem(
    id: 'add-macarrao',
    name: 'Macarrão',
    category: 'Mercearia',
    quantity: 500,
    unit: 'g',
    grams: 500,
  ),
];
