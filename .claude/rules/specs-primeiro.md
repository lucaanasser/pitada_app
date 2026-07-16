# Regra: Spec antes de código

Ordem **sempre spec → código**, nunca o contrário. Nada é implementado sem uma spec
`.yaml` em `specs/` descrevendo o quê / entradas / variações / tokens usados. Mudou o
código? A spec já existia e concorda. Divergiu? Atualize a spec — spec e código nunca
discordam.

## Onde ficam (espelham o código — ver `nomenclatura-e-pastas.md`)

```
specs/
  design-system/   # tokens (cores, tipografia, espaçamento, tema)
  components/      # 1 por widget de core/widgets/ (agrupado igual ao código)
  features/        # 1 por tela/fluxo (vira pasta quando cresce)
  README.yaml      # índice
```
O caminho da spec espelha o do código (`lib/`↔`specs/`, `.dart`↔`.yaml`). Todo `file:`
aponta o `.dart` real.

## Esqueleto — componente
```yaml
component: PitadaButton
file: lib/core/widgets/pitada_button.dart
purpose: Botão padrão, reutilizável.
uses: [AppColors.accent, AppType.button, AppSpacing.radiusLg]
variants:
  - {name: primary, background: AppColors.accent, foreground: AppColors.onAccent}
  - {name: icon, border: AppColors.line2}
api: {label: String, icon: IconData?, onPressed: VoidCallback?}
used_by: [recipe_detail_screen]
```

## Esqueleto — tela
```yaml
screen: RecipesScreen
file: lib/features/recipes/presentation/recipes_screen.dart
purpose: Lista de receitas por pasta.
layout: [Masthead, PitadaTabs, lista de RecipeRow]
providers: [recipesProvider, selectedFolderProvider]
navigates_to: [RecipeDetailScreen]
```

Specs curtas e verdadeiras — a memória viva do design.
