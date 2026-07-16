# Plano — dívidas de nomenclatura & specs

A migração de pastas acabou (fases 0–5, jul/2026: renomes legados, regra dos 7 no `core/`,
compartimentalização das 4 features grandes). O relato daquelas fases foi apagado — está no
`git log`. **Sobrou o que elas não resolveram**, e é disso que este arquivo trata agora.

Guia vivo: marque `[x]` conforme avança. Decisões travadas: **nomes em inglês uniforme**,
**regra dos 7**, **specs espelham o código**.

## As duas leis deste arquivo (custaram caro, não descubra de novo)

1. **`analyze` antes da caixa.** A Fase 1 foi dada como pronta com os arquivos renomeados e o
   conteúdo intocado: `master` ficou com **243 erros**, não compilava, e a caixa "`analyze` limpo"
   estava marcada sem o comando ter rodado. `git mv` é METADE do renome; a outra metade é o
   conteúdo (imports + tipos + prosa). Só marque depois de `flutter analyze` dar 0 erros — e o
   `analyze` sozinho não prova que compila: o portão de verdade é `flutter build web --release`.
2. **Comentário mente em silêncio.** Nenhum compilador confere `USA:`/`USADO POR:`/`SPEC:` nem
   um `///`. Todo renome tem uma terceira metade: a prosa. Portão: `grep` do nome MORTO em
   `lib specs` tem que dar zero — é o único teste que existe p/ isso.

## Antes de tocar em nome: o que já mordeu

- **`sed` é cego p/ semântica.** `recipe_seed.dart` dizia "Usada por: recipes_repository". O sed
  óbvio (`recipes_repository`→`recipe_repository`) escreveria uma falsidade NOVA: quem importa o
  seed é o `seed_recipe_repository`, não o contrato. **Confira o importador real com `grep` antes
  de reescrever a linha.**
- **`///` mente igual ao cabeçalho.** Um sweep tocado como "só o bloco de cabeçalho" deixou 7 linhas
  `///` contradizendo o cabeçalho do MESMO arquivo. `comments-and-logs.md` manda `///` em toda
  declaração pública. Varra os dois.
- **A prosa das specs escapa de tudo.** `seed: recipes_seed.dart` e `# data/supabase_recipes_repository.dart`
  não são `file:` — script nenhum pega. `grep`, sempre.
- **`part` é string de nome de arquivo, não import.** Renomear um `part` exige trocar as DUAS
  pontas (`part 'x.dart'` e `part of 'y.dart'`). O único par escrito à mão do repo é
  `recipe_quick_edit.dart` ↔ `recipe_item_edit.dart` (o resto é freezed/`.g`).
- **`for x in $var` não separa palavras no zsh.** Loop de sed some sem erro nenhum. Rode script de
  migração com `bash script.sh`, nunca colado no shell interativo.
- **Pasta de camada ≠ pasta de split.** `auth/data/` com 1 arquivo é o esqueleto, não violação.
  Arquivo solto ao lado de subpasta também é legítimo (`plans/presentation/plans_screen.dart` + `sheets/`).

## Mover pasta ≠ renomear arquivo — use aritmética de caminho, não `sed`

`sed` casa TEXTO; move de pasta é ARITMÉTICA. O import é **100% relativo** neste repo (1033 imports,
zero `package:pitada`), então mover um arquivo quebra os dois lados: os `../` de dentro dele **e** o
caminho que todo importador usa p/ chegar nele. Os dois dependem de ONDE cada ponta parou — `sed`
não sabe disso. A Fase 3 foram 146 moves e **862 imports** reescritos; à mão ou por sed, não fecha.

```
p/ cada .dart, com o par (caminho ANTIGO, caminho NOVO) fixado ANTES de mover:
  p/ cada import relativo:
    alvo   = normpath(dirname(ANTIGO) + '/' + import)   # resolve de onde ele resolvia
    alvo'  = mapa.get(alvo, alvo)                       # o alvo também pode ter andado
    import'= relpath(alvo', dirname(NOVO))              # recalcula de onde ele vai resolver
```

Duas coisas que isso dá de graça e o sed não dá: pega import que não contém o caminho trocado
(`'../widgets/x.dart'`), e não toca no import de quem se mudou JUNTO com o alvo.

**Valide o script com o mapa IDENTIDADE antes de confiar nele**: todo arquivo mapeado p/ ele mesmo
tem que dar **zero** reescrita. Se der qualquer coisa, a aritmética está errada e você descobre de
graça, não em cima de 146 moves.

**E `--dry` tem que simular o move**, senão ele mente: a 1ª versão listava os arquivos andando em
`lib/` DEPOIS do move — em dry nada tinha movido, então calculava tudo como se o arquivo tivesse
ficado parado (331 reescritas em vez de 862). Fixe o par (antigo, novo) ANTES de mover.

