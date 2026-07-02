// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/lesson_edit_screen.dart
// O QUÊ:     Formulário para criar/editar uma ficha: categoria (chips), nome,
//            resumo e editor de seções. Só coleta os dados; persiste depois.
// USA:       core/widgets (PitadaChip, PitadaButton), widgets locais, theme/*,
//            utils/app_log, go_router (Cancelar/Salvar).
// USADO POR: core/router (/lesson-edit).
// SPEC:      specs/features/learning.yaml (screens.LessonEditScreen — view-lesson-edit)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/pitada_button.dart';
import '../../../core/widgets/pitada_chip.dart';
import '../../../core/utils/app_log.dart';
import 'widgets/section_editor.dart';

/// As categorias disponíveis para uma ficha (rótulos dos chips de seleção).
const _kCategories = ['Técnica', 'Framework', 'Ingrediente', 'Sabor', 'Erva'];

/// Tela de edição/criação de ficha. Aberta sem argumentos (criar) hoje.
/// Usada por: router (/lesson-edit).
class LessonEditScreen extends StatefulWidget {
  const LessonEditScreen({super.key});

  @override
  State<LessonEditScreen> createState() => _LessonEditScreenState();
}

/// Estado do formulário: controllers dos campos e das seções dinâmicas.
class _LessonEditScreenState extends State<LessonEditScreen> {
  int _category = 0;
  final _name = TextEditingController();
  final _summary = TextEditingController();
  final _sections = <(TextEditingController, TextEditingController)>[
    (TextEditingController(), TextEditingController()),
  ];

  /// Libera todos os controllers ao sair. Usada por: framework (ciclo de vida).
  @override
  void dispose() {
    _name.dispose();
    _summary.dispose();
    for (final s in _sections) {
      s.$1.dispose();
      s.$2.dispose();
    }
    super.dispose();
  }

  /// Adiciona uma seção vazia ao editor. Usada por: botão "Adicionar seção".
  void _addSection() {
    setState(
      () => _sections.add((TextEditingController(), TextEditingController())),
    );
  }

  /// Remove a seção no índice [i] e libera seus controllers. Usada por: SectionEditor.
  void _removeSection(int i) {
    setState(() {
      _sections[i].$1.dispose();
      _sections[i].$2.dispose();
      _sections.removeAt(i);
    });
  }

  /// Registra a intenção de salvar e volta (persistência é do próximo passo).
  /// Usada por: cabeçalho "Salvar".
  void _save() {
    AppLog.i(
      'learning',
      'salvar ficha: ${_name.text} (cat ${_kCategories[_category]})',
    );
    context.pop();
  }

  /// Monta o cabeçalho fixo e o formulário rolável. Usada por: router.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _head(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  AppSpacing.lg,
                  AppSpacing.gutter,
                  AppSpacing.xxl,
                ),
                children: [
                  _categoryPicker(),
                  const SizedBox(height: AppSpacing.xl),
                  EditField(
                    label: 'Nome',
                    controller: _name,
                    hint: 'Nome da ficha',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  EditField(
                    label: 'Resumo',
                    controller: _summary,
                    hint: 'O princípio ou a descrição',
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Text('SEÇÕES', style: AppType.label),
                  const SizedBox(height: AppSpacing.md),
                  for (var i = 0; i < _sections.length; i++)
                    SectionEditor(
                      labelController: _sections[i].$1,
                      bodyController: _sections[i].$2,
                      onRemove: () => _removeSection(i),
                    ),
                  PitadaButton(
                    label: 'Adicionar seção',
                    icon: AppIcons.add,
                    variant: PitadaButtonVariant.outline,
                    onPressed: _addSection,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Cabeçalho do editor: Cancelar / título / Salvar. Usada por: [build].
  Widget _head(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.line, width: AppSpacing.hair),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              'Cancelar',
              style: AppType.on(AppType.button, AppColors.muted),
            ),
          ),
          const Expanded(
            child: Text(
              'Nova ficha',
              textAlign: TextAlign.center,
              style: AppType.title,
            ),
          ),
          GestureDetector(
            onTap: _save,
            child: Text(
              'Salvar',
              style: AppType.on(AppType.button, AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  /// Chips de seleção de categoria (seleção única). Usada por: [build].
  Widget _categoryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CATEGORIA', style: AppType.label),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm + 1,
          runSpacing: AppSpacing.sm + 1,
          children: [
            for (var i = 0; i < _kCategories.length; i++)
              PitadaChip(
                label: _kCategories[i],
                variant: i == _category
                    ? PitadaChipVariant.accent
                    : PitadaChipVariant.plain,
                onTap: () => setState(() => _category = i),
              ),
          ],
        ),
      ],
    );
  }
}
