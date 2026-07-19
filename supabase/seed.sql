-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/seed.sql
-- O QUÊ:     Dados de DEV aplicados no `supabase db reset` (NUNCA em produção —
--            `db push` não roda seed). Usuário local de teste + porta fiel do
--            seed do app (recipe_seed.dart / recipe_versions_seed.dart): pastas,
--            técnicas canônicas, receitas com componentes, sabores e grifos.
-- LOGIN DEV: luca@pitada.dev via OTP — o código chega no Mailpit (localhost:54324).
-- ─────────────────────────────────────────────────────────────────────────────

-- ── Usuário local de teste (dispara handle_new_user -> profiles) ─────────────
insert into auth.users (
  instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
  confirmation_token, email_change, email_change_token_new, recovery_token
) values (
  '00000000-0000-0000-0000-000000000000',
  '11111111-1111-1111-1111-111111111111',
  'authenticated', 'authenticated', 'luca@pitada.dev',
  crypt('pitada-local', gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}', '{}', now(), now(),
  '', '', '', ''
);

insert into auth.identities (
  id, user_id, identity_data, provider, provider_id,
  last_sign_in_at, created_at, updated_at
) values (
  gen_random_uuid(), '11111111-1111-1111-1111-111111111111',
  '{"sub":"11111111-1111-1111-1111-111111111111","email":"luca@pitada.dev","email_verified":true}',
  'email', '11111111-1111-1111-1111-111111111111', now(), now(), now()
);