---

# As dívidas

Ordenadas por **o que destrava trabalho**, não por tamanho. As duas primeiras são as únicas que
mudam o que a máquina consegue verificar; o resto é arrumação.

## 1. 15 das 48 specs não parseiam como YAML — [ ]

**Por que é a primeira.** A regra de ouro 1 é "spec antes do código". Enquanto 1/3 do corpus não
parseia, **nenhum portão automático consegue ler spec** — nem "todo `file:` aponta p/ `.dart` vivo",
nem "spec e código concordam". Toda verificação de spec hoje é `grep`, que não entende estrutura.
Isto não é arrumação: é o que separa a regra 1 de ser verificável ou ser fé.

Não é regressão da Fase 3 — conferido no commit `5891015`, já era 15 antes dela. (A anotação antiga
culpava só o `app_shell.yaml`, que hoje parseia; o número real nunca tinha sido medido.)

Causa recorrente: `:` sem aspas dentro de flow map/seq, e chave duplicada.

```
specs/backend/{auth,database,edge_functions}.yaml
specs/components/cards/option_card.yaml
specs/components/controls/{pitada_button,pitada_toggle}.yaml
specs/components/recipe_card.yaml
specs/components/tags/{expiry_tag,pitada_tag}.yaml
specs/design-system/typography.yaml
specs/features/{auth,bancada,groceries,plans_progress,recipes}.yaml
```

- [ ] Consertar os 15 (aspas no valor com `:`; achar a chave duplicada)
- [ ] Portão que impede o 16º: um script que roda `yaml.safe_load` em `specs/**/*.yaml`
- [ ] Só então: portão de que todo `file:` aponta p/ `.dart` vivo (hoje 78/78, mas medido por regex)

**Portão:** `python3 -c "import yaml,glob; [yaml.safe_load(open(p)) for p in glob.glob('specs/**/*.yaml',recursive=True)]"` sai sem erro.

## 2. O vocabulário de sufixos não fecha com o corpus — 52 arquivos — [ ]

**Decisão do dono sobre a REGRA, não um sweep de renome.** `architecture.md` declara vocabulário
obrigatório p/ `presentation`: `_screen _sheet _card _row _tile _view _bar _header _grid _chart
_painter`. **52 arquivos** de `presentation/` + `core/widgets/` não têm nenhum deles (contado
16/jul/2026; a anotação antiga dizia "~35", número que ninguém tinha contado).

`core/widgets` 17 · recipes 12 · notebook 8 · plans 7 · profile 6 · groceries 2

**Não é lapso dos arquivos — é a regra que não tem a palavra.** Não existe sufixo ali p/ botão, tag,
campo editável, empty state ou animação, e é isso que são `pitada_button`, `pitada_tag`, `editable`,
`empty_state`, `paper_fly`, `principle_quote`, `key_point`. A prova: a Fase 2 revisou `core/widgets`
inteiro (agrupou os 25, espelho exato 25 `.dart` ↔ 25 `.yaml`) e **não renomeou nenhum** — não por
esquecimento, por não haver sufixo verdadeiro p/ dar. 17 dos 52 estão justamente ali.

Renomear p/ encaixar (`pitada_button_view`?) inventa sufixo falso — pior que não ter, e contra a
regra de ouro 6 (o nome diz o que a coisa É).

Escolha uma:
- [ ] **(A)** `architecture.md` assume que o vocabulário é **indicativo p/ widget folha**, e
  obrigatório onde de fato discrimina papel: `_screen _sheet _repository _providers _controller
  _service _seed _mapper`. Zero renome; a regra passa a descrever o corpus que você já aprovou 2x.
- [ ] **(B)** Ampliar o vocabulário com o que falta (`_button _field _panel _section _quote _anim`…)
  e passar o sweep nos 52. Mais trabalho e ainda deixa `masthead`/`editable` sem casa óbvia.

Enquanto não decidir, a regra está sendo violada 52 vezes por escrito — o que na prática ensina que
ela é ignorável, que é o pior dos dois mundos.

## 3. `<feature>_providers.dart` repete a feature no plural — 2 arquivos — [ ]

`architecture.md:26` usa este padrão como exemplo LITERAL de errado. Só **2 dos 10** `*_providers.dart`
estão errados — os outros 8 (`day_log_providers`, `settings_providers`, `overview_providers`…) são
`<entidade>_providers`, que é o padrão certo:

- [ ] `recipes/application/recipes_providers.dart` → `recipe_providers.dart` (15 importadores)
- [ ] `plans/application/plans_providers.dart` → `plan_providers.dart` (9 importadores)

