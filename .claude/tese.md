# Tese do Pitada

**Cozinhar é nutrir, usufruir e viver.**

Este documento é o porquê do app. Ele não descreve o que está construído — descreve o
critério com que se decide o que construir. Quando uma decisão de produto estiver em
dúvida, a resposta está aqui, não no código.

---

## O problema

Um app que guarda receitas não ensina a cozinhar.

Receita é **instrução**, não **modelo mental**. "Refogue a cebola por 5 minutos" te faz
jantar hoje e não transfere nada, porque o que importa não está escrito: por que refogar,
como saber o ponto, o que muda se pular. A pessoa executa cinquenta receitas e continua
incapaz de abrir a geladeira e inventar o jantar — que é a definição de saber cozinhar.

O que transfere é o oposto da receita: o **princípio** (dourar cria sabor), o **rácio**
(vinagrete é 3:1 — não é uma receita, é uma proporção que dispensa receita), o **padrão**
(refogado é gordura → aromático → líquido). Conhecimento reutilizável, que vale pra
infinitas receitas e que nenhuma receita individual carrega.

O Pitada existe pra não ser um armazém de receitas.

---

## As quatro habilidades

Saber cozinhar não é uma habilidade. São quatro.

| | Habilidade | O que é |
|---|---|---|
| 1 | **Técnica** | sei executar (dourar, emulsionar) |
| 2 | **Ingrediente** | sei usar o que tenho, sem desperdiçar |
| 3 | **Nutrição** | sei comer bem, com prazer, na hora certa |
| 4 | **Autonomia** | sei abrir a geladeira e inventar o jantar |

As três primeiras são **insumos**. A quarta é o **resultado** — ela não se ensina, ela
emerge do acúmulo das outras três.

**As quatro habilidades são as únicas coisas que o app mede.** Tudo o mais — bancada,
plano, companhia, seed, IA — é meio. Se algo não faz uma das quatro subir, não deveria
existir.

### Autonomia é a métrica anti-armazém

Autonomia é a única coisa que o app mede pelo que a pessoa faz **sem ele**: cozinhar sem
seguir a receita até o fim, substituir um ingrediente porque não tinha, inventar um prato
e só depois anotar.

Um armazém de receitas nunca consegue enxergar isso — ele só vê o que a pessoa guardou.
Se o app consegue detectar e celebrar "você cozinhou sem receita hoje", ele provou que
não é armazém.

---

## O ciclo

As abas não são features paralelas. São os quatro tempos da mesma coisa:

**Planejo → Compro/tenho → Cozinho → Aprendo** — e volta.

Cada aba é dona de uma habilidade e tem um verbo próprio:

| Habilidade | Aba | Verbo | Prova de progresso |
|---|---|---|---|
| Técnica | Receitas | executo | repertório de técnicas usadas |
| Ingrediente | Despensa | uso sem perder | desperdício caindo |
| Nutrição | Plano | como bem e com prazer | cardápio que fecha, com variedade |
| Autonomia | Caderno | invento | cozinhar sem receita, versionar, substituir |

O Caderno não é onde se guarda. É **a aba da autonomia** — o espelho das outras três.
Ele responde a pergunta que nenhuma outra responde: **"eu estou melhorando?"**

---

## Companhia

*Cum panis* — "com quem se divide o pão". A pessoa que come com você. A língua inventou
a palavra dois mil anos antes de existir app.

**Companhia não é o quinto pilar. É um eixo que atravessa os quatro.**

Ninguém tem a habilidade de compartilhar. Compartilhar é **como** as outras quatro
crescem:

- **Técnica** — você vê como o outro fez o mesmo prato. É a única forma de aprender
  técnica que existe fora de uma cozinha física.
- **Ingrediente** — "não achei coentro, usei salsinha" vira uma substituição testada por
  alguém que você conhece; vale dez vezes mais que uma do seed.
