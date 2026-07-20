// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/sheets/folder_edit_sheet.dart
// O QUÊ:     Editor de pasta em bottom sheet: cria (folder null) ou edita nome,
//            cor e quais receitas pertencem à pasta, com opção de apagar.
// USA:       core/widgets (pitada_sheet, sheet_grip, edit_field, pitada_button,
//            hairline_row), folder_color_picker, recipe_providers
//            (FolderEditController + recipesProvider), data/folder, theme/*.
// USADO POR: folder_cover_row, folders_grid_screen, folder_screen (+ / toque longo).
// SPEC:      specs/features/recipes.yaml (aba_pastas.editor_de_pasta)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/cards/hairline_row.dart';
import '../../../../core/widgets/controls/edit_field.dart';
import '../../../../core/widgets/controls/pitada_button.dart';
import '../../../../core/widgets/sheets/pitada_sheet.dart';
import '../../../../core/widgets/sheets/sheet_grip.dart';
import '../../application/recipe_providers.dart';
import '../../data/models/recipe/recipe.dart';
import '../../data/models/folder.dart';
import '../widgets/folder/folder_color_picker.dart';

/// Abre o editor de pasta: [folder] null cria, senão edita. Usada por: capas de
/// pasta (+/toque longo) da aba Receitas, FoldersGrid e FolderScreen.
Future<void> showFolderEditSheet(BuildContext context, {Folder? folder}) {
  return showPitadaSheet<void>(
    context,
    builder: (_) => _FolderEditSheet(folder: folder),
  );
}

/// Conteúdo do editor: grip + título + nome + cor + receitas + Salvar/Apagar.
/// Usada por: showFolderEditSheet.
class _FolderEditSheet extends ConsumerStatefulWidget {
  const _FolderEditSheet({this.folder});

  final Folder? folder;

  @override
  ConsumerState<_FolderEditSheet> createState() => _FolderEditSheetState();
}

class _FolderEditSheetState extends ConsumerState<_FolderEditSheet> {
  late final TextEditingController _name =
      TextEditingController(text: widget.folder?.name ?? '');
  late String _hero = widget.folder?.heroColor ?? 'clay';
  late final Set<String> _selected = _initialSelection();

  bool get _isEditing => widget.folder != null;

  /// Receitas já vinculadas à pasta na edição (lidas do estado atual). Usada por: init.
  Set<String> _initialSelection() {
    final folder = widget.folder;
    if (folder == null) return {};
    final recipes = ref.read(recipesProvider).valueOrNull ?? const [];
    return {
      for (final r in recipes)
        if (r.folderIds.contains(folder.id)) r.id,
    };
  }

  /// Libera o controller do nome. Usada por: framework.
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /// Persiste a pasta (criar/editar) + vínculos de receita e fecha. Usada por: Salvar.
  Future<void> _save() async {
    final controller = ref.read(folderEditControllerProvider);
    final name = _name.text.trim().isEmpty ? 'Nova pasta' : _name.text.trim();
    final String folderId;
    if (_isEditing) {
      folderId = widget.folder!.id;
      await controller.save(widget.folder!.copyWith(name: name, heroColor: _hero));
    } else {
      folderId =
          await controller.create(Folder(id: '', name: name, heroColor: _hero));
    }
    await controller.setRecipes(folderId, _selected.toList());
    if (mounted) Navigator.of(context).pop();
  }

  /// Apaga a pasta e fecha (só na edição). Usada por: botão Apagar.
  Future<void> _delete() async {
    await ref.read(folderEditControllerProvider).delete(widget.folder!.id);
    if (mounted) Navigator.of(context).pop();
  }

  /// Alterna o vínculo de uma receita com a pasta. Usada por: linha da receita.
  void _toggle(String id) => setState(
        () => _selected.contains(id) ? _selected.remove(id) : _selected.add(id),
      );

  /// Monta o corpo do editor acima do teclado. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: Padding(
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
              Text(
                _isEditing ? 'Editar pasta' : 'Nova pasta',
                style: AppType.on(AppType.title, pit.text),
              ),
              const SizedBox(height: AppSpacing.lg),
              EditTextField(
                label: 'Nome',
                controller: _name,
                hint: 'Ex.: Marinadas de frango',
                autofocus: !_isEditing,
              ),
              Text('COR', style: AppType.on(AppType.label, pit.muted)),
              const SizedBox(height: AppSpacing.sm),
              FolderColorPicker(
                value: _hero,
                onChanged: (h) => setState(() => _hero = h),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('RECEITAS', style: AppType.on(AppType.label, pit.muted)),
              const SizedBox(height: AppSpacing.sm),
              Flexible(child: _recipeList(pit, recipes)),
              const SizedBox(height: AppSpacing.md),
              PitadaButton(label: 'Salvar', onPressed: _save),
              if (_isEditing) ...[
                const SizedBox(height: AppSpacing.sm),
                PitadaButton(
                  label: 'Apagar pasta',
                  variant: PitadaButtonVariant.outline,
                  onPressed: _delete,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Lista rolável de receitas com marcação de pertencimento à pasta. Usada por: [build].
  Widget _recipeList(PitadaColors pit, List<Recipe> recipes) {
    if (recipes.isEmpty) {
      return Text(
        'Nenhuma receita ainda.',
        style: AppType.on(AppType.body, pit.muted),
      );
    }
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        for (final r in recipes)
          HairlineRow(
            onTap: () => _toggle(r.id),
            title: Text(
              r.title,
              style: AppType.on(AppType.body, pit.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              _selected.contains(r.id) ? AppIcons.checkCircle : AppIcons.circle,
              size: 22,
              color: _selected.contains(r.id) ? AppColors.accent : pit.line2,
            ),
          ),
      ],
    );
  }
}
