# Regra: Nomenclatura & pastas

Objetivo: achar qualquer arquivo/spec em segundos e renomear em massa sem dor. Vale igual
para `lib/` e `specs/` (o caminho da spec espelha o do código).

## Nomes
- **snake_case, sempre inglês** (arquivo, pasta, feature). Tipos `PascalCase`,
  providers/vars `lowerCamelCase`. UI em pt-BR, código não.
- **A pasta nomeia a feature UMA vez; o arquivo não repete.** Nome = PAPEL + ENTIDADE.
  - ❌ `recipes/data/recipes_repository.dart` · ✅ `recipes/data/repositories/recipe_repository.dart`
  - Exceção única: a tela-raiz da aba pode levar o nome da feature (`<feature>_screen.dart`).
- **Sufixo de papel obrigatório** (é a chave de busca — `find lib -name '*_repository.dart'`):

  | Camada | Sufixos |
  |---|---|
  | presentation | `_screen` `_sheet` `_card` `_row` `_tile` `_view` `_bar` `_header` `_grid` `_chart` `_painter` |
  | application | `_providers` `_controller` `_service` |
  | data | `_repository` `_seed` `_mapper`; **modelo = substantivo puro** (`recipe.dart`), sem sufixo |
  | gerados | `*.freezed.dart` `*.g.dart` ao lado do modelo |

## Regra dos 7
**Máx. 7 arquivos soltos por diretório; o 8º obriga subpasta.** Gerados não contam. 7 é
teto, não piso (não fragmente por simetria; nada de pasta de 1 arquivo). Ao estourar,
quebre nesta ordem:
1. **Por papel:** `data/` → `models/ repositories/ seed/`; `presentation/` → `screens/
   sheets/ widgets/`.
2. **Por sub-domínio** (quando um papel ainda passa de 7): ex. `recipes/presentation/
   widgets/` → `recipe_detail/ cook/ folder/ import/ edit/`; `core/widgets/` →
   `controls/ sheets/ tabs/ tags/ layout/ cards/`.

## Esqueleto canônico
```
features/<feature>/
  data/{models,repositories,seed}/
  application/            # *_providers, *_controller, *_service
  presentation/{screens,sheets,widgets}/
core/
  config/ supabase/ router/ theme/ utils/            # já enxutos
  widgets/{controls,sheets,tabs,tags,layout,cards}/  # quando > 7
```
Aplique **quando o count exigir** — feature pequena (≤ 7 por camada) fica flat. O que não
muda é ONDE cada coisa vai ao quebrar.

## Specs espelham o código
Caminho da spec ≈ caminho do código. Feature-spec vira pasta quando cresce; a regra dos 7
vale aqui também. Todo `file:` aponta o `.dart` real.

## Nomes legados a corrigir (mentem sobre a realidade)
| Hoje | Vira | Motivo |
|---|---|---|
| `features/shopping/` | `features/groceries/` | aba é "Ingredientes"; entidades → `Grocery*`, mas `pantry`/despensa fica |
| `features/learning/` | `features/notebook/` | aba é "Caderno" |
| `caderno_*` | `notebook_*` / `providers` / `add_sheet` | pt-BR solto no código |

Receita de rename em massa e o resto do plano: `.claude/reestruturacao.md`.

## Checklist ao criar/mover arquivo
1. snake_case inglês + sufixo de papel correto.
2. Não repetir o nome da pasta (só a tela-raiz pode).
3. Pasta destino com ≤ 7 soltos? Se o novo é o 8º, quebre por papel antes.
4. Atualize o cabeçalho (`// caminho`, USA, USADO POR, SPEC) do arquivo e de quem o referencia.
5. Crie/mova a spec-espelho no mesmo caminho relativo.
