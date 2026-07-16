-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120008_portion_hints.sql
-- O QUÊ:     Medidas caseiras → gramas. Conversões FIXAS ("um copo" ~200 g) que a
--            Edge Function injeta no prompt do Gemini para as estimativas de porção
--            ficarem estáveis entre chamadas (eixo "porção → gramas").
-- USA:       —
-- USADO POR: gemini.ts (estimate-food) via RPC/leitura de portion_hints.
-- SPEC:      specs/backend/database.yaml (migration 0008_portion_hints.sql)
-- ─────────────────────────────────────────────────────────────────────────────

create table public.portion_hints (
  id    uuid primary key default gen_random_uuid(),
  term  text    not null unique,   -- frase de medida caseira
  grams numeric not null,          -- equivalência em gramas (ml ≈ g p/ líquidos)
  note  text
);

alter table public.portion_hints enable row level security;
create policy portion_hints_read_authenticated on public.portion_hints
  for select to authenticated using (true);
-- A Edge Function lê direto (PostgREST) com a service role, que precisa do GRANT
-- de tabela (RLS ela ignora, privilégio não). anon/authenticated p/ leitura pelo app.
grant select on public.portion_hints to anon, authenticated, service_role;

-- Medidas caseiras comuns no Brasil (referência; a IA ajusta pelo alimento quando faz sentido).
insert into public.portion_hints (term, grams, note) values
  ('copo', 200, 'líquido, copo americano ~200ml'),
  ('copo grande', 300, 'líquido'),
  ('xícara', 240, 'líquido ou volume; sólidos variam'),
  ('meia xícara', 120, null),
  ('colher de sopa', 15, 'cheia; líquidos/pastosos'),
  ('colher de sopa (rasa)', 10, null),
  ('colher de chá', 5, null),
  ('colher (genérica)', 15, 'assume colher de sopa'),
  ('concha', 120, 'sopa/feijão'),
  ('scoop', 30, 'assume dosador de suplemento'),
  ('fatia de pão de forma', 25, null),
  ('fatia de pão francês', 25, 'metade de um pão de 50g'),
  ('fatia de queijo', 20, null),
  ('unidade de ovo', 50, 'ovo de galinha médio'),
  ('banana prata pequena', 70, null),
  ('banana nanica média', 100, null),
  ('maçã média', 130, null),
  ('pão francês', 50, 'unidade'),
  ('prato raso', 250, 'refeição servida'),
  ('punhado', 30, 'castanhas/granola'),
  ('lata (creme de leite)', 200, null),
  ('lata (refrigerante)', 350, 'ml'),
  ('garrafa (refrigerante)', 600, 'ml'),
  ('pote de iogurte', 170, 'individual'),
  -- Porções-padrão de ADITIVOS (chave = nome canônico do alimento): quando o usuário
  -- cita sem quantidade ("leite com toddy"), o resolvedor usa isto em vez de chutar 100g.
  ('achocolatado em pó', 20, 'porção típica sobre leite'),
  ('toddy em pó', 20, null),
  ('nescau', 20, null),
  ('açúcar', 5, 'colher de chá'),
  ('mel', 20, null),
  ('azeite', 8, 'fio/colher'),
  ('manteiga', 10, null),
  ('requeijão', 30, null),
  ('whey protein', 30, 'dose padrão quando sem scoop'),
  -- Aliases de UNIDADE de uma palavra (o parser singulariza plural: scoops→scoop).
  ('colher', 15, 'assume colher de sopa'),
  ('fatia', 25, null),
  ('dose', 30, null),
  ('prato', 250, null),
  ('lata', 350, 'assume lata de bebida'),
  ('garrafa', 600, null),
  -- Chaves coloquiais bare: citado sem quantidade, assume uma porção típica (flagado).
  ('toddy', 20, null),
  ('achocolatado', 20, null);
