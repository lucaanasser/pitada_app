# Regra: Design system & reuso visual

Este é o coração do projeto. **Toda decisão visual vem de um só lugar** e é fácil de
reutilizar. Se você está prestes a escrever um hex, um tamanho de fonte ou um número
de espaçamento dentro de uma tela, PARE — use um token.

## Fonte única de verdade

| Token            | Arquivo                         | Espelha no protótipo (`:root`) |
|------------------|---------------------------------|--------------------------------|
| Cores            | `core/theme/colors.dart`        | `--bg`, `--accent`, ...        |
| Tipografia       | `core/theme/typography.dart`    | `--disp` (Cormorant), `--ui` (Inter) |
| Espaçamento/raio | `core/theme/spacing.dart`       | paddings, border-radius        |
| Tema Material    | `core/theme/app_theme.dart`     | junta tudo no `ThemeData`      |

### Regras rígidas
- **Cores:** só `AppColors.*`. Nunca `Color(0xFF...)` fora de `colors.dart`.
- **Texto:** só `AppType.*` (ex.: `AppType.display`, `AppType.body`, `AppType.label`).
  Nunca `TextStyle(fontFamily: ...)` fora de `typography.dart`.
- **Espaço/raio:** só `AppSpacing.*` (ex.: `AppSpacing.md`, `AppSpacing.radiusLg`).
  Nunca `EdgeInsets.all(24)` com número mágico.

## Tokens de cor (do protótipo — copie exatamente)

```
bg    #15130E   surf   #1D1A13   surf2  #242017   line  #29251A   line2 #383223
text  #F2EDE1   text2  #C5BEAD   muted  #8E8674   faint #605948
accent#C2703F   accent2#D98C5A   sage   #A9B26C
accentSoft rgba(194,112,63,.12)  accentLine rgba(194,112,63,.32)  sageSoft rgba(169,178,108,.13)
// cores de miniatura (hero das receitas):
clay #8A5A43  moss #5E6B45  ochre #9A7B3C  terra #A35C40  plum #6E4A5A  teal #3F6157  rust #9E5236
```

## Tipografia
- **Cormorant Garamond** (500/600/700, itálico 500/600): display, títulos, números
  (kcal, gramas, "Opção N"). Token família: `AppType.display*`.
- **Inter** (400/500/600): corpo, botões, rótulos. Token família: `AppType.ui*`.
- Empacotadas em `assets/fonts/` e declaradas no `pubspec.yaml`. Nunca dependa de rede.

## Componentes compartilhados (reuso obrigatório)

Toda peça visual repetida vira um widget em `core/widgets/` (ou `presentation/widgets/`
se for exclusiva da feature). Mapeamento protótipo → widget:

| Widget           | Classe no protótipo      | O que é |
|------------------|--------------------------|---------|
| `Masthead`       | `.masthead`              | Marca centralizada no topo das abas |
| `SectionHeader`  | `.shead`                 | Rótulo em versalete + filete fino |
| `ChapterTabs`    | `.ftabs/.ftab`           | Abas em serifa (capítulos), ativo com filete terracota |
| `SegTabs`        | `.seg`                   | Abas simples (Aprendizado) |
| `HairlineRow`    | `.rrow/.litem/.ditem`    | Linha de lista separada por filete (sem card) |
| `ExpiryTag`      | `.tag.urgent/.soon`      | Tag de validade em contorno, sem ícone |
| `OptionCard`     | `.opt/.ohead/.odish`     | Opção de refeição (escolher + pratos linkáveis) |
| `WhyCallout`     | `.tip`                   | Callout "Por quê" de técnica num passo |
| `PitadaButton`   | `.btn/.btn-pri/.btn-ic`  | Botão padrão (primário / ícone) |
| `PitadaChip`     | `.pair/.teclink`         | Chip/tag arredondada (harmonizações, técnicas) |
| `NutritionCard`  | `.nutri`                 | kcal grande + macros |
| `Checkbox` (2x)  | `.lbox` (círculo) / `.cbox` (quadrado) | seleção de item |

Antes de criar um widget novo, procure um existente que sirva. Antes de duplicar
estilo, extraia para um token ou um widget.

## Proibições visuais (do guia)
Zero degradê. Zero brilho/sombra colorida. Zero fonte cursiva. Filetes finos no lugar
de cards pesados. Rótulos em versalete com filete. Bastante respiro. Cormorant nos números.
