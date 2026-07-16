# Regra: Comentários & logs

Comentários em pt-BR; identificadores em inglês.

## Onde um comentário pode existir (só aqui)
1. **Cabeçalho do arquivo** (topo, uma vez).
2. **Doc `///` antes de uma declaração** (função, método, construtor, classe, enum,
   mixin, extension, getter/setter).

**Nada no meio do código:** sem comentário no corpo de função, entre statements, no fim
da linha (inline/trailing), rótulo de campo (`final String title; // nome`), nem marcador
de seção (`// —— … ——`). Código difícil se resolve com nome melhor / função extraída — não
com comentário.

Exceções (diretivas, não documentação): `// ignore:` / `// ignore_for_file:` e
`// TODO(pitada): …` (com dono).

**Exceção de inline — só em token visual** (`colors.dart`, `spacing.dart`,
`typography.dart`): rótulo do valor cru é permitido (`static const bg = Color(0xFF15130E);
// fundo geral`). Não vale em função, estrutura/modelo ou widget; e nunca para porquê/
histórico.

## O QUÊ, nunca o COMO
O comentário diz o que a coisa faz (contrato visto de fora), nunca como foi feita.
- ❌ "ordeno com quicksort e removo os repetidos no laço"
- ✅ "recebe o vetor X e devolve o vetor Y ordenado e sem repetidos"

## Cabeçalho de arquivo (obrigatório em todo `.dart`)
```dart
// ─────────────────────────────────────────────────────────────────────────────
// <caminho/do/arquivo.dart>
// O QUÊ:     <o que o arquivo faz, 1-2 linhas>
// USA:       <o que importa e por quê>
// USADO POR: <quem usa>
// SPEC:      <specs/…, se houver>
// ─────────────────────────────────────────────────────────────────────────────
```

## Doc de declaração (obrigatório)
`///` dizendo **o que faz** e **quem usa**. `build`/override trivial: uma linha basta.
```dart
/// Formata gramas p/ exibição (100 -> "100 g"). Usada por: RecipeDetailScreen.
String formatGrams(num grams) => …
```

## Logs — só via `AppLog` (nunca `print`)
Saída: `[Pitada][<feature>] <mensagem>`.
```dart
AppLog.d('recipes', 'import iniciado: $url');          // debug (some em release)
AppLog.w('shopping', 'código não encontrado: $code');  // warn (sempre aparece)
AppLog.e('recipes', 'falha ao salvar', error, stack);
```
1º arg = tag da feature (`recipes|plans|shopping|learning|core`). Mensagem curta, pt-BR,
sem ponto final, com contexto (ids/urls). Nunca logar segredo.