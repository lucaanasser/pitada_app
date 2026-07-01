# Pitada — guia do projeto (leia antes de codar)

App pessoal de receitas, aprendizado de cozinha, planos alimentares e despensa.
**Flutter + Riverpod + go_router**, backend Supabase, IA via Gemini (Edge Functions).
Alvo visual: `pitada.html` (o protótipo é a fonte de verdade). Guia completo:
`pitada-guia-de-construcao.html`. Interface e conteúdo em **português do Brasil**.

## Regras de ouro (não negociáveis)

1. **Spec antes de código — sempre.** A ordem é **spec → código**, NUNCA código → spec.
   Nada é implementado sem antes existir uma spec `.yaml` em `specs/` descrevendo o
   quê/como. Escreveu ou mudou código? A spec correspondente já tinha que existir e
   estar de acordo. Veja `rules/specs-primeiro.md`.
2. **Máx. 200 linhas de código por arquivo.** Se passar, quebre em pedaços menores.
   Veja `rules/arquitetura.md`.
3. **Reutilize tudo, principalmente o visual.** Cor, fonte, espaçamento, botão, tag,
   cabeçalho — vêm SEMPRE dos tokens/widgets compartilhados. Zero valor "chumbado"
   (hex, tamanho de fonte, px) fora do design system. Veja `rules/design-system.md`.
4. **Todo arquivo tem cabeçalho padronizado** (o quê / usa / usado por) e **toda
   função tem comentário** (o quê / quem usa). Logs seguem um único padrão.
   Veja `rules/comentarios-e-logs.md`.

## Onde as coisas ficam

```
specs/                 # SPECS .yaml — sempre primeiro
  design-system/       # tokens (cores, tipografia, espaçamento)
  components/          # widgets compartilhados
  features/           # telas por feature
lib/
  core/
    config/           # env / constantes
    supabase/         # cliente + helpers
    theme/            # AppColors, AppType, AppSpacing, AppTheme  <- design system
    router/           # shell das 4 abas + rotas
    widgets/          # widgets compartilhados (reuso visual)
    utils/            # AppLog, formatação, unidades
  features/
    <feature>/data/          # modelos + repositório (fala com Supabase)
    <feature>/application/    # controllers/providers Riverpod
    <feature>/presentation/   # telas + widgets da feature
assets/fonts|brand/    # Cormorant Garamond + Inter, marca
.claude/rules/         # as regras detalhadas deste projeto
```

## Fluxo de trabalho para qualquer tarefa

1. Ler a spec relevante em `specs/` (ou escrevê-la, se não existir).
2. Implementar seguindo a spec, os tokens do design system e os templates de comentário.
3. Garantir < 200 linhas por arquivo e reuso máximo.
4. Conferir contra o protótipo `pitada.html`.

## Regras detalhadas

- `rules/arquitetura.md` — camadas, feature-first, limite de 200 linhas, como quebrar.
- `rules/specs-primeiro.md` — como escrever e usar as specs `.yaml`.
- `rules/design-system.md` — tokens, catálogo de componentes, mandato de reuso.
- `rules/comentarios-e-logs.md` — templates de cabeçalho/função e padrão de log.

## Convenções rápidas

- Identificadores de código em **inglês**; comentários e textos de UI em **pt-BR**.
- UI nunca chama Supabase direto — só via `provider → repository`.
- Hardware (scanner, share, câmera) sempre atrás de um service abstrato (real + mock).
- Proibido no visual: degradê, brilho/sombra colorida, fonte cursiva. Filete > card.
