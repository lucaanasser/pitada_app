# Regra: Design system & reuso visual

Este é o coração do projeto. **Toda decisão visual vem de um só lugar** e é fácil de
reutilizar. Se você está prestes a escrever um hex, um tamanho de fonte ou um número
de espaçamento dentro de uma tela, PARE — use um token.

> **Estética atual: soft neo-brutalismo pastel.** Superfícies **pastéis**, **bordas**
> (não filete fino), **Space Grotesk** nos títulos/números, **tags coloridas**, tudo
> **flat** (cor chapada, sem sombra/degradê). Mistura a base editorial quente do Pitada
> com as referências — sem abandonar a identidade. **Usabilidade > design: muito respiro,
> nunca sobrecarregar a tela.**

## Fonte única de verdade

| Token            | Arquivo                         | Observação |
|------------------|---------------------------------|--------------------------------|
| Cores            | `core/theme/colors.dart`        | tokens crus dos 2 temas |
| Cores por tema   | `core/theme/pitada_colors.dart` | `ThemeExtension` lido via `context.pit.*` |
| Tipografia       | `core/theme/typography.dart`    | `_disp` (Space Grotesk), `_ui` (Inter) |
| Espaçamento/raio | `core/theme/spacing.dart`       | paddings, border-radius, larguras de borda |
| Tema Material    | `core/theme/app_theme.dart`     | junta tudo em `light` + `dark` |

### Regras rígidas
- **Cores:** só `AppColors.*` (marca/heros, iguais nos 2 temas) ou `context.pit.*`
  (superfícies/texto que mudam por tema). Nunca `Color(0xFF...)` fora de `colors.dart`.
- **Texto:** só `AppType.*`. Nunca `TextStyle(fontFamily: ...)` fora de `typography.dart`.
- **Espaço/raio/borda:** só `AppSpacing.*`. Nunca número mágico de layout na tela.

## Dois temas (claro + escuro)

O app tem **tema claro (base creme)** e **tema escuro** (base histórica). As cores que
**mudam** entre temas vivem no `ThemeExtension` `PitadaColors` e são lidas nos widgets
via **`context.pit.*`**: `bg`, `surf`, `surf2`, `line`, `line2`, `border`, `text`,
`text2`, `muted`, `faint`, mais os helpers `pit.card('moss')` (cor do bloco de foto) e
`pit.tabBg(i)` (fundo tingido por aba). Marca (`accent`/`sage`) e heros continuam em
`AppColors`. **Migre uma tela como unidade** (fundo + textos) — o padrão hoje é escuro
enquanto o claro é migrado tela-a-tela.

## Tokens de cor (tema escuro — base)

```
bg    #15130E   surf   #1D1A13   surf2  #242017   line  #29251A   line2 #383223
text  #F2EDE1   text2  #C5BEAD   muted  #8E8674   faint #605948
accent#C2703F   accent2#D98C5A   sage   #A9B26C   ink(escuro) #3A3324
```

## Tokens de cor (tema claro — creme)

```
bgLight #F5EFE3  surfLight #FBF7EE  surf2Light #F1EADE  lineLight #E8DFCF  line2Light #D9CFBB
textLight #221E17  text2Light #6A6252  mutedLight #938A78  faintLight #B4AB98  ink(claro) #221E17
```

Pastéis por aba e cor de card (por hero, em cada tema) ficam em `colors.dart`
(`tabBgLight/Dark`, `cardLight/Dark`).

## Tipografia
- **Space Grotesk** (500/600/700): títulos, números (kcal, gramas, "Opção N"), botões.
  Geométrica/chunky — a "voz" neo-brutalista. Família: `_disp`.
- **Inter** (400/500/600): corpo, rótulos, texto corrido. Família: `_ui`.
- Empacotadas em `assets/fonts/` e declaradas no `pubspec.yaml`. Nunca dependa de rede.
  (Cormorant Garamond segue nos assets, mas não é mais usada.)

## Componentes compartilhados (reuso obrigatório)

Toda peça visual repetida vira um widget em `core/widgets/` (ou `presentation/widgets/`
se for exclusiva da feature).

| Widget           | O que é |
|------------------|---------|
| `Masthead`       | Marca centralizada no topo das abas |
| `SectionHeader`  | Rótulo em versalete + filete fino |
| `ChapterTabs`    | Abas de capítulo, ativo com filete terracota |
| `SegTabs`        | Abas simples (Aprendizado) |
| `HairlineRow`    | Linha de lista separada por filete (listas densas) |
| `ExpiryTag`      | Tag de validade em contorno, sem ícone |
| `PitadaChip`     | Chip/tag de **contorno** (harmonizações, técnicas) |
| `PitadaTag`      | Pílula **colorida** (fundo pastel + borda) — meta/tempo/nota |
| `NutritionCard`  | Caixa de macros com borda (Proteína · Gordura · Carbo) |
| `OptionCard`     | Opção de refeição (escolher + pratos linkáveis) |
| `WhyCallout`     | Callout "Por quê" de técnica num passo |
| `PitadaButton`   | Botão padrão (primário / contorno) |

Antes de criar um widget novo, procure um existente que sirva. Antes de duplicar
estilo, extraia para um token ou um widget.

## Estética & proibições
**Soft neo-brutalismo pastel:** superfícies pastéis + **bordas** (grossas, cor
`pit.border`, largura `AppSpacing.borderStrong`) + Space Grotesk + tags coloridas.
Cards são permitidos (com borda). Filete ainda vale para **listas densas**.

Proibido: degradê, gradiente, **qualquer sombra** (nem "dura"/offset), fonte cursiva.
**Usabilidade > design:** muito respiro, nunca sobrecarregar a tela de informação.
Space Grotesk nos títulos e números.
