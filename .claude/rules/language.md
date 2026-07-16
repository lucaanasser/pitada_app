# Language

**Principle:** everything a machine reads is in English; pt-BR appears only where a human reads prose.

The split is not "code vs docs" — it is **identifier vs prose**. A `.yaml` spec has English keys and pt-BR sentences; a `.dart` file has English identifiers and pt-BR comments. Both languages live in the same file, on opposite sides of that line.

## English — always
| What | Example |
|---|---|
| Files, folders, features | `recipes/data/repositories/recipe_repository.dart` |
| Types, classes, enums | `RecipeRepository`, `GroceryItem` |
| Providers, variables, functions | `selectedFolderProvider`, `formatGrams` |
| Spec keys and structure | `component:`, `purpose:`, `variants:`, `used_by:` |
| Branch names, commit scope | `feature/recipe-import` |

Naming details (role suffix, snake_case, rule of 7) live in `architecture.md`.

## pt-BR — only these four
1. **In-code comments** — file header and `///` docs. → `comments-and-logs.md`
2. **Spec prose** — the descriptive values, never the keys (`purpose: Lista de receitas por pasta.`).
3. **Product UI** — every string the user sees: tab labels, buttons, messages, empty states.
4. **Log messages** — the `AppLog` message; the feature tag stays English (`AppLog.d('recipes', 'import iniciado')`).

Commit messages are pt-BR imperative — see `versioning.md`.

## The seam: UI label vs code name
A pt-BR label never leaks into an identifier. The label is data; the name is code.
- Tab reads `Caderno` → feature is `notebook`, never `caderno`.
- Tab reads `Ingredientes` → feature is `groceries`, never `ingredientes`.

A legacy pt-BR identifier is a bug, not a style choice — rename it (migration plan in `.claude/reestruturacao.md`).

## Translating, not transliterating
Pick the word an English speaker would use for the concept, not a literal gloss.
- `Caderno` → `notebook` (not `notebook_de_cozinha`)
- `Despensa` → `pantry` (not `pantry_despensa`)
- Never mix languages inside one identifier (`recipe_pasta`, `lista_provider`).

## Checklist
1. Every identifier, file, and folder is English.
2. pt-BR only in comments, spec prose, product UI, and log messages.
3. No pt-BR word inside an identifier; no mixed-language name.
4. UI label translated to an English concept, not transliterated.