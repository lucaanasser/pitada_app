// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/quick_edit_sheet.dart
// O QUÊ:     Bottom sheet genérica de edição rápida: 1+ campos rotulados + Salvar.
//            Devolve os valores digitados (na ordem) ou null se cancelada. Não
//            conhece Recipe — quem chama monta o modelo.
// USA:       core/widgets (pitada_sheet, sheet_grip, pitada_button), edit_field
//            (EditTextField, reuso), theme/*, MediaQuery.viewInsets (sobe c/ teclado).
// USADO POR: recipe_quick_edit.dart (todas as edições inline do detalhe).
// SPEC:      specs/components/quick_edit_sheet.yaml
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/pitada_button.dart';
import '../../../../core/widgets/pitada_sheet.dart';
import '../../../../core/widgets/pitada_toggle.dart';
import '../../../../core/widgets/sheet_grip.dart';
import '../../../../core/widgets/edit_field.dart';

/// Descreve um campo da sheet de edição rápida. Usada por: showQuickEditSheet.
class QuickEditField {
  const QuickEditField({
    required this.label,
    required this.initial,
    this.hint,
    this.keyboardType,
    this.multiline = false,
  });

  final String label;
  final String initial;
  final String? hint;
  final TextInputType? keyboardType;
  final bool multiline;
}

/// Resultado do Salvar: os valores (na ordem) + o estado do switch opcional.
/// Usada por: RecipeQuickEdit (lê values e decide se cria nova versão pelo toggle).
class QuickEditResult {
  const QuickEditResult(this.values, {this.toggle = false});

  final List<String> values;
  final bool toggle;
}

/// Abre a sheet de edição rápida com [fields] e devolve o resultado ao salvar (ou
/// null se dispensada). Com [toggleLabel], mostra um switch (ex.: "nova versão?")
/// cujo estado volta em QuickEditResult.toggle. Usada por: RecipeQuickEdit.
Future<QuickEditResult?> showQuickEditSheet(
  BuildContext context, {
  required String title,
  required List<QuickEditField> fields,
  String? toggleLabel,
  String? toggleSubtitle,
  bool toggleInitial = false,
}) {
  return showPitadaSheet<QuickEditResult>(
    context,
    builder: (_) => _QuickEditSheet(
      title: title,
      fields: fields,
      toggleLabel: toggleLabel,
      toggleSubtitle: toggleSubtitle,
      toggleInitial: toggleInitial,
    ),
  );
}

/// Conteúdo da sheet: grip + título + campos + switch opcional + Salvar.
/// Usada por: showQuickEditSheet.
class _QuickEditSheet extends StatefulWidget {
  const _QuickEditSheet({
    required this.title,
    required this.fields,
    this.toggleLabel,
    this.toggleSubtitle,
    this.toggleInitial = false,
  });

  final String title;
  final List<QuickEditField> fields;
  final String? toggleLabel;
  final String? toggleSubtitle;
  final bool toggleInitial;

  @override
  State<_QuickEditSheet> createState() => _QuickEditSheetState();
}

class _QuickEditSheetState extends State<_QuickEditSheet> {
  late final List<TextEditingController> _ctrls = [
    for (final f in widget.fields) TextEditingController(text: f.initial),
  ];
  late bool _toggle = widget.toggleInitial;

  /// Libera os controllers dos campos. Usada por: framework.
  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    super.dispose();
  }

  /// Coleta os textos + estado do switch e fecha devolvendo-os. Usada por: botão Salvar.
  void _save() => Navigator.of(context).pop(
        QuickEditResult([for (final c in _ctrls) c.text], toggle: _toggle),
      );

  /// A linha do switch opcional (ex.: "Salvar como nova versão"). Usada por: [build].
  Widget _switchRow(PitadaColors pit) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: HairlineRow(
        showDivider: false,
        onTap: () => setState(() => _toggle = !_toggle),
        title: Text(
          widget.toggleLabel!,
          style: AppType.on(AppType.body, pit.text),
        ),
        subtitle: widget.toggleSubtitle == null
            ? null
            : Text(
                widget.toggleSubtitle!,
                style: AppType.on(AppType.caption, pit.muted),
              ),
        trailing: PitadaToggle(value: _toggle),
      ),
    );
  }

  /// Monta grip + título + um EditTextField por campo + Salvar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetGrip(),
              Text(widget.title, style: AppType.on(AppType.title, pit.text)),
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < widget.fields.length; i++)
                EditTextField(
                  label: widget.fields[i].label,
                  controller: _ctrls[i],
                  hint: widget.fields[i].hint,
                  keyboardType: widget.fields[i].keyboardType,
                  maxLines: widget.fields[i].multiline ? null : 1,
                  minLines: widget.fields[i].multiline ? 3 : null,
                  autofocus: i == 0,
                ),
              if (widget.toggleLabel != null) _switchRow(pit),
              const SizedBox(height: AppSpacing.md),
              PitadaButton(label: 'Salvar', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