- **Nutrição** — metas diferentes, mesma comida. Sua amiga faz a mesma receita com metade
  da porção. Isso normaliza a diferença em vez de esconder.
- **Autonomia** — você vê a versão do outro divergir da sua. Nada ensina "a receita não é
  lei" mais rápido do que ver seu amigo fazer diferente e ficar bom.

Ninguém aprende a cozinhar sozinho. Nunca aprendeu. Aprende-se vendo alguém fazer,
errando junto, e tendo alguém pra contar quando dá certo. Cozinha é a habilidade social
por excelência — e é o que todo app de receita esqueceu, porque catálogo é solitário por
natureza.

### Regras da companhia

1. **Cardápio é individual; prática é coletiva.** Não se compartilha o prato — se
   compartilha o compromisso. "Nesta semana nós dois vamos fazer risoto." Cada um faz o
   seu, cada um registra o seu, e um vê o registro do outro.
2. **Nunca uma tela nova. Nunca um feed.** A companhia aparece dentro das quatro
   habilidades: a substituição da amiga aparece na Despensa junto com as suas; a versão
   dela aparece no histórico da receita ao lado da sua v3. O que vira gaveta, morre.
3. **O coletivo mostra o que o outro fez, nunca o quanto.** Ver a foto do risoto da amiga
   é combustível. Ver que ela cozinhou mais que você é veneno.
4. **O eixo não tem métrica própria.** "Você e a Ana cozinharam 12 vezes juntos" é ranking
   pela porta dos fundos. Se quiser saber se a companhia funciona, olhe a Autonomia da
   pessoa — não a contagem de amigos.

**Comer junto** (mesma mesa, mesma panela) é logística, não habilidade. Dividir a panela
não ensina a cozinhar. Fica pra muito depois.

---

## Macro sem culpa

Macro e kcal são **informação**, e informação não julga — 40 g de proteína é um fato tão
neutro quanto 200 g de farinha. Eles são úteis: montar uma dieta regrada exige saber.

O que produz culpa não é o número. É o número comparado a um teto, **depois do fato
consumado**.

- "1.847 / 2.000" no fim do dia é **acusação** — é tarde, você já comeu, e a única leitura
  é "falhei".
- "Este cardápio dá 1.850 por dia" é **arquitetura** — é antes, é seu, e você está
  desenhando.

O número é o mesmo. Muda **quando** ele aparece e **o que se pode fazer com ele**.

> **Macro aparece onde há decisão. Nunca onde só resta arrependimento.**

- **Plano (Cardápio)** — sim, o tempo todo: é o material de trabalho. Trocar de opção e
  ver o número reagir é design, não vigilância. O "cabe" ao lado de cada opção habilita,
  não julga.
- **Receita** — sim: é atributo do prato.
- **Registro pós-cozinha** — **não**. Ali é sobre o que ficou bom, não sobre o que custou.

### A regra do Progresso

O Progresso é a única superfície onde a culpa pode entrar. Por isso:

> **Ele nunca avalia um dia; ele descreve um padrão.**

Sem números vermelhos, sem "faltou", **sem streak** (streak é a mecânica de culpa mais
eficiente já inventada — quebrou no dia 12, desiste no 13).

E toda conclusão dele aponta pro Cardápio, não pra pessoa: "seus almoços quase nunca
fecham" → *ajuste o almoço*, não *coma menos*. **Se você erra o plano em 2 de 7 dias,
talvez o plano esteja errado, não você.** O objeto avaliado é o plano, que é editável —
nunca o comportamento, que é identidade.

**Variedade** vive aqui: "você comeu 34 ingredientes diferentes este mês" não tem teto,
não tem culpa, e mede exatamente "comer bem com prazer". Um número que só sobe é o
antídoto de um número que só cobra.

---

## A regra da IA

> **A IA pode tirar trabalho. Não pode tirar decisão.**

