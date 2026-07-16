// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/recipe_quick_edit.dart
// O QUÊ:     Orquestra a edição inline do detalhe: um método por campo (título,
//            kcal, porções, tempo, dificuldade, macros, ingrediente, passo, técnicas,
//            anotações). Abre a QuickEditSheet, monta o Recipe editado e salva.
// USA:       QuickEditSheet, recipes_providers (RecipeEditController), modelos.
// USADO POR: recipe_detail_body (gestos Editable de cada campo).
// SPEC:      specs/features/recipes.yaml (RecipeDetailScreen: edicao_inline)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/recipes_providers.dart';
import '../data/models/ingredient.dart';
import '../data/models/recipe.dart';
import '../data/models/recipe_step.dart';
import 'sheets/quick_edit_sheet.dart';

part 'recipe_item_edit.dart';

/// Qual macro está sendo editado (célula da NutritionCard). Usada por: [RecipeQuickEdit.macro].
enum RecipeMacro { protein, fat, carb }

/// Teclado numérico dos campos de número. Usada por: os campos kcal/porções/gramas.
const _num = TextInputType.number;

/// Rótulo/subtítulo do switch "nova versão?" presente em toda edição inline.
/// Usada por: [RecipeQuickEdit._one] e a edição de itens (ingrediente/passo).
const _versionLabel = 'Salvar como nova versão';
const _versionSub = 'Mantém a versão anterior no histórico';

/// Fachada de edição inline de UMA receita. Instanciada por gesto no detalhe.
/// Cada método abre a sheet do campo, monta a cópia editada e persiste.
/// Usada por: recipe_detail_screen.
class RecipeQuickEdit {
  const RecipeQuickEdit(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  /// Persiste a receita editada via controller (mock + invalida telas). [asNewVersion]
  /// decide entre sobrescrever e versionar. Usada por: os métodos de edição.
  Future<void> _save(Recipe r, {bool asNewVersion = false}) => ref
      .read(recipeEditControllerProvider)
      .save(r, asNewVersion: asNewVersion);

  /// Abre a sheet de um único campo (com o switch "nova versão?") e aplica [build] ao
  /// valor, salvando conforme o switch. Usada por: campos escalares.
  Future<void> _one(
    String title,
    QuickEditField field,
    Recipe Function(String) build,
  ) async {
    final res = await showQuickEditSheet(
      context,
      title: title,
      fields: [field],
      toggleLabel: _versionLabel,
      toggleSubtitle: _versionSub,
    );
    if (res == null) return;
    await _save(build(res.values.first), asNewVersion: res.toggle);
  }

  /// Edita o nome da receita. Usada por: título do detalhe.
  Future<void> title(Recipe r) => _one(
        'Nome da receita',
        QuickEditField(
          label: 'Nome',
          initial: r.title,
          hint: 'Nome da receita',
        ),
        (s) => r.copyWith(title: s.trim().isEmpty ? r.title : s.trim()),
      );

  /// Edita as calorias por porção. Usada por: número de kcal do detalhe.
  Future<void> kcal(Recipe r) => _one(
        'Calorias',
        QuickEditField(
          label: 'Kcal (por porção)',
          initial: '${r.kcal}',
          keyboardType: _num,
        ),
        (s) => r.copyWith(kcal: int.tryParse(s.trim()) ?? r.kcal),
      );

  /// Edita as porções (mínimo 1). Usada por: segmento "porções" da meta.
  Future<void> servings(Recipe r) => _one(
        'Porções',
        QuickEditField(
          label: 'Porções',
          initial: '${r.servings}',
          keyboardType: _num,
        ),
        (s) => r.copyWith(
          servings: (int.tryParse(s.trim()) ?? r.servings).clamp(1, 999),
        ),
      );

  /// Edita o tempo de preparo (min). Vazio mantém o atual. Usada por: segmento "tempo".
  Future<void> time(Recipe r) => _one(
        'Tempo de preparo',
        QuickEditField(
          label: 'Tempo (min)',
          initial: r.timeMinutes?.toString() ?? '',
          keyboardType: _num,
          hint: 'minutos',
        ),
        (s) => r.copyWith(
          timeMinutes: s.trim().isEmpty
              ? r.timeMinutes
              : int.tryParse(s.trim()) ?? r.timeMinutes,
        ),
      );

  /// Edita a dificuldade. Usada por: segmento "dificuldade" da meta.
  Future<void> difficulty(Recipe r) => _one(
        'Dificuldade',
        QuickEditField(
          label: 'Dificuldade',
          initial: r.difficulty ?? '',
          hint: 'Ex.: Fácil, Médio',
        ),
        (s) =>
            r.copyWith(difficulty: s.trim().isEmpty ? r.difficulty : s.trim()),
      );

  /// Edita um macro (célula da NutritionCard). Usada por: proteína/gordura/carbo.
  Future<void> macro(Recipe r, RecipeMacro m) {
    final (label, current) = switch (m) {
      RecipeMacro.protein => ('Proteína (g)', r.protein),
      RecipeMacro.fat => ('Gordura (g)', r.fat),
      RecipeMacro.carb => ('Carboidrato (g)', r.carb),
    };
    return _one(
      'Macros',
      QuickEditField(
        label: label,
        initial: _numStr(current),
        keyboardType: _num,
      ),
      (s) {
        final v = _toNum(s) ?? current;
        return switch (m) {
          RecipeMacro.protein => r.copyWith(protein: v),
          RecipeMacro.fat => r.copyWith(fat: v),
          RecipeMacro.carb => r.copyWith(carb: v),
        };
      },
    );
  }

  /// Edita as anotações & ajustes (multilinha). Usada por: bloco de anotações.
  Future<void> notes(Recipe r) => _one(
        'Anotações & ajustes',
        QuickEditField(
          label: 'Anotações',
          initial: r.notes ?? '',
          hint: 'Ajustes, variações...',
          multiline: true,
        ),
        (s) => r.copyWith(notes: s.trim()),
      );

  /// Edita as técnicas (uma por linha). Usada por: bloco de tags de técnicas.
  Future<void> techniques(Recipe r) => _one(
        'Técnicas desta receita',
        QuickEditField(
          label: 'Técnicas',
          initial: r.techniques.join('\n'),
          hint: 'Uma técnica por linha',
          multiline: true,
        ),
        (s) => r.copyWith(techniques: _lines(s)),
      );
}

/// Converte texto em número (aceita vírgula); vazio vira null. Usada por: macros/ingrediente.
num? _toNum(String s) {
  final t = s.trim().replaceAll(',', '.');
  return t.isEmpty ? null : num.tryParse(t);
}

/// Formata um número para o campo (sem ".0" redundante). Usada por: valores iniciais.
String _numStr(num? n) => n == null
    ? ''
    : (n == n.roundToDouble() ? n.toInt().toString() : n.toString());

/// Quebra um texto em linhas não vazias e aparadas. Usada por: edição de técnicas.
List<String> _lines(String s) => [
      for (final l in s.split('\n'))
        if (l.trim().isNotEmpty) l.trim(),
    ];
