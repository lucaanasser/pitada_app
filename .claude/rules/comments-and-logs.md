# Comments and Logs

**Principle:** a comment lives only in the file header or directly above a declaration, and states WHAT, never HOW.

In-code comments and log messages are written in pt-BR; identifiers are in English.

## Placement — only two places
1. **File header** (top of the file, once).
2. **Doc comment `///` above a declaration** (function, method, constructor, class, enum, mixin, extension, getter/setter).

**Nothing in the middle of the code:** no comment inside a function body, between statements, at the end of a code line (inline/trailing), no field label (`final String title; // nome`), no section marker (`// —— … ——`). Hard-to-read code is fixed with a better name or an extracted function, not a comment.

Exceptions (directives, not documentation): `// ignore:` / `// ignore_for_file:` and `// TODO(pitada): …` (with an owner).

**Inline exception — visual token files only** (`colors.dart`, `spacing.dart`, `typography.dart`): an inline comment may label what a raw value represents (`static const bg = Color(0xFF15130E); // fundo geral`). Never in a function, struct/model, or widget, and never for rationale or history.

## What, never how
A comment states what the thing does — the external contract — never how it was implemented.
- Wrong: "ordeno com quicksort e removo os repetidos no laço"
- Right: "recebe o vetor X e devolve o vetor Y ordenado e sem repetidos"

A WHAT comment stays true when the implementation changes (quicksort → mergesort); a HOW comment becomes a lie at the first refactor.

## File header (mandatory in every `.dart`)
```dart
// ─────────────────────────────────────────────────────────────────────────────
// <path/to/file.dart>
// O QUÊ:     <what the file does, 1-2 lines>
// USA:       <what it imports and why>
// USADO POR: <who uses it>
// SPEC:      <specs/…, if any>
// ─────────────────────────────────────────────────────────────────────────────
```
Field labels stay pt-BR for consistency with existing files.

## Declaration doc (mandatory)
`///` stating **what it does** and **who uses it**. A trivial `build`/override needs one line.
```dart
/// Formata gramas p/ exibição (100 -> "100 g"). Usada por: RecipeDetailScreen.
String formatGrams(num grams) => …
```

## Logs — only via `AppLog` (never `print`)
Output format: `[Pitada][<feature>] <message>`.
```dart
AppLog.d('recipes', 'import iniciado: $url');           // debug (dropped in release)
AppLog.w('groceries', 'código não encontrado: $code');  // warn (always shown)
AppLog.e('recipes', 'falha ao salvar', error, stack);
```
First argument is the feature tag — it is the **feature folder name**, so it renames when the folder does: `recipes | notebook | plans | groceries | profile | auth | core`. Message short, pt-BR, no trailing period, with useful context (ids, urls). Never log secrets.

## Checklist
1. Header present and filled.
2. Every public declaration has a `///` stating WHAT and who uses it.
3. No comment in the middle of the code (except the token-file inline label).
4. Logs go through `AppLog` with a feature tag; no secrets.