Os dois estão igualmente errados: **consertar um só deixa o corpus MENOS consistente** — faça os dois
ou nenhum. Tipos e providers de dentro (`RecipesRepository`, `recipesRepositoryProvider`) **ficam**:
o precedente travado é que o ARQUIVO de-repete e o TIPO mantém (`GroceriesRepository` mora em
`repository.dart`). Isto é só renome de arquivo — a aritmética de caminho resolve inteiro.

## 4. Identificadores pt-BR vivos — [ ]

`language.md:31` é explícito: identificador pt-BR legado **é bug, não estilo**. Dois sobreviveram, e
são irmãos — ou os dois, ou nenhum:

- [ ] `CardapioView` / `cardapio_view.dart` → `MenuView` / `menu_view.dart` (+ `plans_screen.dart`,
  e a prosa de `specs/features/plans.yaml`)
- [ ] `fio_entry.dart`/`FioEntry`/`fio_tile.dart` → decidir o termo inglês do conceito "fio" do
  Caderno (`thread`?) e renomear arquivo + tipo + `hub_providers` + `notebook_screen` + `overview_providers`

Diferente da #3, aqui **o tipo renomeia junto** — é o ponto da regra. `language.md` manda traduzir o
conceito, não transliterar: `Cardapio`→`Menu`, não `cardapio_view`.

Cuidado com o que NÃO é bug: "Caderno" na prosa/UI é pt-BR de produto e **fica**.

## 5. Route strings `/learning` e `/shopping` — [ ]

As pastas viraram `notebook`/`groceries` na Fase 1, as rotas não. 6 ocorrências em
`core/router/routes.dart` + consumidores + comentários.

- [ ] `/learning` → `/notebook`, `/shopping` → `/groceries` (produtores + consumidores + prosa)
- [ ] `AppIcons.learning`/`learningFill` → `notebook`/`notebookFill`

Decisão pendente do dono desde a Fase 1. São rotas internas (sem deep-link externo publicado), então
o risco é baixo — mas é chamada sua.

NÃO é bug: `PhosphorIconsRegular.shoppingCartSimple` (nome de pacote de terceiro).

## 6. Chave `detalhes:` em pt-BR — 13 specs — [ ]

`language.md` manda **chave em inglês, prosa em pt-BR**. `detalhes:` é chave, logo `details:`.
13 specs. Renome mecânico e chato — mas **faça depois da #1**: mexer em YAML que não parseia é
trabalhar às cegas.

- [ ] `detalhes:` → `details:` nas 13, com o portão da #1 rodando depois

## 7. Números mágicos de layout em `core/widgets/` — [ ]

Violam `design-system.md` ("todo valor visual vem de token"). Reconferido 16/jul/2026: **a maior
parte da anotação antiga estava desatualizada** — os `size: 34` / `height: 6` / `size: 18` citados
não existem mais nas specs. Sobrou um:

- [ ] `Colors.white` cru em `core/widgets/cards/recipe_thumb.dart:55` → token de `AppColors`

## 8. Smoke das 5 abas no browser — [ ]

A única verificação que a Fase 3 devia ter e não tem. `analyze` 0 erros e `flutter build web
--release` passam, mas **ninguém abriu o app pra ver as abas de pé**. A Fase 3 mexeu em caminho e
não em comportamento, e `analyze`+`build` cobrem caminho — mas isso é argumento, não é ter olhado.

- [ ] Rodar (ver memória `verificacao-web-headless`) e olhar as 5 abas

---

## Receita de rename (reusável em QUALQUER troca futura)

```bash
OLD=shopping; NEW=groceries                    # da raiz do repo

# 1. os arquivos
git mv lib/features/$OLD lib/features/$NEW
git mv lib/features/$NEW/presentation/${OLD}_screen.dart \
       lib/features/$NEW/presentation/${NEW}_screen.dart

# 2. o CONTEÚDO — a metade que já foi esquecida uma vez.
#    2a. imports de arquivo: do nome MAIS específico p/ o mais genérico, senão
#        'shopping_list.dart' come o prefixo de 'shopping_list_view.dart'.
#    2b. caminhos de pasta nos cabeçalhos, imports e 'file:' das specs:
grep -rl "features/$OLD" lib specs | xargs sed -i '' "s#features/$OLD#features/$NEW#g"
#    2c. tipos/providers/tags — LISTE e revise 1 a 1 antes de trocar:
grep -rn "Shopping\|'shopping'" lib

# 3. a TERCEIRA metade: a prosa (cabeçalho, ///, prosa de spec). Portão:
grep -rn "shopping" lib specs        # tem que dar zero

# 4. o portão: sem isto o renome NÃO está feito
flutter analyze                      # 0 erros
flutter build web --release          # o analyze sozinho não prova que compila
```

Se o renome MOVE arquivo de pasta, não use o passo 2b: use a aritmética de caminho (seção acima).