-- ── Pastas (kSeedFolders) ─────────────────────────────────────────────────────
insert into public.folders (id, user_id, name, hero_color, position) values
  ('aaaaaaaa-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'Marinadas de frango', 'terra', 0),
  ('aaaaaaaa-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'Jantares rápidos',    'teal',  1),
  ('aaaaaaaa-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'Fit',                 'moss',  2),
  ('aaaaaaaa-0000-0000-0000-000000000004', '11111111-1111-1111-1111-111111111111', 'Doces',               'plum',  3);

-- ── Técnicas canônicas (entidades por usuário; grifadas nos passos abaixo) ────
insert into public.techniques (id, user_id, slug, name) values
  ('dddddddd-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'selar',      'Selar a carne'),
  ('dddddddd-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'refogar',    'Refogar'),
  ('dddddddd-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'emulsionar', 'Emulsionar um molho');

-- ── Receitas ──────────────────────────────────────────────────────────────────
-- Frango xadrez: grupo de versões; a DEFINITIVA (v3) é dona do id canônico
-- (id = version_group_id); v1/v2 são linhas próprias no mesmo grupo.
insert into public.recipes (
  id, user_id, title, source, source_url, servings, time_minutes,
  kcal, protein, carb, fat, difficulty, hero_color,
  version, version_group_id
) values
  ('bbbbbbbb-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111',
   'Frango xadrez', 'instagram', 'https://instagram.com/reel/frango-xadrez', 4, 25,
   512, 42, 38, 18, 'Intermediário', 'terra',
   3, 'bbbbbbbb-0000-0000-0000-000000000001'),
  ('bbbbbbbb-0000-0000-0000-000000000011', '11111111-1111-1111-1111-111111111111',
   'Frango xadrez', 'instagram', 'https://instagram.com/reel/frango-xadrez', 4, 20,
   498, 40, 41, 16, 'Fácil', 'terra',
   1, 'bbbbbbbb-0000-0000-0000-000000000001'),
  ('bbbbbbbb-0000-0000-0000-000000000012', '11111111-1111-1111-1111-111111111111',
   'Frango xadrez', 'instagram', 'https://instagram.com/reel/frango-xadrez', 4, 25,
   520, 41, 40, 19, 'Intermediário', 'terra',
   2, 'bbbbbbbb-0000-0000-0000-000000000001'),
  ('bbbbbbbb-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111',
   'Bowl de quinoa', 'manual', null, 2, 15,
   438, 22, 54, 14, 'Fácil', 'moss', 1, null),
  ('bbbbbbbb-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111',
   'Strogonoff de carne', 'site', null, 4, 30,
   680, 38, 40, 34, 'Intermediário', 'rust',
   2, 'bbbbbbbb-0000-0000-0000-000000000003'),
  ('bbbbbbbb-0000-0000-0000-000000000031', '11111111-1111-1111-1111-111111111111',
   'Strogonoff de carne', 'site', null, 4, 25,
   700, 37, 42, 36, 'Fácil', 'rust',
   1, 'bbbbbbbb-0000-0000-0000-000000000003'),
  ('bbbbbbbb-0000-0000-0000-000000000004', '11111111-1111-1111-1111-111111111111',
   'Panqueca de banana', 'manual', null, 1, 10,
   286, 12, 44, 7, 'Fácil', 'ochre', 1, null);

-- ── Receita <-> pasta (só definitivas aparecem em pastas) ────────────────────
insert into public.recipe_folders (recipe_id, folder_id) values
  ('bbbbbbbb-0000-0000-0000-000000000001', 'aaaaaaaa-0000-0000-0000-000000000002'),
  ('bbbbbbbb-0000-0000-0000-000000000002', 'aaaaaaaa-0000-0000-0000-000000000003'),
  ('bbbbbbbb-0000-0000-0000-000000000003', 'aaaaaaaa-0000-0000-0000-000000000002'),
  ('bbbbbbbb-0000-0000-0000-000000000004', 'aaaaaaaa-0000-0000-0000-000000000004'),
  ('bbbbbbbb-0000-0000-0000-000000000004', 'aaaaaaaa-0000-0000-0000-000000000003');

-- ── Componentes do Strogonoff v3 definitivo (Base + Molho = sub-receitas) ─────
-- As demais receitas têm um único componente implícito (component_id null nas filhas).
insert into public.recipe_components (id, recipe_id, position, name) values
  ('eeeeeeee-0000-0000-0000-000000000001', 'bbbbbbbb-0000-0000-0000-000000000003', 0, 'Base'),
  ('eeeeeeee-0000-0000-0000-000000000002', 'bbbbbbbb-0000-0000-0000-000000000003', 1, 'Molho');

-- ── Ingredientes (grama é a base; humanQty/humanUnit = referência; flavors = função) ──
insert into public.recipe_ingredients (recipe_id, position, name, grams, human_qty, human_unit, flavors) values
  -- Frango xadrez v3 (definitiva)
  ('bbbbbbbb-0000-0000-0000-000000000001', 0, 'Peito de frango', 500, 500, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 1, 'Ovo', 80, 2, 'unidade', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 2, 'Pimentão', 120, 1, 'unidade', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 3, 'Shoyu', 45, 3, 'c. sopa', '{umami,salt}'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 4, 'Amendoim', 70, 0.5, 'xícara', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 5, 'Alho', 15, 3, 'dentes', '{}'),
  -- Frango xadrez v1
  ('bbbbbbbb-0000-0000-0000-000000000011', 0, 'Peito de frango', 500, 500, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000011', 1, 'Pimentão', 120, 1, 'unidade', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000011', 2, 'Shoyu', 60, 4, 'c. sopa', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000011', 3, 'Amendoim', 40, 0.3, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000011', 4, 'Alho', 15, 3, 'dentes', '{}'),
  -- Frango xadrez v2
  ('bbbbbbbb-0000-0000-0000-000000000012', 0, 'Peito de frango', 500, 500, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 1, 'Pimentão', 120, 1, 'unidade', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 2, 'Shoyu', 60, 4, 'c. sopa', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 3, 'Amendoim', 40, 0.3, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 4, 'Alho', 15, 3, 'dentes', '{}'),
  -- Bowl de quinoa
  ('bbbbbbbb-0000-0000-0000-000000000002', 0, 'Quinoa', 90, 0.5, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000002', 1, 'Grão-de-bico', 120, 120, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000002', 2, 'Abacate', 80, 0.5, 'unidade', '{fat}'),
  -- Strogonoff v1
  ('bbbbbbbb-0000-0000-0000-000000000031', 0, 'Alcatra', 500, 500, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000031', 1, 'Creme de leite', 200, 1, 'lata', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000031', 2, 'Champignon', 80, 80, 'g', '{}'),
  -- Panqueca de banana
  ('bbbbbbbb-0000-0000-0000-000000000004', 0, 'Banana', 120, 1, 'unidade', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000004', 1, 'Ovo', 100, 2, 'unidade', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000004', 2, 'Aveia', 30, 3, 'c. sopa', '{}');

-- Strogonoff v3 definitivo: ingredientes por componente (Base / Molho).
insert into public.recipe_ingredients (recipe_id, component_id, position, name, grams, human_qty, human_unit, flavors) values
  ('bbbbbbbb-0000-0000-0000-000000000003', 'eeeeeeee-0000-0000-0000-000000000001', 0, 'Alcatra', 500, 500, 'g', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000003', 'eeeeeeee-0000-0000-0000-000000000002', 1, 'Creme de leite', 200, 1, 'lata', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000003', 'eeeeeeee-0000-0000-0000-000000000002', 2, 'Champignon', 100, 100, 'g', '{umami}');

-- ── Passos (tip vira o callout "Por quê") ────────────────────────────────────
insert into public.recipe_steps (recipe_id, position, text, tip) values
  -- Frango xadrez v3
  ('bbbbbbbb-0000-0000-0000-000000000001', 0, 'Corte o frango em cubos e seque bem com papel-toalha.',
   'Frango seco doura em vez de cozinhar na própria água — mais sabor.'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 1, 'Sele os cubos em fogo alto, sem mexer demais, até dourar.',
   'Panela cheia demais esfria e cozinha; sele em levas.'),
  ('bbbbbbbb-0000-0000-0000-000000000001', 2, 'Refogue alho e pimentão rapidamente para manterem a crocância.', null),
  ('bbbbbbbb-0000-0000-0000-000000000001', 3, 'Volte o frango, junte o shoyu e o amendoim e finalize.',
   'O shoyu reduz e vira molho — desligue quando encorpar.'),
  -- Frango xadrez v1
  ('bbbbbbbb-0000-0000-0000-000000000011', 0, 'Corte o frango em cubos e pique o pimentão e o alho.', null),
  ('bbbbbbbb-0000-0000-0000-000000000011', 1, 'Junte tudo na panela de uma vez e cozinhe até o frango passar do ponto.',
   'Cozinhar tudo junto solta água — o molho fica ralo e o frango, cinza.'),
  ('bbbbbbbb-0000-0000-0000-000000000011', 2, 'Acerte o sal com o shoyu e finalize com o amendoim.', null),
  -- Frango xadrez v2
  ('bbbbbbbb-0000-0000-0000-000000000012', 0, 'Corte o frango em cubos e seque bem com papel-toalha.',
   'Frango seco doura em vez de cozinhar na própria água.'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 1, 'Sele os cubos em LEVAS, sem lotar a panela, até criar crosta.',
   'Panela cheia demais esfria e cozinha; sele em levas.'),
  ('bbbbbbbb-0000-0000-0000-000000000012', 2, 'Refogue o alho e o pimentão rapidamente.', null),
  ('bbbbbbbb-0000-0000-0000-000000000012', 3, 'Volte o frango, junte o shoyu e o amendoim e finalize.', null),
  -- Bowl de quinoa
  ('bbbbbbbb-0000-0000-0000-000000000002', 0, 'Cozinhe a quinoa e monte o bowl com os demais itens.', null),
  -- Strogonoff v1
  ('bbbbbbbb-0000-0000-0000-000000000031', 0, 'Sele a carne e refogue com cebola e mostarda.', null),
  ('bbbbbbbb-0000-0000-0000-000000000031', 1, 'Desligue o fogo e incorpore o creme de leite de lata.',
   'Creme de leite ferve e talha — junte fora do fogo.'),
  -- Panqueca de banana
  ('bbbbbbbb-0000-0000-0000-000000000004', 0, 'Amasse a banana, misture tudo e doure dos dois lados.', null);

-- Strogonoff v3 definitivo: passos por componente (Base / Molho).
insert into public.recipe_steps (recipe_id, component_id, position, text, tip) values
  ('bbbbbbbb-0000-0000-0000-000000000003', 'eeeeeeee-0000-0000-0000-000000000001', 0, 'Sele a carne em fogo alto, em levas.', null),
  ('bbbbbbbb-0000-0000-0000-000000000003', 'eeeeeeee-0000-0000-0000-000000000002', 1, 'Faça o molho e incorpore o creme de leite.', null);

-- ── Grifos técnica<->passo (anchor = trecho literal do passo a destacar) ──────
-- Casa o passo por (recipe_id, position) já que os ids das linhas são gerados.
insert into public.recipe_step_techniques (step_id, technique_id, anchor)
select s.id, v.technique_id, v.anchor
from (values
  ('bbbbbbbb-0000-0000-0000-000000000001'::uuid, 1, 'dddddddd-0000-0000-0000-000000000001'::uuid, 'Sele os cubos'),
  ('bbbbbbbb-0000-0000-0000-000000000001'::uuid, 2, 'dddddddd-0000-0000-0000-000000000002'::uuid, 'Refogue'),
  ('bbbbbbbb-0000-0000-0000-000000000003'::uuid, 0, 'dddddddd-0000-0000-0000-000000000001'::uuid, 'Sele a carne'),
  ('bbbbbbbb-0000-0000-0000-000000000003'::uuid, 1, 'dddddddd-0000-0000-0000-000000000003'::uuid, 'incorpore o creme de leite')
) as v(recipe_id, position, technique_id, anchor)
join public.recipe_steps s on s.recipe_id = v.recipe_id and s.position = v.position;

-- ── Subreceita COMPARTILHADA (sub_recipe_seed.dart): a cobertura + 2 bolos ────
-- Editar a cobertura propaga pros dois; o bolo de chocolate usa 1,5×.
insert into public.sub_recipes (id, user_id, name) values
  ('ffffffff-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111',
   'Cobertura de chocolate');

insert into public.sub_recipe_ingredients (sub_recipe_id, position, name, grams, human_qty, human_unit, flavors) values
  ('ffffffff-0000-0000-0000-000000000001', 0, 'Manteiga', 15, 1, 'c. sopa', '{fat}'),
  ('ffffffff-0000-0000-0000-000000000001', 1, 'Chocolate em pó', 30, 3, 'c. sopa', '{bitter,sweet}'),
  ('ffffffff-0000-0000-0000-000000000001', 2, 'Açúcar', 90, 0.5, 'xícara', '{sweet}'),
  ('ffffffff-0000-0000-0000-000000000001', 3, 'Leite', 60, 60, 'ml', '{}');

insert into public.sub_recipe_steps (sub_recipe_id, position, text, tip) values
  ('ffffffff-0000-0000-0000-000000000001', 0, 'Derreta a manteiga com o chocolate em pó em fogo baixo.', null),
  ('ffffffff-0000-0000-0000-000000000001', 1, 'Junte o leite e o açúcar e mexa até encorpar; cubra o bolo.',
   'Calda ganha brilho no bolo ainda morno — não espere esfriar.');

insert into public.recipes (
  id, user_id, title, source, source_url, servings, time_minutes,
  kcal, protein, carb, fat, difficulty, hero_color, version, version_group_id
) values
  ('bbbbbbbb-0000-0000-0000-000000000005', '11111111-1111-1111-1111-111111111111',
   'Bolo de cenoura', 'manual', null, 12, 50, 385, 5, 52, 17, 'Fácil', 'ochre', 1, null),
  ('bbbbbbbb-0000-0000-0000-000000000006', '11111111-1111-1111-1111-111111111111',
   'Bolo de chocolate', 'manual', null, 10, 45, 410, 6, 55, 19, 'Fácil', 'rust', 1, null);

insert into public.recipe_folders (recipe_id, folder_id) values
  ('bbbbbbbb-0000-0000-0000-000000000005', 'aaaaaaaa-0000-0000-0000-000000000004'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'aaaaaaaa-0000-0000-0000-000000000004');

-- Massa local + vínculo com a cobertura (name null no vínculo; scale por uso).
insert into public.recipe_components (id, recipe_id, position, name, sub_recipe_id, scale) values
  ('eeeeeeee-0000-0000-0000-000000000003', 'bbbbbbbb-0000-0000-0000-000000000005', 0, 'Massa', null, 1),
  ('eeeeeeee-0000-0000-0000-000000000004', 'bbbbbbbb-0000-0000-0000-000000000005', 1, null,
   'ffffffff-0000-0000-0000-000000000001', 1),
  ('eeeeeeee-0000-0000-0000-000000000005', 'bbbbbbbb-0000-0000-0000-000000000006', 0, 'Massa', null, 1),
  ('eeeeeeee-0000-0000-0000-000000000006', 'bbbbbbbb-0000-0000-0000-000000000006', 1, null,
   'ffffffff-0000-0000-0000-000000000001', 1.5);

insert into public.recipe_ingredients (recipe_id, component_id, position, name, grams, human_qty, human_unit, flavors) values
  -- Bolo de cenoura: Massa
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 0, 'Óleo', 100, 0.5, 'xícara', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 1, 'Cenouras médias', 250, 3, 'unidade', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 2, 'Ovos', 200, 4, 'unidade', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 3, 'Açúcar', 360, 2, 'xícara', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 4, 'Farinha de trigo', 300, 2.5, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 5, 'Fermento em pó', 15, 1, 'c. sopa', '{}'),
  -- Bolo de chocolate: Massa
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 0, 'Farinha de trigo', 240, 2, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 1, 'Chocolate em pó', 90, 1, 'xícara', '{bitter}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 2, 'Açúcar', 270, 1.5, 'xícara', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 3, 'Ovos', 150, 3, 'unidade', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 4, 'Leite', 240, 1, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 5, 'Óleo', 100, 0.5, 'xícara', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 6, 'Fermento em pó', 15, 1, 'c. sopa', '{}');

insert into public.recipe_steps (recipe_id, component_id, position, text, tip) values
  -- Bolo de cenoura: Massa
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 0,
   'Bata no liquidificador as cenouras, os ovos e o óleo.', null),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 1,
   'Misture o açúcar e a farinha; o fermento vai por último.',
   'Fermento por último e sem bater: bater demais tira o ar.'),
  ('bbbbbbbb-0000-0000-0000-000000000005', 'eeeeeeee-0000-0000-0000-000000000003', 2,
   'Asse em forma untada a 180 °C por 40 minutos.', null),
  -- Bolo de chocolate: Massa
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 0,
   'Misture os secos: farinha, chocolate, açúcar e fermento.', null),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 1,
   'Junte ovos, leite e óleo e bata até ficar liso.', null),
  ('bbbbbbbb-0000-0000-0000-000000000006', 'eeeeeeee-0000-0000-0000-000000000005', 2,
   'Asse a 180 °C por 35 minutos.', null);

-- ── Demo do UNIFICAR (unify_demo_seed.dart): coberturas LOCAIS parecidas ──────
insert into public.recipes (
  id, user_id, title, source, source_url, servings, time_minutes,
  kcal, protein, carb, fat, difficulty, hero_color, version, version_group_id
) values
  ('bbbbbbbb-0000-0000-0000-000000000007', '11111111-1111-1111-1111-111111111111',
   'Bolo formigueiro', 'instagram', 'https://instagram.com/reel/bolo-formigueiro',
   12, 55, 395, 6, 50, 18, 'Fácil', 'plum', 1, null),
  ('bbbbbbbb-0000-0000-0000-000000000008', '11111111-1111-1111-1111-111111111111',
   'Nega maluca', 'site', 'https://receitas.com/nega-maluca',
   10, 45, 420, 6, 56, 20, 'Fácil', 'clay', 1, null);

insert into public.recipe_folders (recipe_id, folder_id) values
  ('bbbbbbbb-0000-0000-0000-000000000007', 'aaaaaaaa-0000-0000-0000-000000000004'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'aaaaaaaa-0000-0000-0000-000000000004');

insert into public.recipe_components (id, recipe_id, position, name) values
  ('eeeeeeee-0000-0000-0000-000000000007', 'bbbbbbbb-0000-0000-0000-000000000007', 0, 'Massa'),
  ('eeeeeeee-0000-0000-0000-000000000008', 'bbbbbbbb-0000-0000-0000-000000000007', 1, 'Cobertura de chocolate'),
  ('eeeeeeee-0000-0000-0000-000000000009', 'bbbbbbbb-0000-0000-0000-000000000008', 0, 'Massa'),
  ('eeeeeeee-0000-0000-0000-000000000010', 'bbbbbbbb-0000-0000-0000-000000000008', 1, 'Cobertura de chocolate');

insert into public.recipe_ingredients (recipe_id, component_id, position, name, grams, human_qty, human_unit, flavors) values
  -- Formigueiro: Massa
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 0, 'Ovos', 150, 3, 'unidade', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 1, 'Açúcar', 270, 1.5, 'xícara', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 2, 'Farinha de trigo', 300, 2.5, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 3, 'Granulado', 80, 0.5, 'xícara', '{sweet}'),
  -- Formigueiro: Cobertura local
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000008', 4, 'Manteiga', 20, 1.5, 'c. sopa', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000008', 5, 'Chocolate em pó', 40, 4, 'c. sopa', '{bitter,sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000008', 6, 'Açúcar', 120, 0.7, 'xícara', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000008', 7, 'Granulado', 50, 0.3, 'xícara', '{sweet}'),
  -- Nega maluca: Massa
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 0, 'Ovos', 150, 3, 'unidade', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 1, 'Chocolate em pó', 90, 1, 'xícara', '{bitter}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 2, 'Farinha de trigo', 240, 2, 'xícara', '{}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 3, 'Água quente', 240, 1, 'xícara', '{}'),
  -- Nega maluca: Cobertura local
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000010', 4, 'Manteiga', 15, 1, 'c. sopa', '{fat}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000010', 5, 'Chocolate em pó', 30, 3, 'c. sopa', '{bitter,sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000010', 6, 'Açúcar', 90, 0.5, 'xícara', '{sweet}'),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000010', 7, 'Leite', 60, 60, 'ml', '{}');

insert into public.recipe_steps (recipe_id, component_id, position, text, tip) values
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 0,
   'Bata ovos, açúcar e a manteiga; junte os secos.', null),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000007', 1,
   'Envolva o granulado por último e asse a 180 °C por 40 min.',
   'Granulado enfarinhado não afunda na massa.'),
  ('bbbbbbbb-0000-0000-0000-000000000007', 'eeeeeeee-0000-0000-0000-000000000008', 2,
   'Derreta tudo em fogo baixo e cubra o bolo.', null),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 0,
   'Misture tudo e bata até a massa ficar lisa.', null),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000009', 1,
   'Asse a 180 °C por 35 minutos.', null),
  ('bbbbbbbb-0000-0000-0000-000000000008', 'eeeeeeee-0000-0000-0000-000000000010', 2,
   'Leve tudo ao fogo mexendo até encorpar; despeje quente.',
   'Calda quente escorre e cobre por igual.');
