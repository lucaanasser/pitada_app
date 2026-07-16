# Pitada — guia do projeto (leia antes de codar)

App pessoal de receitas, caderno de cozinha, planos alimentares e despensa.
**Flutter + Riverpod + go_router**, backend **Supabase**, IA via **Gemini** (Edge Functions).
Estética **soft neo-brutalismo pastel**. UI e conteúdo em **pt-BR**; código em inglês.
Referências visuais vivas: `pitada-estilo.html`, `pitada-guia-de-construcao.html`.

## Regras de ouro (inegociáveis) — cada uma tem um arquivo em `rules/`

1. **Spec antes de código.** Nada nasce sem uma spec `.yaml` em `specs/`. Ordem
   spec → código, nunca o contrário. → `specs-primeiro.md`
2. **≤ 200 linhas por arquivo.** Passou, quebre. → `arquitetura.md`
3. **Zero valor visual chumbado.** Cor, fonte, espaço, ícone, widget vêm sempre dos
   tokens / `core/widgets`. → `design-system.md`
4. **Comentário só no cabeçalho e antes de declaração**, dizendo o QUÊ (nunca o COMO).
   → `comentarios-e-logs.md`
5. **Nome espelha a realidade + regra dos 7.** snake_case inglês, sufixo de papel
   (`_screen`, `_sheet`, `_repository`…), a pasta nomeia a feature uma vez, máx. 7
   arquivos soltos por pasta. → `nomenclatura-e-pastas.md`
6. **Versione sempre.** Terminou algo, commit local (autor único, sem push).
   → `versionamento.md`

## Estrutura (detalhe e regra dos 7 em `nomenclatura-e-pastas.md`)

```
specs/            # specs .yaml — sempre primeiro; ESPELHA o caminho do código
lib/core/         # theme (tokens) · widgets (reuso) · router · config · supabase · utils
lib/features/<f>/ # data (modelos + repositório) · application (providers) · presentation (telas + widgets)
```

Fluxo de dados (a seta nunca volta): `presentation → application → data → Supabase`.
A UI nunca chama Supabase direto e só importa modelos de `data/`.

## Convenções

- Nome de arquivo/pasta/feature em inglês; rótulo de aba em pt-BR (`Caderno`→`notebook`,
  `Ingredientes`→`groceries`). Nome nunca legado (ver regra 5).
- Dois temas (claro/escuro): cor por tema via `context.pit.*`, marca em `AppColors`;
  toda tela funciona nos dois.
- Hardware (scanner/câmera/share) atrás de service abstrato (real + mock) p/ rodar no PC.
- Proibido no visual: sombra, degradê/gradiente, fonte cursiva. Sim: bordas, pastel,
  Space Grotesk, tags coloridas, cards com borda.
- Usabilidade > design: muito respiro, nunca sobrecarregar a tela.

Plano vivo da migração p/ o padrão de nomes: `.claude/reestruturacao.md`.
