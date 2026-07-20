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

- [x] Consertar os 15 (eram 16 — `sub_recipes.yaml` havia regredido; 20/jul/2026)
- [x] Portão que impede o 16º: `python3 tool/spec_gate.py` (parse de `specs/**/*.yaml`)
- [x] Portão de que todo `file:` aponta p/ `.dart` vivo (no mesmo `tool/spec_gate.py`)

**Portão:** `python3 -c "import yaml,glob; [yaml.safe_load(open(p)) for p in glob.glob('specs/**/*.yaml',recursive=True)]"` sai sem erro.

## 2. O vocabulário de sufixos não fechava com o corpus — DECIDIDO 20/jul/2026 — [x]

**Decisão do dono (20/jul/2026): híbrido, nem (A) nem (B) puros.** Nem afrouxar o sufixo a
"indicativo" (o dono QUER sufixo obrigatório em feature — é o que torna botão/card achável e
reusável por agente), nem inflar a lista até cobrir tudo (lista grande sem serventia). A meta era
90%+ encaixando bem. Três decisões, gravadas em `architecture.md`:

1. **Vocabulário de `presentation` cresce de 11 p/ 16**, só com o que o corpus já provou precisar
   (≥ 2 usos reais): `+ _section _field _panel _picker _tag`. Critério gravado na regra: sufixo novo
   só entra com 2+ arquivos reais — o freio contra inchar. Isso legaliza 137/177 (77%) sem tocar em código.
2. **Átomos de `core/widgets/` são exceção nominal** (o nome É o papel: `pitada_button`, `masthead`,
   `sheet_grip`). Preço: spec 1:1 obrigatória em `specs/components/` — átomo sem spec é bug.
3. **Válvula de escape** (≤ ~5 no app): arquivo que não é papel-padrão nem átomo (pieces-file,
   dado estático que não é widget, driver de animação) pode ficar sem sufixo COM linha no cabeçalho
   dizendo por quê. A 6ª significa "tem papel escondido, a lista deve crescer".

**Renomes feitos (20/jul/2026), fora de `recipes/` (outro agente ativo lá):**
- groceries: `category_group`→`category_section`
- notebook: `key_point`→`key_point_tile`, `lesson_body`→`lesson_body_view`,
  `principle_quote`→`principle_quote_view`, `note_take`→`note_take_tile`,
  `pairing_legend`→`pairing_legend_view`
- plans: `day_log_extras`→`day_log_extras_section`, `day_log_footer`→`day_log_footer_bar`,
  `day_summary`→`day_summary_view`
- profile: `activity_graph`→`activity_chart`, `friend_avatars`→`friend_avatar_row`,
  `kitchen_radar`→`kitchen_radar_section`, `profile_stats`→`stats_bar`
- escape valve (com nota no cabeçalho): `add_pantry_data` (dado estático, não-widget),
  `log_param` (pieces: LogParamCell + LogStepRow), `settings_rows` (3 classes de linha),
  `section_editor` (`_editor` fora do vocab pela regra dos 2+; promover quando a família de
  edição de `recipes/` normalizar)

**Pendente (esperando o outro agente sair de `recipes/`):** ~11 arquivos de recipes
(`recipe_meta`, `recipe_detail_body`, `paper_fly`, `import_preview`, `recipe_meta_text`, a família
`*_quick_edit`/`*_item_edit`/`recipe_editors`, `framework_slot_pill`). `paper_fly` provavelmente
escape valve; a família de edição pede decidir `_editor` (2+ usos aí dentro).

## 3. `<feature>_providers.dart` repete a feature no plural — 2 arquivos — [ ]

`architecture.md:26` usa este padrão como exemplo LITERAL de errado. Só **2 dos 10** `*_providers.dart`
estão errados — os outros 8 (`day_log_providers`, `settings_providers`, `overview_providers`…) são
`<entidade>_providers`, que é o padrão certo:

- [x] `recipes/application/recipes_providers.dart` → `recipe_providers.dart` (20/jul/2026)
- [x] `plans/application/plans_providers.dart` → `plan_providers.dart` (20/jul/2026)

