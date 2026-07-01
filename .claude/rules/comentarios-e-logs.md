# Regra: Comentários & logs padronizados

Comentários e textos de doc em **pt-BR**; identificadores de código em inglês.

## 1. Cabeçalho obrigatório em TODO arquivo `.dart`

Todo arquivo começa com este bloco. Preencha os quatro campos sem exceção:

```dart
// ─────────────────────────────────────────────────────────────────────────────
// <caminho/relativo/do/arquivo.dart>
// O QUÊ:     <o que este arquivo faz, 1-2 linhas>
// USA:       <arquivos/pacotes que importa e por quê>
// USADO POR: <quem importa/usa este arquivo>
// ─────────────────────────────────────────────────────────────────────────────
```

Exemplo:

```dart
// ─────────────────────────────────────────────────────────────────────────────
// lib/core/widgets/pitada_button.dart
// O QUÊ:     Botão padrão do app (primário e de ícone), reutilizável em telas.
// USA:       core/theme (AppColors, AppType, AppSpacing) para estilo padronizado.
// USADO POR: recipe_detail_screen, import_sheet, shopping_screen (ações principais).
// ─────────────────────────────────────────────────────────────────────────────
```

## 2. Comentário obrigatório em TODA função / método público

Use doc comment `///` acima da declaração. Diga **o que faz** e **quem usa**:

```dart
/// Formata gramas para exibição (ex.: 100 -> "100 g").
/// Usada por: RecipeDetailScreen, IngredientRow.
String formatGrams(num grams) => ...
```

Para `build`/overrides triviais, um `///` de uma linha basta. Para lógica não óbvia,
comente também o **porquê** dentro do corpo — nunca o óbvio.

## 3. Logs — um único padrão via `AppLog`

Nunca use `print`. Use o helper `core/utils/app_log.dart`. Formato de saída:

```
[Pitada][<feature>] <mensagem>
```

API:

```dart
AppLog.d('recipes', 'import iniciado: $url');   // debug
AppLog.i('plans',   'opção escolhida: $optionId'); // info
AppLog.w('shopping','código de barras não encontrado: $code'); // warn
AppLog.e('recipes', 'falha ao salvar', error, stack); // erro
```

Regras:
- Primeiro argumento é sempre a **tag da feature** (`recipes`, `plans`, `shopping`,
  `learning`, `core`).
- Mensagem curta, em pt-BR, sem ponto final, com contexto útil (ids, urls).
- `debug` some em release; `warn`/`error` sempre aparecem.
- Nunca logue segredos (chaves, tokens).

## 4. Estilo geral
- Comentário explica **porquê**, não reescreve o código.
- Sem código morto ou comentários de "TODO" sem dono. Use `// TODO(pitada): ...`.
- Seções longas dentro de um `build` podem levar um `// —— nome da seção ——`.
