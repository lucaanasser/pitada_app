// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/sheets/plan/option_name_sheet.dart
// O QUÊ:     Bottom sheet para renomear a aba de uma opção de refeição (rótulo livre).
// USA:       theme/*, core/widgets (PitadaButton, SheetGrip), pitada_sheet, plan_providers.
// USADO POR: MealOptionTabs (segurar/duplo-clique na aba ativa).
// SPEC:      specs/features/plans/plans.yaml (showOptionNameSheet)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../../core/widgets/sheets/sheet_grip.dart';
import '../../../application/plan_providers.dart';

/// Abre o sheet p/ renomear a opção [optionIndex] da refeição [mealId].
/// Vazio => a opção volta a "Opção N". Usada por: MealOptionTabs.
void showOptionNameSheet(
  BuildContext context, {
  required String mealId,
  required int optionIndex,
  required String currentName,
}) {
  showPitadaSheet<void>(
    context,
    builder: (_) => _OptionNameSheet(
      mealId: mealId,
      optionIndex: optionIndex,
      currentName: currentName,
    ),
  );
}

/// Conteúdo do sheet: título + campo de nome + salvar. Usada por: showOptionNameSheet.
class _OptionNameSheet extends ConsumerStatefulWidget {
  const _OptionNameSheet({
    required this.mealId,
    required this.optionIndex,
    required this.currentName,
  });

  final String mealId;
  final int optionIndex;
  final String currentName;

  @override
  ConsumerState<_OptionNameSheet> createState() => _OptionNameSheetState();
}

class _OptionNameSheetState extends ConsumerState<_OptionNameSheet> {
  late final TextEditingController _name;

  /// Preenche o campo com o nome atual da opção. Usada por: framework.
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.currentName);
  }

  /// Libera o controller do nome. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Renomeia a opção e fecha o sheet. Usada por: botão "Salvar".
  void _save() {
    ref
        .read(planControllerProvider.notifier)
        .renameOption(widget.mealId, widget.optionIndex, _name.text);
    Navigator.of(context).pop();
  }

  /// Monta o formulário (grip + título + campo + salvar). Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.gutter,
        right: AppSpacing.gutter,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetGrip(),
          Text('Nome da opção', style: AppType.on(AppType.title, pit.text)),
          const SizedBox(height: AppSpacing.lg),
          _field(pit),
          const SizedBox(height: AppSpacing.xl),
          PitadaButton(label: 'Salvar', onPressed: _save),
        ],
      ),
    );
  }

  /// Campo de texto do nome da opção (mesmo padrão dos demais sheets). Usada por: [build].
  Widget _field(PitadaColors pit) {
    return TextField(
      controller: _name,
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      style: AppType.on(AppType.body, pit.text),
      cursorColor: AppColors.accent,
      onSubmitted: (_) => _save(),
      decoration: InputDecoration(
        hintText: 'Ex.: Clássico',
        hintStyle: AppType.on(AppType.body, pit.faint),
        filled: true,
        fillColor: pit.surf2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: pit.line2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: BorderSide(color: pit.line2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.br(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.accentLine),
        ),
      ),
    );
  }
}