A IA é uma máquina de fazer as quatro habilidades subirem no papel e descerem na pessoa.
Ela sugere a substituição → não subiu Ingrediente, subiu "saber perguntar". Ela monta o
cardápio → não subiu Nutrição, subiu delegação. Ela abre a geladeira e inventa o jantar →
**matou a Autonomia**, que é a habilidade-fim. É o armazém de receitas com outra roupa: em
vez de reproduzir a receita salva, a pessoa reproduz a resposta da IA.

**Pode (trabalho):**
- transcrever a receita do print do Instagram
- estimar os macros de "1 concha de feijão"
- reconhecer que "shoyu" e "molho de soja" são a mesma coisa
- estruturar a nota bagunçada escrita com a mão suja

**Não pode (decisão):**
- decidir o que a pessoa come
- decidir o que substituir
- decidir se aquela versão ficou melhor

Não é ideologia: **a decisão é o exercício.** Tirar a decisão é tirar o treino.

**Exceção — a IA pode perguntar.** "Você usou salsinha no lugar do coentro — quer guardar
essa troca?" Não decide nada, e transforma algo que a pessoa fez sem pensar em algo que
ela sabe que fez. É a diferença entre professor e cola.

O gargalo do app não é falta de inteligência: é que registrar dá trabalho e ninguém
registra. IA que faz o registro custar 3 segundos em vez de 40 viabiliza as quatro
habilidades. IA que responde no lugar da pessoa as substitui.

---

## Princípios de desenho

**O que vira gaveta, morre.** O Caderno tinha 8 ferramentas em 3 pilares — dividido por
*formato de armazenamento*, não por *momento de uso*. Ninguém navega até "Substituições".
Toda gaveta é um índice de banco de dados fingindo ser produto.

