// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/day_selector.dart
// O QUÊ:     Seletor de dias da semana (seg 26 .. sex 29) usando ChapterTabs.
// USA:       core/widgets/chapter_tabs, plans_providers (selectedDayProvider).
// USADO POR: plans_screen (troca o dia ativo do plano).
// SPEC:      specs/features/plans.yaml (ChapterTabs de dias)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/chapter_tabs.dart';
import '../../application/plans_providers.dart';

/// Abas dos dias da semana; o índice ativo vem de selectedDayProvider.
/// Usada por: plans_screen. Hoje os dias são fixos (protótipo); só o total muda.
class DaySelector extends ConsumerWidget {
  const DaySelector({super.key});

  /// Rótulos fixos dos dias (protótipo: qui 28 ativo). Usada por: [build].
  static const _days = ['seg 26', 'ter 27', 'qui 28', 'sex 29', 'sáb 30'];

  /// Renderiza as abas e escreve a escolha em selectedDayProvider.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedDayProvider);
    return ChapterTabs(
      tabs: _days,
      selected: selected,
      onSelect: (i) => ref.read(selectedDayProvider.notifier).state = i,
    );
  }
}
