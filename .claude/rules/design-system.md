# Regra: Design system & reuso visual

Toda decisão visual vem de um token. Prestes a escrever um hex, um tamanho de fonte ou um
número de espaçamento numa tela? Pare — use um token.

Estética: **soft neo-brutalismo pastel** — superfícies pastéis, **bordas** (não filete
fino), **Space Grotesk** em títulos/números, **tags coloridas**, tudo flat.

## Fonte única de verdade

| O quê | Arquivo (API) |
|---|---|
| Cores cruas dos 2 temas | `core/theme/colors.dart` (`AppColors`) |
| Cores por tema | `core/theme/pitada_colors.dart` (`context.pit.*`) |
| Tipografia | `core/theme/typography.dart` (`AppType`) |
| Espaço / raio / borda | `core/theme/spacing.dart` (`AppSpacing`) |
| Ícones (Phosphor) | `core/theme/app_icons.dart` (`AppIcons`) |
| Tema Material | `core/theme/app_theme.dart` (`light` + `dark`) |

**Nunca fora desses arquivos:** `Color(0xFF…)`, `TextStyle(fontFamily:…)`, número mágico
de layout, `Icons.*` (Material).

## Dois temas — obrigatório em toda UI

Cores que mudam por tema vivem em `PitadaColors`, lidas via **`context.pit.*`**:
`bg surf surf2 line line2 border text text2 muted faint` + `pit.card('moss')` (bloco de
foto) e `pit.tabBg(i)` (fundo por aba). Marca (`accent`/`sage`) e heros ficam em
`AppColors` (iguais nos 2 temas). Os valores exatos moram em `colors.dart` — fonte de
verdade, não duplicar aqui.

**Proibido usar direto** os tokens crus do escuro (`AppColors.text/text2/muted/faint/
line/line2/surf/surf2/bg`) — ficam ilegíveis no claro. Troque 1:1 pelo `context.pit.*` de
mesmo nome. `AppType.*` traz uma cor-fallback do escuro; sempre sobrescreva com
`AppType.on(AppType.<estilo>, context.pit.<token>)`. Migre a tela inteira como unidade
(fundo + texto + bordas), nunca metade.

## Tipografia
- **Space Grotesk** (`_disp`): títulos, números (kcal, gramas, "Opção N"), botões.
- **Inter** (`_ui`): corpo, rótulos, texto corrido.
- Empacotadas em `assets/fonts/`, declaradas no `pubspec.yaml`. Nunca via rede.

## Componentes (reuso obrigatório)

Peça visual repetida vira widget em `core/widgets/` (ou `presentation/widgets/` se for
exclusiva da feature). Antes de criar, procure o que já existe. Principais:

| Widget | O que é |
|---|---|
| Masthead · SectionHeader | marca no topo · rótulo de seção |
| PitadaTabs · PitadaTabBar | abas de conteúdo · dock das 5 abas |
| HairlineRow | linha de lista com filete (listas densas) |
| PitadaButton · PitadaChip | botão · chip de contorno (técnicas/harmonizações) |
| PitadaTag | pílula colorida — **só para tag** |
| ExpiryTag · NutritionCard · OptionCard · WhyCallout | validade · macros · refeição · callout "Por quê" |

**Cápsula é só para TAG** (classificação: técnica, tipo, veredito, categoria). **Nunca**
para métrica (kcal, tempo, gramas → texto sóbrio em `pit.text2`/`pit.muted`) nem para
seletor/controle (use `PitadaTabs` ou título com caret que abre sheet). Ver a spec do
`PitadaTag`.

## Proibido / permitido
Proibido: qualquer **sombra** (nem "dura"/offset), degradê/gradiente, fonte cursiva.
Permitido: bordas (`AppSpacing.borderStrong`, cor `pit.border`), pastel, cards com borda,
filete só em listas densas. Usabilidade > design: respiro, nunca sobrecarregar.