**Organize por momento, não por tipo.** Antes ("o que vou fazer?") · Durante ("como faço
isso?") · Depois ("o que aprendi?"). A distinção não some — ela vira consequência, não
pergunta. A pessoa escreve num campo só; a estrutura emerge do conteúdo. Gaveta é problema
do app, não do cozinheiro.

**O teste do cozinheiro molhado.** Mão suja, panela no fogo. Se ele precisa decidir em
qual gaveta aquilo vai, ele não decide — não registra. O caderno morre vazio.

**O conhecimento encosta na receita, não espera visita.** Ensino não é uma seção; é um
comportamento do app. O princípio aparece no passo, no momento em que ele importa.
Cinquenta receitas depois a pessoa viu "Maillard" quinze vezes em contextos diferentes —
que é literalmente como se aprende.

**Uma escrita, duas verdades.** A pessoa registra "botei menos sal, ficou melhor"; o app
pergunta "virou a nova versão?"; um toque e a receita ganha v4 com o changelog que ela já
escreveu. Nunca duas escritas. Nunca dois sistemas que dessincronizam.

**Versionar é o ritual de virar dono.** O iniciante reproduz a receita dos outros. O
momento em que ele edita e ela passa a ser dele é a transição de "reproduzir" pra
"cozinhar". Versionamento não é feature de power user — é toda a diferença entre armazém
e caderno.

**Dois cozinheiros, uma UI.** O iniciante *consome* o rácio que veio pronto e *lê* o
princípio. O experiente *edita* o rácio até virar o dele e *escreve* o princípio que
descobriu. Mesmo objeto, papel invertido. O app não precisa saber em que estágio a pessoa
está — ela simplesmente começa a escrever mais do que lê.

**O app vem cheio.** Seed de conhecimento (fichas, rácios, harmonizações) é o produto, não
conveniência: mata a página em branco, é útil antes de qualquer esforço, e faz o primeiro
registro ser uma *edição* — dez vezes mais fácil que criar do zero.

**O desperdício é o erro objetivo.** Todo app de comida mede o que a pessoa fez; nenhum
mede o que ela deixou de fazer. Mas o aprendizado mora quase todo no que deu errado, e
desperdício é o único erro datado e inegável — ninguém discute com um coentro podre. E o
ciclo já sabe: entrou na compra, saiu pra receita, o que sumiu sem nenhum dos dois é
desperdício deduzível. O app não pergunta — ele confirma.

**Prevenir, não relatar.** Coentro vencendo em 2 dias → o Plano sugere a receita que usa
coentro → a Bancada sugere cozinhar hoje. O app não dá um relatório de culpa; dá um
jantar. O ciclo fecha antes do lixo. É o que separa "app que mostra gráfico de
desperdício" de "app que reduz desperdício".

**Habilidade sem histórico é slogan.** As quatro são medidas ao longo do tempo. Pode-se
desenhar primeiro — mas não se pode mais terminar no SnackBar.

---

## Ordem de construção

O critério: **cada fatia fecha um ciclo que produz dado real e ensina algo que hoje não se
sabe.** Nada de três meses de infra pra descobrir no fim que a mecânica não pega.

**1. O ciclo mínimo: cozinhei → registrei → virou versão.**
O coração da tese. A menor fatia que faz Técnica e Autonomia existirem, e a única que
prova sozinha que o app não é armazém. Força a junta registro↔versão a nascer certa.
Ensina o que ninguém sabe: **as pessoas registram?** Se não, nada em cima disso importa —
e é melhor descobrir na fatia 1 que na 6.

**2. O desperdício na Despensa.**
"Joguei fora porque perdeu" + a pergunta que fecha o ciclo. Barata, e a única métrica
objetiva e melhorável do app. Faz Ingrediente virar habilidade em vez de inventário. Gera
histórico desde o dia 1 — quanto antes ligar, mais cedo o gráfico tem o que dizer.

**3. Macro real no Plano.**
O desenho já está resolvido; falta o número ser verdadeiro. É trabalho, não descoberta —
e é onde a IA paga o aluguel (estimar macro de ingrediente escrito em português solto é
exatamente "tirar trabalho, não decisão").

**4. O Caderno como espelho.**
Heatmap escopado em cozinha + trilho cronológico. Só agora: **o espelho não tem o que
refletir até 1–3 gerarem dado real.** Construído antes, ele reflete seed — e redesenhar a
vitrine com produtos de mentira é o problema original.

**5. Companhia.**
Precisa de tudo acima. Não há o que compartilhar antes do registro ser real. E é a fatia
com maior risco de estragar o resto (a culpa social) — melhor estar seguro das quatro
habilidades antes.

### Fora da ordem, de propósito

- **A Bancada** — intenção de cozinhar não é habilidade; é combustível do ciclo, não parte
  dele. Faz sentido depois da 1: se as pessoas registram, ela aumenta o volume; se não,
  ela só enche outra lista de salvos — que é o que ela jura combater.
- **O "Durante" (princípio no passo)** — o movimento mais valioso e o mais caro (exige
  ligar conhecimento a passo/ingrediente). É o *acabamento* da Técnica, não a fundação.

---

## Perguntas em aberto

- **Nome da aba Caderno.** "Caderno" é onde se guarda — passivo, arquivo, a metáfora que
  produziu as 8 gavetas. A aba não guarda: ela empurra pra cozinhar, mostra o princípio na
  hora, devolve o progresso. A metáfora vai continuar puxando o desenho de volta pro
  arquivo a cada feature nova.
- **Nome do "fio".** O desenho do trilho fica (ele carrega a metáfora melhor que a
  palavra). O rótulo vira "Recentes" ou some — nome que descreve o desenho envelhece mal.
  No código, `FioEntry` → `TimelineEntry` (`fio` é identificador pt-BR: bug pela regra 4).
- **Individual vs. casa.** Macro é individual; um cardápio que fecha em 1.850 kcal pra uma
  pessoa não fecha pra mais três na mesa. Hoje a tese assume single-player com companhia
  remota.