Os dois estão igualmente errados: **consertar um só deixa o corpus MENOS consistente** — faça os dois
ou nenhum. Tipos e providers de dentro (`RecipesRepository`, `recipesRepositoryProvider`) **ficam**:
o precedente travado é que o ARQUIVO de-repete e o TIPO mantém (`GroceriesRepository` mora em
`repository.dart`). Isto é só renome de arquivo — a aritmética de caminho resolve inteiro.

## 4. Identificadores pt-BR vivos — [ ]

`language.md:31` é explícito: identificador pt-BR legado **é bug, não estilo**. Dois sobreviveram, e
são irmãos — ou os dois, ou nenhum:

- [x] `CardapioView` / `cardapio_view.dart` → `MenuView` / `menu_view.dart` (20/jul/2026)
- [x] `fio_entry.dart`/`FioEntry`/`fio_tile.dart` → termo escolhido: **thread** (`ThreadEntry`,
  `ThreadTile`, `ThreadKind`, `threadProvider`); "fio" segue na prosa/UI (20/jul/2026)

Diferente da #3, aqui **o tipo renomeia junto** — é o ponto da regra. `language.md` manda traduzir o
conceito, não transliterar: `Cardapio`→`Menu`, não `cardapio_view`.

Cuidado com o que NÃO é bug: "Caderno" na prosa/UI é pt-BR de produto e **fica**.

## 5. Route strings `/learning` e `/shopping` — [ ]

As pastas viraram `notebook`/`groceries` na Fase 1, as rotas não. 6 ocorrências em
`core/router/routes.dart` + consumidores + comentários.

- [x] `/learning` → `/notebook`, `/shopping` → `/groceries` (produtores + consumidores + prosa; 20/jul/2026)
- [x] `AppIcons.learning`/`learningFill` → `notebook`/`notebookFill`; o glifo de caderno
  (EmptyState) virou `AppIcons.journal` p/ desfazer a colisão de nome

Decisão pendente do dono desde a Fase 1. São rotas internas (sem deep-link externo publicado), então
o risco é baixo — mas é chamada sua.

NÃO é bug: `PhosphorIconsRegular.shoppingCartSimple` (nome de pacote de terceiro).

## 6. Chave `detalhes:` em pt-BR — 13 specs — [ ]

`language.md` manda **chave em inglês, prosa em pt-BR**. `detalhes:` é chave, logo `details:`.
13 specs. Renome mecânico e chato — mas **faça depois da #1**: mexer em YAML que não parseia é
trabalhar às cegas.

- [x] `detalhes:` → `details:` nas 13 (+ `detalhes_icon_button` → `details_icon_button`; 20/jul/2026)

## 7. Números mágicos de layout em `core/widgets/` — [ ]

Violam `design-system.md` ("todo valor visual vem de token"). Reconferido 16/jul/2026: **a maior
parte da anotação antiga estava desatualizada** — os `size: 34` / `height: 6` / `size: 18` citados
não existem mais nas specs. Sobrou um:

- [x] `Colors.white` cru em `recipe_thumb.dart` → token novo `AppColors.onHero` (também
  aplicado em `friend_avatars.dart`; o botão do `PitadaToggle` ligado virou `onAccent`; 20/jul/2026)

## 8. Duas noções de técnica até o Caderno ser refatorado — [ ]

Decisão consciente (jul/2026, refatoração da página de receita): `Technique.notion`
(recipes) nasceu como campo próprio porque o Caderno ainda é legado, mas o Caderno já
tem `LessonKind.technique` com `Lesson.summary` = a mesma noção. São dois lugares onde
a mesma coisa pode ser escrita — exatamente o "dois sistemas que dessincronizam" que a
tese proíbe.

- [ ] Na refatoração do Caderno: reconciliar `Technique.notion` ↔ `Lesson.summary`
      (uma escrita, duas verdades — decidir qual é a fonte e derivar a outra)

## 9. Smoke das 5 abas no browser — [ ]

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