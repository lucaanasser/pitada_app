# Regra: Spec antes de código (specs `.yaml`)

## A ordem é SEMPRE spec → código. Nunca código → spec.

Esta é a regra mais rígida do projeto:

1. **Primeiro** escreva (ou atualize) a spec `.yaml` em `specs/`.
2. **Depois** implemente o `.dart` seguindo a spec.

É **proibido** escrever código e só então documentar a spec ("código → spec"). Se você
se pegou implementando algo sem spec, PARE, escreva a spec, e só então continue. Toda
PR/commit que adiciona código precisa que a spec correspondente já exista e concorde.

**Nada é implementado sem uma spec.** Toda tela, componente e token de design nasce
primeiro como um arquivo `.yaml` em `specs/`. A spec é o contrato; o código a segue.

## Onde ficam

```
specs/
  design-system/    # tokens: cores, tipografia, espaçamento, tema
  components/       # um arquivo por widget compartilhado (core/widgets/)
  features/         # um arquivo por tela/fluxo de cada feature
  README.yaml       # índice de todas as specs
```

O nome da spec espelha o arquivo que ela gera:
`specs/components/pitada_button.yaml` → `lib/core/widgets/pitada_button.dart`.

## Fluxo

1. **Escreva/atualize a spec** `.yaml` descrevendo o quê, entradas, variações,
   tokens usados e o alvo visual no protótipo.
2. **Implemente** o `.dart` seguindo a spec.
3. Se a implementação divergir, **atualize a spec** — spec e código nunca discordam.

## Estrutura de uma spec de componente

```yaml
component: PitadaButton
file: lib/core/widgets/pitada_button.dart
prototype: ".btn / .btn-pri / .btn-ic em pitada.html"
purpose: Botão padrão do app, com variações reutilizáveis.
uses:                      # tokens/arquivos que consome
  - AppColors.accent
  - AppType.button
  - AppSpacing.radiusLg
variants:
  - name: primary          # .btn-pri
    background: AppColors.accent
    foreground: "#1F0D04"
  - name: icon             # .btn-ic
    border: AppColors.line2
api:
  - label: String
  - icon: IconData?
  - onPressed: VoidCallback?
used_by:
  - recipe_detail_screen (barra inferior)
```

## Estrutura de uma spec de tela (feature)

```yaml
screen: RecipesScreen
file: lib/features/recipes/presentation/recipes_screen.dart
prototype: "aba 'Receitas' em pitada.html"
purpose: Lista de receitas por pasta (capítulo).
layout:                    # de cima pra baixo, na ordem
  - Masthead
  - ChapterTabs: [Todas, Marinadas, Jantares rápidos, Fit, Doces]
  - lista de RecipeRow (HairlineRow)
components: [Masthead, ChapterTabs, RecipeRow]
providers: [recipesProvider, selectedFolderProvider]
navigates_to: [RecipeDetailScreen]
```

Mantenha as specs curtas e verdadeiras. Elas são a memória viva do design.
