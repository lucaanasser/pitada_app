// ─────────────────────────────────────────────────────────────────────────────
// lib/core/utils/slug.dart
// O QUÊ:     Normalização de texto pt-BR em slug canônico (sem acento, minúsculo,
//            espaços colapsados) — a mesma forma do slug de técnica no banco.
// USA:       nada (helper puro).
// USADO POR: framework_suggestion_service, framework_create_screen,
//            seed_technique_repository (dedupe/agrupamento por técnica).
// SPEC:      specs/features/recipes.yaml (data.tecnica)
// ─────────────────────────────────────────────────────────────────────────────

/// Pares acento -> ascii do pt-BR (suficiente p/ nomes de técnica).
const _accents = 'áàâãäéèêëíìîïóòôõöúùûüçñ';
const _plain = 'aaaaaeeeeiiiiooooouuuucn';

/// Converte um texto em slug canônico: 'Selar a Carne ' -> 'selar a carne',
/// 'Refogar até dourar' -> 'refogar ate dourar'. Usada por: agrupamento de
/// frameworks e dedupe de técnicas.
String slugify(String text) {
  final lower = text.trim().toLowerCase();
  final sb = StringBuffer();
  for (final rune in lower.runes) {
    final ch = String.fromCharCode(rune);
    final i = _accents.indexOf(ch);
    sb.write(i >= 0 ? _plain[i] : ch);
  }
  return sb.toString().replaceAll(RegExp(r'\s+'), ' ');
}
