// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/presentation/widgets/note_row.dart
// O QUÊ:     Linha de nota de fonte na lista (miniatura + título + "tipo · autor").
// USA:       core/widgets (HairlineRow, RecipeThumb), theme/*, SourceNote.
// USADO POR: NotesScreen.
// SPEC:      specs/features/learning.yaml (NotesScreen: HairlineRow livro/vídeo/chef)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/hairline_row.dart';
import '../../../../core/widgets/recipe_thumb.dart';
import '../../data/source_note.dart';

/// Uma nota de fonte como linha de lista. Usada por: NotesScreen.
class NoteRow extends StatelessWidget {
  const NoteRow({
    super.key,
    required this.note,
    this.onTap,
    this.showDivider = true,
  });

  final SourceNote note;
  final VoidCallback? onTap;
  final bool showDivider;

  /// Monta a linha: ícone por tipo, título e meta "tipo · autor". Usada por: NotesScreen.
  @override
  Widget build(BuildContext context) {
    return HairlineRow(
      onTap: onTap,
      showDivider: showDivider,
      leading: RecipeThumb(color: AppColors.heroOf(_hero()), icon: _icon()),
      title: Text(note.title, style: AppType.titleSm),
      subtitle:
          Text(_meta(), style: AppType.on(AppType.caption, AppColors.muted)),
      trailing:
          const Icon(Icons.chevron_right, size: 16, color: AppColors.faint),
    );
  }

  /// Cor de miniatura por tipo de fonte. Usada por: [build].
  String _hero() {
    switch (note.kind) {
      case 'Livro':
        return 'clay';
      case 'Vídeo':
        return 'teal';
      case 'Curso':
        return 'ochre';
      default:
        return 'plum';
    }
  }

  /// Ícone por tipo de fonte. Usada por: [build].
  IconData _icon() {
    switch (note.kind) {
      case 'Livro':
        return Icons.menu_book_outlined;
      case 'Vídeo':
        return Icons.play_circle_outline;
      case 'Curso':
        return Icons.school_outlined;
      default:
        return Icons.person_outline;
    }
  }

  /// Linha de meta "tipo · autor" (autor opcional). Usada por: [build].
  String _meta() {
    if (note.meta.isEmpty) return note.kind;
    return '${note.kind}  ·  ${note.meta}';
  }
}
