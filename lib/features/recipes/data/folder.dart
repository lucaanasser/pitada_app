// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/folder.dart
// O QUÊ:     Modelo de pasta (capítulo) — agrupa receitas independentes.
// USA:       nada (modelo imutável puro).
// USADO POR: recipes_seed, recipes_providers (ChapterTabs), recipes_screen.
// NOTA:      Pasta != sub-receita (esta agrupa; aquela soma macros num prato).
// SPEC:      specs/features/recipes.yaml (data.models)
// ─────────────────────────────────────────────────────────────────────────────

/// Uma pasta/capítulo de receitas (ex.: 'Marinadas de frango'). Uma receita pode
/// estar em várias. Usada por: filtros da aba Receitas.
class Folder {
  final String id;
  final String name;

  const Folder({required this.id, required this.name});
}
