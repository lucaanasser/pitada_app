-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260715120009_foods_ibge_seed.sql
-- O QUÊ:     1962 alimentos "como consumidos" do IBGE POF na tabela foods
--            (source='ibge', por 100 g). GERADO por gen_ibge_sql.mjs — NÃO editar.
-- FONTE:     IBGE POF 2008-2009, Tabela de Composição Nutricional dos Alimentos
--            Consumidos no Brasil (dado público). XLS: ftp.ibge.gov.br → extraído
--            p/ supabase/seed/ibge_pof.csv (Python/xlrd) → este SQL.
-- USADO POR: search_foods() / Edge Function estimate-food.
-- SPEC:      specs/backend/database.yaml (migration 0009_foods_ibge_seed.sql)
-- ─────────────────────────────────────────────────────────────────────────────
insert into public.foods
  (source, ext_id, name, name_norm, category, kcal, protein, carb, fat, fiber)
values
  ('ibge', 630010199, 'ARROZ (POLIDO, PARBOILIZADO, AGULHA, AGULHINHA, ETC)', unaccent(lower('ARROZ (POLIDO, PARBOILIZADO, AGULHA, AGULHINHA, ETC)')), 'Preparações', 135.62, 2.5, 27.78, 1.2, 1.55),
  ('ibge', 630020199, 'ARROZ INTEGRAL', unaccent(lower('ARROZ INTEGRAL')), 'Preparações', 130.95, 2.56, 25.56, 1.97, 2.72),
  ('ibge', 630070101, 'MILHO (EM GRAO) - CRU(A)', unaccent(lower('MILHO (EM GRAO) - CRU(A)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070102, 'MILHO (EM GRAO) - COZIDO(A)', unaccent(lower('MILHO (EM GRAO) - COZIDO(A)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070103, 'MILHO (EM GRAO) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('MILHO (EM GRAO) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070104, 'MILHO (EM GRAO) - ASSADO(A)', unaccent(lower('MILHO (EM GRAO) - ASSADO(A)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070107, 'MILHO (EM GRAO) - REFOGADO(A)', unaccent(lower('MILHO (EM GRAO) - REFOGADO(A)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070113, 'MILHO (EM GRAO) - ENSOPADO', unaccent(lower('MILHO (EM GRAO) - ENSOPADO')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070199, 'MILHO (EM GRAO)', unaccent(lower('MILHO (EM GRAO)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 630070601, 'CANJIQUINHA DE MILHO EM GRAO - CRU(A)', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO - CRU(A)')), 'Preparações', 79.68, 1.24, 13.5, 2.2, 0.67),
  ('ibge', 630070602, 'CANJIQUINHA DE MILHO EM GRAO - COZIDO(A)', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO - COZIDO(A)')), 'Preparações', 62.95, 1.24, 13.5, 0.3, 0.67),
  ('ibge', 630070613, 'CANJIQUINHA DE MILHO EM GRAO - ENSOPADO', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO - ENSOPADO')), 'Preparações', 79.68, 1.24, 13.5, 2.2, 0.67),
  ('ibge', 630070614, 'CANJIQUINHA DE MILHO EM GRAO - MINGAU', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO - MINGAU')), 'Preparações', 62.95, 1.24, 13.5, 0.3, 0.67),
  ('ibge', 630070615, 'CANJIQUINHA DE MILHO EM GRAO - SOPA', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 630070699, 'CANJIQUINHA DE MILHO EM GRAO', unaccent(lower('CANJIQUINHA DE MILHO EM GRAO')), 'Preparações', 62.95, 1.24, 13.5, 0.3, 0.67),
  ('ibge', 630070799, 'XEREM DE MILHO', unaccent(lower('XEREM DE MILHO')), 'Preparações', 62.95, 1.24, 13.5, 0.3, 0.67),
  ('ibge', 630100199, 'AMENDOIM (EM GRAO) (IN NATURA)', unaccent(lower('AMENDOIM (EM GRAO) (IN NATURA)')), 'Preparações', 567.0, 25.8, 16.13, 49.24, 8.5),
  ('ibge', 630110199, 'ERVILHA EM GRAO', unaccent(lower('ERVILHA EM GRAO')), 'Preparações', 109.09, 5.36, 15.63, 3.06, 5.5),
  ('ibge', 630120199, 'FAVA (EM GRAO)', unaccent(lower('FAVA (EM GRAO)')), 'Preparações', 85.62, 4.8, 10.1, 3.17, 3.6),
  ('ibge', 630120499, 'MANGALO AMARGO EM GRAO', unaccent(lower('MANGALO AMARGO EM GRAO')), 'Preparações', 85.62, 4.8, 10.1, 3.17, 3.6),
  ('ibge', 630160399, 'FEIJAO DE CORDA', unaccent(lower('FEIJAO DE CORDA')), 'Preparações', 121.33, 3.17, 20.32, 3.13, 5.0),
  ('ibge', 630163499, 'FEIJAO VERDE', unaccent(lower('FEIJAO VERDE')), 'Preparações', 121.33, 3.17, 20.32, 3.13, 5.0),
  ('ibge', 630200199, 'SEMENTE DE LINHACA', unaccent(lower('SEMENTE DE LINHACA')), 'Preparações', 534.0, 18.29, 28.88, 42.16, 27.3),
  ('ibge', 630260299, 'ANDU', unaccent(lower('ANDU')), 'Preparações', 97.41, 5.84, 15.05, 1.79, 3.78),
  ('ibge', 630280199, 'GRAO DE BICO', unaccent(lower('GRAO DE BICO')), 'Preparações', 188.48, 8.86, 27.42, 5.36, 7.6),
  ('ibge', 630290199, 'LENTILHA', unaccent(lower('LENTILHA')), 'Preparações', 136.28, 9.02, 20.13, 2.67, 5.86),
  ('ibge', 630300199, 'SOJA EM GRAO', unaccent(lower('SOJA EM GRAO')), 'Preparações', 196.34, 16.64, 9.93, 11.61, 6.0),
  ('ibge', 630310299, 'FEIJAO (PRETO, MULATINHO, ROXO, ROSINHA, ETC)', unaccent(lower('FEIJAO (PRETO, MULATINHO, ROXO, ROSINHA, ETC)')), 'Preparações', 97.41, 5.84, 15.05, 1.79, 3.78),
  ('ibge', 630350199, 'QUIRERA NAO ESPECIFICADA', unaccent(lower('QUIRERA NAO ESPECIFICADA')), 'Preparações', 62.95, 1.24, 13.5, 0.3, 0.67),
  ('ibge', 630403499, 'FEIJAO VERDE ORGANICO', unaccent(lower('FEIJAO VERDE ORGANICO')), 'Preparações', 121.33, 3.17, 20.32, 3.13, 5.0),
  ('ibge', 630410199, 'FEIJAO ORGANICO', unaccent(lower('FEIJAO ORGANICO')), 'Preparações', 97.41, 5.84, 15.05, 1.79, 3.78),
  ('ibge', 630420199, 'PIPOCA  LIGHT', unaccent(lower('PIPOCA  LIGHT')), 'Preparações', 445.94, 10.77, 64.85, 17.78, 12.07),
  ('ibge', 630430199, 'ARROZ  ORGANICO', unaccent(lower('ARROZ  ORGANICO')), 'Preparações', 135.62, 2.5, 27.78, 1.2, 1.55),
  ('ibge', 630440199, 'ARROZ INTEGRAL ORGANICO', unaccent(lower('ARROZ INTEGRAL ORGANICO')), 'Preparações', 130.95, 2.56, 25.56, 1.97, 2.72),
  ('ibge', 630460299, 'FEIJAO SOJA ORGANICO', unaccent(lower('FEIJAO SOJA ORGANICO')), 'Preparações', 196.34, 16.64, 9.93, 11.61, 6.0),
  ('ibge', 630490199, 'QUINOA', unaccent(lower('QUINOA')), 'Preparações', 135.47, 4.37, 19.83, 4.33, 2.16),
  ('ibge', 640010101, 'BATATA-INGLESA - CRU(A)', unaccent(lower('BATATA-INGLESA - CRU(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640010102, 'BATATA-INGLESA - COZIDO(A)', unaccent(lower('BATATA-INGLESA - COZIDO(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640010103, 'BATATA-INGLESA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('BATATA-INGLESA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640010104, 'BATATA-INGLESA - ASSADO(A)', unaccent(lower('BATATA-INGLESA - ASSADO(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640010105, 'BATATA-INGLESA - FRITO(A)', unaccent(lower('BATATA-INGLESA - FRITO(A)')), 'Preparações', 263.5, 2.87, 33.6, 13.64, 3.44),
  ('ibge', 640010107, 'BATATA-INGLESA - REFOGADO(A)', unaccent(lower('BATATA-INGLESA - REFOGADO(A)')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640010108, 'BATATA-INGLESA - MOLHO VERMELHO', unaccent(lower('BATATA-INGLESA - MOLHO VERMELHO')), 'Preparações', 73.6, 1.63, 17.08, 0.12, 1.94),
  ('ibge', 640010109, 'BATATA-INGLESA - MOLHO BRANCO', unaccent(lower('BATATA-INGLESA - MOLHO BRANCO')), 'Preparações', 101.39, 2.15, 17.86, 2.57, 1.68),
  ('ibge', 640010110, 'BATATA-INGLESA - AO ALHO E OLEO', unaccent(lower('BATATA-INGLESA - AO ALHO E OLEO')), 'Preparações', 263.5, 2.87, 33.6, 13.64, 3.44),
  ('ibge', 640010111, 'BATATA-INGLESA - COM MANTEIGA/OLEO', unaccent(lower('BATATA-INGLESA - COM MANTEIGA/OLEO')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640010113, 'BATATA-INGLESA - ENSOPADO', unaccent(lower('BATATA-INGLESA - ENSOPADO')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640010115, 'BATATA-INGLESA - SOPA', unaccent(lower('BATATA-INGLESA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640010199, 'BATATA-INGLESA', unaccent(lower('BATATA-INGLESA')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640030302, 'MANDIOQUINHA SALSA (BATATA BAROA) - COZIDO(A)', unaccent(lower('MANDIOQUINHA SALSA (BATATA BAROA) - COZIDO(A)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640030307, 'MANDIOQUINHA SALSA (BATATA BAROA) - REFOGADO(A)', unaccent(lower('MANDIOQUINHA SALSA (BATATA BAROA) - REFOGADO(A)')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640030313, 'MANDIOQUINHA SALSA (BATATA BAROA) - ENSOPADO', unaccent(lower('MANDIOQUINHA SALSA (BATATA BAROA) - ENSOPADO')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640030399, 'MANDIOQUINHA SALSA (BATATA BAROA)', unaccent(lower('MANDIOQUINHA SALSA (BATATA BAROA)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640030499, 'CENOURA AMARELA (BATATA BAROA)', unaccent(lower('CENOURA AMARELA (BATATA BAROA)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640040101, 'BATATA DOCE - CRU(A)', unaccent(lower('BATATA DOCE - CRU(A)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640040102, 'BATATA DOCE - COZIDO(A)', unaccent(lower('BATATA DOCE - COZIDO(A)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640040104, 'BATATA DOCE - ASSADO(A)', unaccent(lower('BATATA DOCE - ASSADO(A)')), 'Preparações', 90.0, 2.01, 20.71, 0.15, 3.3),
  ('ibge', 640040105, 'BATATA DOCE - FRITO(A)', unaccent(lower('BATATA DOCE - FRITO(A)')), 'Preparações', 351.28, 4.4, 56.88, 12.59, 8.03),
  ('ibge', 640040107, 'BATATA DOCE - REFOGADO(A)', unaccent(lower('BATATA DOCE - REFOGADO(A)')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640040113, 'BATATA DOCE - ENSOPADO', unaccent(lower('BATATA DOCE - ENSOPADO')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640040199, 'BATATA DOCE', unaccent(lower('BATATA DOCE')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640050101, 'INHAME - CRU(A)', unaccent(lower('INHAME - CRU(A)')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640050102, 'INHAME - COZIDO(A)', unaccent(lower('INHAME - COZIDO(A)')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640050104, 'INHAME - ASSADO(A)', unaccent(lower('INHAME - ASSADO(A)')), 'Preparações', 90.0, 2.01, 20.71, 0.15, 3.3),
  ('ibge', 640050105, 'INHAME - FRITO(A)', unaccent(lower('INHAME - FRITO(A)')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640050107, 'INHAME - REFOGADO(A)', unaccent(lower('INHAME - REFOGADO(A)')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640050113, 'INHAME - ENSOPADO', unaccent(lower('INHAME - ENSOPADO')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640050115, 'INHAME - SOPA', unaccent(lower('INHAME - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640050899, 'QUICARE', unaccent(lower('QUICARE')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640060101, 'MANDIOCA - CRU(A)', unaccent(lower('MANDIOCA - CRU(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060102, 'MANDIOCA - COZIDO(A)', unaccent(lower('MANDIOCA - COZIDO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060104, 'MANDIOCA - ASSADO(A)', unaccent(lower('MANDIOCA - ASSADO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060105, 'MANDIOCA - FRITO(A)', unaccent(lower('MANDIOCA - FRITO(A)')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060107, 'MANDIOCA - REFOGADO(A)', unaccent(lower('MANDIOCA - REFOGADO(A)')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060108, 'MANDIOCA - MOLHO VERMELHO', unaccent(lower('MANDIOCA - MOLHO VERMELHO')), 'Preparações', 104.8, 0.74, 25.16, 0.28, 1.58),
  ('ibge', 640060111, 'MANDIOCA - COM MANTEIGA/OLEO', unaccent(lower('MANDIOCA - COM MANTEIGA/OLEO')), 'Preparações', 154.6, 0.61, 28.6, 4.34, 1.52),
  ('ibge', 640060113, 'MANDIOCA - ENSOPADO', unaccent(lower('MANDIOCA - ENSOPADO')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060115, 'MANDIOCA - SOPA', unaccent(lower('MANDIOCA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640060199, 'MANDIOCA', unaccent(lower('MANDIOCA')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060902, 'AIPIM - COZIDO(A)', unaccent(lower('AIPIM - COZIDO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060904, 'AIPIM - ASSADO(A)', unaccent(lower('AIPIM - ASSADO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640060905, 'AIPIM - FRITO(A)', unaccent(lower('AIPIM - FRITO(A)')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060906, 'AIPIM - EMPANADO(A)/A MILANESA', unaccent(lower('AIPIM - EMPANADO(A)/A MILANESA')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060907, 'AIPIM - REFOGADO(A)', unaccent(lower('AIPIM - REFOGADO(A)')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060908, 'AIPIM - MOLHO VERMELHO', unaccent(lower('AIPIM - MOLHO VERMELHO')), 'Preparações', 104.8, 0.74, 25.16, 0.28, 1.58),
  ('ibge', 640060911, 'AIPIM - COM MANTEIGA/OLEO', unaccent(lower('AIPIM - COM MANTEIGA/OLEO')), 'Preparações', 154.6, 0.61, 28.6, 4.34, 1.52),
  ('ibge', 640060913, 'AIPIM - ENSOPADO', unaccent(lower('AIPIM - ENSOPADO')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640060915, 'AIPIM - SOPA', unaccent(lower('AIPIM - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640060999, 'AIPIM', unaccent(lower('AIPIM')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640061001, 'MACAXEIRA - CRU(A)', unaccent(lower('MACAXEIRA - CRU(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640061002, 'MACAXEIRA - COZIDO(A)', unaccent(lower('MACAXEIRA - COZIDO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640061004, 'MACAXEIRA - ASSADO(A)', unaccent(lower('MACAXEIRA - ASSADO(A)')), 'Preparações', 125.0, 0.6, 30.1, 0.3, 1.6),
  ('ibge', 640061005, 'MACAXEIRA - FRITO(A)', unaccent(lower('MACAXEIRA - FRITO(A)')), 'Preparações', 162.74, 0.57, 28.59, 5.26, 1.52),
  ('ibge', 640070102, 'CARA - COZIDO(A)', unaccent(lower('CARA - COZIDO(A)')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640070105, 'CARA - FRITO(A)', unaccent(lower('CARA - FRITO(A)')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640070107, 'CARA - REFOGADO(A)', unaccent(lower('CARA - REFOGADO(A)')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640070113, 'CARA - ENSOPADO', unaccent(lower('CARA - ENSOPADO')), 'Preparações', 115.74, 1.71, 23.4, 1.9, 1.8),
  ('ibge', 640070114, 'CARA - MINGAU', unaccent(lower('CARA - MINGAU')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640070115, 'CARA - SOPA', unaccent(lower('CARA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640071302, 'INHAME CARAQUENTO (CARA) - COZIDO(A)', unaccent(lower('INHAME CARAQUENTO (CARA) - COZIDO(A)')), 'Preparações', 100.0, 1.71, 23.4, 0.12, 1.8),
  ('ibge', 640080201, 'BATATA (NÃO ESPECIFICADA) - CRU(A)', unaccent(lower('BATATA (NÃO ESPECIFICADA) - CRU(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640080202, 'BATATA (NÃO ESPECIFICADA) - COZIDO(A)', unaccent(lower('BATATA (NÃO ESPECIFICADA) - COZIDO(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640080203, 'BATATA (NÃO ESPECIFICADA) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('BATATA (NÃO ESPECIFICADA) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640080204, 'BATATA (NÃO ESPECIFICADA) - ASSADO(A)', unaccent(lower('BATATA (NÃO ESPECIFICADA) - ASSADO(A)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640080205, 'BATATA (NÃO ESPECIFICADA) - FRITO(A)', unaccent(lower('BATATA (NÃO ESPECIFICADA) - FRITO(A)')), 'Preparações', 263.5, 2.87, 33.6, 13.64, 3.44),
  ('ibge', 640080207, 'BATATA (NÃO ESPECIFICADA) - REFOGADO(A)', unaccent(lower('BATATA (NÃO ESPECIFICADA) - REFOGADO(A)')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640080208, 'BATATA (NÃO ESPECIFICADA) - MOLHO VERMELHO', unaccent(lower('BATATA (NÃO ESPECIFICADA) - MOLHO VERMELHO')), 'Preparações', 73.6, 1.63, 17.08, 0.12, 1.94),
  ('ibge', 640080209, 'BATATA (NÃO ESPECIFICADA) - MOLHO BRANCO', unaccent(lower('BATATA (NÃO ESPECIFICADA) - MOLHO BRANCO')), 'Preparações', 101.39, 2.15, 17.86, 2.57, 1.68),
  ('ibge', 640080212, 'BATATA (NÃO ESPECIFICADA) - AO VINAGRETE', unaccent(lower('BATATA (NÃO ESPECIFICADA) - AO VINAGRETE')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640080213, 'BATATA (NÃO ESPECIFICADA) - ENSOPADO', unaccent(lower('BATATA (NÃO ESPECIFICADA) - ENSOPADO')), 'Preparações', 111.74, 1.71, 20.01, 3.01, 2.05),
  ('ibge', 640080215, 'BATATA (NÃO ESPECIFICADA) - SOPA', unaccent(lower('BATATA (NÃO ESPECIFICADA) - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640080299, 'BATATA (NÃO ESPECIFICADA)', unaccent(lower('BATATA (NÃO ESPECIFICADA)')), 'Preparações', 86.0, 1.71, 20.01, 0.1, 2.05),
  ('ibge', 640090802, 'MANDIOQUINHA - COZIDO(A)', unaccent(lower('MANDIOQUINHA - COZIDO(A)')), 'Preparações', 76.0, 1.37, 17.72, 0.14, 2.5),
  ('ibge', 640090805, 'MANDIOQUINHA - FRITO(A)', unaccent(lower('MANDIOQUINHA - FRITO(A)')), 'Preparações', 116.4, 1.3, 16.83, 5.13, 2.38),
  ('ibge', 640090807, 'MANDIOQUINHA - REFOGADO(A)', unaccent(lower('MANDIOQUINHA - REFOGADO(A)')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640090813, 'MANDIOQUINHA - ENSOPADO', unaccent(lower('MANDIOQUINHA - ENSOPADO')), 'Preparações', 91.74, 1.37, 17.72, 1.92, 2.5),
  ('ibge', 640100101, 'RABANETE - CRU(A)', unaccent(lower('RABANETE - CRU(A)')), 'Preparações', 16.0, 0.68, 3.4, 0.1, 1.6),
  ('ibge', 640100102, 'RABANETE - COZIDO(A)', unaccent(lower('RABANETE - COZIDO(A)')), 'Preparações', 18.0, 0.6, 4.1, 0.1, 1.6),
  ('ibge', 640100112, 'RABANETE - AO VINAGRETE', unaccent(lower('RABANETE - AO VINAGRETE')), 'Preparações', 18.0, 0.6, 4.1, 0.1, 1.6),
  ('ibge', 640110101, 'BETERRABA - CRU(A)', unaccent(lower('BETERRABA - CRU(A)')), 'Preparações', 43.0, 1.61, 9.56, 0.17, 2.8),
  ('ibge', 640110102, 'BETERRABA - COZIDO(A)', unaccent(lower('BETERRABA - COZIDO(A)')), 'Preparações', 44.0, 1.68, 9.96, 0.18, 2.0),
  ('ibge', 640110107, 'BETERRABA - REFOGADO(A)', unaccent(lower('BETERRABA - REFOGADO(A)')), 'Preparações', 67.62, 1.68, 9.96, 2.85, 2.0),
  ('ibge', 640110112, 'BETERRABA - AO VINAGRETE', unaccent(lower('BETERRABA - AO VINAGRETE')), 'Preparações', 44.0, 1.68, 9.96, 0.18, 2.0),
  ('ibge', 640110115, 'BETERRABA - SOPA', unaccent(lower('BETERRABA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640110199, 'BETERRABA', unaccent(lower('BETERRABA')), 'Preparações', 43.0, 1.61, 9.56, 0.17, 2.8),
  ('ibge', 640120101, 'CENOURA - CRU(A)', unaccent(lower('CENOURA - CRU(A)')), 'Preparações', 41.0, 0.93, 9.58, 0.24, 2.8),
  ('ibge', 640120102, 'CENOURA - COZIDO(A)', unaccent(lower('CENOURA - COZIDO(A)')), 'Preparações', 35.0, 0.76, 8.22, 0.18, 3.0),
  ('ibge', 640120105, 'CENOURA - FRITO(A)', unaccent(lower('CENOURA - FRITO(A)')), 'Preparações', 60.47, 0.74, 7.97, 3.17, 2.91),
  ('ibge', 640120107, 'CENOURA - REFOGADO(A)', unaccent(lower('CENOURA - REFOGADO(A)')), 'Preparações', 60.47, 0.74, 7.97, 3.17, 2.91),
  ('ibge', 640120108, 'CENOURA - MOLHO VERMELHO', unaccent(lower('CENOURA - MOLHO VERMELHO')), 'Preparações', 32.8, 0.87, 7.65, 0.18, 2.7),
  ('ibge', 640120110, 'CENOURA - AO ALHO E OLEO', unaccent(lower('CENOURA - AO ALHO E OLEO')), 'Preparações', 60.47, 0.74, 7.97, 3.17, 2.91),
  ('ibge', 640120111, 'CENOURA - COM MANTEIGA/OLEO', unaccent(lower('CENOURA - COM MANTEIGA/OLEO')), 'Preparações', 56.74, 0.79, 8.22, 2.64, 3.0),
  ('ibge', 640120112, 'CENOURA - AO VINAGRETE', unaccent(lower('CENOURA - AO VINAGRETE')), 'Preparações', 35.0, 0.76, 8.22, 0.18, 3.0),
  ('ibge', 640120113, 'CENOURA - ENSOPADO', unaccent(lower('CENOURA - ENSOPADO')), 'Preparações', 60.47, 0.74, 7.97, 3.17, 2.91),
  ('ibge', 640120115, 'CENOURA - SOPA', unaccent(lower('CENOURA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 640120199, 'CENOURA', unaccent(lower('CENOURA')), 'Preparações', 41.0, 0.93, 9.58, 0.24, 2.8),
  ('ibge', 640130102, 'NABO - COZIDO(A)', unaccent(lower('NABO - COZIDO(A)')), 'Preparações', 22.0, 0.71, 5.06, 0.08, 2.0),
  ('ibge', 640130107, 'NABO - REFOGADO(A)', unaccent(lower('NABO - REFOGADO(A)')), 'Preparações', 47.74, 0.71, 5.06, 2.99, 2.0),
  ('ibge', 640160101, 'ACAFRAO - CRU(A)', unaccent(lower('ACAFRAO - CRU(A)')), 'Preparações', 310.0, 11.43, 65.37, 5.85, 3.9),
  ('ibge', 640180105, 'BATATA INGLESA ORGANICA - FRITO(A)', unaccent(lower('BATATA INGLESA ORGANICA - FRITO(A)')), 'Preparações', 263.5, 2.87, 33.6, 13.64, 3.44),
  ('ibge', 650010199, 'CREME DE ARROZ', unaccent(lower('CREME DE ARROZ')), 'Preparações', 148.32, 3.8, 26.07, 3.29, 0.3),
  ('ibge', 650010499, 'ARROZINA', unaccent(lower('ARROZINA')), 'Preparações', 148.32, 3.8, 26.07, 3.29, 0.3),
  ('ibge', 650010599, 'MUCILON', unaccent(lower('MUCILON')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650010899, 'MINGAU DE ARROZ', unaccent(lower('MINGAU DE ARROZ')), 'Preparações', 148.32, 3.8, 26.07, 3.29, 0.3),
  ('ibge', 650020299, 'CROQUINHOS DE ARROZ', unaccent(lower('CROQUINHOS DE ARROZ')), 'Preparações', 387.0, 12.94, 77.9, 4.54, 14.5),
  ('ibge', 650030199, 'FARINHA DE AVEIA', unaccent(lower('FARINHA DE AVEIA')), 'Preparações', 384.0, 16.0, 67.0, 6.3, 9.8),
  ('ibge', 650040199, 'AVEIA EM FLOCOS', unaccent(lower('AVEIA EM FLOCOS')), 'Preparações', 384.0, 16.0, 67.0, 6.3, 9.8),
  ('ibge', 650060199, 'FUBA DE MILHO', unaccent(lower('FUBA DE MILHO')), 'Preparações', 60.58, 1.44, 13.0, 0.2, 0.26),
  ('ibge', 650060399, 'FARINHA DE MILHO', unaccent(lower('FARINHA DE MILHO')), 'Preparações', 351.0, 7.2, 79.1, 1.5, 5.5),
  ('ibge', 650060899, 'PUBA DE MILHO', unaccent(lower('PUBA DE MILHO')), 'Preparações', 311.0, 4.8, 45.1, 12.4, 0.7),
  ('ibge', 650060999, 'PUBA DE FUBA', unaccent(lower('PUBA DE FUBA')), 'Preparações', 311.0, 4.8, 45.1, 12.4, 0.7),
  ('ibge', 650061302, 'MILHO MOIDO - COZIDO(A)', unaccent(lower('MILHO MOIDO - COZIDO(A)')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 650061499, 'MINGAU DE MILHO', unaccent(lower('MINGAU DE MILHO')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650070299, 'AMIDO DE MILHO', unaccent(lower('AMIDO DE MILHO')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650070599, 'AMIDO DE ARROZ', unaccent(lower('AMIDO DE ARROZ')), 'Preparações', 148.32, 3.8, 26.07, 3.29, 0.3),
  ('ibge', 650080199, 'CREMOGEMA', unaccent(lower('CREMOGEMA')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650080299, 'VITAMILHO', unaccent(lower('VITAMILHO')), 'Preparações', 128.3, 4.35, 26.42, 0.22, 1.71),
  ('ibge', 650080499, 'CREME DE MILHO', unaccent(lower('CREME DE MILHO')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650090299, 'SUCRILHOS DE MILHO', unaccent(lower('SUCRILHOS DE MILHO')), 'Preparações', 377.0, 4.7, 88.8, 0.7, 2.1),
  ('ibge', 650090399, 'CEREAL MATINAL DE MILHO EM FLOCOS', unaccent(lower('CEREAL MATINAL DE MILHO EM FLOCOS')), 'Preparações', 377.0, 4.7, 88.8, 0.7, 2.1),
  ('ibge', 650130199, 'GERME DE TRIGO', unaccent(lower('GERME DE TRIGO')), 'Preparações', 360.0, 23.15, 51.8, 9.72, 13.2),
  ('ibge', 650130399, 'FIBRA DE TRIGO', unaccent(lower('FIBRA DE TRIGO')), 'Preparações', 216.0, 15.55, 64.51, 4.25, 42.8),
  ('ibge', 650130499, 'FIBRA DE CEREAL TRIGO', unaccent(lower('FIBRA DE CEREAL TRIGO')), 'Preparações', 216.0, 15.55, 64.51, 4.25, 42.8),
  ('ibge', 650140199, 'FARINHA DE MANDIOCA', unaccent(lower('FARINHA DE MANDIOCA')), 'Preparações', 361.0, 1.6, 87.9, 0.3, 6.4),
  ('ibge', 650141099, 'FARINHA DE COPIOBA', unaccent(lower('FARINHA DE COPIOBA')), 'Preparações', 361.0, 1.6, 87.9, 0.3, 6.4),
  ('ibge', 650141599, 'FARINHA DE AGUA', unaccent(lower('FARINHA DE AGUA')), 'Preparações', 361.0, 1.6, 87.9, 0.3, 6.4),
  ('ibge', 650141699, 'CRUERA', unaccent(lower('CRUERA')), 'Preparações', 361.0, 1.6, 87.9, 0.3, 6.4),
  ('ibge', 650150299, 'GOMA DE MANDIOCA', unaccent(lower('GOMA DE MANDIOCA')), 'Preparações', 336.0, 2.0, 82.0, 0, 0),
  ('ibge', 650150599, 'SAGU DE MANDIOCA', unaccent(lower('SAGU DE MANDIOCA')), 'Preparações', 116.99, 4.33, 15.51, 4.1, 0.03),
  ('ibge', 650151099, 'FARINHA DE TAPIOCA', unaccent(lower('FARINHA DE TAPIOCA')), 'Preparações', 331.0, 0.5, 81.1, 0.3, 0.6),
  ('ibge', 650151199, 'FARINHA BEIJU', unaccent(lower('FARINHA BEIJU')), 'Preparações', 331.0, 0.5, 81.1, 0.3, 0.6),
  ('ibge', 650151599, 'SAGU DE TAPIOCA', unaccent(lower('SAGU DE TAPIOCA')), 'Preparações', 116.99, 4.33, 15.51, 4.1, 0.03),
  ('ibge', 650151699, 'TAPIOCA DE GOMA', unaccent(lower('TAPIOCA DE GOMA')), 'Preparações', 336.0, 2.0, 82.0, 0, 0),
  ('ibge', 650200199, 'FARINHA LACTEA', unaccent(lower('FARINHA LACTEA')), 'Preparações', 396.67, 12.67, 73.33, 6.33, 2.67),
  ('ibge', 650210199, 'NESTON', unaccent(lower('NESTON')), 'Preparações', 345.8, 12.92, 70.8, 0, 6.25),
  ('ibge', 650210299, 'FLOCOS DE CEREAIS', unaccent(lower('FLOCOS DE CEREAIS')), 'Preparações', 365.0, 7.2, 83.8, 1.0, 4.1),
  ('ibge', 650210599, 'VITAFLOCOS', unaccent(lower('VITAFLOCOS')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 650240301, 'MINI PIZZA SEMIPRONTA - CRU(A)', unaccent(lower('MINI PIZZA SEMIPRONTA - CRU(A)')), 'Preparações', 252.49, 10.17, 33.73, 8.22, 1.75),
  ('ibge', 650240302, 'MINI PIZZA SEMIPRONTA - COZIDO(A)', unaccent(lower('MINI PIZZA SEMIPRONTA - COZIDO(A)')), 'Preparações', 252.49, 10.17, 33.73, 8.22, 1.75),
  ('ibge', 650240304, 'MINI PIZZA SEMIPRONTA - ASSADO(A)', unaccent(lower('MINI PIZZA SEMIPRONTA - ASSADO(A)')), 'Preparações', 252.49, 10.17, 33.73, 8.22, 1.75),
  ('ibge', 650240305, 'MINI PIZZA SEMIPRONTA - FRITO(A)', unaccent(lower('MINI PIZZA SEMIPRONTA - FRITO(A)')), 'Preparações', 252.49, 10.17, 33.73, 8.22, 1.75),
  ('ibge', 650240399, 'MINI PIZZA SEMIPRONTA', unaccent(lower('MINI PIZZA SEMIPRONTA')), 'Preparações', 252.49, 10.17, 33.73, 8.22, 1.75),
  ('ibge', 650250199, 'FIBRA DE SOJA', unaccent(lower('FIBRA DE SOJA')), 'Preparações', 70.0, 12.0, 74.0, 2.0, 73.0),
  ('ibge', 650260399, 'MINI PASTEL', unaccent(lower('MINI PASTEL')), 'Preparações', 319.81, 10.38, 33.51, 15.68, 1.45),
  ('ibge', 650340101, 'MACARRAO - CRU(A)', unaccent(lower('MACARRAO - CRU(A)')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340102, 'MACARRAO - COZIDO(A)', unaccent(lower('MACARRAO - COZIDO(A)')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340103, 'MACARRAO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('MACARRAO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340104, 'MACARRAO - ASSADO(A)', unaccent(lower('MACARRAO - ASSADO(A)')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340105, 'MACARRAO - FRITO(A)', unaccent(lower('MACARRAO - FRITO(A)')), 'Preparações', 186.68, 5.8, 30.86, 4.17, 1.8),
  ('ibge', 650340106, 'MACARRAO - EMPANADO(A)/A MILANESA', unaccent(lower('MACARRAO - EMPANADO(A)/A MILANESA')), 'Preparações', 186.68, 5.8, 30.86, 4.17, 1.8),
  ('ibge', 650340107, 'MACARRAO - REFOGADO(A)', unaccent(lower('MACARRAO - REFOGADO(A)')), 'Preparações', 186.68, 5.8, 30.86, 4.17, 1.8),
  ('ibge', 650340108, 'MACARRAO - MOLHO VERMELHO', unaccent(lower('MACARRAO - MOLHO VERMELHO')), 'Preparações', 103.72, 3.5, 18.27, 1.92, 1.46),
  ('ibge', 650340109, 'MACARRAO - MOLHO BRANCO', unaccent(lower('MACARRAO - MOLHO BRANCO')), 'Preparações', 158.99, 5.42, 26.54, 3.23, 1.48),
  ('ibge', 650340110, 'MACARRAO - AO ALHO E OLEO', unaccent(lower('MACARRAO - AO ALHO E OLEO')), 'Preparações', 186.68, 5.8, 30.86, 4.17, 1.8),
  ('ibge', 650340111, 'MACARRAO - COM MANTEIGA/OLEO', unaccent(lower('MACARRAO - COM MANTEIGA/OLEO')), 'Preparações', 182.22, 5.83, 30.86, 3.67, 1.8),
  ('ibge', 650340112, 'MACARRAO - AO VINAGRETE', unaccent(lower('MACARRAO - AO VINAGRETE')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340113, 'MACARRAO - ENSOPADO', unaccent(lower('MACARRAO - ENSOPADO')), 'Preparações', 186.68, 5.8, 30.86, 4.17, 1.8),
  ('ibge', 650340115, 'MACARRAO - SOPA', unaccent(lower('MACARRAO - SOPA')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650340199, 'MACARRAO', unaccent(lower('MACARRAO')), 'Preparações', 158.0, 5.8, 30.86, 0.93, 1.8),
  ('ibge', 650350199, 'PURE DE BATATA', unaccent(lower('PURE DE BATATA')), 'Preparações', 115.16, 1.81, 17.76, 4.36, 1.78),
  ('ibge', 650360199, 'BIFE VEGETAL', unaccent(lower('BIFE VEGETAL')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 650360305, 'CARNE VEGETAL - FRITO(A)', unaccent(lower('CARNE VEGETAL - FRITO(A)')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 650360499, 'PASTA DE SOJA', unaccent(lower('PASTA DE SOJA')), 'Preparações', 62.0, 6.9, 2.4, 2.7, 0.1),
  ('ibge', 650360599, 'CARNE DE SOJA', unaccent(lower('CARNE DE SOJA')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 650370299, 'AMENDOIM MOIDO', unaccent(lower('AMENDOIM MOIDO')), 'Preparações', 567.0, 25.8, 16.13, 49.24, 8.5),
  ('ibge', 650410199, 'GRANOLA', unaccent(lower('GRANOLA')), 'Preparações', 388.0, 9.5, 73.8, 6.3, 8.5),
  ('ibge', 650460199, 'MUSLI', unaccent(lower('MUSLI')), 'Preparações', 388.0, 9.5, 73.8, 6.3, 8.5),
  ('ibge', 650470199, 'MIX DE CEREAIS', unaccent(lower('MIX DE CEREAIS')), 'Preparações', 388.0, 9.5, 73.8, 6.3, 8.5),
  ('ibge', 650480199, 'MIOJO', unaccent(lower('MIOJO')), 'Preparações', 189.86, 5.64, 25.54, 7.18, 1.16),
  ('ibge', 650480299, 'MACARRAO INSTANTANEO', unaccent(lower('MACARRAO INSTANTANEO')), 'Preparações', 189.86, 5.64, 25.54, 7.18, 1.16),
  ('ibge', 650510199, 'SUSTAGEM', unaccent(lower('SUSTAGEM')), 'Preparações', 369.15, 24.05, 68.02, 0.49, 0),
  ('ibge', 650560199, 'PROTEINA DE SOJA', unaccent(lower('PROTEINA DE SOJA')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 650560399, 'PROTEINA VEGETAL', unaccent(lower('PROTEINA VEGETAL')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 650570199, 'COMPLEMENTO ALIMENTAR DE QUALQUER SABOR', unaccent(lower('COMPLEMENTO ALIMENTAR DE QUALQUER SABOR')), 'Preparações', 369.15, 24.05, 68.02, 0.49, 0),
  ('ibge', 650590299, 'SUCRILHOS DE MILHO LIGHT', unaccent(lower('SUCRILHOS DE MILHO LIGHT')), 'Preparações', 365.0, 7.2, 83.8, 1.0, 4.1),
  ('ibge', 650600304, 'MINI PIZZA SEMIPRONTA LIGHT - ASSADO(A)', unaccent(lower('MINI PIZZA SEMIPRONTA LIGHT - ASSADO(A)')), 'Preparações', 255.57, 14.6, 29.82, 8.45, 1.74),
  ('ibge', 650630215, 'MACARRAO INSTANTANEO LIGHT - SOPA', unaccent(lower('MACARRAO INSTANTANEO LIGHT - SOPA')), 'Preparações', 189.86, 5.64, 25.54, 7.18, 1.16),
  ('ibge', 650630299, 'MACARRAO INSTANTANEO LIGHT', unaccent(lower('MACARRAO INSTANTANEO LIGHT')), 'Preparações', 189.86, 5.64, 25.54, 7.18, 1.16),
  ('ibge', 650640199, 'PROTEINA DE SOJA ORGANICA', unaccent(lower('PROTEINA DE SOJA ORGANICA')), 'Preparações', 142.37, 18.51, 5.8, 5.32, 0.44),
  ('ibge', 657322599, 'MACARRAO COM CARNE', unaccent(lower('MACARRAO COM CARNE')), 'Preparações', 120.59, 6.22, 17.42, 2.79, 1.25),
  ('ibge', 657322699, 'MACARRAO COM PEIXE', unaccent(lower('MACARRAO COM PEIXE')), 'Preparações', 163.17, 14.98, 15.43, 4.13, 0.9),
  ('ibge', 660010199, 'COCO DA BAHIA (SECO OU VERDE)', unaccent(lower('COCO DA BAHIA (SECO OU VERDE)')), 'Preparações', 354.0, 3.33, 15.23, 33.49, 9.0),
  ('ibge', 660030199, 'CASTANHA PORTUGUESA', unaccent(lower('CASTANHA PORTUGUESA')), 'Preparações', 131.0, 2.0, 27.76, 1.38, 4.14),
  ('ibge', 660040199, 'PINHAO', unaccent(lower('PINHAO')), 'Preparações', 174.37, 2.98, 43.92, 0.75, 15.6),
  ('ibge', 660050199, 'AMENDOA', unaccent(lower('AMENDOA')), 'Preparações', 578.0, 21.26, 19.74, 50.64, 11.8),
  ('ibge', 660060199, 'AVELA', unaccent(lower('AVELA')), 'Preparações', 628.0, 14.95, 16.7, 60.75, 9.7),
  ('ibge', 660070199, 'CASTANHA DO PARA', unaccent(lower('CASTANHA DO PARA')), 'Preparações', 656.0, 14.32, 12.27, 66.43, 7.5),
  ('ibge', 660080199, 'CASTANHA DE CAJU', unaccent(lower('CASTANHA DE CAJU')), 'Preparações', 574.0, 15.31, 32.69, 46.35, 3.0),
  ('ibge', 660091299, 'BUTIA', unaccent(lower('BUTIA')), 'Preparações', 105.0, 1.9, 22.8, 2.0, 7.4),
  ('ibge', 660110899, 'TUCUMA', unaccent(lower('TUCUMA')), 'Preparações', 474.0, 5.5, 6.8, 47.2, 19.2),
  ('ibge', 660120899, 'COCO MUCAJA', unaccent(lower('COCO MUCAJA')), 'Preparações', 404.28, 2.08, 13.95, 40.66, 13.44),
  ('ibge', 660150199, 'NOZ (NOGUEIRA)', unaccent(lower('NOZ (NOGUEIRA)')), 'Preparações', 654.0, 15.23, 13.71, 65.21, 6.7),
  ('ibge', 660170699, 'ACAI', unaccent(lower('ACAI')), 'Preparações', 262.0, 3.6, 57.4, 2.0, 5.92),
  ('ibge', 660170799, 'JUCARA', unaccent(lower('JUCARA')), 'Preparações', 262.0, 3.6, 57.4, 2.0, 5.92),
  ('ibge', 660170999, 'UACAI', unaccent(lower('UACAI')), 'Preparações', 262.0, 3.6, 57.4, 2.0, 5.92),
  ('ibge', 660171299, 'JUSSARA', unaccent(lower('JUSSARA')), 'Preparações', 262.0, 3.6, 57.4, 2.0, 5.92),
  ('ibge', 660180599, 'PUPUNHA', unaccent(lower('PUPUNHA')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 660190299, 'BACABA', unaccent(lower('BACABA')), 'Preparações', 212.0, 3.12, 6.6, 19.8, 0),
  ('ibge', 660190499, 'BACABUCU', unaccent(lower('BACABUCU')), 'Preparações', 212.0, 3.12, 6.6, 19.8, 0),
  ('ibge', 660200199, 'CASTANHA DA INDIA', unaccent(lower('CASTANHA DA INDIA')), 'Preparações', 656.0, 14.32, 12.27, 66.43, 7.5),
  ('ibge', 660220199, 'PISTACHE', unaccent(lower('PISTACHE')), 'Preparações', 557.0, 20.61, 27.97, 44.44, 10.3),
  ('ibge', 660230199, 'BURITI', unaccent(lower('BURITI')), 'Preparações', 145.0, 1.8, 10.2, 8.1, 9.6),
  ('ibge', 660240199, 'COCO', unaccent(lower('COCO')), 'Preparações', 354.0, 3.33, 15.23, 33.49, 9.0),
  ('ibge', 660260199, 'PATAUA', unaccent(lower('PATAUA')), 'Preparações', 105.0, 1.9, 22.8, 2.0, 7.4),
  ('ibge', 670010199, 'ALFACE', unaccent(lower('ALFACE')), 'Preparações', 15.0, 1.36, 2.79, 0.15, 1.3),
  ('ibge', 670020107, 'BERTALHA - REFOGADO(A)', unaccent(lower('BERTALHA - REFOGADO(A)')), 'Preparações', 45.3, 2.97, 3.75, 2.78, 2.4),
  ('ibge', 670030101, 'CHICORIA - CRU(A)', unaccent(lower('CHICORIA - CRU(A)')), 'Preparações', 17.0, 1.25, 3.35, 0.2, 3.1),
  ('ibge', 670030102, 'CHICORIA - COZIDO(A)', unaccent(lower('CHICORIA - COZIDO(A)')), 'Preparações', 58.88, 1.9, 5.63, 3.89, 2.0),
  ('ibge', 670030107, 'CHICORIA - REFOGADO(A)', unaccent(lower('CHICORIA - REFOGADO(A)')), 'Preparações', 58.88, 1.9, 5.63, 3.89, 2.0),
  ('ibge', 670030112, 'CHICORIA - AO VINAGRETE', unaccent(lower('CHICORIA - AO VINAGRETE')), 'Preparações', 58.88, 1.9, 5.63, 3.89, 2.0),
  ('ibge', 670030499, 'ESCAROLA', unaccent(lower('ESCAROLA')), 'Preparações', 52.88, 1.61, 4.31, 3.75, 3.99),
  ('ibge', 670050101, 'COUVE - CRU(A)', unaccent(lower('COUVE - CRU(A)')), 'Preparações', 30.0, 2.45, 5.69, 0.42, 3.6),
  ('ibge', 670050102, 'COUVE - COZIDO(A)', unaccent(lower('COUVE - COZIDO(A)')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670050105, 'COUVE - FRITO(A)', unaccent(lower('COUVE - FRITO(A)')), 'Preparações', 47.13, 2.11, 4.91, 2.75, 2.8),
  ('ibge', 670050107, 'COUVE - REFOGADO(A)', unaccent(lower('COUVE - REFOGADO(A)')), 'Preparações', 47.13, 2.11, 4.91, 2.75, 2.8),
  ('ibge', 670050108, 'COUVE - MOLHO VERMELHO', unaccent(lower('COUVE - MOLHO VERMELHO')), 'Preparações', 25.6, 1.95, 5.0, 0.32, 2.54),
  ('ibge', 670050110, 'COUVE - AO ALHO E OLEO', unaccent(lower('COUVE - AO ALHO E OLEO')), 'Preparações', 47.13, 2.11, 4.91, 2.75, 2.8),
  ('ibge', 670050111, 'COUVE - COM MANTEIGA/OLEO', unaccent(lower('COUVE - COM MANTEIGA/OLEO')), 'Preparações', 43.85, 2.13, 4.91, 2.38, 2.8),
  ('ibge', 670050112, 'COUVE - AO VINAGRETE', unaccent(lower('COUVE - AO VINAGRETE')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670050113, 'COUVE - ENSOPADO', unaccent(lower('COUVE - ENSOPADO')), 'Preparações', 47.13, 2.11, 4.91, 2.75, 2.8),
  ('ibge', 670050114, 'COUVE - MINGAU', unaccent(lower('COUVE - MINGAU')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670050199, 'COUVE', unaccent(lower('COUVE')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670060101, 'COUVE FLOR - CRU(A)', unaccent(lower('COUVE FLOR - CRU(A)')), 'Preparações', 23.0, 1.84, 4.11, 0.45, 2.3),
  ('ibge', 670060102, 'COUVE FLOR - COZIDO(A)', unaccent(lower('COUVE FLOR - COZIDO(A)')), 'Preparações', 23.0, 1.84, 4.11, 0.45, 2.3),
  ('ibge', 670060105, 'COUVE FLOR - FRITO(A)', unaccent(lower('COUVE FLOR - FRITO(A)')), 'Preparações', 55.38, 1.84, 4.11, 4.11, 2.3),
  ('ibge', 670060106, 'COUVE FLOR - EMPANADO(A)/A MILANESA', unaccent(lower('COUVE FLOR - EMPANADO(A)/A MILANESA')), 'Preparações', 137.44, 4.17, 10.31, 9.21, 2.08),
  ('ibge', 670060107, 'COUVE FLOR - REFOGADO(A)', unaccent(lower('COUVE FLOR - REFOGADO(A)')), 'Preparações', 55.38, 1.84, 4.11, 4.11, 2.3),
  ('ibge', 670060112, 'COUVE FLOR - AO VINAGRETE', unaccent(lower('COUVE FLOR - AO VINAGRETE')), 'Preparações', 23.0, 1.84, 4.11, 0.45, 2.3),
  ('ibge', 670060199, 'COUVE FLOR', unaccent(lower('COUVE FLOR')), 'Preparações', 23.0, 1.84, 4.11, 0.45, 2.3),
  ('ibge', 670070101, 'ESPINAFRE - CRU(A)', unaccent(lower('ESPINAFRE - CRU(A)')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670070102, 'ESPINAFRE - COZIDO(A)', unaccent(lower('ESPINAFRE - COZIDO(A)')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670070107, 'ESPINAFRE - REFOGADO(A)', unaccent(lower('ESPINAFRE - REFOGADO(A)')), 'Preparações', 45.3, 2.97, 3.75, 2.78, 2.4),
  ('ibge', 670070112, 'ESPINAFRE - AO VINAGRETE', unaccent(lower('ESPINAFRE - AO VINAGRETE')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670070199, 'ESPINAFRE', unaccent(lower('ESPINAFRE')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670080101, 'MOSTARDA (VERDURA) - CRU(A)', unaccent(lower('MOSTARDA (VERDURA) - CRU(A)')), 'Preparações', 26.0, 2.7, 4.9, 0.2, 3.3),
  ('ibge', 670080102, 'MOSTARDA (VERDURA) - COZIDO(A)', unaccent(lower('MOSTARDA (VERDURA) - COZIDO(A)')), 'Preparações', 15.0, 2.26, 2.1, 0.24, 2.0),
  ('ibge', 670080107, 'MOSTARDA (VERDURA) - REFOGADO(A)', unaccent(lower('MOSTARDA (VERDURA) - REFOGADO(A)')), 'Preparações', 43.68, 2.26, 2.1, 3.48, 2.0),
  ('ibge', 670080199, 'MOSTARDA (VERDURA)', unaccent(lower('MOSTARDA (VERDURA)')), 'Preparações', 15.0, 2.26, 2.1, 0.24, 2.0),
  ('ibge', 670090101, 'REPOLHO - CRU(A)', unaccent(lower('REPOLHO - CRU(A)')), 'Preparações', 25.0, 1.28, 5.8, 0.1, 2.24),
  ('ibge', 670090102, 'REPOLHO - COZIDO(A)', unaccent(lower('REPOLHO - COZIDO(A)')), 'Preparações', 23.0, 1.27, 5.51, 0.06, 1.9),
  ('ibge', 670090105, 'REPOLHO - FRITO(A)', unaccent(lower('REPOLHO - FRITO(A)')), 'Preparações', 49.77, 1.27, 5.51, 3.09, 1.9),
  ('ibge', 670090107, 'REPOLHO - REFOGADO(A)', unaccent(lower('REPOLHO - REFOGADO(A)')), 'Preparações', 49.77, 1.27, 5.51, 3.09, 1.9),
  ('ibge', 670090109, 'REPOLHO - MOLHO BRANCO', unaccent(lower('REPOLHO - MOLHO BRANCO')), 'Preparações', 23.0, 1.27, 5.51, 0.06, 1.9),
  ('ibge', 670090110, 'REPOLHO - AO ALHO E OLEO', unaccent(lower('REPOLHO - AO ALHO E OLEO')), 'Preparações', 49.77, 1.27, 5.51, 3.09, 1.9),
  ('ibge', 670090112, 'REPOLHO - AO VINAGRETE', unaccent(lower('REPOLHO - AO VINAGRETE')), 'Preparações', 23.0, 1.27, 5.51, 0.06, 1.9),
  ('ibge', 670090113, 'REPOLHO - ENSOPADO', unaccent(lower('REPOLHO - ENSOPADO')), 'Preparações', 49.77, 1.27, 5.51, 3.09, 1.9),
  ('ibge', 670090115, 'REPOLHO - SOPA', unaccent(lower('REPOLHO - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 670090199, 'REPOLHO', unaccent(lower('REPOLHO')), 'Preparações', 23.0, 1.27, 5.51, 0.06, 1.9),
  ('ibge', 670110199, 'CEBOLINHA', unaccent(lower('CEBOLINHA')), 'Preparações', 25.0, 1.8, 5.65, 0.1, 3.5),
  ('ibge', 670130101, 'AGRIAO - CRU(A)', unaccent(lower('AGRIAO - CRU(A)')), 'Preparações', 25.0, 2.58, 3.65, 0.66, 1.6),
  ('ibge', 670130102, 'AGRIAO - COZIDO(A)', unaccent(lower('AGRIAO - COZIDO(A)')), 'Preparações', 11.0, 2.3, 1.29, 0.1, 0.5),
  ('ibge', 670130112, 'AGRIAO - AO VINAGRETE', unaccent(lower('AGRIAO - AO VINAGRETE')), 'Preparações', 11.0, 2.3, 1.29, 0.1, 0.5),
  ('ibge', 670130113, 'AGRIAO - ENSOPADO', unaccent(lower('AGRIAO - ENSOPADO')), 'Preparações', 35.75, 2.33, 1.29, 2.9, 0.5),
  ('ibge', 670130199, 'AGRIAO', unaccent(lower('AGRIAO')), 'Preparações', 25.0, 2.58, 3.65, 0.66, 1.6),
  ('ibge', 670140101, 'TAIOBA - CRU(A)', unaccent(lower('TAIOBA - CRU(A)')), 'Preparações', 34.0, 2.9, 5.4, 0.9, 4.5),
  ('ibge', 670140102, 'TAIOBA - COZIDO(A)', unaccent(lower('TAIOBA - COZIDO(A)')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670140107, 'TAIOBA - REFOGADO(A)', unaccent(lower('TAIOBA - REFOGADO(A)')), 'Preparações', 47.13, 2.11, 4.91, 2.75, 2.8),
  ('ibge', 670150101, 'ACELGA - CRU(A)', unaccent(lower('ACELGA - CRU(A)')), 'Preparações', 19.0, 1.8, 3.74, 0.2, 1.6),
  ('ibge', 670150102, 'ACELGA - COZIDO(A)', unaccent(lower('ACELGA - COZIDO(A)')), 'Preparações', 14.0, 1.5, 2.41, 0.17, 1.7),
  ('ibge', 670150107, 'ACELGA - REFOGADO(A)', unaccent(lower('ACELGA - REFOGADO(A)')), 'Preparações', 47.74, 1.5, 2.41, 3.99, 1.7),
  ('ibge', 670150199, 'ACELGA', unaccent(lower('ACELGA')), 'Preparações', 19.0, 1.8, 3.74, 0.2, 1.6),
  ('ibge', 670150502, 'BETERRABA BRANCA (ACELGA) - COZIDO(A)', unaccent(lower('BETERRABA BRANCA (ACELGA) - COZIDO(A)')), 'Preparações', 14.0, 1.5, 2.41, 0.17, 1.7),
  ('ibge', 670160101, 'ALMEIRAO - CRU(A)', unaccent(lower('ALMEIRAO - CRU(A)')), 'Preparações', 17.0, 1.25, 3.35, 0.2, 3.1),
  ('ibge', 670160102, 'ALMEIRAO - COZIDO(A)', unaccent(lower('ALMEIRAO - COZIDO(A)')), 'Preparações', 22.0, 1.61, 4.31, 0.26, 3.99),
  ('ibge', 670160107, 'ALMEIRAO - REFOGADO(A)', unaccent(lower('ALMEIRAO - REFOGADO(A)')), 'Preparações', 52.88, 1.61, 4.31, 3.75, 3.99),
  ('ibge', 670160112, 'ALMEIRAO - AO VINAGRETE', unaccent(lower('ALMEIRAO - AO VINAGRETE')), 'Preparações', 22.0, 1.61, 4.31, 0.26, 3.99),
  ('ibge', 670160201, 'RADITE - CRU(A)', unaccent(lower('RADITE - CRU(A)')), 'Preparações', 17.0, 1.25, 3.35, 0.2, 3.1),
  ('ibge', 670160207, 'RADITE - REFOGADO(A)', unaccent(lower('RADITE - REFOGADO(A)')), 'Preparações', 52.88, 1.61, 4.31, 3.75, 3.99),
  ('ibge', 670160212, 'RADITE - AO VINAGRETE', unaccent(lower('RADITE - AO VINAGRETE')), 'Preparações', 22.0, 1.61, 4.31, 0.26, 3.99),
  ('ibge', 670170401, 'BROCOLIS - CRU(A)', unaccent(lower('BROCOLIS - CRU(A)')), 'Preparações', 34.0, 2.82, 6.64, 0.37, 2.6),
  ('ibge', 670170402, 'BROCOLIS - COZIDO(A)', unaccent(lower('BROCOLIS - COZIDO(A)')), 'Preparações', 35.0, 2.38, 7.18, 0.41, 3.3),
  ('ibge', 670170406, 'BROCOLIS - EMPANADO(A)/A MILANESA', unaccent(lower('BROCOLIS - EMPANADO(A)/A MILANESA')), 'Preparações', 181.23, 4.18, 15.43, 11.48, 2.06),
  ('ibge', 670170407, 'BROCOLIS - REFOGADO(A)', unaccent(lower('BROCOLIS - REFOGADO(A)')), 'Preparações', 60.74, 2.38, 7.18, 3.32, 3.3),
  ('ibge', 670170410, 'BROCOLIS - AO ALHO E OLEO', unaccent(lower('BROCOLIS - AO ALHO E OLEO')), 'Preparações', 60.74, 2.38, 7.18, 3.32, 3.3),
  ('ibge', 670170412, 'BROCOLIS - AO VINAGRETE', unaccent(lower('BROCOLIS - AO VINAGRETE')), 'Preparações', 35.0, 2.38, 7.18, 0.41, 3.3),
  ('ibge', 670170499, 'BROCOLIS', unaccent(lower('BROCOLIS')), 'Preparações', 35.0, 2.38, 7.18, 0.41, 3.3),
  ('ibge', 670180101, 'SERRALHA - CRU(A)', unaccent(lower('SERRALHA - CRU(A)')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670180102, 'SERRALHA - COZIDO(A)', unaccent(lower('SERRALHA - COZIDO(A)')), 'Preparações', 23.0, 2.97, 3.75, 0.26, 2.4),
  ('ibge', 670180107, 'SERRALHA - REFOGADO(A)', unaccent(lower('SERRALHA - REFOGADO(A)')), 'Preparações', 45.3, 2.97, 3.75, 2.78, 2.4),
  ('ibge', 670190102, 'CARURU - COZIDO(A)', unaccent(lower('CARURU - COZIDO(A)')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670190699, 'CUXA', unaccent(lower('CUXA')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670190799, 'VINAGREIRA', unaccent(lower('VINAGREIRA')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670191399, 'CARIRU', unaccent(lower('CARIRU')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670200199, 'RUCULA', unaccent(lower('RUCULA')), 'Preparações', 25.0, 2.58, 3.65, 0.66, 1.6),
  ('ibge', 670210599, 'JAMBU', unaccent(lower('JAMBU')), 'Preparações', 32.0, 1.9, 7.2, 0.3, 1.3),
  ('ibge', 670220101, 'LINGUA DE VACA (VERDURA) - CRU(A)', unaccent(lower('LINGUA DE VACA (VERDURA) - CRU(A)')), 'Preparações', 30.0, 2.45, 5.69, 0.42, 3.6),
  ('ibge', 670230199, 'ALCACHOFRA', unaccent(lower('ALCACHOFRA')), 'Preparações', 53.0, 2.89, 11.95, 0.34, 8.6),
  ('ibge', 670250199, 'BREDO', unaccent(lower('BREDO')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670260407, 'SALSAO (AIPO) - REFOGADO(A)', unaccent(lower('SALSAO (AIPO) - REFOGADO(A)')), 'Preparações', 18.0, 0.83, 4.0, 0.16, 1.6),
  ('ibge', 670280199, 'ERVA DOCE', unaccent(lower('ERVA DOCE')), 'Preparações', 31.0, 1.24, 7.29, 0.2, 3.1),
  ('ibge', 670300301, 'FOLHA DE AIPIM - CRU(A)', unaccent(lower('FOLHA DE AIPIM - CRU(A)')), 'Preparações', 30.0, 2.45, 5.69, 0.42, 3.6),
  ('ibge', 670300402, 'FOLHA DE MACAXEIRA - COZIDO(A)', unaccent(lower('FOLHA DE MACAXEIRA - COZIDO(A)')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 670310101, 'BROTO DE FEIJAO - CRU(A)', unaccent(lower('BROTO DE FEIJAO - CRU(A)')), 'Preparações', 30.0, 3.04, 5.94, 0.18, 1.8),
  ('ibge', 670310102, 'BROTO DE FEIJAO - COZIDO(A)', unaccent(lower('BROTO DE FEIJAO - COZIDO(A)')), 'Preparações', 53.38, 2.03, 4.19, 3.75, 0.8),
  ('ibge', 670330602, 'MORANGA - COZIDO(A)', unaccent(lower('MORANGA - COZIDO(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670330607, 'MORANGA - REFOGADO(A)', unaccent(lower('MORANGA - REFOGADO(A)')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 670330613, 'MORANGA - ENSOPADO', unaccent(lower('MORANGA - ENSOPADO')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 670330699, 'MORANGA', unaccent(lower('MORANGA')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670370101, 'ABOBRINHA - CRU(A)', unaccent(lower('ABOBRINHA - CRU(A)')), 'Preparações', 16.0, 1.21, 3.35, 0.18, 1.1),
  ('ibge', 670370102, 'ABOBRINHA - COZIDO(A)', unaccent(lower('ABOBRINHA - COZIDO(A)')), 'Preparações', 20.0, 0.91, 4.31, 0.31, 1.4),
  ('ibge', 670370103, 'ABOBRINHA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('ABOBRINHA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 20.0, 0.91, 4.31, 0.31, 1.4),
  ('ibge', 670370104, 'ABOBRINHA - ASSADO(A)', unaccent(lower('ABOBRINHA - ASSADO(A)')), 'Preparações', 20.0, 0.91, 4.31, 0.31, 1.4),
  ('ibge', 670370105, 'ABOBRINHA - FRITO(A)', unaccent(lower('ABOBRINHA - FRITO(A)')), 'Preparações', 42.3, 0.91, 4.31, 2.83, 1.4),
  ('ibge', 670370106, 'ABOBRINHA - EMPANADO(A)/A MILANESA', unaccent(lower('ABOBRINHA - EMPANADO(A)/A MILANESA')), 'Preparações', 160.71, 4.35, 16.01, 8.92, 1.56),
  ('ibge', 670370107, 'ABOBRINHA - REFOGADO(A)', unaccent(lower('ABOBRINHA - REFOGADO(A)')), 'Preparações', 42.3, 0.91, 4.31, 2.83, 1.4),
  ('ibge', 670370113, 'ABOBRINHA - ENSOPADO', unaccent(lower('ABOBRINHA - ENSOPADO')), 'Preparações', 42.3, 0.91, 4.31, 2.83, 1.4),
  ('ibge', 670380501, 'JERIMUM - CRU(A)', unaccent(lower('JERIMUM - CRU(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670380502, 'JERIMUM - COZIDO(A)', unaccent(lower('JERIMUM - COZIDO(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670390101, 'ABOBORA - CRU(A)', unaccent(lower('ABOBORA - CRU(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670390102, 'ABOBORA - COZIDO(A)', unaccent(lower('ABOBORA - COZIDO(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670390104, 'ABOBORA - ASSADO(A)', unaccent(lower('ABOBORA - ASSADO(A)')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670390105, 'ABOBORA - FRITO(A)', unaccent(lower('ABOBORA - FRITO(A)')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 670390107, 'ABOBORA - REFOGADO(A)', unaccent(lower('ABOBORA - REFOGADO(A)')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 670390108, 'ABOBORA - MOLHO VERMELHO', unaccent(lower('ABOBORA - MOLHO VERMELHO')), 'Preparações', 20.8, 0.84, 5.0, 0.09, 1.18),
  ('ibge', 670390113, 'ABOBORA - ENSOPADO', unaccent(lower('ABOBORA - ENSOPADO')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 670390115, 'ABOBORA - SOPA', unaccent(lower('ABOBORA - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 670390199, 'ABOBORA', unaccent(lower('ABOBORA')), 'Preparações', 20.0, 0.72, 4.9, 0.07, 1.1),
  ('ibge', 670400199, 'PEPINO', unaccent(lower('PEPINO')), 'Preparações', 15.0, 0.65, 3.63, 0.11, 1.14),
  ('ibge', 670410101, 'CHUCHU - CRU(A)', unaccent(lower('CHUCHU - CRU(A)')), 'Preparações', 24.0, 0.62, 5.09, 0.48, 2.8),
  ('ibge', 670410102, 'CHUCHU - COZIDO(A)', unaccent(lower('CHUCHU - COZIDO(A)')), 'Preparações', 24.0, 0.62, 5.09, 0.48, 2.8),
  ('ibge', 670410104, 'CHUCHU - ASSADO(A)', unaccent(lower('CHUCHU - ASSADO(A)')), 'Preparações', 24.0, 0.76, 5.15, 0.42, 2.54),
  ('ibge', 670410107, 'CHUCHU - REFOGADO(A)', unaccent(lower('CHUCHU - REFOGADO(A)')), 'Preparações', 49.09, 0.62, 5.09, 3.32, 2.8),
  ('ibge', 670410108, 'CHUCHU - MOLHO VERMELHO', unaccent(lower('CHUCHU - MOLHO VERMELHO')), 'Preparações', 24.0, 0.76, 5.15, 0.42, 2.54),
  ('ibge', 670410110, 'CHUCHU - AO ALHO E OLEO', unaccent(lower('CHUCHU - AO ALHO E OLEO')), 'Preparações', 49.09, 0.62, 5.09, 3.32, 2.8),
  ('ibge', 670410112, 'CHUCHU - AO VINAGRETE', unaccent(lower('CHUCHU - AO VINAGRETE')), 'Preparações', 24.0, 0.62, 5.09, 0.48, 2.8),
  ('ibge', 670410113, 'CHUCHU - ENSOPADO', unaccent(lower('CHUCHU - ENSOPADO')), 'Preparações', 49.09, 0.62, 5.09, 3.32, 2.8),
  ('ibge', 670410115, 'CHUCHU - SOPA', unaccent(lower('CHUCHU - SOPA')), 'Preparações', 31.44, 0.95, 7.01, 0.12, 0.71),
  ('ibge', 670420101, 'JILO - CRU(A)', unaccent(lower('JILO - CRU(A)')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670420102, 'JILO - COZIDO(A)', unaccent(lower('JILO - COZIDO(A)')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670420104, 'JILO - ASSADO(A)', unaccent(lower('JILO - ASSADO(A)')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670420105, 'JILO - FRITO(A)', unaccent(lower('JILO - FRITO(A)')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670420107, 'JILO - REFOGADO(A)', unaccent(lower('JILO - REFOGADO(A)')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670420111, 'JILO - COM MANTEIGA/OLEO', unaccent(lower('JILO - COM MANTEIGA/OLEO')), 'Preparações', 43.19, 1.9, 4.51, 2.61, 2.5),
  ('ibge', 670420113, 'JILO - ENSOPADO', unaccent(lower('JILO - ENSOPADO')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670420199, 'JILO', unaccent(lower('JILO')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670430101, 'MAXIXE - CRU(A)', unaccent(lower('MAXIXE - CRU(A)')), 'Preparações', 14.0, 1.4, 2.7, 0.1, 2.2),
  ('ibge', 670430102, 'MAXIXE - COZIDO(A)', unaccent(lower('MAXIXE - COZIDO(A)')), 'Preparações', 14.0, 0.4, 3.04, 0.2, 1.0),
  ('ibge', 670430107, 'MAXIXE - REFOGADO(A)', unaccent(lower('MAXIXE - REFOGADO(A)')), 'Preparações', 36.94, 0.4, 3.04, 2.8, 1.0),
  ('ibge', 670430113, 'MAXIXE - ENSOPADO', unaccent(lower('MAXIXE - ENSOPADO')), 'Preparações', 36.94, 0.4, 3.04, 2.8, 1.0),
  ('ibge', 670430602, 'PEPININHO (MAXIXE) - COZIDO(A)', unaccent(lower('PEPININHO (MAXIXE) - COZIDO(A)')), 'Preparações', 14.0, 0.4, 3.04, 0.2, 1.0),
  ('ibge', 670430612, 'PEPININHO (MAXIXE) - AO VINAGRETE', unaccent(lower('PEPININHO (MAXIXE) - AO VINAGRETE')), 'Preparações', 14.0, 0.4, 3.04, 0.2, 1.0),
  ('ibge', 670440101, 'PALMITO IN NATURA - CRU(A)', unaccent(lower('PALMITO IN NATURA - CRU(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440102, 'PALMITO IN NATURA - COZIDO(A)', unaccent(lower('PALMITO IN NATURA - COZIDO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440107, 'PALMITO IN NATURA - REFOGADO(A)', unaccent(lower('PALMITO IN NATURA - REFOGADO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440113, 'PALMITO IN NATURA - ENSOPADO', unaccent(lower('PALMITO IN NATURA - ENSOPADO')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440902, 'GUARIROBA (PALMITO IN NATURA) - COZIDO(A)', unaccent(lower('GUARIROBA (PALMITO IN NATURA) - COZIDO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440907, 'GUARIROBA (PALMITO IN NATURA) - REFOGADO(A)', unaccent(lower('GUARIROBA (PALMITO IN NATURA) - REFOGADO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670440908, 'GUARIROBA (PALMITO IN NATURA) - MOLHO VERMELHO', unaccent(lower('GUARIROBA (PALMITO IN NATURA) - MOLHO VERMELHO')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670441002, 'GUEIROBA (PALMITO IN NATURA) - COZIDO(A)', unaccent(lower('GUEIROBA (PALMITO IN NATURA) - COZIDO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670441007, 'GUEIROBA (PALMITO IN NATURA) - REFOGADO(A)', unaccent(lower('GUEIROBA (PALMITO IN NATURA) - REFOGADO(A)')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 670450199, 'PIMENTAO', unaccent(lower('PIMENTAO')), 'Preparações', 20.0, 0.86, 4.64, 0.17, 1.7),
  ('ibge', 670500101, 'QUIABO - CRU(A)', unaccent(lower('QUIABO - CRU(A)')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670500102, 'QUIABO - COZIDO(A)', unaccent(lower('QUIABO - COZIDO(A)')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670500105, 'QUIABO - FRITO(A)', unaccent(lower('QUIABO - FRITO(A)')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670500106, 'QUIABO - EMPANADO(A)/A MILANESA', unaccent(lower('QUIABO - EMPANADO(A)/A MILANESA')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670500107, 'QUIABO - REFOGADO(A)', unaccent(lower('QUIABO - REFOGADO(A)')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670500113, 'QUIABO - ENSOPADO', unaccent(lower('QUIABO - ENSOPADO')), 'Preparações', 47.09, 1.87, 4.51, 3.05, 2.5),
  ('ibge', 670500199, 'QUIABO', unaccent(lower('QUIABO')), 'Preparações', 22.0, 1.87, 4.51, 0.21, 2.5),
  ('ibge', 670510199, 'TOMATE', unaccent(lower('TOMATE')), 'Preparações', 18.0, 0.88, 3.92, 0.2, 1.2),
  ('ibge', 670520101, 'VAGEM - CRU(A)', unaccent(lower('VAGEM - CRU(A)')), 'Preparações', 35.0, 1.89, 7.88, 0.28, 3.2),
  ('ibge', 670520102, 'VAGEM - COZIDO(A)', unaccent(lower('VAGEM - COZIDO(A)')), 'Preparações', 35.0, 1.89, 7.88, 0.28, 3.2),
  ('ibge', 670520107, 'VAGEM - REFOGADO(A)', unaccent(lower('VAGEM - REFOGADO(A)')), 'Preparações', 67.12, 1.89, 7.88, 3.91, 3.2),
  ('ibge', 670520111, 'VAGEM - COM MANTEIGA/OLEO', unaccent(lower('VAGEM - COM MANTEIGA/OLEO')), 'Preparações', 67.12, 1.89, 7.88, 3.91, 3.2),
  ('ibge', 670520113, 'VAGEM - ENSOPADO', unaccent(lower('VAGEM - ENSOPADO')), 'Preparações', 67.12, 1.89, 7.88, 3.91, 3.2),
  ('ibge', 670520199, 'VAGEM', unaccent(lower('VAGEM')), 'Preparações', 35.0, 1.89, 7.88, 0.28, 3.2),
  ('ibge', 670530199, 'COGUMELO IN NATURA', unaccent(lower('COGUMELO IN NATURA')), 'Preparações', 28.0, 2.17, 5.29, 0.47, 2.2),
  ('ibge', 670540101, 'BERINJELA - CRU(A)', unaccent(lower('BERINJELA - CRU(A)')), 'Preparações', 32.9, 0.78, 8.21, 0.22, 2.35),
  ('ibge', 670540102, 'BERINJELA - COZIDO(A)', unaccent(lower('BERINJELA - COZIDO(A)')), 'Preparações', 35.0, 0.83, 8.73, 0.23, 2.5),
  ('ibge', 670540104, 'BERINJELA - ASSADO(A)', unaccent(lower('BERINJELA - ASSADO(A)')), 'Preparações', 35.0, 0.83, 8.73, 0.23, 2.5),
  ('ibge', 670540105, 'BERINJELA - FRITO(A)', unaccent(lower('BERINJELA - FRITO(A)')), 'Preparações', 75.55, 0.83, 8.73, 4.82, 2.5),
  ('ibge', 670540106, 'BERINJELA - EMPANADO(A)/A MILANESA', unaccent(lower('BERINJELA - EMPANADO(A)/A MILANESA')), 'Preparações', 164.87, 3.69, 15.86, 10.18, 2.71),
  ('ibge', 670540107, 'BERINJELA - REFOGADO(A)', unaccent(lower('BERINJELA - REFOGADO(A)')), 'Preparações', 75.55, 0.83, 8.73, 4.82, 2.5),
  ('ibge', 670540112, 'BERINJELA - AO VINAGRETE', unaccent(lower('BERINJELA - AO VINAGRETE')), 'Preparações', 35.0, 0.83, 8.73, 0.23, 2.5),
  ('ibge', 670540113, 'BERINJELA - ENSOPADO', unaccent(lower('BERINJELA - ENSOPADO')), 'Preparações', 75.55, 0.83, 8.73, 4.82, 2.5),
  ('ibge', 670540199, 'BERINJELA', unaccent(lower('BERINJELA')), 'Preparações', 35.0, 0.83, 8.73, 0.23, 2.5),
  ('ibge', 670550102, 'ERVILHA EM VAGEM - COZIDO(A)', unaccent(lower('ERVILHA EM VAGEM - COZIDO(A)')), 'Preparações', 67.09, 3.27, 7.05, 3.07, 2.8),
  ('ibge', 670550107, 'ERVILHA EM VAGEM - REFOGADO(A)', unaccent(lower('ERVILHA EM VAGEM - REFOGADO(A)')), 'Preparações', 67.09, 3.27, 7.05, 3.07, 2.8),
  ('ibge', 670570101, 'CEBOLA - CRU(A)', unaccent(lower('CEBOLA - CRU(A)')), 'Preparações', 40.0, 1.1, 9.34, 0.1, 1.93),
  ('ibge', 670570102, 'CEBOLA - COZIDO(A)', unaccent(lower('CEBOLA - COZIDO(A)')), 'Preparações', 44.0, 1.36, 10.15, 0.19, 1.4),
  ('ibge', 670570103, 'CEBOLA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CEBOLA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 44.0, 1.36, 10.15, 0.19, 1.4),
  ('ibge', 670570104, 'CEBOLA - ASSADO(A)', unaccent(lower('CEBOLA - ASSADO(A)')), 'Preparações', 44.0, 1.36, 10.15, 0.19, 1.4),
  ('ibge', 670570105, 'CEBOLA - FRITO(A)', unaccent(lower('CEBOLA - FRITO(A)')), 'Preparações', 63.12, 1.36, 10.15, 2.35, 1.4),
  ('ibge', 670570107, 'CEBOLA - REFOGADO(A)', unaccent(lower('CEBOLA - REFOGADO(A)')), 'Preparações', 63.12, 1.36, 10.15, 2.35, 1.4),
  ('ibge', 670570108, 'CEBOLA - MOLHO VERMELHO', unaccent(lower('CEBOLA - MOLHO VERMELHO')), 'Preparações', 40.0, 1.35, 9.2, 0.19, 1.42),
  ('ibge', 670570111, 'CEBOLA - COM MANTEIGA/OLEO', unaccent(lower('CEBOLA - COM MANTEIGA/OLEO')), 'Preparações', 60.15, 1.38, 10.15, 2.02, 1.4),
  ('ibge', 670570112, 'CEBOLA - AO VINAGRETE', unaccent(lower('CEBOLA - AO VINAGRETE')), 'Preparações', 40.0, 1.1, 9.34, 0.1, 1.93),
  ('ibge', 670570199, 'CEBOLA', unaccent(lower('CEBOLA')), 'Preparações', 40.0, 1.1, 9.34, 0.1, 1.93),
  ('ibge', 670580107, 'CATALONHA - REFOGADO(A)', unaccent(lower('CATALONHA - REFOGADO(A)')), 'Preparações', 42.94, 1.88, 4.13, 2.68, 2.1),
  ('ibge', 670610199, 'JARDINEIRA (SELETA)', unaccent(lower('JARDINEIRA (SELETA)')), 'Preparações', 47.0, 2.53, 9.06, 0.26, 2.8),
  ('ibge', 670610299, 'SELETA (JARDINEIRA)', unaccent(lower('SELETA (JARDINEIRA)')), 'Preparações', 47.0, 2.53, 9.06, 0.26, 2.8),
  ('ibge', 670620199, 'ALHO', unaccent(lower('ALHO')), 'Preparações', 149.0, 6.36, 33.06, 0.5, 2.1),
  ('ibge', 670630199, 'ALHO PORO', unaccent(lower('ALHO PORO')), 'Preparações', 54.48, 0.81, 7.62, 2.86, 1.0),
  ('ibge', 670730199, 'BROTO DE ALFAFA', unaccent(lower('BROTO DE ALFAFA')), 'Preparações', 23.0, 3.99, 2.1, 0.69, 1.9),
  ('ibge', 670780199, 'ALFACE ORGANICA', unaccent(lower('ALFACE ORGANICA')), 'Preparações', 15.0, 1.36, 2.79, 0.15, 1.3),
  ('ibge', 670790199, 'TOMATE ORGANICO', unaccent(lower('TOMATE ORGANICO')), 'Preparações', 18.0, 0.88, 3.92, 0.2, 1.2),
  ('ibge', 670800199, 'PIMENTAO ORGANICO', unaccent(lower('PIMENTAO ORGANICO')), 'Preparações', 20.0, 0.86, 4.64, 0.17, 1.7),
  ('ibge', 670970199, 'OREGANO', unaccent(lower('OREGANO')), 'Preparações', 306.0, 11.0, 64.43, 10.25, 42.8),
  ('ibge', 680101799, 'PACOVA', unaccent(lower('PACOVA')), 'Preparações', 78.0, 1.2, 20.3, 0.1, 2.0),
  ('ibge', 680110101, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - CRU(A)', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - CRU(A)')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680110102, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - COZIDO(A)', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - COZIDO(A)')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680110104, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - ASSADO(A)', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - ASSADO(A)')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680110105, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - FRITO(A)', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - FRITO(A)')), 'Preparações', 213.1, 1.22, 25.47, 13.25, 2.9),
  ('ibge', 680110106, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 213.1, 1.22, 25.47, 13.25, 2.9),
  ('ibge', 680110111, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - COM MANTEIGA/OLEO', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - COM MANTEIGA/OLEO')), 'Preparações', 195.41, 1.33, 25.48, 11.24, 2.9),
  ('ibge', 680110113, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - ENSOPADO', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - ENSOPADO')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680110114, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - MINGAU', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - MINGAU')), 'Preparações', 112.04, 2.29, 23.18, 1.72, 1.54),
  ('ibge', 680110115, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - SOPA', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC) - SOPA')), 'Preparações', 112.04, 2.29, 23.18, 1.72, 1.54),
  ('ibge', 680110199, 'BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC)', unaccent(lower('BANANA (OURO, PRATA, D´ÁGUA, DA TERRA, ETC)')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680180199, 'LARANJA (PERA, SELETA, LIMA, DA TERRA, ETC)', unaccent(lower('LARANJA (PERA, SELETA, LIMA, DA TERRA, ETC)')), 'Preparações', 47.0, 0.94, 11.75, 0.12, 2.35),
  ('ibge', 680190199, 'LIMA', unaccent(lower('LIMA')), 'Preparações', 47.0, 0.94, 11.75, 0.12, 2.35),
  ('ibge', 680200199, 'LIMAO (COMUM, GALEGO, ETC)', unaccent(lower('LIMAO (COMUM, GALEGO, ETC)')), 'Preparações', 30.0, 0.7, 10.54, 0.2, 2.8),
  ('ibge', 680220199, 'TANGERINA', unaccent(lower('TANGERINA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680220299, 'MEXERICA', unaccent(lower('MEXERICA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680221799, 'BERGAMOTA', unaccent(lower('BERGAMOTA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680221899, 'MIMOSA', unaccent(lower('MIMOSA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680222399, 'TANJA', unaccent(lower('TANJA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680222799, 'MARICOTA', unaccent(lower('MARICOTA')), 'Preparações', 53.0, 0.81, 13.34, 0.31, 1.8),
  ('ibge', 680240799, 'LARANJINHA JAPONESA', unaccent(lower('LARANJINHA JAPONESA')), 'Preparações', 47.0, 0.94, 11.75, 0.12, 2.35),
  ('ibge', 680250199, 'CANA DE ACUCAR', unaccent(lower('CANA DE ACUCAR')), 'Preparações', 73.58, 0, 19.97, 0.05, 0),
  ('ibge', 680260199, 'ABACAXI', unaccent(lower('ABACAXI')), 'Preparações', 48.0, 0.54, 12.63, 0.12, 1.4),
  ('ibge', 680260299, 'ANANAS', unaccent(lower('ANANAS')), 'Preparações', 48.0, 0.54, 12.63, 0.12, 1.4),
  ('ibge', 680270199, 'ABACATE', unaccent(lower('ABACATE')), 'Preparações', 120.0, 2.23, 7.82, 10.06, 5.6),
  ('ibge', 680280199, 'CAQUI', unaccent(lower('CAQUI')), 'Preparações', 70.0, 0.58, 18.59, 0.19, 3.6),
  ('ibge', 680290199, 'FIGO', unaccent(lower('FIGO')), 'Preparações', 74.0, 0.75, 19.18, 0.3, 2.9),
  ('ibge', 680300199, 'MACA', unaccent(lower('MACA')), 'Preparações', 52.0, 0.26, 13.81, 0.17, 2.4),
  ('ibge', 680310199, 'MAMAO', unaccent(lower('MAMAO')), 'Preparações', 39.0, 0.61, 9.81, 0.14, 1.8),
  ('ibge', 680310899, 'PAPAIA', unaccent(lower('PAPAIA')), 'Preparações', 39.0, 0.61, 9.81, 0.14, 1.8),
  ('ibge', 680320199, 'MANGA', unaccent(lower('MANGA')), 'Preparações', 65.0, 0.51, 17.0, 0.27, 1.76),
  ('ibge', 680321599, 'MANGUITO', unaccent(lower('MANGUITO')), 'Preparações', 65.0, 0.51, 17.0, 0.27, 1.76),
  ('ibge', 680330199, 'MARACUJA', unaccent(lower('MARACUJA')), 'Preparações', 97.0, 2.2, 23.38, 0.7, 10.4),
  ('ibge', 680340199, 'MELANCIA', unaccent(lower('MELANCIA')), 'Preparações', 30.0, 0.61, 7.55, 0.15, 0.4),
  ('ibge', 680350199, 'MELAO', unaccent(lower('MELAO')), 'Preparações', 36.0, 0.54, 9.09, 0.14, 0.8),
  ('ibge', 680360199, 'PERA', unaccent(lower('PERA')), 'Preparações', 58.0, 0.38, 15.46, 0.12, 3.16),
  ('ibge', 680370199, 'PESSEGO', unaccent(lower('PESSEGO')), 'Preparações', 39.0, 0.91, 9.54, 0.25, 1.5),
  ('ibge', 680380199, 'FRUTA DE CONDE', unaccent(lower('FRUTA DE CONDE')), 'Preparações', 74.0, 1.65, 17.7, 0.62, 2.3),
  ('ibge', 680380299, 'PINHA (FRUTA DE CONDE)', unaccent(lower('PINHA (FRUTA DE CONDE)')), 'Preparações', 74.0, 1.65, 17.7, 0.62, 2.3),
  ('ibge', 680380399, 'ATA', unaccent(lower('ATA')), 'Preparações', 74.0, 1.65, 17.7, 0.62, 2.3),
  ('ibge', 680390199, 'UVA', unaccent(lower('UVA')), 'Preparações', 69.0, 0.72, 18.1, 0.16, 0.9),
  ('ibge', 680391299, 'UVA PASSA', unaccent(lower('UVA PASSA')), 'Preparações', 299.0, 3.07, 79.18, 0.46, 3.7),
  ('ibge', 680400199, 'JENIPAPO', unaccent(lower('JENIPAPO')), 'Preparações', 113.0, 5.2, 25.7, 0.3, 9.4),
  ('ibge', 680410199, 'JACA', unaccent(lower('JACA')), 'Preparações', 94.0, 1.47, 24.01, 0.3, 1.6),
  ('ibge', 680420199, 'GOIABA', unaccent(lower('GOIABA')), 'Preparações', 68.0, 2.55, 14.32, 0.95, 5.4),
  ('ibge', 680420399, 'ARACA ACU (GOIABA)', unaccent(lower('ARACA ACU (GOIABA)')), 'Preparações', 68.0, 2.55, 14.32, 0.95, 5.4),
  ('ibge', 680430199, 'AMEIXA', unaccent(lower('AMEIXA')), 'Preparações', 46.0, 0.7, 11.42, 0.28, 1.4),
  ('ibge', 680440199, 'CAJU', unaccent(lower('CAJU')), 'Preparações', 43.0, 1.0, 10.3, 0.3, 1.7),
  ('ibge', 680450199, 'CEREJA', unaccent(lower('CEREJA')), 'Preparações', 63.0, 1.06, 16.01, 0.2, 2.1),
  ('ibge', 680460199, 'CAJA MANGA', unaccent(lower('CAJA MANGA')), 'Preparações', 46.0, 1.3, 11.4, 0, 2.6),
  ('ibge', 680460299, 'CAJARANA', unaccent(lower('CAJARANA')), 'Preparações', 46.0, 0.2, 12.4, 0.1, 1.1),
  ('ibge', 680470199, 'TAPEREBA', unaccent(lower('TAPEREBA')), 'Preparações', 70.0, 0.8, 13.8, 2.1, 1.0),
  ('ibge', 680470299, 'ACAJA (TABEREBA)', unaccent(lower('ACAJA (TABEREBA)')), 'Preparações', 46.0, 1.3, 11.4, 0, 2.6),
  ('ibge', 680480199, 'CARAMBOLA', unaccent(lower('CARAMBOLA')), 'Preparações', 31.0, 1.04, 6.73, 0.33, 2.8),
  ('ibge', 680490199, 'JABOTICABA', unaccent(lower('JABOTICABA')), 'Preparações', 73.0, 0.66, 18.4, 0.5, 7.0),
  ('ibge', 680500199, 'GRAVIOLA', unaccent(lower('GRAVIOLA')), 'Preparações', 62.0, 0.8, 15.8, 0.2, 1.9),
  ('ibge', 680520199, 'MORANGO', unaccent(lower('MORANGO')), 'Preparações', 32.0, 0.67, 7.68, 0.3, 2.0),
  ('ibge', 680530199, 'JAMBO', unaccent(lower('JAMBO')), 'Preparações', 27.0, 0.9, 6.5, 0.1, 5.1),
  ('ibge', 680540199, 'ATEMOIA', unaccent(lower('ATEMOIA')), 'Preparações', 74.0, 1.65, 17.7, 0.62, 2.3),
  ('ibge', 680560199, 'MANGABA', unaccent(lower('MANGABA')), 'Preparações', 43.0, 0.7, 10.5, 0.3, 0.8),
  ('ibge', 680570199, 'ARACA', unaccent(lower('ARACA')), 'Preparações', 68.0, 2.55, 14.32, 0.95, 5.4),
  ('ibge', 680580199, 'NESPERA', unaccent(lower('NESPERA')), 'Preparações', 47.0, 0.43, 12.14, 0.2, 1.7),
  ('ibge', 680590199, 'FRUTA PAO', unaccent(lower('FRUTA PAO')), 'Preparações', 103.0, 1.07, 27.12, 0.23, 4.9),
  ('ibge', 680600199, 'SAPOTI', unaccent(lower('SAPOTI')), 'Preparações', 96.0, 0.7, 25.9, 0.1, 9.9),
  ('ibge', 680610199, 'UXI', unaccent(lower('UXI')), 'Preparações', 252.0, 2.2, 38.2, 10.1, 20.5),
  ('ibge', 680620199, 'TAMARINDO', unaccent(lower('TAMARINDO')), 'Preparações', 239.0, 2.8, 62.5, 0.6, 5.1),
  ('ibge', 680630199, 'CACAU', unaccent(lower('CACAU')), 'Preparações', 74.0, 1.0, 19.4, 0.1, 2.2),
  ('ibge', 680640199, 'PITOMBA', unaccent(lower('PITOMBA')), 'Preparações', 66.0, 0.83, 16.53, 0.44, 1.3),
  ('ibge', 680650199, 'BACURI', unaccent(lower('BACURI')), 'Preparações', 105.0, 1.9, 22.8, 2.0, 7.4),
  ('ibge', 680660199, 'INGA', unaccent(lower('INGA')), 'Preparações', 60.0, 1.0, 15.5, 0.1, 1.2),
  ('ibge', 680670199, 'PEQUI', unaccent(lower('PEQUI')), 'Preparações', 152.0, 1.5, 6.3, 13.4, 4.7),
  ('ibge', 680680199, 'PITANGA', unaccent(lower('PITANGA')), 'Preparações', 41.0, 0.9, 10.2, 0.2, 3.2),
  ('ibge', 680690199, 'CIRIGUELA', unaccent(lower('CIRIGUELA')), 'Preparações', 76.0, 1.4, 18.9, 0.4, 3.9),
  ('ibge', 680700199, 'MURICI', unaccent(lower('MURICI')), 'Preparações', 66.0, 0.9, 14.4, 1.3, 2.2),
  ('ibge', 680710199, 'UMBU', unaccent(lower('UMBU')), 'Preparações', 37.0, 0.8, 9.4, 0, 2.0),
  ('ibge', 680710399, 'IMBU', unaccent(lower('IMBU')), 'Preparações', 37.0, 0.8, 9.4, 0, 2.0),
  ('ibge', 680720299, 'BIRIBA', unaccent(lower('BIRIBA')), 'Preparações', 74.0, 1.65, 17.7, 0.62, 2.3),
  ('ibge', 680730199, 'CUPUACU', unaccent(lower('CUPUACU')), 'Preparações', 49.0, 1.2, 10.4, 1.0, 3.1),
  ('ibge', 680740199, 'NECTARINA', unaccent(lower('NECTARINA')), 'Preparações', 44.0, 1.06, 10.55, 0.32, 1.7),
  ('ibge', 680750199, 'MARI', unaccent(lower('MARI')), 'Preparações', 281.1, 2.7, 20.1, 21.1, 0),
  ('ibge', 680760199, 'ROMA', unaccent(lower('ROMA')), 'Preparações', 56.0, 0.4, 15.1, 0, 0.4),
  ('ibge', 680770199, 'ACEROLA', unaccent(lower('ACEROLA')), 'Preparações', 32.0, 0.4, 7.69, 0.3, 1.1),
  ('ibge', 680780199, 'KIWI', unaccent(lower('KIWI')), 'Preparações', 61.0, 1.14, 14.66, 0.52, 3.0),
  ('ibge', 680800199, 'ABIU', unaccent(lower('ABIU')), 'Preparações', 62.0, 0.8, 14.9, 0.7, 1.7),
  ('ibge', 680820199, 'JURUBEBA', unaccent(lower('JURUBEBA')), 'Preparações', 126.0, 4.4, 23.1, 3.9, 1.2),
  ('ibge', 680840199, 'FRUTA (NAO ESPECIFICADA)', unaccent(lower('FRUTA (NAO ESPECIFICADA)')), 'Preparações', 89.0, 1.09, 22.84, 0.33, 2.6),
  ('ibge', 680860199, 'MACA ORGANICA', unaccent(lower('MACA ORGANICA')), 'Preparações', 52.0, 0.26, 13.81, 0.17, 2.4),
  ('ibge', 680890199, 'ACEROLA ORGANICA', unaccent(lower('ACEROLA ORGANICA')), 'Preparações', 32.0, 0.4, 7.69, 0.3, 1.1),
  ('ibge', 680990199, 'AMORA', unaccent(lower('AMORA')), 'Preparações', 43.0, 1.39, 9.61, 0.49, 5.3),
  ('ibge', 681020199, 'JAMELAO (JAMBURAO)', unaccent(lower('JAMELAO (JAMBURAO)')), 'Preparações', 73.0, 0.66, 18.4, 0.5, 7.0),
  ('ibge', 690030299, 'DEMERARA', unaccent(lower('DEMERARA')), 'Preparações', 387.0, 0, 99.98, 0, 0),
  ('ibge', 690030499, 'ACUCAR MASCAVO', unaccent(lower('ACUCAR MASCAVO')), 'Preparações', 380.0, 0.12, 98.09, 0, 0),
  ('ibge', 690040199, 'RAPADURA', unaccent(lower('RAPADURA')), 'Preparações', 296.0, 0, 76.6, 0, 0),
  ('ibge', 690040299, 'ALFENIM DE CANA', unaccent(lower('ALFENIM DE CANA')), 'Preparações', 296.0, 0, 76.6, 0, 0),
  ('ibge', 690040399, 'BATIDA (RAPADURA)', unaccent(lower('BATIDA (RAPADURA)')), 'Preparações', 380.0, 0.12, 98.09, 0, 0),
  ('ibge', 690050199, 'SORVETE DE QUALQUER SABOR INDUSTRIALIZADO', unaccent(lower('SORVETE DE QUALQUER SABOR INDUSTRIALIZADO')), 'Preparações', 206.0, 3.6, 25.13, 11.0, 0.87),
  ('ibge', 690050299, 'PICOLE DE QUALQUER SABOR INDUSTRIALIZADO', unaccent(lower('PICOLE DE QUALQUER SABOR INDUSTRIALIZADO')), 'Preparações', 79.0, 0, 19.23, 0.24, 0),
  ('ibge', 690060199, 'CHICLETE', unaccent(lower('CHICLETE')), 'Preparações', 396.0, 0, 98.9, 0, 0.1),
  ('ibge', 690060399, 'BALA', unaccent(lower('BALA')), 'Preparações', 394.0, 0, 98.0, 0.2, 0),
  ('ibge', 690060499, 'CARAMELO (BALA)', unaccent(lower('CARAMELO (BALA)')), 'Preparações', 382.0, 4.6, 77.0, 8.1, 0),
  ('ibge', 690060599, 'DROPS', unaccent(lower('DROPS')), 'Preparações', 394.0, 0, 98.0, 0.2, 0),
  ('ibge', 690060699, 'PASTILHA', unaccent(lower('PASTILHA')), 'Preparações', 396.0, 0, 98.9, 0, 0.1),
  ('ibge', 690060799, 'PIRULITO', unaccent(lower('PIRULITO')), 'Preparações', 394.0, 0, 98.0, 0.2, 0),
  ('ibge', 690060999, 'GOMA DE MASCAR', unaccent(lower('GOMA DE MASCAR')), 'Preparações', 396.0, 0, 98.9, 0, 0.1),
  ('ibge', 690061099, 'JUJUBA', unaccent(lower('JUJUBA')), 'Preparações', 375.0, 0, 93.55, 0.05, 0.2),
  ('ibge', 690070199, 'TABLETE DE CHOCOLATE', unaccent(lower('TABLETE DE CHOCOLATE')), 'Preparações', 535.0, 7.65, 59.4, 29.66, 3.4),
  ('ibge', 690070299, 'BARRA DE CHOCOLATE', unaccent(lower('BARRA DE CHOCOLATE')), 'Preparações', 535.0, 7.65, 59.4, 29.66, 3.4),
  ('ibge', 690070699, 'CONFETE', unaccent(lower('CONFETE')), 'Preparações', 492.0, 4.33, 71.19, 21.13, 2.8),
  ('ibge', 690080199, 'CHOCOLATE EM PO DE QUALQUER MARCA', unaccent(lower('CHOCOLATE EM PO DE QUALQUER MARCA')), 'Preparações', 364.24, 2.83, 85.53, 3.55, 1.66),
  ('ibge', 690081899, 'OVOMALTINE', unaccent(lower('OVOMALTINE')), 'Preparações', 388.0, 9.17, 75.13, 5.19, 1.98),
  ('ibge', 690082199, 'ACHOCOLATADO EM PO', unaccent(lower('ACHOCOLATADO EM PO')), 'Preparações', 400.0, 4.55, 90.28, 2.27, 4.5),
  ('ibge', 690082299, 'TODDYNHO', unaccent(lower('TODDYNHO')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 690090199, 'BOMBOM DE QUALQUER MARCA', unaccent(lower('BOMBOM DE QUALQUER MARCA')), 'Preparações', 373.0, 0, 93.18, 0.02, 0),
  ('ibge', 690090499, 'TRUFA', unaccent(lower('TRUFA')), 'Preparações', 487.87, 3.57, 49.06, 36.26, 4.55),
  ('ibge', 690100199, 'GELEIA DE FRUTAS DE QUALQUER MARCA OU SABOR', unaccent(lower('GELEIA DE FRUTAS DE QUALQUER MARCA OU SABOR')), 'Preparações', 278.0, 0.37, 68.86, 0.07, 1.1),
  ('ibge', 690100299, 'MOUSSE DE QUALQUER SABOR (GELÉIA)', unaccent(lower('MOUSSE DE QUALQUER SABOR (GELÉIA)')), 'Preparações', 331.89, 5.09, 32.19, 21.87, 1.18),
  ('ibge', 690110199, 'GELEIA DE MOCOTO', unaccent(lower('GELEIA DE MOCOTO')), 'Preparações', 120.25, 3.04, 27.99, 0, 0),
  ('ibge', 690120199, 'DOCE DE FRUTAS EM PASTA DE QUALQUER SABOR', unaccent(lower('DOCE DE FRUTAS EM PASTA DE QUALQUER SABOR')), 'Preparações', 291.3, 0.77, 74.28, 0.29, 1.62),
  ('ibge', 690120399, 'PASTA DE AMENDOIM', unaccent(lower('PASTA DE AMENDOIM')), 'Preparações', 588.0, 25.09, 19.56, 50.39, 6.0),
  ('ibge', 690120499, 'PESSEGADA', unaccent(lower('PESSEGADA')), 'Preparações', 77.0, 0.54, 19.79, 0.14, 2.2),
  ('ibge', 690120699, 'MARMELADA', unaccent(lower('MARMELADA')), 'Preparações', 278.0, 0.37, 68.86, 0.07, 1.1),
  ('ibge', 690120999, 'FIGADA', unaccent(lower('FIGADA')), 'Preparações', 88.0, 0.38, 22.9, 0.1, 2.2),
  ('ibge', 690121199, 'GOIABADA', unaccent(lower('GOIABADA')), 'Preparações', 291.3, 0.77, 74.28, 0.29, 1.62),
  ('ibge', 690121499, 'CAJU EM PASTA', unaccent(lower('CAJU EM PASTA')), 'Preparações', 291.3, 0.77, 74.28, 0.29, 1.62),
  ('ibge', 690122499, 'MARIOLA', unaccent(lower('MARIOLA')), 'Preparações', 291.3, 0.77, 74.28, 0.29, 1.62),
  ('ibge', 690130199, 'DOCE DE FRUTAS EM CALDA DE QUALQUER SABOR', unaccent(lower('DOCE DE FRUTAS EM CALDA DE QUALQUER SABOR')), 'Preparações', 77.0, 0.54, 19.79, 0.14, 2.2),
  ('ibge', 690140199, 'DOCE DE FRUTAS CRISTALIZADO DE QUALQUER SABOR', unaccent(lower('DOCE DE FRUTAS CRISTALIZADO DE QUALQUER SABOR')), 'Preparações', 291.3, 0.77, 74.28, 0.29, 1.62),
  ('ibge', 690150199, 'MELADO', unaccent(lower('MELADO')), 'Preparações', 296.0, 0, 76.6, 0, 0),
  ('ibge', 690160299, 'MEL', unaccent(lower('MEL')), 'Preparações', 304.0, 0.3, 82.4, 0, 0.2),
  ('ibge', 690170199, 'GELATINA DE QUALQUER SABOR', unaccent(lower('GELATINA DE QUALQUER SABOR')), 'Preparações', 278.0, 0.37, 68.86, 0.07, 1.1),
  ('ibge', 690200499, 'MERENGUE', unaccent(lower('MERENGUE')), 'Preparações', 358.26, 6.21, 85.89, 0.1, 0.0),
  ('ibge', 690230199, 'SCHIMIER DE CANA', unaccent(lower('SCHIMIER DE CANA')), 'Preparações', 296.0, 0, 76.6, 0, 0),
  ('ibge', 690240199, 'FRUTA SECA OU DESIDRATADA', unaccent(lower('FRUTA SECA OU DESIDRATADA')), 'Preparações', 240.0, 2.18, 63.88, 0.38, 7.1),
  ('ibge', 690240299, 'PASSA', unaccent(lower('PASSA')), 'Preparações', 299.0, 3.07, 79.18, 0.46, 3.7),
  ('ibge', 690260199, 'PUDIM DE QUALQUER SABOR', unaccent(lower('PUDIM DE QUALQUER SABOR')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690260799, 'DANETTE PUDIM', unaccent(lower('DANETTE PUDIM')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690270199, 'MANJAR', unaccent(lower('MANJAR')), 'Preparações', 284.98, 8.2, 40.14, 10.74, 0.34),
  ('ibge', 690290199, 'CUSCUZ', unaccent(lower('CUSCUZ')), 'Preparações', 128.3, 4.35, 26.42, 0.22, 1.71),
  ('ibge', 690290299, 'CUSCUZ DE TAPIOCA', unaccent(lower('CUSCUZ DE TAPIOCA')), 'Preparações', 116.99, 4.33, 15.51, 4.1, 0.03),
  ('ibge', 690300199, 'MARIA MOLE', unaccent(lower('MARIA MOLE')), 'Preparações', 444.92, 1.64, 68.84, 19.94, 2.59),
  ('ibge', 690310199, 'COCADA', unaccent(lower('COCADA')), 'Preparações', 404.8, 1.01, 75.65, 12.46, 1.58),
  ('ibge', 690310299, 'QUEBRA QUEIXO', unaccent(lower('QUEBRA QUEIXO')), 'Preparações', 404.8, 1.01, 75.65, 12.46, 1.58),
  ('ibge', 690320199, 'DOCE DE AMENDOIM', unaccent(lower('DOCE DE AMENDOIM')), 'Preparações', 451.58, 11.16, 55.29, 23.89, 3.73),
  ('ibge', 690320299, 'PE DE MOLEQUE', unaccent(lower('PE DE MOLEQUE')), 'Preparações', 474.0, 9.1, 69.2, 17.91, 2.42),
  ('ibge', 690320399, 'PACOCA', unaccent(lower('PACOCA')), 'Preparações', 472.17, 10.35, 64.04, 21.53, 3.89),
  ('ibge', 690320499, 'TORRAO DE AMENDOIM', unaccent(lower('TORRAO DE AMENDOIM')), 'Preparações', 460.34, 11.01, 56.27, 24.64, 6.13),
  ('ibge', 690320599, 'PACOQUINHA DE AMENDOIM', unaccent(lower('PACOQUINHA DE AMENDOIM')), 'Preparações', 472.17, 10.35, 64.04, 21.53, 3.89),
  ('ibge', 690320799, 'AMENDOIM CARAMELIZADO', unaccent(lower('AMENDOIM CARAMELIZADO')), 'Preparações', 474.0, 9.1, 69.2, 17.91, 2.42),
  ('ibge', 690320899, 'AMENDOIM AMANTEIGADO', unaccent(lower('AMENDOIM AMANTEIGADO')), 'Preparações', 567.0, 25.8, 16.13, 49.24, 8.5),
  ('ibge', 690320999, 'AMENDOIM ACHOCOLATADO', unaccent(lower('AMENDOIM ACHOCOLATADO')), 'Preparações', 519.0, 13.1, 49.7, 33.5, 4.7),
  ('ibge', 690330399, 'AMENDOIM APIMENTADO', unaccent(lower('AMENDOIM APIMENTADO')), 'Preparações', 567.0, 25.8, 16.13, 49.24, 8.5),
  ('ibge', 690330499, 'AMENDOIM COZIDO', unaccent(lower('AMENDOIM COZIDO')), 'Preparações', 318.0, 13.5, 21.26, 22.01, 8.8),
  ('ibge', 690360199, 'BRIGADEIRO', unaccent(lower('BRIGADEIRO')), 'Preparações', 334.48, 7.52, 54.86, 10.14, 0.23),
  ('ibge', 690370199, 'BOMBA DE QUALQUER TIPO', unaccent(lower('BOMBA DE QUALQUER TIPO')), 'Preparações', 339.25, 6.32, 18.55, 26.93, 0.54),
  ('ibge', 690380199, 'MIL FOLHAS', unaccent(lower('MIL FOLHAS')), 'Preparações', 440.33, 2.36, 43.22, 29.03, 0.42),
  ('ibge', 690390199, 'QUEIJADINHA', unaccent(lower('QUEIJADINHA')), 'Preparações', 404.8, 1.01, 75.65, 12.46, 1.58),
  ('ibge', 690410199, 'DOCE A BASE DE OVOS', unaccent(lower('DOCE A BASE DE OVOS')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690410499, 'CACAROLA ITALIANA', unaccent(lower('CACAROLA ITALIANA')), 'Preparações', 284.98, 8.2, 40.14, 10.74, 0.34),
  ('ibge', 690410599, 'QUINDIM', unaccent(lower('QUINDIM')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690410899, 'FIOS DE OVOS', unaccent(lower('FIOS DE OVOS')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690420199, 'DOCE A BASE DE LEITE', unaccent(lower('DOCE A BASE DE LEITE')), 'Preparações', 319.69, 7.88, 54.18, 8.66, 0),
  ('ibge', 690420299, 'PAVE DE QUALQUER SABOR', unaccent(lower('PAVE DE QUALQUER SABOR')), 'Preparações', 306.43, 4.93, 21.59, 22.24, 0.36),
  ('ibge', 690420399, 'AMBROSIA', unaccent(lower('AMBROSIA')), 'Preparações', 144.23, 4.09, 23.88, 3.84, 0.26),
  ('ibge', 690420499, 'LEITE GELEIFICADO', unaccent(lower('LEITE GELEIFICADO')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690420599, 'CHANDELE DE QUALQUER SABOR', unaccent(lower('CHANDELE DE QUALQUER SABOR')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690430299, 'MUMU', unaccent(lower('MUMU')), 'Preparações', 319.69, 7.88, 54.18, 8.66, 0),
  ('ibge', 690440199, 'CANUDINHO RECHEADO', unaccent(lower('CANUDINHO RECHEADO')), 'Preparações', 123.26, 2.43, 21.33, 4.5, 2.22),
  ('ibge', 690450199, 'SAROLHO', unaccent(lower('SAROLHO')), 'Preparações', 336.0, 2.0, 82.0, 0, 0),
  ('ibge', 690450299, 'BEIJU', unaccent(lower('BEIJU')), 'Preparações', 336.0, 2.0, 82.0, 0, 0),
  ('ibge', 690460199, 'SCHIMIER DE FRUTA (EXCETO DE CANA)', unaccent(lower('SCHIMIER DE FRUTA (EXCETO DE CANA)')), 'Preparações', 278.0, 0.37, 68.86, 0.07, 1.1),
  ('ibge', 690470199, 'BEIJO DE MOCA', unaccent(lower('BEIJO DE MOCA')), 'Preparações', 387.0, 0, 99.98, 0, 0),
  ('ibge', 690480199, 'PICOLE ENSACADO', unaccent(lower('PICOLE ENSACADO')), 'Preparações', 79.0, 0, 19.23, 0.24, 0),
  ('ibge', 690480799, 'GELADINHO', unaccent(lower('GELADINHO')), 'Preparações', 122.69, 0.14, 32.51, 0.09, 0.45),
  ('ibge', 690500199, 'CHURRO', unaccent(lower('CHURRO')), 'Preparações', 401.66, 3.0, 45.94, 23.44, 0.81),
  ('ibge', 690510199, 'PAMONHA', unaccent(lower('PAMONHA')), 'Preparações', 171.0, 2.6, 30.7, 4.8, 2.4),
  ('ibge', 690540199, 'ALGODAO-DOCE', unaccent(lower('ALGODAO-DOCE')), 'Preparações', 387.0, 0, 99.98, 0, 0),
  ('ibge', 690560399, 'IOIO CREME (CHOCOLATE EM CREME)', unaccent(lower('IOIO CREME (CHOCOLATE EM CREME)')), 'Preparações', 350.0, 4.6, 62.9, 8.9, 2.8),
  ('ibge', 690580199, 'OVO DE PASCOA', unaccent(lower('OVO DE PASCOA')), 'Preparações', 535.0, 7.65, 59.4, 29.66, 3.4),
  ('ibge', 690580499, 'KINDER OVO', unaccent(lower('KINDER OVO')), 'Preparações', 535.0, 7.65, 59.4, 29.66, 3.4),
  ('ibge', 690590199, 'TORRONE', unaccent(lower('TORRONE')), 'Preparações', 460.34, 11.01, 56.27, 24.64, 6.13),
  ('ibge', 690600199, 'ARROZ-DOCE', unaccent(lower('ARROZ-DOCE')), 'Preparações', 108.49, 3.05, 18.77, 2.34, 0.1),
  ('ibge', 690640499, 'POLPA DE COCO', unaccent(lower('POLPA DE COCO')), 'Preparações', 402.0, 3.8, 9.8, 41.7, 5.0),
  ('ibge', 690650199, 'DIET SHAKE', unaccent(lower('DIET SHAKE')), 'Preparações', 335.52, 19.19, 69.94, 1.87, 7.39),
  ('ibge', 690650299, 'CONCENTRADO ALIMENTAR DIET SHAKE', unaccent(lower('CONCENTRADO ALIMENTAR DIET SHAKE')), 'Preparações', 335.52, 19.19, 69.94, 1.87, 7.39),
  ('ibge', 690660299, 'ACUCAR', unaccent(lower('ACUCAR')), 'Preparações', 387.0, 0, 99.98, 0, 0),
  ('ibge', 690700199, 'ACUCAR LIGHT', unaccent(lower('ACUCAR LIGHT')), 'Preparações', 400.0, 0, 100.0, 0, 0),
  ('ibge', 690720199, 'BARRA DE CEREAIS', unaccent(lower('BARRA DE CEREAIS')), 'Preparações', 352.92, 3.17, 69.44, 8.55, 2.32),
  ('ibge', 690720299, 'BARRA DE CEREAIS SALGADA', unaccent(lower('BARRA DE CEREAIS SALGADA')), 'Preparações', 352.92, 3.17, 69.44, 8.55, 2.32),
  ('ibge', 690720399, 'BARRA DE CEREAIS DOCE', unaccent(lower('BARRA DE CEREAIS DOCE')), 'Preparações', 352.92, 3.17, 69.44, 8.55, 2.32),
  ('ibge', 690730199, 'SOBREMESA DE QUALQUER TIPO (EXCETO INFANTIL)', unaccent(lower('SOBREMESA DE QUALQUER TIPO (EXCETO INFANTIL)')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690740199, 'RABANADA', unaccent(lower('RABANADA')), 'Preparações', 293.0, 4.7, 31.3, 16.6, 0.5),
  ('ibge', 690750199, 'MILK SHAKE', unaccent(lower('MILK SHAKE')), 'Preparações', 161.09, 3.11, 23.49, 6.43, 0.76),
  ('ibge', 690790199, 'GELEIA DIET', unaccent(lower('GELEIA DIET')), 'Preparações', 52.64, 0.47, 12.72, 0.17, 1.4),
  ('ibge', 690800199, 'DOCE DE FRUTAS DIET', unaccent(lower('DOCE DE FRUTAS DIET')), 'Preparações', 52.64, 0.47, 12.72, 0.17, 1.4),
  ('ibge', 690840199, 'PASTEIS DE SANTA CLARA', unaccent(lower('PASTEIS DE SANTA CLARA')), 'Preparações', 131.15, 5.58, 15.44, 5.07, 0),
  ('ibge', 690850199, 'SUSPIRO', unaccent(lower('SUSPIRO')), 'Preparações', 358.26, 6.21, 85.89, 0.1, 0.0),
  ('ibge', 690930199, 'DOCE DE FRUTAS CRISTALIZADO DE QUALQUER SABOR DIET', unaccent(lower('DOCE DE FRUTAS CRISTALIZADO DE QUALQUER SABOR DIET')), 'Preparações', 52.64, 0.47, 12.72, 0.17, 1.4),
  ('ibge', 690960199, 'SORVETE DE QUALQUER SABOR INDUSTRIALIZADO LIGHT', unaccent(lower('SORVETE DE QUALQUER SABOR INDUSTRIALIZADO LIGHT')), 'Preparações', 188.99, 4.43, 26.14, 7.67, 0.6),
  ('ibge', 690970199, 'SORVETE DE QUALQUER SABOR INDUSTRIALIZADO DIET', unaccent(lower('SORVETE DE QUALQUER SABOR INDUSTRIALIZADO DIET')), 'Preparações', 190.0, 3.17, 15.87, 12.7, 4.8),
  ('ibge', 690980399, 'BALA LIGHT', unaccent(lower('BALA LIGHT')), 'Preparações', 235.0, 0, 95.0, 0, 0),
  ('ibge', 690990199, 'CHICLETE DIET', unaccent(lower('CHICLETE DIET')), 'Preparações', 240.0, 0, 100.0, 0, 0),
  ('ibge', 690990399, 'BALA DIET', unaccent(lower('BALA DIET')), 'Preparações', 235.0, 0, 95.0, 0, 0),
  ('ibge', 691000299, 'BARRA DE CHOCOLATE LIGHT', unaccent(lower('BARRA DE CHOCOLATE LIGHT')), 'Preparações', 539.78, 10.58, 40.42, 41.64, 4.32),
  ('ibge', 691010299, 'BARRA DE CHOCOLATE DIET', unaccent(lower('BARRA DE CHOCOLATE DIET')), 'Preparações', 539.78, 10.58, 40.42, 41.64, 4.32),
  ('ibge', 691022199, 'ACHOCOLATADO EM PO LIGHT', unaccent(lower('ACHOCOLATADO EM PO LIGHT')), 'Preparações', 337.7, 29.42, 55.3, 2.39, 4.43),
  ('ibge', 691032199, 'ACHOCOLATADO EM PO DIET', unaccent(lower('ACHOCOLATADO EM PO DIET')), 'Preparações', 337.7, 29.42, 55.3, 2.39, 4.43),
  ('ibge', 691032299, 'TODDYNHO DIET', unaccent(lower('TODDYNHO DIET')), 'Preparações', 73.29, 3.48, 7.09, 3.51, 0.39),
  ('ibge', 691040199, 'BOMBOM DE QUALQUER MARCA LIGHT', unaccent(lower('BOMBOM DE QUALQUER MARCA LIGHT')), 'Preparações', 373.0, 0, 93.18, 0.02, 0),
  ('ibge', 691050199, 'BOMBOM DE QUALQUER MARCA DIET', unaccent(lower('BOMBOM DE QUALQUER MARCA DIET')), 'Preparações', 373.0, 0, 93.18, 0.02, 0),
  ('ibge', 691050299, 'BOMBOM CARAMELIZADO DE QUALQUER MARCA DIET', unaccent(lower('BOMBOM CARAMELIZADO DE QUALQUER MARCA DIET')), 'Preparações', 373.0, 0, 93.18, 0.02, 0),
  ('ibge', 691060199, 'GELEIA DE FRUTAS DE QUALQUER MARCA OU SABOR LIGHT', unaccent(lower('GELEIA DE FRUTAS DE QUALQUER MARCA OU SABOR LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691060499, 'GELEIA LIGHT', unaccent(lower('GELEIA LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691060599, 'GELEIA DE FRUTAS LIGHT', unaccent(lower('GELEIA DE FRUTAS LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691070199, 'DOCE DE FRUTAS EM BARRA OU PASTA LIGHT', unaccent(lower('DOCE DE FRUTAS EM BARRA OU PASTA LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691070299, 'DOCE DE FRUTAS EM PASTA LIGHT', unaccent(lower('DOCE DE FRUTAS EM PASTA LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691080199, 'PUDIM DE QUALQUER SABOR LIGHT', unaccent(lower('PUDIM DE QUALQUER SABOR LIGHT')), 'Preparações', 119.15, 5.68, 15.75, 3.55, 0),
  ('ibge', 691080899, 'PUDIM DANETTE LIGHT', unaccent(lower('PUDIM DANETTE LIGHT')), 'Preparações', 119.15, 5.68, 15.75, 3.55, 0),
  ('ibge', 691090199, 'PUDIM DE QUALQUER SABOR DIET', unaccent(lower('PUDIM DE QUALQUER SABOR DIET')), 'Preparações', 119.15, 5.68, 15.75, 3.55, 0),
  ('ibge', 691120199, 'DOCE DE LEITE LIGHT', unaccent(lower('DOCE DE LEITE LIGHT')), 'Preparações', 292.29, 7.58, 58.98, 3.62, 0),
  ('ibge', 691130199, 'DOCE DE LEITE DIET', unaccent(lower('DOCE DE LEITE DIET')), 'Preparações', 292.29, 7.58, 58.98, 3.62, 0),
  ('ibge', 691250199, 'BARRA DE CEREAIS DIET', unaccent(lower('BARRA DE CEREAIS DIET')), 'Preparações', 403.45, 5.56, 86.36, 5.44, 7.2),
  ('ibge', 691250299, 'BARRA DE CEREAIS DOCE DIET', unaccent(lower('BARRA DE CEREAIS DOCE DIET')), 'Preparações', 403.45, 5.56, 86.36, 5.44, 7.2),
  ('ibge', 691280199, 'MILK SHAKE DIET', unaccent(lower('MILK SHAKE DIET')), 'Preparações', 335.52, 19.19, 69.94, 1.87, 7.39),
  ('ibge', 691300199, 'COCADA DIET', unaccent(lower('COCADA DIET')), 'Preparações', 404.8, 1.01, 75.65, 12.46, 1.58),
  ('ibge', 691310199, 'DOCE DE AMENDOIM DIET', unaccent(lower('DOCE DE AMENDOIM DIET')), 'Preparações', 599.0, 28.03, 15.26, 52.5, 9.4),
  ('ibge', 691310399, 'PACOCA DIET', unaccent(lower('PACOCA DIET')), 'Preparações', 599.0, 28.03, 15.26, 52.5, 9.4),
  ('ibge', 691310899, 'AMENDOIM AMANTEIGADO DIET', unaccent(lower('AMENDOIM AMANTEIGADO DIET')), 'Preparações', 477.86, 7.09, 64.64, 21.64, 2.96),
  ('ibge', 691380199, 'DOCE A BASE DE LEITE DIET', unaccent(lower('DOCE A BASE DE LEITE DIET')), 'Preparações', 292.29, 7.58, 58.98, 3.62, 0),
  ('ibge', 691390199, 'GELATINA DE QUALQUER SABOR LIGHT', unaccent(lower('GELATINA DE QUALQUER SABOR LIGHT')), 'Preparações', 179.0, 0.36, 46.13, 0.05, 0.34),
  ('ibge', 691400199, 'ADOCANTE LIGHT', unaccent(lower('ADOCANTE LIGHT')), 'Preparações', 365.0, 2.17, 89.08, 0, 0),
  ('ibge', 691400299, 'ADOCANTE EM PO LIGHT', unaccent(lower('ADOCANTE EM PO LIGHT')), 'Preparações', 365.0, 2.17, 89.08, 0, 0),
  ('ibge', 700150199, 'MOSTARDA MOLHO', unaccent(lower('MOSTARDA MOLHO')), 'Preparações', 67.0, 4.37, 5.33, 4.01, 3.3),
  ('ibge', 700230499, 'HORTELA', unaccent(lower('HORTELA')), 'Preparações', 1.0, 0, 0.2, 0, 0),
  ('ibge', 700240199, 'ALCAPARRA EM CONSERVA', unaccent(lower('ALCAPARRA EM CONSERVA')), 'Preparações', 23.0, 2.36, 4.89, 0.86, 3.2),
  ('ibge', 700260199, 'COENTRO', unaccent(lower('COENTRO')), 'Preparações', 279.0, 21.93, 52.1, 4.78, 10.4),
  ('ibge', 700360199, 'MOLHO DE SOJA', unaccent(lower('MOLHO DE SOJA')), 'Preparações', 53.0, 6.28, 7.61, 0.04, 0.8),
  ('ibge', 700360499, 'SHOYO', unaccent(lower('SHOYO')), 'Preparações', 53.0, 6.28, 7.61, 0.04, 0.8),
  ('ibge', 700380199, 'LEITE DE COCO', unaccent(lower('LEITE DE COCO')), 'Preparações', 202.46, 1.61, 5.59, 20.85, 0.91),
  ('ibge', 700430199, 'MAIONESE (MOLHO)', unaccent(lower('MAIONESE (MOLHO)')), 'Preparações', 261.05, 0.47, 13.38, 23.33, 0.06),
  ('ibge', 700470199, 'MASSA DE TOMATE', unaccent(lower('MASSA DE TOMATE')), 'Preparações', 38.0, 1.65, 8.98, 0.21, 1.9),
  ('ibge', 700480199, 'MOLHO DE TOMATE', unaccent(lower('MOLHO DE TOMATE')), 'Preparações', 24.0, 1.32, 5.38, 0.18, 1.5),
  ('ibge', 700480299, 'KETCHUP', unaccent(lower('KETCHUP')), 'Preparações', 97.0, 1.74, 25.15, 0.31, 0.3),
  ('ibge', 700480399, 'CATCHUP', unaccent(lower('CATCHUP')), 'Preparações', 97.0, 1.74, 25.15, 0.31, 0.3),
  ('ibge', 700610199, 'PIMENTA EM PO', unaccent(lower('PIMENTA EM PO')), 'Preparações', 255.0, 10.95, 64.81, 3.26, 26.5),
  ('ibge', 700710199, 'TUCUPI EM CALDO SEM PIMENTA', unaccent(lower('TUCUPI EM CALDO SEM PIMENTA')), 'Preparações', 4.87, 0.01, 1.3, 0.0, 0.01),
  ('ibge', 700750299, 'CREME DE QUEIJO', unaccent(lower('CREME DE QUEIJO')), 'Preparações', 209.66, 10.34, 6.72, 15.81, 0.1),
  ('ibge', 700770199, 'CALDO DE PEIXE', unaccent(lower('CALDO DE PEIXE')), 'Preparações', 16.0, 2.0, 0.4, 0.6, 0),
  ('ibge', 700790199, 'CALDO DE TOMATE', unaccent(lower('CALDO DE TOMATE')), 'Preparações', 37.65, 0.75, 7.39, 0.78, 0.46),
  ('ibge', 700910299, 'GERGELIM', unaccent(lower('GERGELIM')), 'Preparações', 631.0, 20.45, 11.73, 61.21, 11.6),
  ('ibge', 701030199, 'TOMATE SECO', unaccent(lower('TOMATE SECO')), 'Preparações', 213.0, 5.06, 23.33, 14.08, 5.8),
  ('ibge', 701040199, 'MAIONESE (MOLHO) LIGHT', unaccent(lower('MAIONESE (MOLHO) LIGHT')), 'Preparações', 156.58, 0.59, 18.77, 9.46, 1.24),
  ('ibge', 701050199, 'MOLHO DE SOJA LIGHT', unaccent(lower('MOLHO DE SOJA LIGHT')), 'Preparações', 53.13, 5.18, 8.53, 0.08, 0.8),
  ('ibge', 701060199, 'LEITE DE COCO LIGHT', unaccent(lower('LEITE DE COCO LIGHT')), 'Preparações', 202.46, 1.61, 5.59, 20.85, 0.91),
  ('ibge', 707920299, 'VINAGRETE', unaccent(lower('VINAGRETE')), 'Preparações', 76.78, 0.65, 3.68, 6.21, 0.93),
  ('ibge', 710010102, 'FILE MIGNON - COZIDO(A)', unaccent(lower('FILE MIGNON - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710010103, 'FILE MIGNON - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FILE MIGNON - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710010104, 'FILE MIGNON - ASSADO(A)', unaccent(lower('FILE MIGNON - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710010105, 'FILE MIGNON - FRITO(A)', unaccent(lower('FILE MIGNON - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710010106, 'FILE MIGNON - EMPANADO(A)/A MILANESA', unaccent(lower('FILE MIGNON - EMPANADO(A)/A MILANESA')), 'Preparações', 242.84, 31.13, 3.39, 11.61, 0.14),
  ('ibge', 710010107, 'FILE MIGNON - REFOGADO(A)', unaccent(lower('FILE MIGNON - REFOGADO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710010108, 'FILE MIGNON - MOLHO VERMELHO', unaccent(lower('FILE MIGNON - MOLHO VERMELHO')), 'Preparações', 168.0, 24.8, 1.08, 7.24, 0.3),
  ('ibge', 710010109, 'FILE MIGNON - MOLHO BRANCO', unaccent(lower('FILE MIGNON - MOLHO BRANCO')), 'Preparações', 195.79, 25.32, 1.85, 9.69, 0.04),
  ('ibge', 710010111, 'FILE MIGNON - COM MANTEIGA/OLEO', unaccent(lower('FILE MIGNON - COM MANTEIGA/OLEO')), 'Preparações', 223.14, 30.69, 0.0, 11.16, 0),
  ('ibge', 710010199, 'FILE MIGNON', unaccent(lower('FILE MIGNON')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710020102, 'CONTRAFILE - COZIDO(A)', unaccent(lower('CONTRAFILE - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710020103, 'CONTRAFILE - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CONTRAFILE - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710020104, 'CONTRAFILE - ASSADO(A)', unaccent(lower('CONTRAFILE - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710020105, 'CONTRAFILE - FRITO(A)', unaccent(lower('CONTRAFILE - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710020106, 'CONTRAFILE - EMPANADO(A)/A MILANESA', unaccent(lower('CONTRAFILE - EMPANADO(A)/A MILANESA')), 'Preparações', 242.84, 31.13, 3.39, 11.61, 0.14),
  ('ibge', 710020107, 'CONTRAFILE - REFOGADO(A)', unaccent(lower('CONTRAFILE - REFOGADO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710020108, 'CONTRAFILE - MOLHO VERMELHO', unaccent(lower('CONTRAFILE - MOLHO VERMELHO')), 'Preparações', 168.0, 24.8, 1.08, 7.24, 0.3),
  ('ibge', 710020501, 'BISTECA BOVINA - CRU(A)', unaccent(lower('BISTECA BOVINA - CRU(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020502, 'BISTECA BOVINA - COZIDO(A)', unaccent(lower('BISTECA BOVINA - COZIDO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020503, 'BISTECA BOVINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('BISTECA BOVINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020504, 'BISTECA BOVINA - ASSADO(A)', unaccent(lower('BISTECA BOVINA - ASSADO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020505, 'BISTECA BOVINA - FRITO(A)', unaccent(lower('BISTECA BOVINA - FRITO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020506, 'BISTECA BOVINA - EMPANADO(A)/A MILANESA', unaccent(lower('BISTECA BOVINA - EMPANADO(A)/A MILANESA')), 'Preparações', 329.84, 26.31, 3.39, 22.65, 0.14),
  ('ibge', 710020507, 'BISTECA BOVINA - REFOGADO(A)', unaccent(lower('BISTECA BOVINA - REFOGADO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 710020508, 'BISTECA BOVINA - MOLHO VERMELHO', unaccent(lower('BISTECA BOVINA - MOLHO VERMELHO')), 'Preparações', 381.6, 17.52, 1.08, 33.62, 0.3),
  ('ibge', 710030101, 'ALCATRA - CRU(A)', unaccent(lower('ALCATRA - CRU(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030102, 'ALCATRA - COZIDO(A)', unaccent(lower('ALCATRA - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030103, 'ALCATRA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('ALCATRA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030104, 'ALCATRA - ASSADO(A)', unaccent(lower('ALCATRA - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030105, 'ALCATRA - FRITO(A)', unaccent(lower('ALCATRA - FRITO(A)')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710030106, 'ALCATRA - EMPANADO(A)/A MILANESA', unaccent(lower('ALCATRA - EMPANADO(A)/A MILANESA')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710030107, 'ALCATRA - REFOGADO(A)', unaccent(lower('ALCATRA - REFOGADO(A)')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710030108, 'ALCATRA - MOLHO VERMELHO', unaccent(lower('ALCATRA - MOLHO VERMELHO')), 'Preparações', 168.0, 24.8, 1.08, 7.24, 0.3),
  ('ibge', 710030112, 'ALCATRA - AO VINAGRETE', unaccent(lower('ALCATRA - AO VINAGRETE')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030113, 'ALCATRA - ENSOPADO', unaccent(lower('ALCATRA - ENSOPADO')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710030303, 'MAMINHA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('MAMINHA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710030304, 'MAMINHA - ASSADO(A)', unaccent(lower('MAMINHA - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710030305, 'MAMINHA - FRITO(A)', unaccent(lower('MAMINHA - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710030308, 'MAMINHA - MOLHO VERMELHO', unaccent(lower('MAMINHA - MOLHO VERMELHO')), 'Preparações', 164.0, 29.16, 1.08, 4.04, 0.3),
  ('ibge', 710030402, 'PICANHA - COZIDO(A)', unaccent(lower('PICANHA - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030403, 'PICANHA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PICANHA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030404, 'PICANHA - ASSADO(A)', unaccent(lower('PICANHA - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710030405, 'PICANHA - FRITO(A)', unaccent(lower('PICANHA - FRITO(A)')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710030413, 'PICANHA - ENSOPADO', unaccent(lower('PICANHA - ENSOPADO')), 'Preparações', 253.57, 30.67, 0, 14.61, 0),
  ('ibge', 710050102, 'PATINHO - COZIDO(A)', unaccent(lower('PATINHO - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050103, 'PATINHO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PATINHO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050104, 'PATINHO - ASSADO(A)', unaccent(lower('PATINHO - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050105, 'PATINHO - FRITO(A)', unaccent(lower('PATINHO - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710050106, 'PATINHO - EMPANADO(A)/A MILANESA', unaccent(lower('PATINHO - EMPANADO(A)/A MILANESA')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710050108, 'PATINHO - MOLHO VERMELHO', unaccent(lower('PATINHO - MOLHO VERMELHO')), 'Preparações', 164.0, 29.16, 1.08, 4.04, 0.3),
  ('ibge', 710050113, 'PATINHO - ENSOPADO', unaccent(lower('PATINHO - ENSOPADO')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710050202, 'CABECA DE LOMBO (CARNE BOVINA) - COZIDO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050203, 'CABECA DE LOMBO (CARNE BOVINA) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050204, 'CABECA DE LOMBO (CARNE BOVINA) - ASSADO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710050205, 'CABECA DE LOMBO (CARNE BOVINA) - FRITO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710050206, 'CABECA DE LOMBO (CARNE BOVINA) - EMPANADO(A)/A MILANESA', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - EMPANADO(A)/A MILANESA')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710050207, 'CABECA DE LOMBO (CARNE BOVINA) - REFOGADO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) - REFOGADO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710060402, 'POSTA BRANCA - COZIDO(A)', unaccent(lower('POSTA BRANCA - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060405, 'POSTA BRANCA - FRITO(A)', unaccent(lower('POSTA BRANCA - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710060408, 'POSTA BRANCA - MOLHO VERMELHO', unaccent(lower('POSTA BRANCA - MOLHO VERMELHO')), 'Preparações', 164.0, 29.16, 1.08, 4.04, 0.3),
  ('ibge', 710060602, 'TATU (LAGARTO REDONDO) - COZIDO(A)', unaccent(lower('TATU (LAGARTO REDONDO) - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060604, 'TATU (LAGARTO REDONDO) - ASSADO(A)', unaccent(lower('TATU (LAGARTO REDONDO) - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060607, 'TATU (LAGARTO REDONDO) - REFOGADO(A)', unaccent(lower('TATU (LAGARTO REDONDO) - REFOGADO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710060699, 'TATU (LAGARTO REDONDO)', unaccent(lower('TATU (LAGARTO REDONDO)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060702, 'PAULISTA - COZIDO(A)', unaccent(lower('PAULISTA - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060704, 'PAULISTA - ASSADO(A)', unaccent(lower('PAULISTA - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060802, 'LOMBO PAULISTA (CARNE BOVINA) - COZIDO(A)', unaccent(lower('LOMBO PAULISTA (CARNE BOVINA) - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060804, 'LOMBO PAULISTA (CARNE BOVINA) - ASSADO(A)', unaccent(lower('LOMBO PAULISTA (CARNE BOVINA) - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710060805, 'LOMBO PAULISTA (CARNE BOVINA) - FRITO(A)', unaccent(lower('LOMBO PAULISTA (CARNE BOVINA) - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710060813, 'LOMBO PAULISTA (CARNE BOVINA) - ENSOPADO', unaccent(lower('LOMBO PAULISTA (CARNE BOVINA) - ENSOPADO')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710070202, 'POSTA VERMELHA - COZIDO(A)', unaccent(lower('POSTA VERMELHA - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710080102, 'ACEM - COZIDO(A)', unaccent(lower('ACEM - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710080104, 'ACEM - ASSADO(A)', unaccent(lower('ACEM - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710080105, 'ACEM - FRITO(A)', unaccent(lower('ACEM - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710080106, 'ACEM - EMPANADO(A)/A MILANESA', unaccent(lower('ACEM - EMPANADO(A)/A MILANESA')), 'Preparações', 280.84, 24.68, 3.39, 18.03, 0.14),
  ('ibge', 710080107, 'ACEM - REFOGADO(A)', unaccent(lower('ACEM - REFOGADO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710080113, 'ACEM - ENSOPADO', unaccent(lower('ACEM - ENSOPADO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710080302, 'AGULHA (ACEM) - COZIDO(A)', unaccent(lower('AGULHA (ACEM) - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710080304, 'AGULHA (ACEM) - ASSADO(A)', unaccent(lower('AGULHA (ACEM) - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710080305, 'AGULHA (ACEM) - FRITO(A)', unaccent(lower('AGULHA (ACEM) - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710090502, 'PALETA - COZIDO(A)', unaccent(lower('PALETA - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710090505, 'PALETA - FRITO(A)', unaccent(lower('PALETA - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710090508, 'PALETA - MOLHO VERMELHO', unaccent(lower('PALETA - MOLHO VERMELHO')), 'Preparações', 198.4, 19.64, 1.08, 12.37, 0.3),
  ('ibge', 710090513, 'PALETA - ENSOPADO', unaccent(lower('PALETA - ENSOPADO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710090802, 'PA COM OSSO - COZIDO(A)', unaccent(lower('PA COM OSSO - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710090803, 'PA COM OSSO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PA COM OSSO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710090804, 'PA COM OSSO - ASSADO(A)', unaccent(lower('PA COM OSSO - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710100102, 'MUSCULO BOVINO - COZIDO(A)', unaccent(lower('MUSCULO BOVINO - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710100104, 'MUSCULO BOVINO - ASSADO(A)', unaccent(lower('MUSCULO BOVINO - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710100108, 'MUSCULO BOVINO - MOLHO VERMELHO', unaccent(lower('MUSCULO BOVINO - MOLHO VERMELHO')), 'Preparações', 164.0, 29.16, 1.08, 4.04, 0.3),
  ('ibge', 710100113, 'MUSCULO BOVINO - ENSOPADO', unaccent(lower('MUSCULO BOVINO - ENSOPADO')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 710100115, 'MUSCULO BOVINO - SOPA', unaccent(lower('MUSCULO BOVINO - SOPA')), 'Preparações', 63.94, 3.81, 7.73, 1.81, 0.39),
  ('ibge', 710100602, 'CHAMBARIL - COZIDO(A)', unaccent(lower('CHAMBARIL - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710100604, 'CHAMBARIL - ASSADO(A)', unaccent(lower('CHAMBARIL - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710100607, 'CHAMBARIL - REFOGADO(A)', unaccent(lower('CHAMBARIL - REFOGADO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710100902, 'CARNE MARICA BOVINA - COZIDO(A)', unaccent(lower('CARNE MARICA BOVINA - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710100905, 'CARNE MARICA BOVINA - FRITO(A)', unaccent(lower('CARNE MARICA BOVINA - FRITO(A)')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 710100907, 'CARNE MARICA BOVINA - REFOGADO(A)', unaccent(lower('CARNE MARICA BOVINA - REFOGADO(A)')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 710101102, 'VAZIO (CARNE BOVINA) - COZIDO(A)', unaccent(lower('VAZIO (CARNE BOVINA) - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710101103, 'VAZIO (CARNE BOVINA) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('VAZIO (CARNE BOVINA) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710101105, 'VAZIO (CARNE BOVINA) - FRITO(A)', unaccent(lower('VAZIO (CARNE BOVINA) - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710110102, 'PEITO BOVINO - COZIDO(A)', unaccent(lower('PEITO BOVINO - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710110105, 'PEITO BOVINO - FRITO(A)', unaccent(lower('PEITO BOVINO - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710120202, 'FRALDINHA (CAPA DE FILE) - COZIDO(A)', unaccent(lower('FRALDINHA (CAPA DE FILE) - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710120203, 'FRALDINHA (CAPA DE FILE) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FRALDINHA (CAPA DE FILE) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710120204, 'FRALDINHA (CAPA DE FILE) - ASSADO(A)', unaccent(lower('FRALDINHA (CAPA DE FILE) - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710120205, 'FRALDINHA (CAPA DE FILE) - FRITO(A)', unaccent(lower('FRALDINHA (CAPA DE FILE) - FRITO(A)')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 710120301, 'ABA DE FILÉ - CRU(A)', unaccent(lower('ABA DE FILÉ - CRU(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710120303, 'ABA DE FILÉ - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('ABA DE FILÉ - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710120305, 'ABA DE FILÉ - FRITO(A)', unaccent(lower('ABA DE FILÉ - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710130102, 'COSTELA BOVINA - COZIDO(A)', unaccent(lower('COSTELA BOVINA - COZIDO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710130104, 'COSTELA BOVINA - ASSADO(A)', unaccent(lower('COSTELA BOVINA - ASSADO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710130107, 'COSTELA BOVINA - REFOGADO(A)', unaccent(lower('COSTELA BOVINA - REFOGADO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710130113, 'COSTELA BOVINA - ENSOPADO', unaccent(lower('COSTELA BOVINA - ENSOPADO')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710170402, 'JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - COZIDO(A)', unaccent(lower('JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - COZIDO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710170404, 'JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - ASSADO(A)', unaccent(lower('JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - ASSADO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710170405, 'JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - FRITO(A)', unaccent(lower('JACARE (CARNE BOVINA DE SEGUNDA C/ OSSO) - FRITO(A)')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710170603, 'FILE DE SEGUNDA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FILE DE SEGUNDA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710170604, 'FILE DE SEGUNDA - ASSADO(A)', unaccent(lower('FILE DE SEGUNDA - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710170605, 'FILE DE SEGUNDA - FRITO(A)', unaccent(lower('FILE DE SEGUNDA - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710170606, 'FILE DE SEGUNDA - EMPANADO(A)/A MILANESA', unaccent(lower('FILE DE SEGUNDA - EMPANADO(A)/A MILANESA')), 'Preparações', 280.84, 24.68, 3.39, 18.03, 0.14),
  ('ibge', 710170610, 'FILE DE SEGUNDA - AO ALHO E OLEO', unaccent(lower('FILE DE SEGUNDA - AO ALHO E OLEO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710180102, 'VISCERA BOVINA - COZIDO(A)', unaccent(lower('VISCERA BOVINA - COZIDO(A)')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710180105, 'VISCERA BOVINA - FRITO(A)', unaccent(lower('VISCERA BOVINA - FRITO(A)')), 'Preparações', 213.66, 29.08, 5.13, 7.82, 0),
  ('ibge', 710180602, 'PANELADA (VISCERAS BOVINAS NAO ESPECIFICADAS) - COZIDO(A)', unaccent(lower('PANELADA (VISCERAS BOVINAS NAO ESPECIFICADAS) - COZIDO(A)')), 'Preparações', 100.04, 13.98, 4.18, 2.96, 0.62),
  ('ibge', 710180613, 'PANELADA (VISCERAS BOVINAS NAO ESPECIFICADAS) - ENSOPADO', unaccent(lower('PANELADA (VISCERAS BOVINAS NAO ESPECIFICADAS) - ENSOPADO')), 'Preparações', 100.04, 13.98, 4.18, 2.96, 0.62),
  ('ibge', 710190102, 'CORACAO BOVINO - COZIDO(A)', unaccent(lower('CORACAO BOVINO - COZIDO(A)')), 'Preparações', 165.0, 28.48, 0.15, 4.73, 0),
  ('ibge', 710190103, 'CORACAO BOVINO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CORACAO BOVINO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 165.0, 28.48, 0.15, 4.73, 0),
  ('ibge', 710190104, 'CORACAO BOVINO - ASSADO(A)', unaccent(lower('CORACAO BOVINO - ASSADO(A)')), 'Preparações', 165.0, 28.48, 0.15, 4.73, 0),
  ('ibge', 710190105, 'CORACAO BOVINO - FRITO(A)', unaccent(lower('CORACAO BOVINO - FRITO(A)')), 'Preparações', 187.66, 28.48, 0.15, 7.29, 0),
  ('ibge', 710200102, 'RIM DE BOI - COZIDO(A)', unaccent(lower('RIM DE BOI - COZIDO(A)')), 'Preparações', 158.0, 27.27, 0, 4.65, 0),
  ('ibge', 710210204, 'BOFE BOVINO - ASSADO(A)', unaccent(lower('BOFE BOVINO - ASSADO(A)')), 'Preparações', 158.0, 27.27, 0, 4.65, 0),
  ('ibge', 710210205, 'BOFE BOVINO - FRITO(A)', unaccent(lower('BOFE BOVINO - FRITO(A)')), 'Preparações', 180.66, 27.27, 0, 7.21, 0),
  ('ibge', 710210207, 'BOFE BOVINO - REFOGADO(A)', unaccent(lower('BOFE BOVINO - REFOGADO(A)')), 'Preparações', 180.66, 27.27, 0, 7.21, 0),
  ('ibge', 710220102, 'MIOLO DE BOI - COZIDO(A)', unaccent(lower('MIOLO DE BOI - COZIDO(A)')), 'Preparações', 151.0, 11.67, 1.48, 10.53, 0),
  ('ibge', 710240102, 'TRIPA BOVINA - COZIDO(A)', unaccent(lower('TRIPA BOVINA - COZIDO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240103, 'TRIPA BOVINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('TRIPA BOVINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240104, 'TRIPA BOVINA - ASSADO(A)', unaccent(lower('TRIPA BOVINA - ASSADO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240105, 'TRIPA BOVINA - FRITO(A)', unaccent(lower('TRIPA BOVINA - FRITO(A)')), 'Preparações', 116.66, 11.71, 1.99, 6.61, 0),
  ('ibge', 710240202, 'DOBRADINHA FRESCA - COZIDO(A)', unaccent(lower('DOBRADINHA FRESCA - COZIDO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240204, 'DOBRADINHA FRESCA - ASSADO(A)', unaccent(lower('DOBRADINHA FRESCA - ASSADO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240208, 'DOBRADINHA FRESCA - MOLHO VERMELHO', unaccent(lower('DOBRADINHA FRESCA - MOLHO VERMELHO')), 'Preparações', 80.0, 9.63, 2.67, 3.28, 0.3),
  ('ibge', 710240213, 'DOBRADINHA FRESCA - ENSOPADO', unaccent(lower('DOBRADINHA FRESCA - ENSOPADO')), 'Preparações', 116.66, 11.71, 1.99, 6.61, 0),
  ('ibge', 710240299, 'DOBRADINHA FRESCA', unaccent(lower('DOBRADINHA FRESCA')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240302, 'FATO BOVINO - COZIDO(A)', unaccent(lower('FATO BOVINO - COZIDO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710240305, 'FATO BOVINO - FRITO(A)', unaccent(lower('FATO BOVINO - FRITO(A)')), 'Preparações', 116.66, 11.71, 1.99, 6.61, 0),
  ('ibge', 710240402, 'FATO CAPRINO - COZIDO(A)', unaccent(lower('FATO CAPRINO - COZIDO(A)')), 'Preparações', 94.0, 11.71, 1.99, 4.05, 0),
  ('ibge', 710250101, 'FIGADO BOVINO - CRU(A)', unaccent(lower('FIGADO BOVINO - CRU(A)')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710250102, 'FIGADO BOVINO - COZIDO(A)', unaccent(lower('FIGADO BOVINO - COZIDO(A)')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710250103, 'FIGADO BOVINO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FIGADO BOVINO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710250104, 'FIGADO BOVINO - ASSADO(A)', unaccent(lower('FIGADO BOVINO - ASSADO(A)')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710250105, 'FIGADO BOVINO - FRITO(A)', unaccent(lower('FIGADO BOVINO - FRITO(A)')), 'Preparações', 213.66, 29.08, 5.13, 7.82, 0),
  ('ibge', 710250106, 'FIGADO BOVINO - EMPANADO(A)/A MILANESA', unaccent(lower('FIGADO BOVINO - EMPANADO(A)/A MILANESA')), 'Preparações', 229.84, 29.54, 8.52, 7.87, 0.14),
  ('ibge', 710250107, 'FIGADO BOVINO - REFOGADO(A)', unaccent(lower('FIGADO BOVINO - REFOGADO(A)')), 'Preparações', 213.66, 29.08, 5.13, 7.82, 0),
  ('ibge', 710250108, 'FIGADO BOVINO - MOLHO VERMELHO', unaccent(lower('FIGADO BOVINO - MOLHO VERMELHO')), 'Preparações', 157.6, 23.53, 5.18, 4.24, 0.3),
  ('ibge', 710250110, 'FIGADO BOVINO - AO ALHO E OLEO', unaccent(lower('FIGADO BOVINO - AO ALHO E OLEO')), 'Preparações', 213.66, 29.08, 5.13, 7.82, 0),
  ('ibge', 710250113, 'FIGADO BOVINO - ENSOPADO', unaccent(lower('FIGADO BOVINO - ENSOPADO')), 'Preparações', 213.66, 29.08, 5.13, 7.82, 0),
  ('ibge', 710260103, 'CUPIM - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CUPIM - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 330.1, 28.63, 0, 23.04, 0),
  ('ibge', 710260104, 'CUPIM - ASSADO(A)', unaccent(lower('CUPIM - ASSADO(A)')), 'Preparações', 330.1, 28.63, 0, 23.04, 0),
  ('ibge', 710260105, 'CUPIM - FRITO(A)', unaccent(lower('CUPIM - FRITO(A)')), 'Preparações', 363.08, 26.91, 0, 27.63, 0),
  ('ibge', 710270102, 'LINGUA BOVINA - COZIDO(A)', unaccent(lower('LINGUA BOVINA - COZIDO(A)')), 'Preparações', 284.0, 19.29, 0, 22.3, 0),
  ('ibge', 710270103, 'LINGUA BOVINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('LINGUA BOVINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 284.0, 19.29, 0, 22.3, 0),
  ('ibge', 710270104, 'LINGUA BOVINA - ASSADO(A)', unaccent(lower('LINGUA BOVINA - ASSADO(A)')), 'Preparações', 284.0, 19.29, 0, 22.3, 0),
  ('ibge', 710270105, 'LINGUA BOVINA - FRITO(A)', unaccent(lower('LINGUA BOVINA - FRITO(A)')), 'Preparações', 306.66, 19.29, 0, 24.86, 0),
  ('ibge', 710270108, 'LINGUA BOVINA - MOLHO VERMELHO', unaccent(lower('LINGUA BOVINA - MOLHO VERMELHO')), 'Preparações', 232.0, 15.7, 1.08, 17.88, 0.3),
  ('ibge', 710270113, 'LINGUA BOVINA - ENSOPADO', unaccent(lower('LINGUA BOVINA - ENSOPADO')), 'Preparações', 306.66, 19.29, 0, 24.86, 0),
  ('ibge', 710280199, 'RABADA DE BOI', unaccent(lower('RABADA DE BOI')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 710310102, 'MOCOTO BOVINO - COZIDO(A)', unaccent(lower('MOCOTO BOVINO - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710310113, 'MOCOTO BOVINO - ENSOPADO', unaccent(lower('MOCOTO BOVINO - ENSOPADO')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710310115, 'MOCOTO BOVINO - SOPA', unaccent(lower('MOCOTO BOVINO - SOPA')), 'Preparações', 63.94, 3.81, 7.73, 1.81, 0.39),
  ('ibge', 710310199, 'MOCOTO BOVINO', unaccent(lower('MOCOTO BOVINO')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710310405, 'BRACO BOVINO - FRITO(A)', unaccent(lower('BRACO BOVINO - FRITO(A)')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 710310502, 'MAO BOVINA - COZIDO(A)', unaccent(lower('MAO BOVINA - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710330102, 'CARRE - COZIDO(A)', unaccent(lower('CARRE - COZIDO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330103, 'CARRE - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARRE - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330104, 'CARRE - ASSADO(A)', unaccent(lower('CARRE - ASSADO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330105, 'CARRE - FRITO(A)', unaccent(lower('CARRE - FRITO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330502, 'BISTECA SUINA - COZIDO(A)', unaccent(lower('BISTECA SUINA - COZIDO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330503, 'BISTECA SUINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('BISTECA SUINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330504, 'BISTECA SUINA - ASSADO(A)', unaccent(lower('BISTECA SUINA - ASSADO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330505, 'BISTECA SUINA - FRITO(A)', unaccent(lower('BISTECA SUINA - FRITO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330506, 'BISTECA SUINA - EMPANADO(A)/A MILANESA', unaccent(lower('BISTECA SUINA - EMPANADO(A)/A MILANESA')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330507, 'BISTECA SUINA - REFOGADO(A)', unaccent(lower('BISTECA SUINA - REFOGADO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710330599, 'BISTECA SUINA', unaccent(lower('BISTECA SUINA')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710340102, 'PERNIL SUINO - COZIDO(A)', unaccent(lower('PERNIL SUINO - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710340104, 'PERNIL SUINO - ASSADO(A)', unaccent(lower('PERNIL SUINO - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710340105, 'PERNIL SUINO - FRITO(A)', unaccent(lower('PERNIL SUINO - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710340107, 'PERNIL SUINO - REFOGADO(A)', unaccent(lower('PERNIL SUINO - REFOGADO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710340302, 'QUARTO SUINO - COZIDO(A)', unaccent(lower('QUARTO SUINO - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710350101, 'COSTELA SUINA - CRU(A)', unaccent(lower('COSTELA SUINA - CRU(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350102, 'COSTELA SUINA - COZIDO(A)', unaccent(lower('COSTELA SUINA - COZIDO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350103, 'COSTELA SUINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('COSTELA SUINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350104, 'COSTELA SUINA - ASSADO(A)', unaccent(lower('COSTELA SUINA - ASSADO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350105, 'COSTELA SUINA - FRITO(A)', unaccent(lower('COSTELA SUINA - FRITO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350107, 'COSTELA SUINA - REFOGADO(A)', unaccent(lower('COSTELA SUINA - REFOGADO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350108, 'COSTELA SUINA - MOLHO VERMELHO', unaccent(lower('COSTELA SUINA - MOLHO VERMELHO')), 'Preparações', 322.4, 23.51, 1.08, 24.28, 0.3),
  ('ibge', 710350113, 'COSTELA SUINA - ENSOPADO', unaccent(lower('COSTELA SUINA - ENSOPADO')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710350199, 'COSTELA SUINA', unaccent(lower('COSTELA SUINA')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710370102, 'LOMBO SUINO - COZIDO(A)', unaccent(lower('LOMBO SUINO - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710370103, 'LOMBO SUINO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('LOMBO SUINO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710370104, 'LOMBO SUINO - ASSADO(A)', unaccent(lower('LOMBO SUINO - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710370105, 'LOMBO SUINO - FRITO(A)', unaccent(lower('LOMBO SUINO - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710380199, 'TOUCINHO', unaccent(lower('TOUCINHO')), 'Preparações', 541.0, 37.04, 1.43, 41.78, 0),
  ('ibge', 710390302, 'MIUDO SUINO - COZIDO(A)', unaccent(lower('MIUDO SUINO - COZIDO(A)')), 'Preparações', 165.0, 26.02, 3.76, 4.4, 0),
  ('ibge', 710390699, 'ARRASTO SUINO', unaccent(lower('ARRASTO SUINO')), 'Preparações', 100.04, 13.98, 4.18, 2.96, 0.62),
  ('ibge', 710390799, 'SARAPATEL SUINO FRESCO', unaccent(lower('SARAPATEL SUINO FRESCO')), 'Preparações', 100.04, 13.98, 4.18, 2.96, 0.62),
  ('ibge', 710410101, 'CARNE SUINA - CRU(A)', unaccent(lower('CARNE SUINA - CRU(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710410102, 'CARNE SUINA - COZIDO(A)', unaccent(lower('CARNE SUINA - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710410103, 'CARNE SUINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE SUINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710410104, 'CARNE SUINA - ASSADO(A)', unaccent(lower('CARNE SUINA - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710410105, 'CARNE SUINA - FRITO(A)', unaccent(lower('CARNE SUINA - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710410106, 'CARNE SUINA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE SUINA - EMPANADO(A)/A MILANESA')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710410107, 'CARNE SUINA - REFOGADO(A)', unaccent(lower('CARNE SUINA - REFOGADO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710410108, 'CARNE SUINA - MOLHO VERMELHO', unaccent(lower('CARNE SUINA - MOLHO VERMELHO')), 'Preparações', 236.0, 20.54, 1.08, 16.08, 0.3),
  ('ibge', 710410110, 'CARNE SUINA - AO ALHO E OLEO', unaccent(lower('CARNE SUINA - AO ALHO E OLEO')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710410113, 'CARNE SUINA - ENSOPADO', unaccent(lower('CARNE SUINA - ENSOPADO')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710410199, 'CARNE SUINA', unaccent(lower('CARNE SUINA')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710430101, 'CARNE MOIDA - CRU(A)', unaccent(lower('CARNE MOIDA - CRU(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 710430102, 'CARNE MOIDA - COZIDO(A)', unaccent(lower('CARNE MOIDA - COZIDO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 710430104, 'CARNE MOIDA - ASSADO(A)', unaccent(lower('CARNE MOIDA - ASSADO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 710430105, 'CARNE MOIDA - FRITO(A)', unaccent(lower('CARNE MOIDA - FRITO(A)')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 710430106, 'CARNE MOIDA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE MOIDA - EMPANADO(A)/A MILANESA')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 710430107, 'CARNE MOIDA - REFOGADO(A)', unaccent(lower('CARNE MOIDA - REFOGADO(A)')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 710430108, 'CARNE MOIDA - MOLHO VERMELHO', unaccent(lower('CARNE MOIDA - MOLHO VERMELHO')), 'Preparações', 176.0, 21.56, 1.08, 8.92, 0.3),
  ('ibge', 710430109, 'CARNE MOIDA - MOLHO BRANCO', unaccent(lower('CARNE MOIDA - MOLHO BRANCO')), 'Preparações', 203.79, 22.07, 1.85, 11.37, 0.04),
  ('ibge', 710430110, 'CARNE MOIDA - AO ALHO E OLEO', unaccent(lower('CARNE MOIDA - AO ALHO E OLEO')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 710430113, 'CARNE MOIDA - ENSOPADO', unaccent(lower('CARNE MOIDA - ENSOPADO')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 710430115, 'CARNE MOIDA - SOPA', unaccent(lower('CARNE MOIDA - SOPA')), 'Preparações', 63.94, 3.81, 7.73, 1.81, 0.39),
  ('ibge', 710430199, 'CARNE MOIDA', unaccent(lower('CARNE MOIDA')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 710430299, 'GUIZADO', unaccent(lower('GUIZADO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710450103, 'TRIPA SUINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('TRIPA SUINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 233.0, 12.49, 0, 20.32, 0),
  ('ibge', 710450105, 'TRIPA SUINA - FRITO(A)', unaccent(lower('TRIPA SUINA - FRITO(A)')), 'Preparações', 255.66, 12.49, 0, 22.88, 0),
  ('ibge', 710460102, 'FIGADO SUINO - COZIDO(A)', unaccent(lower('FIGADO SUINO - COZIDO(A)')), 'Preparações', 165.0, 26.02, 3.76, 4.4, 0),
  ('ibge', 710460104, 'FIGADO SUINO - ASSADO(A)', unaccent(lower('FIGADO SUINO - ASSADO(A)')), 'Preparações', 165.0, 26.02, 3.76, 4.4, 0),
  ('ibge', 710460105, 'FIGADO SUINO - FRITO(A)', unaccent(lower('FIGADO SUINO - FRITO(A)')), 'Preparações', 187.66, 26.02, 3.76, 6.96, 0),
  ('ibge', 710470102, 'LINGUA SUINA - COZIDO(A)', unaccent(lower('LINGUA SUINA - COZIDO(A)')), 'Preparações', 271.0, 24.1, 0, 18.6, 0),
  ('ibge', 710470103, 'LINGUA SUINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('LINGUA SUINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 271.0, 24.1, 0, 18.6, 0),
  ('ibge', 710470104, 'LINGUA SUINA - ASSADO(A)', unaccent(lower('LINGUA SUINA - ASSADO(A)')), 'Preparações', 271.0, 24.1, 0, 18.6, 0),
  ('ibge', 710470105, 'LINGUA SUINA - FRITO(A)', unaccent(lower('LINGUA SUINA - FRITO(A)')), 'Preparações', 293.66, 24.1, 0, 21.16, 0),
  ('ibge', 710470107, 'LINGUA SUINA - REFOGADO(A)', unaccent(lower('LINGUA SUINA - REFOGADO(A)')), 'Preparações', 293.66, 24.1, 0, 21.16, 0),
  ('ibge', 710500102, 'ORELHA SUINA FRESCA - COZIDO(A)', unaccent(lower('ORELHA SUINA FRESCA - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710510399, 'SARRABULHO', unaccent(lower('SARRABULHO')), 'Preparações', 100.04, 13.98, 4.18, 2.96, 0.62),
  ('ibge', 710520302, 'MOCOTO SUINO - COZIDO(A)', unaccent(lower('MOCOTO SUINO - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710540102, 'CARNE DE CABRITO - COZIDO(A)', unaccent(lower('CARNE DE CABRITO - COZIDO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540103, 'CARNE DE CABRITO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE CABRITO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540104, 'CARNE DE CABRITO - ASSADO(A)', unaccent(lower('CARNE DE CABRITO - ASSADO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540202, 'CARNE DE BODE - COZIDO(A)', unaccent(lower('CARNE DE BODE - COZIDO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540203, 'CARNE DE BODE - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE BODE - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540204, 'CARNE DE BODE - ASSADO(A)', unaccent(lower('CARNE DE BODE - ASSADO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540205, 'CARNE DE BODE - FRITO(A)', unaccent(lower('CARNE DE BODE - FRITO(A)')), 'Preparações', 165.66, 27.1, 0, 5.59, 0),
  ('ibge', 710540302, 'CARNE CAPRINA - COZIDO(A)', unaccent(lower('CARNE CAPRINA - COZIDO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540304, 'CARNE CAPRINA - ASSADO(A)', unaccent(lower('CARNE CAPRINA - ASSADO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540305, 'CARNE CAPRINA - FRITO(A)', unaccent(lower('CARNE CAPRINA - FRITO(A)')), 'Preparações', 165.66, 27.1, 0, 5.59, 0),
  ('ibge', 710540313, 'CARNE CAPRINA - ENSOPADO', unaccent(lower('CARNE CAPRINA - ENSOPADO')), 'Preparações', 165.66, 27.1, 0, 5.59, 0),
  ('ibge', 710540501, 'CARNE DE CAPRINO - CRU(A)', unaccent(lower('CARNE DE CAPRINO - CRU(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540502, 'CARNE DE CAPRINO - COZIDO(A)', unaccent(lower('CARNE DE CAPRINO - COZIDO(A)')), 'Preparações', 143.0, 27.1, 0, 3.03, 0),
  ('ibge', 710540505, 'CARNE DE CAPRINO - FRITO(A)', unaccent(lower('CARNE DE CAPRINO - FRITO(A)')), 'Preparações', 165.66, 27.1, 0, 5.59, 0),
  ('ibge', 710560102, 'CARNE DE CARNEIRO - COZIDO(A)', unaccent(lower('CARNE DE CARNEIRO - COZIDO(A)')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560103, 'CARNE DE CARNEIRO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE CARNEIRO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560104, 'CARNE DE CARNEIRO - ASSADO(A)', unaccent(lower('CARNE DE CARNEIRO - ASSADO(A)')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560105, 'CARNE DE CARNEIRO - FRITO(A)', unaccent(lower('CARNE DE CARNEIRO - FRITO(A)')), 'Preparações', 253.57, 28.35, 0, 14.78, 0),
  ('ibge', 710560113, 'CARNE DE CARNEIRO - ENSOPADO', unaccent(lower('CARNE DE CARNEIRO - ENSOPADO')), 'Preparações', 253.57, 28.35, 0, 14.78, 0),
  ('ibge', 710560202, 'CARNE DE OVELHA - COZIDO(A)', unaccent(lower('CARNE DE OVELHA - COZIDO(A)')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560203, 'CARNE DE OVELHA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE OVELHA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560204, 'CARNE DE OVELHA - ASSADO(A)', unaccent(lower('CARNE DE OVELHA - ASSADO(A)')), 'Preparações', 204.0, 28.35, 0, 9.17, 0),
  ('ibge', 710560205, 'CARNE DE OVELHA - FRITO(A)', unaccent(lower('CARNE DE OVELHA - FRITO(A)')), 'Preparações', 253.57, 28.35, 0, 14.78, 0),
  ('ibge', 710580102, 'MOCOTO DE CAPRINO - COZIDO(A)', unaccent(lower('MOCOTO DE CAPRINO - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710630102, 'PERNIL - COZIDO(A)', unaccent(lower('PERNIL - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710630103, 'PERNIL - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PERNIL - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710630104, 'PERNIL - ASSADO(A)', unaccent(lower('PERNIL - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710630105, 'PERNIL - FRITO(A)', unaccent(lower('PERNIL - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710640102, 'LAGARTO BOVINO - COZIDO(A)', unaccent(lower('LAGARTO BOVINO - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710640104, 'LAGARTO BOVINO - ASSADO(A)', unaccent(lower('LAGARTO BOVINO - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 710640105, 'LAGARTO BOVINO - FRITO(A)', unaccent(lower('LAGARTO BOVINO - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710640107, 'LAGARTO BOVINO - REFOGADO(A)', unaccent(lower('LAGARTO BOVINO - REFOGADO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 710640108, 'LAGARTO BOVINO - MOLHO VERMELHO', unaccent(lower('LAGARTO BOVINO - MOLHO VERMELHO')), 'Preparações', 164.0, 29.16, 1.08, 4.04, 0.3),
  ('ibge', 710650102, 'ALCATRA SUINA - COZIDO(A)', unaccent(lower('ALCATRA SUINA - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710650104, 'ALCATRA SUINA - ASSADO(A)', unaccent(lower('ALCATRA SUINA - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 710650105, 'ALCATRA SUINA - FRITO(A)', unaccent(lower('ALCATRA SUINA - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 710710299, 'BRACHOLA', unaccent(lower('BRACHOLA')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710710399, 'BIFE ROLE CRU', unaccent(lower('BIFE ROLE CRU')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710720499, 'BUCHADA DE BODE', unaccent(lower('BUCHADA DE BODE')), 'Preparações', 125.0, 19.8, 0, 4.4, 3.9),
  ('ibge', 710750102, 'SUA SUINA - COZIDO(A)', unaccent(lower('SUA SUINA - COZIDO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710750105, 'SUA SUINA - FRITO(A)', unaccent(lower('SUA SUINA - FRITO(A)')), 'Preparações', 397.0, 29.06, 0, 30.3, 0),
  ('ibge', 710760101, 'CARNE DE OUTROS ANIMAIS - CRU(A)', unaccent(lower('CARNE DE OUTROS ANIMAIS - CRU(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710760102, 'CARNE DE OUTROS ANIMAIS - COZIDO(A)', unaccent(lower('CARNE DE OUTROS ANIMAIS - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710760103, 'CARNE DE OUTROS ANIMAIS - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE OUTROS ANIMAIS - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710760104, 'CARNE DE OUTROS ANIMAIS - ASSADO(A)', unaccent(lower('CARNE DE OUTROS ANIMAIS - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710760105, 'CARNE DE OUTROS ANIMAIS - FRITO(A)', unaccent(lower('CARNE DE OUTROS ANIMAIS - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710760107, 'CARNE DE OUTROS ANIMAIS - REFOGADO(A)', unaccent(lower('CARNE DE OUTROS ANIMAIS - REFOGADO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710760108, 'CARNE DE OUTROS ANIMAIS - MOLHO VERMELHO', unaccent(lower('CARNE DE OUTROS ANIMAIS - MOLHO VERMELHO')), 'Preparações', 198.4, 19.64, 1.08, 12.37, 0.3),
  ('ibge', 710760113, 'CARNE DE OUTROS ANIMAIS - ENSOPADO', unaccent(lower('CARNE DE OUTROS ANIMAIS - ENSOPADO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710760199, 'CARNE DE OUTROS ANIMAIS', unaccent(lower('CARNE DE OUTROS ANIMAIS')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710760302, 'CARNE DA PACA - COZIDO(A)', unaccent(lower('CARNE DA PACA - COZIDO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710760304, 'CARNE DA PACA - ASSADO(A)', unaccent(lower('CARNE DA PACA - ASSADO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710760305, 'CARNE DA PACA - FRITO(A)', unaccent(lower('CARNE DA PACA - FRITO(A)')), 'Preparações', 234.66, 34.85, 0, 9.52, 0),
  ('ibge', 710761102, 'CARNE DE JACARE - COZIDO(A)', unaccent(lower('CARNE DE JACARE - COZIDO(A)')), 'Preparações', 92.0, 19.4, 0, 1.6, 0),
  ('ibge', 710761105, 'CARNE DE JACARE - FRITO(A)', unaccent(lower('CARNE DE JACARE - FRITO(A)')), 'Preparações', 114.66, 19.4, 0, 4.16, 0),
  ('ibge', 710761502, 'CARNE DE CAPIVARA - COZIDO(A)', unaccent(lower('CARNE DE CAPIVARA - COZIDO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710761504, 'CARNE DE CAPIVARA - ASSADO(A)', unaccent(lower('CARNE DE CAPIVARA - ASSADO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710761505, 'CARNE DE CAPIVARA - FRITO(A)', unaccent(lower('CARNE DE CAPIVARA - FRITO(A)')), 'Preparações', 234.66, 34.85, 0, 9.52, 0),
  ('ibge', 710761702, 'CARNE DE COTIA - COZIDO(A)', unaccent(lower('CARNE DE COTIA - COZIDO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710761704, 'CARNE DE COTIA - ASSADO(A)', unaccent(lower('CARNE DE COTIA - ASSADO(A)')), 'Preparações', 212.0, 34.85, 0, 6.96, 0),
  ('ibge', 710762202, 'CARNE DE JABUTI - COZIDO(A)', unaccent(lower('CARNE DE JABUTI - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 710780102, 'CARNE DE PRIMEIRA - COZIDO(A)', unaccent(lower('CARNE DE PRIMEIRA - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780103, 'CARNE DE PRIMEIRA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE PRIMEIRA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780104, 'CARNE DE PRIMEIRA - ASSADO(A)', unaccent(lower('CARNE DE PRIMEIRA - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780105, 'CARNE DE PRIMEIRA - FRITO(A)', unaccent(lower('CARNE DE PRIMEIRA - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780106, 'CARNE DE PRIMEIRA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE DE PRIMEIRA - EMPANADO(A)/A MILANESA')), 'Preparações', 242.84, 31.13, 3.39, 11.61, 0.14),
  ('ibge', 710780107, 'CARNE DE PRIMEIRA - REFOGADO(A)', unaccent(lower('CARNE DE PRIMEIRA - REFOGADO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780108, 'CARNE DE PRIMEIRA - MOLHO VERMELHO', unaccent(lower('CARNE DE PRIMEIRA - MOLHO VERMELHO')), 'Preparações', 168.0, 24.8, 1.08, 7.24, 0.3),
  ('ibge', 710780109, 'CARNE DE PRIMEIRA - MOLHO BRANCO', unaccent(lower('CARNE DE PRIMEIRA - MOLHO BRANCO')), 'Preparações', 195.79, 25.32, 1.85, 9.69, 0.04),
  ('ibge', 710780111, 'CARNE DE PRIMEIRA - COM MANTEIGA/OLEO', unaccent(lower('CARNE DE PRIMEIRA - COM MANTEIGA/OLEO')), 'Preparações', 223.14, 30.69, 0.0, 11.16, 0),
  ('ibge', 710780402, 'CHULETA - COZIDO(A)', unaccent(lower('CHULETA - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780403, 'CHULETA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CHULETA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780404, 'CHULETA - ASSADO(A)', unaccent(lower('CHULETA - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780405, 'CHULETA - FRITO(A)', unaccent(lower('CHULETA - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780501, 'FILE NAO ESPECIFICADO - CRU(A)', unaccent(lower('FILE NAO ESPECIFICADO - CRU(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780502, 'FILE NAO ESPECIFICADO - COZIDO(A)', unaccent(lower('FILE NAO ESPECIFICADO - COZIDO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780503, 'FILE NAO ESPECIFICADO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FILE NAO ESPECIFICADO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780504, 'FILE NAO ESPECIFICADO - ASSADO(A)', unaccent(lower('FILE NAO ESPECIFICADO - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710780505, 'FILE NAO ESPECIFICADO - FRITO(A)', unaccent(lower('FILE NAO ESPECIFICADO - FRITO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780506, 'FILE NAO ESPECIFICADO - EMPANADO(A)/A MILANESA', unaccent(lower('FILE NAO ESPECIFICADO - EMPANADO(A)/A MILANESA')), 'Preparações', 242.84, 31.13, 3.39, 11.61, 0.14),
  ('ibge', 710780507, 'FILE NAO ESPECIFICADO - REFOGADO(A)', unaccent(lower('FILE NAO ESPECIFICADO - REFOGADO(A)')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780508, 'FILE NAO ESPECIFICADO - MOLHO VERMELHO', unaccent(lower('FILE NAO ESPECIFICADO - MOLHO VERMELHO')), 'Preparações', 168.0, 24.8, 1.08, 7.24, 0.3),
  ('ibge', 710780511, 'FILE NAO ESPECIFICADO - COM MANTEIGA/OLEO', unaccent(lower('FILE NAO ESPECIFICADO - COM MANTEIGA/OLEO')), 'Preparações', 223.14, 30.69, 0.0, 11.16, 0),
  ('ibge', 710780513, 'FILE NAO ESPECIFICADO - ENSOPADO', unaccent(lower('FILE NAO ESPECIFICADO - ENSOPADO')), 'Preparações', 226.66, 30.67, 0, 11.56, 0),
  ('ibge', 710780599, 'FILE NAO ESPECIFICADO', unaccent(lower('FILE NAO ESPECIFICADO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 710810702, 'MIUDO DE BODE - COZIDO(A)', unaccent(lower('MIUDO DE BODE - COZIDO(A)')), 'Preparações', 191.0, 29.08, 5.13, 5.26, 0),
  ('ibge', 710830102, 'PE SUINO FRESCO - COZIDO(A)', unaccent(lower('PE SUINO FRESCO - COZIDO(A)')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710830103, 'PE SUINO FRESCO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PE SUINO FRESCO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 214.0, 28.81, 0, 10.13, 0),
  ('ibge', 710830105, 'PE SUINO FRESCO - FRITO(A)', unaccent(lower('PE SUINO FRESCO - FRITO(A)')), 'Preparações', 236.66, 28.81, 0, 12.69, 0),
  ('ibge', 710910101, 'CARNE BOVINA - CRU(A)', unaccent(lower('CARNE BOVINA - CRU(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710910102, 'CARNE BOVINA - COZIDO(A)', unaccent(lower('CARNE BOVINA - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710910103, 'CARNE BOVINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE BOVINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710910104, 'CARNE BOVINA - ASSADO(A)', unaccent(lower('CARNE BOVINA - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710910105, 'CARNE BOVINA - FRITO(A)', unaccent(lower('CARNE BOVINA - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710910106, 'CARNE BOVINA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE BOVINA - EMPANADO(A)/A MILANESA')), 'Preparações', 280.84, 24.68, 3.39, 18.03, 0.14),
  ('ibge', 710910107, 'CARNE BOVINA - REFOGADO(A)', unaccent(lower('CARNE BOVINA - REFOGADO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710910108, 'CARNE BOVINA - MOLHO VERMELHO', unaccent(lower('CARNE BOVINA - MOLHO VERMELHO')), 'Preparações', 198.4, 19.64, 1.08, 12.37, 0.3),
  ('ibge', 710910109, 'CARNE BOVINA - MOLHO BRANCO', unaccent(lower('CARNE BOVINA - MOLHO BRANCO')), 'Preparações', 226.19, 20.16, 1.85, 14.82, 0.04),
  ('ibge', 710910110, 'CARNE BOVINA - AO ALHO E OLEO', unaccent(lower('CARNE BOVINA - AO ALHO E OLEO')), 'Preparações', 261.14, 24.24, 0.0, 17.59, 0),
  ('ibge', 710910111, 'CARNE BOVINA - COM MANTEIGA/OLEO', unaccent(lower('CARNE BOVINA - COM MANTEIGA/OLEO')), 'Preparações', 261.14, 24.24, 0.0, 17.59, 0),
  ('ibge', 710910112, 'CARNE BOVINA - AO VINAGRETE', unaccent(lower('CARNE BOVINA - AO VINAGRETE')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 710910113, 'CARNE BOVINA - ENSOPADO', unaccent(lower('CARNE BOVINA - ENSOPADO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 710910115, 'CARNE BOVINA - SOPA', unaccent(lower('CARNE BOVINA - SOPA')), 'Preparações', 63.94, 3.81, 7.73, 1.81, 0.39),
  ('ibge', 710910199, 'CARNE BOVINA', unaccent(lower('CARNE BOVINA')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 711060101, 'LOMBO NAO ESPECIFICADO - CRU(A)', unaccent(lower('LOMBO NAO ESPECIFICADO - CRU(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 711060102, 'LOMBO NAO ESPECIFICADO - COZIDO(A)', unaccent(lower('LOMBO NAO ESPECIFICADO - COZIDO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 711060104, 'LOMBO NAO ESPECIFICADO - ASSADO(A)', unaccent(lower('LOMBO NAO ESPECIFICADO - ASSADO(A)')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 711060105, 'LOMBO NAO ESPECIFICADO - FRITO(A)', unaccent(lower('LOMBO NAO ESPECIFICADO - FRITO(A)')), 'Preparações', 338.57, 25.34, 0, 25.67, 0),
  ('ibge', 711060109, 'LOMBO NAO ESPECIFICADO - MOLHO BRANCO', unaccent(lower('LOMBO NAO ESPECIFICADO - MOLHO BRANCO')), 'Preparações', 289.0, 25.34, 0, 20.06, 0),
  ('ibge', 711080102, 'MUSCULO NAO ESPECIFICADO - COZIDO(A)', unaccent(lower('MUSCULO NAO ESPECIFICADO - COZIDO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 711080113, 'MUSCULO NAO ESPECIFICADO - ENSOPADO', unaccent(lower('MUSCULO NAO ESPECIFICADO - ENSOPADO')), 'Preparações', 221.66, 36.12, 0, 7.56, 0),
  ('ibge', 711090202, 'OSSADA NAO ESPECIFICADA - COZIDO(A)', unaccent(lower('OSSADA NAO ESPECIFICADA - COZIDO(A)')), 'Preparações', 164.0, 26.13, 0, 5.81, 0),
  ('ibge', 711090207, 'OSSADA NAO ESPECIFICADA - REFOGADO(A)', unaccent(lower('OSSADA NAO ESPECIFICADA - REFOGADO(A)')), 'Preparações', 186.66, 26.13, 0, 8.37, 0),
  ('ibge', 711090215, 'OSSADA NAO ESPECIFICADA - SOPA', unaccent(lower('OSSADA NAO ESPECIFICADA - SOPA')), 'Preparações', 164.0, 26.13, 0, 5.81, 0),
  ('ibge', 711090299, 'OSSADA NAO ESPECIFICADA', unaccent(lower('OSSADA NAO ESPECIFICADA')), 'Preparações', 164.0, 26.13, 0, 5.81, 0),
  ('ibge', 711120201, 'CARNE DE SEGUNDA - CRU(A)', unaccent(lower('CARNE DE SEGUNDA - CRU(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 711120202, 'CARNE DE SEGUNDA - COZIDO(A)', unaccent(lower('CARNE DE SEGUNDA - COZIDO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 711120203, 'CARNE DE SEGUNDA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE SEGUNDA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 711120204, 'CARNE DE SEGUNDA - ASSADO(A)', unaccent(lower('CARNE DE SEGUNDA - ASSADO(A)')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 711120205, 'CARNE DE SEGUNDA - FRITO(A)', unaccent(lower('CARNE DE SEGUNDA - FRITO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 711120206, 'CARNE DE SEGUNDA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE DE SEGUNDA - EMPANADO(A)/A MILANESA')), 'Preparações', 280.84, 24.68, 3.39, 18.03, 0.14),
  ('ibge', 711120207, 'CARNE DE SEGUNDA - REFOGADO(A)', unaccent(lower('CARNE DE SEGUNDA - REFOGADO(A)')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 711120208, 'CARNE DE SEGUNDA - MOLHO VERMELHO', unaccent(lower('CARNE DE SEGUNDA - MOLHO VERMELHO')), 'Preparações', 198.4, 19.64, 1.08, 12.37, 0.3),
  ('ibge', 711120210, 'CARNE DE SEGUNDA - AO ALHO E OLEO', unaccent(lower('CARNE DE SEGUNDA - AO ALHO E OLEO')), 'Preparações', 261.14, 24.24, 0.0, 17.59, 0),
  ('ibge', 711120213, 'CARNE DE SEGUNDA - ENSOPADO', unaccent(lower('CARNE DE SEGUNDA - ENSOPADO')), 'Preparações', 264.66, 24.22, 0, 17.98, 0),
  ('ibge', 711140104, 'CONTRAFILE ORGANICO - ASSADO(A)', unaccent(lower('CONTRAFILE ORGANICO - ASSADO(A)')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 711140504, 'BISTECA ORGANICA - ASSADO(A)', unaccent(lower('BISTECA ORGANICA - ASSADO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 711140505, 'BISTECA ORGANICA - FRITO(A)', unaccent(lower('BISTECA ORGANICA - FRITO(A)')), 'Preparações', 471.0, 21.57, 0, 41.98, 0),
  ('ibge', 711170201, 'CABECA DE LOMBO (CARNE BOVINA) ORGANICA - CRU(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) ORGANICA - CRU(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 711170204, 'CABECA DE LOMBO (CARNE BOVINA) ORGANICA - ASSADO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) ORGANICA - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 711170205, 'CABECA DE LOMBO (CARNE BOVINA) ORGANICA - FRITO(A)', unaccent(lower('CABECA DE LOMBO (CARNE BOVINA) ORGANICA - FRITO(A)')), 'Preparações', 248.57, 36.12, 0, 10.61, 0),
  ('ibge', 711180604, 'TATU (LAGARTO REDONDO) ORGANICO - ASSADO(A)', unaccent(lower('TATU (LAGARTO REDONDO) ORGANICO - ASSADO(A)')), 'Preparações', 199.0, 36.12, 0, 5.0, 0),
  ('ibge', 720010101, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720010102, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720010103, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720010104, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720010105, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 720010106, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 720010108, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO')), 'Preparações', 98.4, 19.59, 1.08, 1.26, 0.3),
  ('ibge', 720010109, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO')), 'Preparações', 140.05, 20.81, 1.47, 5.11, 0.07),
  ('ibge', 720010113, 'PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO', unaccent(lower('PEIXE DE MAR (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 720040102, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720040103, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720040104, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 720040105, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 720040106, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 720040109, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO')), 'Preparações', 140.05, 20.81, 1.47, 5.11, 0.07),
  ('ibge', 720040113, 'PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO', unaccent(lower('PEIXE DE MAR SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 726010101, 'CAMARAO - CRU(A)', unaccent(lower('CAMARAO - CRU(A)')), 'Preparações', 99.0, 20.91, 0, 1.08, 0),
  ('ibge', 726010102, 'CAMARAO - COZIDO(A)', unaccent(lower('CAMARAO - COZIDO(A)')), 'Preparações', 99.0, 20.91, 0, 1.08, 0),
  ('ibge', 726010103, 'CAMARAO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CAMARAO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 99.0, 20.91, 0, 1.08, 0),
  ('ibge', 726010104, 'CAMARAO - ASSADO(A)', unaccent(lower('CAMARAO - ASSADO(A)')), 'Preparações', 99.0, 20.91, 0, 1.08, 0),
  ('ibge', 726010105, 'CAMARAO - FRITO(A)', unaccent(lower('CAMARAO - FRITO(A)')), 'Preparações', 121.66, 20.91, 0, 3.64, 0),
  ('ibge', 726010106, 'CAMARAO - EMPANADO(A)/A MILANESA', unaccent(lower('CAMARAO - EMPANADO(A)/A MILANESA')), 'Preparações', 137.84, 21.37, 3.39, 3.69, 0.14),
  ('ibge', 726010107, 'CAMARAO - REFOGADO(A)', unaccent(lower('CAMARAO - REFOGADO(A)')), 'Preparações', 121.66, 20.91, 0, 3.64, 0),
  ('ibge', 726010108, 'CAMARAO - MOLHO VERMELHO', unaccent(lower('CAMARAO - MOLHO VERMELHO')), 'Preparações', 84.0, 16.99, 1.08, 0.9, 0.3),
  ('ibge', 726010109, 'CAMARAO - MOLHO BRANCO', unaccent(lower('CAMARAO - MOLHO BRANCO')), 'Preparações', 125.65, 18.21, 1.47, 4.75, 0.07),
  ('ibge', 726010110, 'CAMARAO - AO ALHO E OLEO', unaccent(lower('CAMARAO - AO ALHO E OLEO')), 'Preparações', 121.66, 20.91, 0, 3.64, 0),
  ('ibge', 726010113, 'CAMARAO - ENSOPADO', unaccent(lower('CAMARAO - ENSOPADO')), 'Preparações', 121.66, 20.91, 0, 3.64, 0),
  ('ibge', 726010199, 'CAMARAO', unaccent(lower('CAMARAO')), 'Preparações', 99.0, 20.91, 0, 1.08, 0),
  ('ibge', 726110102, 'SIRI - COZIDO(A)', unaccent(lower('SIRI - COZIDO(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726110106, 'SIRI - EMPANADO(A)/A MILANESA', unaccent(lower('SIRI - EMPANADO(A)/A MILANESA')), 'Preparações', 140.84, 20.66, 3.39, 4.38, 0.14),
  ('ibge', 726110107, 'SIRI - REFOGADO(A)', unaccent(lower('SIRI - REFOGADO(A)')), 'Preparações', 124.66, 20.2, 0, 4.33, 0),
  ('ibge', 726112002, 'BAU (SIRI) - COZIDO(A)', unaccent(lower('BAU (SIRI) - COZIDO(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726112101, 'GOIA - CRU(A)', unaccent(lower('GOIA - CRU(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726210102, 'CARANGUEJO - COZIDO(A)', unaccent(lower('CARANGUEJO - COZIDO(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726210104, 'CARANGUEJO - ASSADO(A)', unaccent(lower('CARANGUEJO - ASSADO(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726210112, 'CARANGUEJO - AO VINAGRETE', unaccent(lower('CARANGUEJO - AO VINAGRETE')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726210502, 'GUAIAMU - COZIDO(A)', unaccent(lower('GUAIAMU - COZIDO(A)')), 'Preparações', 102.0, 20.2, 0, 1.77, 0),
  ('ibge', 726310102, 'MARISCO - COZIDO(A)', unaccent(lower('MARISCO - COZIDO(A)')), 'Preparações', 148.0, 25.55, 5.13, 1.95, 0),
  ('ibge', 726310105, 'MARISCO - FRITO(A)', unaccent(lower('MARISCO - FRITO(A)')), 'Preparações', 170.66, 25.55, 5.13, 4.51, 0),
  ('ibge', 726310108, 'MARISCO - MOLHO VERMELHO', unaccent(lower('MARISCO - MOLHO VERMELHO')), 'Preparações', 123.2, 20.7, 5.18, 1.6, 0.3),
  ('ibge', 726310199, 'MARISCO', unaccent(lower('MARISCO')), 'Preparações', 148.0, 25.55, 5.13, 1.95, 0),
  ('ibge', 726410102, 'OSTRA - COZIDO(A)', unaccent(lower('OSTRA - COZIDO(A)')), 'Preparações', 137.0, 14.1, 7.82, 4.91, 0),
  ('ibge', 726510106, 'LULA - EMPANADO(A)/A MILANESA', unaccent(lower('LULA - EMPANADO(A)/A MILANESA')), 'Preparações', 143.84, 18.32, 6.92, 4.19, 0.14),
  ('ibge', 726610102, 'SURURU - COZIDO(A)', unaccent(lower('SURURU - COZIDO(A)')), 'Preparações', 148.0, 25.55, 5.13, 1.95, 0),
  ('ibge', 726610113, 'SURURU - ENSOPADO', unaccent(lower('SURURU - ENSOPADO')), 'Preparações', 170.66, 25.55, 5.13, 4.51, 0),
  ('ibge', 727040102, 'BACALHAU - COZIDO(A)', unaccent(lower('BACALHAU - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 727040104, 'BACALHAU - ASSADO(A)', unaccent(lower('BACALHAU - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 727040105, 'BACALHAU - FRITO(A)', unaccent(lower('BACALHAU - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 727040106, 'BACALHAU - EMPANADO(A)/A MILANESA', unaccent(lower('BACALHAU - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 727040107, 'BACALHAU - REFOGADO(A)', unaccent(lower('BACALHAU - REFOGADO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 727040108, 'BACALHAU - MOLHO VERMELHO', unaccent(lower('BACALHAU - MOLHO VERMELHO')), 'Preparações', 98.4, 19.59, 1.08, 1.26, 0.3),
  ('ibge', 727040113, 'BACALHAU - ENSOPADO', unaccent(lower('BACALHAU - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 727040199, 'BACALHAU', unaccent(lower('BACALHAU')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 727310104, 'OVAS DE PEIXE (QUALQUER ESPECIE) - ASSADO(A)', unaccent(lower('OVAS DE PEIXE (QUALQUER ESPECIE) - ASSADO(A)')), 'Preparações', 204.0, 28.62, 1.92, 8.23, 0),
  ('ibge', 727310105, 'OVAS DE PEIXE (QUALQUER ESPECIE) - FRITO(A)', unaccent(lower('OVAS DE PEIXE (QUALQUER ESPECIE) - FRITO(A)')), 'Preparações', 226.66, 28.62, 1.92, 10.79, 0),
  ('ibge', 740010101, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740010102, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740010103, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740010104, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740010105, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 740010106, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 740010107, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - REFOGADO(A)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - REFOGADO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 740010108, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO')), 'Preparações', 98.4, 19.59, 1.08, 1.26, 0.3),
  ('ibge', 740010109, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO')), 'Preparações', 126.19, 20.11, 1.85, 3.71, 0.04),
  ('ibge', 740010113, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 740010199, 'PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC)', unaccent(lower('PEIXE DE AGUA DOCE (INTEIRO, EM POSTA, EM FILÉ, ETC)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740040102, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740040103, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740040104, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 740040105, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 740040106, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 740040108, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO')), 'Preparações', 98.4, 19.59, 1.08, 1.26, 0.3),
  ('ibge', 740040113, 'PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO', unaccent(lower('PEIXE DE AGUA DOCE SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 744410102, 'TRACAJA - COZIDO(A)', unaccent(lower('TRACAJA - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760010101, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - CRU(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760010102, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760010103, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760010104, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760010105, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 760010106, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 760010107, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - REFOGADO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - REFOGADO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 760010108, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO VERMELHO')), 'Preparações', 98.4, 19.59, 1.08, 1.26, 0.3),
  ('ibge', 760010109, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - MOLHO BRANCO')), 'Preparações', 140.05, 20.81, 1.47, 5.11, 0.07),
  ('ibge', 760010113, 'PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO', unaccent(lower('PEIXE NAO ESPECIFICADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ENSOPADO')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 760040102, 'PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - COZIDO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760040103, 'PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760040104, 'PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - ASSADO(A)')), 'Preparações', 117.0, 24.16, 0, 1.53, 0),
  ('ibge', 760040105, 'PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)', unaccent(lower('PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - FRITO(A)')), 'Preparações', 139.66, 24.16, 0, 4.09, 0),
  ('ibge', 760040106, 'PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('PEIXE NAO ESPECIFICADO SALGADO (INTEIRO, EM POSTA, EM FILÉ, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 155.84, 24.62, 3.39, 4.14, 0.14),
  ('ibge', 770010199, 'AZEITONA', unaccent(lower('AZEITONA')), 'Preparações', 145.0, 1.03, 3.84, 15.32, 3.3),
  ('ibge', 770020199, 'ERVILHA EM CONSERVA', unaccent(lower('ERVILHA EM CONSERVA')), 'Preparações', 69.0, 4.42, 12.58, 0.35, 4.1),
  ('ibge', 770020299, 'PETIT POIS', unaccent(lower('PETIT POIS')), 'Preparações', 69.0, 4.42, 12.58, 0.35, 4.1),
  ('ibge', 770040199, 'MILHO VERDE EM CONSERVA', unaccent(lower('MILHO VERDE EM CONSERVA')), 'Preparações', 81.0, 2.64, 18.8, 0.93, 1.9),
  ('ibge', 770050199, 'PALMITO EM CONSERVA', unaccent(lower('PALMITO EM CONSERVA')), 'Preparações', 28.0, 2.52, 4.62, 0.62, 2.4),
  ('ibge', 770060199, 'COGUMELO EM CONSERVA', unaccent(lower('COGUMELO EM CONSERVA')), 'Preparações', 50.74, 1.87, 5.09, 3.2, 2.4),
  ('ibge', 770060299, 'CHAMPIGNON EM CONSERVA', unaccent(lower('CHAMPIGNON EM CONSERVA')), 'Preparações', 50.74, 1.87, 5.09, 3.2, 2.4),
  ('ibge', 770070199, 'ASPARGO EM CONSERVA', unaccent(lower('ASPARGO EM CONSERVA')), 'Preparações', 19.0, 2.14, 2.46, 0.65, 1.6),
  ('ibge', 770090199, 'REPOLHO EM CONSERVA', unaccent(lower('REPOLHO EM CONSERVA')), 'Preparações', 19.0, 0.91, 4.28, 0.14, 2.9),
  ('ibge', 770090299, 'CHUCRUTE', unaccent(lower('CHUCRUTE')), 'Preparações', 19.0, 0.91, 4.28, 0.14, 2.9),
  ('ibge', 770110199, 'LEGUME NAO ESPECIFICADO EM CONSERVA', unaccent(lower('LEGUME NAO ESPECIFICADO EM CONSERVA')), 'Preparações', 47.0, 2.53, 9.06, 0.26, 2.8),
  ('ibge', 770140499, 'CREME DE CEBOLA (SOPA DESIDRATADA)', unaccent(lower('CREME DE CEBOLA (SOPA DESIDRATADA)')), 'Preparações', 46.31, 0.82, 5.34, 2.47, 0.2),
  ('ibge', 770140599, 'CREME DE LEGUMES (SOPA DESIDRATADA)', unaccent(lower('CREME DE LEGUMES (SOPA DESIDRATADA)')), 'Preparações', 10.55, 0.48, 2.15, 0.02, 0.23),
  ('ibge', 770140699, 'YAKISSOBA', unaccent(lower('YAKISSOBA')), 'Preparações', 527.0, 8.38, 57.54, 30.76, 3.9),
  ('ibge', 770150101, 'MILHO VERDE COM ERVILHA EM CONSERVA - CRU(A)', unaccent(lower('MILHO VERDE COM ERVILHA EM CONSERVA - CRU(A)')), 'Preparações', 79.52, 3.83, 16.81, 0.47, 2.96),
  ('ibge', 770150102, 'MILHO VERDE COM ERVILHA EM CONSERVA - COZIDO(A)', unaccent(lower('MILHO VERDE COM ERVILHA EM CONSERVA - COZIDO(A)')), 'Preparações', 79.52, 3.83, 16.81, 0.47, 2.96),
  ('ibge', 770150105, 'MILHO VERDE COM ERVILHA EM CONSERVA - FRITO(A)', unaccent(lower('MILHO VERDE COM ERVILHA EM CONSERVA - FRITO(A)')), 'Preparações', 79.52, 3.83, 16.81, 0.47, 2.96),
  ('ibge', 770150199, 'MILHO VERDE COM ERVILHA EM CONSERVA', unaccent(lower('MILHO VERDE COM ERVILHA EM CONSERVA')), 'Preparações', 79.52, 3.83, 16.81, 0.47, 2.96),
  ('ibge', 770190199, 'FEIJOADA', unaccent(lower('FEIJOADA')), 'Preparações', 181.59, 11.11, 16.92, 7.9, 5.68),
  ('ibge', 770200199, 'FEIJAO BRANCO COM DOBRADINHA EM CONSERVA', unaccent(lower('FEIJAO BRANCO COM DOBRADINHA EM CONSERVA')), 'Preparações', 136.38, 10.68, 10.2, 5.91, 2.33),
  ('ibge', 770210199, 'COZIDO', unaccent(lower('COZIDO')), 'Preparações', 87.33, 5.61, 7.93, 3.79, 1.74),
  ('ibge', 770230299, 'PASTA DE CARNE EM CONSERVA', unaccent(lower('PASTA DE CARNE EM CONSERVA')), 'Preparações', 245.65, 9.89, 14.1, 16.89, 0.17),
  ('ibge', 770240299, 'PASTA DE PRESUNTO EM CONSERVA', unaccent(lower('PASTA DE PRESUNTO EM CONSERVA')), 'Preparações', 276.46, 17.86, 1.8, 21.43, 0),
  ('ibge', 770250299, 'PASTA DE GALINHA EM CONSERVA', unaccent(lower('PASTA DE GALINHA EM CONSERVA')), 'Preparações', 214.36, 16.39, 3.66, 14.53, 0.25),
  ('ibge', 770260199, 'CARNE BOVINA EM CONSERVA', unaccent(lower('CARNE BOVINA EM CONSERVA')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 770260299, 'ALMONDEGA', unaccent(lower('ALMONDEGA')), 'Preparações', 214.85, 20.64, 11.0, 9.2, 0.76),
  ('ibge', 770260399, 'KITUTE BOVINO', unaccent(lower('KITUTE BOVINO')), 'Preparações', 242.0, 24.22, 0, 15.42, 0),
  ('ibge', 770260499, 'ALMONDEGA AO MOLHO EM CONSERVA', unaccent(lower('ALMONDEGA AO MOLHO EM CONSERVA')), 'Preparações', 203.52, 16.16, 9.7, 10.72, 0.91),
  ('ibge', 770270499, 'KITUTE SUINO', unaccent(lower('KITUTE SUINO')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770270599, 'PRESUNTADA', unaccent(lower('PRESUNTADA')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770270701, 'FIAMBRE - CRU(A)', unaccent(lower('FIAMBRE - CRU(A)')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770270702, 'FIAMBRE - COZIDO(A)', unaccent(lower('FIAMBRE - COZIDO(A)')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770270704, 'FIAMBRE - ASSADO(A)', unaccent(lower('FIAMBRE - ASSADO(A)')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770270705, 'FIAMBRE - FRITO(A)', unaccent(lower('FIAMBRE - FRITO(A)')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 770280199, 'SALSICHA EM CONSERVA', unaccent(lower('SALSICHA EM CONSERVA')), 'Preparações', 269.08, 8.3, 0.27, 25.81, 0.01),
  ('ibge', 770300299, 'SARDINHA EM CONSERVA', unaccent(lower('SARDINHA EM CONSERVA')), 'Preparações', 208.0, 24.62, 0, 11.45, 0),
  ('ibge', 770340299, 'ATUM EM CONSERVA', unaccent(lower('ATUM EM CONSERVA')), 'Preparações', 198.0, 29.13, 0, 8.21, 0),
  ('ibge', 770370199, 'PEPINO EM CONSERVA', unaccent(lower('PEPINO EM CONSERVA')), 'Preparações', 12.0, 0.6, 2.59, 0.14, 1.1),
  ('ibge', 770390299, 'PASTA DE PEIXE EM CONSERVA', unaccent(lower('PASTA DE PEIXE EM CONSERVA')), 'Preparações', 198.0, 29.13, 0, 8.21, 0),
  ('ibge', 770400199, 'PICLES', unaccent(lower('PICLES')), 'Preparações', 12.0, 0.6, 2.59, 0.14, 1.1),
  ('ibge', 770520199, 'NABO EM CONSERVA', unaccent(lower('NABO EM CONSERVA')), 'Preparações', 43.26, 0.87, 9.94, 0.19, 1.59),
  ('ibge', 770540199, 'STROGONOFF', unaccent(lower('STROGONOFF')), 'Preparações', 147.68, 12.83, 4.12, 9.11, 0.44),
  ('ibge', 770600199, 'SALMAO EM CONSERVA', unaccent(lower('SALMAO EM CONSERVA')), 'Preparações', 136.0, 23.08, 0, 4.83, 0),
  ('ibge', 770610499, 'CREME DE CEBOLA (SOPA DESIDRATADA) LIGHT', unaccent(lower('CREME DE CEBOLA (SOPA DESIDRATADA) LIGHT')), 'Preparações', 46.31, 0.82, 5.34, 2.47, 0.2),
  ('ibge', 770610599, 'CREME DE LEGUMES (SOPA DESIDRATADA) LIGHT', unaccent(lower('CREME DE LEGUMES (SOPA DESIDRATADA) LIGHT')), 'Preparações', 10.55, 0.48, 2.15, 0.02, 0.23),
  ('ibge', 770610699, 'YAKISSOBA (SOPA DE LEGUMES DESIDRATADA) LIGHT', unaccent(lower('YAKISSOBA (SOPA DE LEGUMES DESIDRATADA) LIGHT')), 'Preparações', 80.04, 3.0, 15.61, 0.47, 0.97),
  ('ibge', 770630299, 'ATUM EM CONSERVA LIGHT', unaccent(lower('ATUM EM CONSERVA LIGHT')), 'Preparações', 116.0, 25.51, 0, 0.82, 0),
  ('ibge', 780010301, 'FRANGO INTEIRO - CRU(A)', unaccent(lower('FRANGO INTEIRO - CRU(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780010302, 'FRANGO INTEIRO - COZIDO(A)', unaccent(lower('FRANGO INTEIRO - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780010303, 'FRANGO INTEIRO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FRANGO INTEIRO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780010304, 'FRANGO INTEIRO - ASSADO(A)', unaccent(lower('FRANGO INTEIRO - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780010305, 'FRANGO INTEIRO - FRITO(A)', unaccent(lower('FRANGO INTEIRO - FRITO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780010306, 'FRANGO INTEIRO - EMPANADO(A)/A MILANESA', unaccent(lower('FRANGO INTEIRO - EMPANADO(A)/A MILANESA')), 'Preparações', 277.84, 27.76, 3.39, 16.21, 0.14),
  ('ibge', 780010307, 'FRANGO INTEIRO - REFOGADO(A)', unaccent(lower('FRANGO INTEIRO - REFOGADO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780010308, 'FRANGO INTEIRO - MOLHO VERMELHO', unaccent(lower('FRANGO INTEIRO - MOLHO VERMELHO')), 'Preparações', 196.0, 22.1, 1.08, 10.92, 0.3),
  ('ibge', 780010313, 'FRANGO INTEIRO - ENSOPADO', unaccent(lower('FRANGO INTEIRO - ENSOPADO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030101, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - CRU(A)', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - CRU(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030102, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - COZIDO(A)', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030103, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030104, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - ASSADO(A)', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030105, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - FRITO(A)', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - FRITO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030106, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - EMPANADO(A)/A MILANESA', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - EMPANADO(A)/A MILANESA')), 'Preparações', 277.84, 27.76, 3.39, 16.21, 0.14),
  ('ibge', 780030107, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - REFOGADO(A)', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - REFOGADO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030108, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - MOLHO VERMELHO', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - MOLHO VERMELHO')), 'Preparações', 196.0, 22.1, 1.08, 10.92, 0.3),
  ('ibge', 780030113, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - ENSOPADO', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA - ENSOPADO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030199, 'PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA', unaccent(lower('PARTE DE GALINHA OU FRANGO NAO ESPECIFICADA')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030201, 'FRANGO EM PEDAÇOS - CRU(A)', unaccent(lower('FRANGO EM PEDAÇOS - CRU(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030202, 'FRANGO EM PEDAÇOS - COZIDO(A)', unaccent(lower('FRANGO EM PEDAÇOS - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030203, 'FRANGO EM PEDAÇOS - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FRANGO EM PEDAÇOS - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030204, 'FRANGO EM PEDAÇOS - ASSADO(A)', unaccent(lower('FRANGO EM PEDAÇOS - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030205, 'FRANGO EM PEDAÇOS - FRITO(A)', unaccent(lower('FRANGO EM PEDAÇOS - FRITO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030206, 'FRANGO EM PEDAÇOS - EMPANADO(A)/A MILANESA', unaccent(lower('FRANGO EM PEDAÇOS - EMPANADO(A)/A MILANESA')), 'Preparações', 277.84, 27.76, 3.39, 16.21, 0.14),
  ('ibge', 780030207, 'FRANGO EM PEDAÇOS - REFOGADO(A)', unaccent(lower('FRANGO EM PEDAÇOS - REFOGADO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030208, 'FRANGO EM PEDAÇOS - MOLHO VERMELHO', unaccent(lower('FRANGO EM PEDAÇOS - MOLHO VERMELHO')), 'Preparações', 196.0, 22.1, 1.08, 10.92, 0.3),
  ('ibge', 780030209, 'FRANGO EM PEDAÇOS - MOLHO BRANCO', unaccent(lower('FRANGO EM PEDAÇOS - MOLHO BRANCO')), 'Preparações', 226.78, 22.6, 1.85, 13.71, 0.04),
  ('ibge', 780030210, 'FRANGO EM PEDAÇOS - AO ALHO E OLEO', unaccent(lower('FRANGO EM PEDAÇOS - AO ALHO E OLEO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030211, 'FRANGO EM PEDAÇOS - COM MANTEIGA/OLEO', unaccent(lower('FRANGO EM PEDAÇOS - COM MANTEIGA/OLEO')), 'Preparações', 192.14, 30.93, 0.0, 6.67, 0),
  ('ibge', 780030213, 'FRANGO EM PEDAÇOS - ENSOPADO', unaccent(lower('FRANGO EM PEDAÇOS - ENSOPADO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030215, 'FRANGO EM PEDAÇOS - SOPA', unaccent(lower('FRANGO EM PEDAÇOS - SOPA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780030299, 'FRANGO EM PEDAÇOS', unaccent(lower('FRANGO EM PEDAÇOS')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030302, 'GALINHA EM PEDACOS - COZIDO(A)', unaccent(lower('GALINHA EM PEDACOS - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030303, 'GALINHA EM PEDACOS - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('GALINHA EM PEDACOS - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030304, 'GALINHA EM PEDACOS - ASSADO(A)', unaccent(lower('GALINHA EM PEDACOS - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030305, 'GALINHA EM PEDACOS - FRITO(A)', unaccent(lower('GALINHA EM PEDACOS - FRITO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030306, 'GALINHA EM PEDACOS - EMPANADO(A)/A MILANESA', unaccent(lower('GALINHA EM PEDACOS - EMPANADO(A)/A MILANESA')), 'Preparações', 277.84, 27.76, 3.39, 16.21, 0.14),
  ('ibge', 780030307, 'GALINHA EM PEDACOS - REFOGADO(A)', unaccent(lower('GALINHA EM PEDACOS - REFOGADO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030308, 'GALINHA EM PEDACOS - MOLHO VERMELHO', unaccent(lower('GALINHA EM PEDACOS - MOLHO VERMELHO')), 'Preparações', 196.0, 22.1, 1.08, 10.92, 0.3),
  ('ibge', 780030309, 'GALINHA EM PEDACOS - MOLHO BRANCO', unaccent(lower('GALINHA EM PEDACOS - MOLHO BRANCO')), 'Preparações', 226.78, 22.6, 1.85, 13.71, 0.04),
  ('ibge', 780030313, 'GALINHA EM PEDACOS - ENSOPADO', unaccent(lower('GALINHA EM PEDACOS - ENSOPADO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030401, 'CARNE DE GALINHA - CRU(A)', unaccent(lower('CARNE DE GALINHA - CRU(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030402, 'CARNE DE GALINHA - COZIDO(A)', unaccent(lower('CARNE DE GALINHA - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030403, 'CARNE DE GALINHA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE GALINHA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030404, 'CARNE DE GALINHA - ASSADO(A)', unaccent(lower('CARNE DE GALINHA - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030405, 'CARNE DE GALINHA - FRITO(A)', unaccent(lower('CARNE DE GALINHA - FRITO(A)')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030406, 'CARNE DE GALINHA - EMPANADO(A)/A MILANESA', unaccent(lower('CARNE DE GALINHA - EMPANADO(A)/A MILANESA')), 'Preparações', 277.84, 27.76, 3.39, 16.21, 0.14),
  ('ibge', 780030407, 'CARNE DE GALINHA - REFOGADO(A)', unaccent(lower('CARNE DE GALINHA - REFOGADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780030408, 'CARNE DE GALINHA - MOLHO VERMELHO', unaccent(lower('CARNE DE GALINHA - MOLHO VERMELHO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030409, 'CARNE DE GALINHA - MOLHO BRANCO', unaccent(lower('CARNE DE GALINHA - MOLHO BRANCO')), 'Preparações', 226.78, 22.6, 1.85, 13.71, 0.04),
  ('ibge', 780030413, 'CARNE DE GALINHA - ENSOPADO', unaccent(lower('CARNE DE GALINHA - ENSOPADO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 780030415, 'CARNE DE GALINHA - SOPA', unaccent(lower('CARNE DE GALINHA - SOPA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780030499, 'CARNE DE GALINHA', unaccent(lower('CARNE DE GALINHA')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780040101, 'PEITO DE GALINHA OU FRANGO - CRU(A)', unaccent(lower('PEITO DE GALINHA OU FRANGO - CRU(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040102, 'PEITO DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('PEITO DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040103, 'PEITO DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEITO DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040104, 'PEITO DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('PEITO DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040105, 'PEITO DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('PEITO DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040106, 'PEITO DE GALINHA OU FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('PEITO DE GALINHA OU FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780040107, 'PEITO DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('PEITO DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040108, 'PEITO DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('PEITO DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 143.2, 24.99, 1.08, 3.64, 0.3),
  ('ibge', 780040109, 'PEITO DE GALINHA OU FRANGO - MOLHO BRANCO', unaccent(lower('PEITO DE GALINHA OU FRANGO - MOLHO BRANCO')), 'Preparações', 170.99, 25.51, 1.85, 6.1, 0.04),
  ('ibge', 780040113, 'PEITO DE GALINHA OU FRANGO - ENSOPADO', unaccent(lower('PEITO DE GALINHA OU FRANGO - ENSOPADO')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040115, 'PEITO DE GALINHA OU FRANGO - SOPA', unaccent(lower('PEITO DE GALINHA OU FRANGO - SOPA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780040199, 'PEITO DE GALINHA OU FRANGO', unaccent(lower('PEITO DE GALINHA OU FRANGO')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040201, 'FILE DE FRANGO - CRU(A)', unaccent(lower('FILE DE FRANGO - CRU(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040202, 'FILE DE FRANGO - COZIDO(A)', unaccent(lower('FILE DE FRANGO - COZIDO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040203, 'FILE DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FILE DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040204, 'FILE DE FRANGO - ASSADO(A)', unaccent(lower('FILE DE FRANGO - ASSADO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780040205, 'FILE DE FRANGO - FRITO(A)', unaccent(lower('FILE DE FRANGO - FRITO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040206, 'FILE DE FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('FILE DE FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780040207, 'FILE DE FRANGO - REFOGADO(A)', unaccent(lower('FILE DE FRANGO - REFOGADO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040208, 'FILE DE FRANGO - MOLHO VERMELHO', unaccent(lower('FILE DE FRANGO - MOLHO VERMELHO')), 'Preparações', 143.2, 24.99, 1.08, 3.64, 0.3),
  ('ibge', 780040209, 'FILE DE FRANGO - MOLHO BRANCO', unaccent(lower('FILE DE FRANGO - MOLHO BRANCO')), 'Preparações', 170.99, 25.51, 1.85, 6.1, 0.04),
  ('ibge', 780040210, 'FILE DE FRANGO - AO ALHO E OLEO', unaccent(lower('FILE DE FRANGO - AO ALHO E OLEO')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040213, 'FILE DE FRANGO - ENSOPADO', unaccent(lower('FILE DE FRANGO - ENSOPADO')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780040299, 'FILE DE FRANGO', unaccent(lower('FILE DE FRANGO')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780060202, 'CARCACA DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('CARCACA DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780060204, 'CARCACA DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('CARCACA DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780060205, 'CARCACA DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('CARCACA DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780060207, 'CARCACA DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('CARCACA DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780060213, 'CARCACA DE GALINHA OU FRANGO - ENSOPADO', unaccent(lower('CARCACA DE GALINHA OU FRANGO - ENSOPADO')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780070101, 'ASA DE GALINHA OU FRANGO - CRU(A)', unaccent(lower('ASA DE GALINHA OU FRANGO - CRU(A)')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780070102, 'ASA DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('ASA DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780070103, 'ASA DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('ASA DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780070104, 'ASA DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('ASA DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780070105, 'ASA DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('ASA DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 312.66, 26.86, 0, 22.02, 0),
  ('ibge', 780070106, 'ASA DE GALINHA OU FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('ASA DE GALINHA OU FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 328.84, 27.32, 3.39, 22.07, 0.14),
  ('ibge', 780070107, 'ASA DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('ASA DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 312.66, 26.86, 0, 22.02, 0),
  ('ibge', 780070108, 'ASA DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('ASA DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 236.8, 21.75, 1.08, 15.6, 0.3),
  ('ibge', 780070113, 'ASA DE GALINHA OU FRANGO - ENSOPADO', unaccent(lower('ASA DE GALINHA OU FRANGO - ENSOPADO')), 'Preparações', 312.66, 26.86, 0, 22.02, 0),
  ('ibge', 780070202, 'DRUMETE DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 213.0, 27.73, 0, 10.5, 0),
  ('ibge', 780070203, 'DRUMETE DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 213.0, 27.73, 0, 10.5, 0),
  ('ibge', 780070204, 'DRUMETE DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 213.0, 27.73, 0, 10.5, 0),
  ('ibge', 780070205, 'DRUMETE DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 235.66, 27.73, 0, 13.06, 0),
  ('ibge', 780070207, 'DRUMETE DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 235.66, 27.73, 0, 13.06, 0),
  ('ibge', 780070208, 'DRUMETE DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('DRUMETE DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 175.2, 22.45, 1.08, 8.44, 0.3),
  ('ibge', 780080102, 'PESCOCO DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('PESCOCO DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 300.0, 25.95, 0, 20.97, 0),
  ('ibge', 780080104, 'PESCOCO DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('PESCOCO DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 300.0, 25.95, 0, 20.97, 0),
  ('ibge', 780080105, 'PESCOCO DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('PESCOCO DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 322.66, 25.95, 0, 23.53, 0),
  ('ibge', 780080107, 'PESCOCO DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('PESCOCO DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 322.66, 25.95, 0, 23.53, 0),
  ('ibge', 780080109, 'PESCOCO DE GALINHA OU FRANGO - MOLHO BRANCO', unaccent(lower('PESCOCO DE GALINHA OU FRANGO - MOLHO BRANCO')), 'Preparações', 272.59, 21.54, 1.85, 19.27, 0.04),
  ('ibge', 780090102, 'PE DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('PE DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 215.0, 19.4, 0.2, 14.6, 0),
  ('ibge', 780090103, 'PE DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PE DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 215.0, 19.4, 0.2, 14.6, 0),
  ('ibge', 780090104, 'PE DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('PE DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 215.0, 19.4, 0.2, 14.6, 0),
  ('ibge', 780090105, 'PE DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('PE DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 237.66, 19.4, 0.2, 17.16, 0),
  ('ibge', 780090107, 'PE DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('PE DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 237.66, 19.4, 0.2, 17.16, 0),
  ('ibge', 780090108, 'PE DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('PE DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 176.8, 15.78, 1.24, 11.72, 0.3),
  ('ibge', 780090113, 'PE DE GALINHA OU FRANGO - ENSOPADO', unaccent(lower('PE DE GALINHA OU FRANGO - ENSOPADO')), 'Preparações', 237.66, 19.4, 0.2, 17.16, 0),
  ('ibge', 780100102, 'MIUDO DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('MIUDO DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 167.0, 24.46, 0.87, 6.51, 0),
  ('ibge', 780100104, 'MIUDO DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('MIUDO DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 167.0, 24.46, 0.87, 6.51, 0),
  ('ibge', 780100105, 'MIUDO DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('MIUDO DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 189.66, 24.46, 0.87, 9.07, 0),
  ('ibge', 780100108, 'MIUDO DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('MIUDO DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 138.4, 19.83, 1.77, 5.24, 0.3),
  ('ibge', 780100115, 'MIUDO DE GALINHA OU FRANGO - SOPA', unaccent(lower('MIUDO DE GALINHA OU FRANGO - SOPA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780110102, 'MOELA DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('MOELA DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 146.0, 30.39, 0, 2.68, 0),
  ('ibge', 780110103, 'MOELA DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('MOELA DE GALINHA OU FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 146.0, 30.39, 0, 2.68, 0),
  ('ibge', 780110105, 'MOELA DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('MOELA DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 168.66, 30.39, 0, 5.24, 0),
  ('ibge', 780110107, 'MOELA DE GALINHA OU FRANGO - REFOGADO(A)', unaccent(lower('MOELA DE GALINHA OU FRANGO - REFOGADO(A)')), 'Preparações', 168.66, 30.39, 0, 5.24, 0),
  ('ibge', 780110108, 'MOELA DE GALINHA OU FRANGO - MOLHO VERMELHO', unaccent(lower('MOELA DE GALINHA OU FRANGO - MOLHO VERMELHO')), 'Preparações', 121.6, 24.58, 1.08, 2.18, 0.3),
  ('ibge', 780110109, 'MOELA DE GALINHA OU FRANGO - MOLHO BRANCO', unaccent(lower('MOELA DE GALINHA OU FRANGO - MOLHO BRANCO')), 'Preparações', 149.39, 25.09, 1.85, 4.63, 0.04),
  ('ibge', 780110113, 'MOELA DE GALINHA OU FRANGO - ENSOPADO', unaccent(lower('MOELA DE GALINHA OU FRANGO - ENSOPADO')), 'Preparações', 168.66, 30.39, 0, 5.24, 0),
  ('ibge', 780110115, 'MOELA DE GALINHA OU FRANGO - SOPA', unaccent(lower('MOELA DE GALINHA OU FRANGO - SOPA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780120202, 'CORACAO DE FRANGO - COZIDO(A)', unaccent(lower('CORACAO DE FRANGO - COZIDO(A)')), 'Preparações', 185.0, 26.41, 0.1, 7.92, 0),
  ('ibge', 780120203, 'CORACAO DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CORACAO DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 185.0, 26.41, 0.1, 7.92, 0),
  ('ibge', 780120204, 'CORACAO DE FRANGO - ASSADO(A)', unaccent(lower('CORACAO DE FRANGO - ASSADO(A)')), 'Preparações', 185.0, 26.41, 0.1, 7.92, 0),
  ('ibge', 780120205, 'CORACAO DE FRANGO - FRITO(A)', unaccent(lower('CORACAO DE FRANGO - FRITO(A)')), 'Preparações', 207.66, 26.41, 0.1, 10.48, 0),
  ('ibge', 780120213, 'CORACAO DE FRANGO - ENSOPADO', unaccent(lower('CORACAO DE FRANGO - ENSOPADO')), 'Preparações', 185.0, 26.41, 0.1, 7.92, 0),
  ('ibge', 780130102, 'FIGADO DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('FIGADO DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 167.0, 24.46, 0.87, 6.51, 0),
  ('ibge', 780130104, 'FIGADO DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('FIGADO DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 167.0, 24.46, 0.87, 6.51, 0),
  ('ibge', 780130105, 'FIGADO DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('FIGADO DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 189.66, 24.46, 0.87, 9.07, 0),
  ('ibge', 780140799, 'CANJA', unaccent(lower('CANJA')), 'Preparações', 31.47, 1.61, 3.64, 1.06, 0.13),
  ('ibge', 780170202, 'PERU EM PEDACO NAO ESPECIFICADO - COZIDO(A)', unaccent(lower('PERU EM PEDACO NAO ESPECIFICADO - COZIDO(A)')), 'Preparações', 207.0, 26.93, 0, 10.23, 0),
  ('ibge', 780170204, 'PERU EM PEDACO NAO ESPECIFICADO - ASSADO(A)', unaccent(lower('PERU EM PEDACO NAO ESPECIFICADO - ASSADO(A)')), 'Preparações', 207.0, 26.93, 0, 10.23, 0),
  ('ibge', 780170205, 'PERU EM PEDACO NAO ESPECIFICADO - FRITO(A)', unaccent(lower('PERU EM PEDACO NAO ESPECIFICADO - FRITO(A)')), 'Preparações', 229.66, 26.93, 0, 12.8, 0),
  ('ibge', 780170213, 'PERU EM PEDACO NAO ESPECIFICADO - ENSOPADO', unaccent(lower('PERU EM PEDACO NAO ESPECIFICADO - ENSOPADO')), 'Preparações', 229.66, 26.93, 0, 12.8, 0),
  ('ibge', 780180101, 'PEITO DE PERU - CRU(A)', unaccent(lower('PEITO DE PERU - CRU(A)')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780180102, 'PEITO DE PERU - COZIDO(A)', unaccent(lower('PEITO DE PERU - COZIDO(A)')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780180103, 'PEITO DE PERU - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('PEITO DE PERU - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780180104, 'PEITO DE PERU - ASSADO(A)', unaccent(lower('PEITO DE PERU - ASSADO(A)')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780180105, 'PEITO DE PERU - FRITO(A)', unaccent(lower('PEITO DE PERU - FRITO(A)')), 'Preparações', 162.66, 30.19, 0, 3.74, 0),
  ('ibge', 780180106, 'PEITO DE PERU - EMPANADO(A)/A MILANESA', unaccent(lower('PEITO DE PERU - EMPANADO(A)/A MILANESA')), 'Preparações', 162.66, 30.19, 0, 3.74, 0),
  ('ibge', 780180199, 'PEITO DE PERU', unaccent(lower('PEITO DE PERU')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780210102, 'ASA DE PERU - COZIDO(A)', unaccent(lower('ASA DE PERU - COZIDO(A)')), 'Preparações', 229.0, 27.38, 0, 12.43, 0),
  ('ibge', 780210104, 'ASA DE PERU - ASSADO(A)', unaccent(lower('ASA DE PERU - ASSADO(A)')), 'Preparações', 229.0, 27.38, 0, 12.43, 0),
  ('ibge', 780270102, 'CHESTER - COZIDO(A)', unaccent(lower('CHESTER - COZIDO(A)')), 'Preparações', 207.0, 26.93, 0, 10.23, 0),
  ('ibge', 780270104, 'CHESTER - ASSADO(A)', unaccent(lower('CHESTER - ASSADO(A)')), 'Preparações', 207.0, 26.93, 0, 10.23, 0),
  ('ibge', 780270199, 'CHESTER', unaccent(lower('CHESTER')), 'Preparações', 207.0, 26.93, 0, 10.23, 0),
  ('ibge', 780270204, 'TENDER - ASSADO(A)', unaccent(lower('TENDER - ASSADO(A)')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 780280102, 'NAMBU - COZIDO(A)', unaccent(lower('NAMBU - COZIDO(A)')), 'Preparações', 219.0, 23.9, 0, 13.0, 0),
  ('ibge', 780290103, 'NUGGETS DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('NUGGETS DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 780290104, 'NUGGETS DE FRANGO - ASSADO(A)', unaccent(lower('NUGGETS DE FRANGO - ASSADO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 780290105, 'NUGGETS DE FRANGO - FRITO(A)', unaccent(lower('NUGGETS DE FRANGO - FRITO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 780290106, 'NUGGETS DE FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('NUGGETS DE FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 780290107, 'NUGGETS DE FRANGO - REFOGADO(A)', unaccent(lower('NUGGETS DE FRANGO - REFOGADO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 780290202, 'STEAK DE FRANGO - COZIDO(A)', unaccent(lower('STEAK DE FRANGO - COZIDO(A)')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780290203, 'STEAK DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('STEAK DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780290204, 'STEAK DE FRANGO - ASSADO(A)', unaccent(lower('STEAK DE FRANGO - ASSADO(A)')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780290205, 'STEAK DE FRANGO - FRITO(A)', unaccent(lower('STEAK DE FRANGO - FRITO(A)')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780290206, 'STEAK DE FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('STEAK DE FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780290299, 'STEAK DE FRANGO', unaccent(lower('STEAK DE FRANGO')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 780300105, 'CODORNA - FRITO(A)', unaccent(lower('CODORNA - FRITO(A)')), 'Preparações', 269.66, 32.4, 0, 14.66, 0),
  ('ibge', 780320102, 'PE E ASA DE GALINHA OU FRANGO - COZIDO(A)', unaccent(lower('PE E ASA DE GALINHA OU FRANGO - COZIDO(A)')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780320104, 'PE E ASA DE GALINHA OU FRANGO - ASSADO(A)', unaccent(lower('PE E ASA DE GALINHA OU FRANGO - ASSADO(A)')), 'Preparações', 290.0, 26.86, 0, 19.46, 0),
  ('ibge', 780320105, 'PE E ASA DE GALINHA OU FRANGO - FRITO(A)', unaccent(lower('PE E ASA DE GALINHA OU FRANGO - FRITO(A)')), 'Preparações', 312.66, 26.86, 0, 22.02, 0),
  ('ibge', 780330101, 'OVO DE GALINHA - CRU(A)', unaccent(lower('OVO DE GALINHA - CRU(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330102, 'OVO DE GALINHA - COZIDO(A)', unaccent(lower('OVO DE GALINHA - COZIDO(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330104, 'OVO DE GALINHA - ASSADO(A)', unaccent(lower('OVO DE GALINHA - ASSADO(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330105, 'OVO DE GALINHA - FRITO(A)', unaccent(lower('OVO DE GALINHA - FRITO(A)')), 'Preparações', 222.59, 13.67, 1.22, 17.65, 0),
  ('ibge', 780330107, 'OVO DE GALINHA - REFOGADO(A)', unaccent(lower('OVO DE GALINHA - REFOGADO(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330108, 'OVO DE GALINHA - MOLHO VERMELHO', unaccent(lower('OVO DE GALINHA - MOLHO VERMELHO')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330110, 'OVO DE GALINHA - AO ALHO E OLEO', unaccent(lower('OVO DE GALINHA - AO ALHO E OLEO')), 'Preparações', 222.59, 13.67, 1.22, 17.65, 0),
  ('ibge', 780330111, 'OVO DE GALINHA - COM MANTEIGA/OLEO', unaccent(lower('OVO DE GALINHA - COM MANTEIGA/OLEO')), 'Preparações', 214.18, 13.73, 1.22, 16.7, 0),
  ('ibge', 780330112, 'OVO DE GALINHA - AO VINAGRETE', unaccent(lower('OVO DE GALINHA - AO VINAGRETE')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330113, 'OVO DE GALINHA - ENSOPADO', unaccent(lower('OVO DE GALINHA - ENSOPADO')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330114, 'OVO DE GALINHA - MINGAU', unaccent(lower('OVO DE GALINHA - MINGAU')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780330199, 'OVO DE GALINHA', unaccent(lower('OVO DE GALINHA')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780350101, 'OVO DE CODORNA - CRU(A)', unaccent(lower('OVO DE CODORNA - CRU(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780350102, 'OVO DE CODORNA - COZIDO(A)', unaccent(lower('OVO DE CODORNA - COZIDO(A)')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780350105, 'OVO DE CODORNA - FRITO(A)', unaccent(lower('OVO DE CODORNA - FRITO(A)')), 'Preparações', 222.59, 13.67, 1.22, 17.65, 0),
  ('ibge', 780350112, 'OVO DE CODORNA - AO VINAGRETE', unaccent(lower('OVO DE CODORNA - AO VINAGRETE')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780350199, 'OVO DE CODORNA', unaccent(lower('OVO DE CODORNA')), 'Preparações', 155.0, 12.58, 1.12, 10.61, 0),
  ('ibge', 780370202, 'GALINHA DE ANGOLA ABATIDA, CONGELADA OU VIVA - COZIDO(A)', unaccent(lower('GALINHA DE ANGOLA ABATIDA, CONGELADA OU VIVA - COZIDO(A)')), 'Preparações', 247.0, 32.4, 0, 12.1, 0),
  ('ibge', 780370204, 'GALINHA DE ANGOLA ABATIDA, CONGELADA OU VIVA - ASSADO(A)', unaccent(lower('GALINHA DE ANGOLA ABATIDA, CONGELADA OU VIVA - ASSADO(A)')), 'Preparações', 247.0, 32.4, 0, 12.1, 0),
  ('ibge', 780370302, 'CAPOTE - COZIDO(A)', unaccent(lower('CAPOTE - COZIDO(A)')), 'Preparações', 247.0, 32.4, 0, 12.1, 0),
  ('ibge', 780370304, 'CAPOTE - ASSADO(A)', unaccent(lower('CAPOTE - ASSADO(A)')), 'Preparações', 247.0, 32.4, 0, 12.1, 0),
  ('ibge', 780370305, 'CAPOTE - FRITO(A)', unaccent(lower('CAPOTE - FRITO(A)')), 'Preparações', 269.66, 32.4, 0, 14.66, 0),
  ('ibge', 780370702, 'MUTUM - COZIDO(A)', unaccent(lower('MUTUM - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780390702, 'PATO EM PEDAÇOS - COZIDO(A)', unaccent(lower('PATO EM PEDAÇOS - COZIDO(A)')), 'Preparações', 201.0, 26.14, 0, 9.97, 0),
  ('ibge', 780390713, 'PATO EM PEDAÇOS - ENSOPADO', unaccent(lower('PATO EM PEDAÇOS - ENSOPADO')), 'Preparações', 201.0, 26.14, 0, 9.97, 0),
  ('ibge', 780390805, 'PEITO DE PATO - FRITO(A)', unaccent(lower('PEITO DE PATO - FRITO(A)')), 'Preparações', 223.66, 26.14, 0, 12.53, 0),
  ('ibge', 780391302, 'CARNE DE PATO - COZIDO(A)', unaccent(lower('CARNE DE PATO - COZIDO(A)')), 'Preparações', 201.0, 26.14, 0, 9.97, 0),
  ('ibge', 780391304, 'CARNE DE PATO - ASSADO(A)', unaccent(lower('CARNE DE PATO - ASSADO(A)')), 'Preparações', 201.0, 26.14, 0, 9.97, 0),
  ('ibge', 780391305, 'CARNE DE PATO - FRITO(A)', unaccent(lower('CARNE DE PATO - FRITO(A)')), 'Preparações', 223.66, 26.14, 0, 12.53, 0),
  ('ibge', 780540101, 'PEITO DE PERU LIGHT - CRU(A)', unaccent(lower('PEITO DE PERU LIGHT - CRU(A)')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780540102, 'PEITO DE PERU LIGHT - COZIDO(A)', unaccent(lower('PEITO DE PERU LIGHT - COZIDO(A)')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780540199, 'PEITO DE PERU LIGHT', unaccent(lower('PEITO DE PERU LIGHT')), 'Preparações', 140.0, 30.19, 0, 1.18, 0),
  ('ibge', 780550102, 'FRANGO INTEIRO ORGANICO - COZIDO(A)', unaccent(lower('FRANGO INTEIRO ORGANICO - COZIDO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780550104, 'FRANGO INTEIRO ORGANICO - ASSADO(A)', unaccent(lower('FRANGO INTEIRO ORGANICO - ASSADO(A)')), 'Preparações', 239.0, 27.3, 0, 13.6, 0),
  ('ibge', 780570202, 'FILE DE FRANGO ORGANICO - COZIDO(A)', unaccent(lower('FILE DE FRANGO ORGANICO - COZIDO(A)')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780570203, 'FILE DE FRANGO ORGANICO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('FILE DE FRANGO ORGANICO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 173.0, 30.91, 0, 4.51, 0),
  ('ibge', 780570205, 'FILE DE FRANGO ORGANICO - FRITO(A)', unaccent(lower('FILE DE FRANGO ORGANICO - FRITO(A)')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 780570206, 'FILE DE FRANGO ORGANICO - EMPANADO(A)/A MILANESA', unaccent(lower('FILE DE FRANGO ORGANICO - EMPANADO(A)/A MILANESA')), 'Preparações', 211.84, 31.37, 3.39, 7.12, 0.14),
  ('ibge', 790010199, 'LEITE DE VACA INTEGRAL', unaccent(lower('LEITE DE VACA INTEGRAL')), 'Preparações', 60.02, 3.22, 4.52, 3.25, 0),
  ('ibge', 790020199, 'LEITE DE VACA FRESCO', unaccent(lower('LEITE DE VACA FRESCO')), 'Preparações', 60.02, 3.22, 4.52, 3.25, 0),
  ('ibge', 790030199, 'LEITE DE CABRA', unaccent(lower('LEITE DE CABRA')), 'Preparações', 69.03, 3.56, 4.45, 4.14, 0),
  ('ibge', 790060199, 'LEITE EM PO INTEGRAL', unaccent(lower('LEITE EM PO INTEGRAL')), 'Preparações', 480.0, 25.76, 36.16, 26.0, 0),
  ('ibge', 790071099, 'LEITE EM PO DESNATADO', unaccent(lower('LEITE EM PO DESNATADO')), 'Preparações', 358.0, 35.1, 52.19, 0.72, 0),
  ('ibge', 790080199, 'LEITE EM PO', unaccent(lower('LEITE EM PO')), 'Preparações', 480.0, 25.76, 36.16, 26.0, 0),
  ('ibge', 790090199, 'LEITE CONDENSADO', unaccent(lower('LEITE CONDENSADO')), 'Preparações', 319.69, 7.88, 54.18, 8.66, 0),
  ('ibge', 790090399, 'LEITE BEIJINHO', unaccent(lower('LEITE BEIJINHO')), 'Preparações', 319.69, 7.88, 54.18, 8.66, 0),
  ('ibge', 790100199, 'CREME DE LEITE', unaccent(lower('CREME DE LEITE')), 'Preparações', 292.0, 2.17, 2.96, 30.91, 0),
  ('ibge', 790110199, 'CHANTILLY', unaccent(lower('CHANTILLY')), 'Preparações', 276.39, 2.93, 12.36, 24.57, 0),
  ('ibge', 790120199, 'IOGURTE DE QUALQUER SABOR', unaccent(lower('IOGURTE DE QUALQUER SABOR')), 'Preparações', 98.69, 3.46, 14.62, 3.47, 2.13),
  ('ibge', 790120399, 'IOGURTE DESNATADO', unaccent(lower('IOGURTE DESNATADO')), 'Preparações', 56.0, 5.73, 7.68, 0.18, 0),
  ('ibge', 790120499, 'IOGURTE NATURAL', unaccent(lower('IOGURTE NATURAL')), 'Preparações', 61.0, 3.47, 4.66, 3.25, 0),
  ('ibge', 790130199, 'YAKULT DE QUALQUER SABOR', unaccent(lower('YAKULT DE QUALQUER SABOR')), 'Preparações', 69.3, 3.03, 14.46, 0.07, 0),
  ('ibge', 790130399, 'BEBIDA LACTEA', unaccent(lower('BEBIDA LACTEA')), 'Preparações', 91.13, 2.78, 18.03, 1.15, 0.14),
  ('ibge', 790130499, 'LEITE FERMENTADO', unaccent(lower('LEITE FERMENTADO')), 'Preparações', 50.23, 3.31, 4.7, 1.98, 0),
  ('ibge', 790140199, 'COALHADA', unaccent(lower('COALHADA')), 'Preparações', 61.0, 3.47, 4.66, 3.25, 0),
  ('ibge', 790150199, 'MANTEIGA COM OU SEM SAL', unaccent(lower('MANTEIGA COM OU SEM SAL')), 'Preparações', 717.0, 0.85, 0.06, 81.11, 0),
  ('ibge', 790150599, 'MANTEIGA DE GARRAFA', unaccent(lower('MANTEIGA DE GARRAFA')), 'Preparações', 717.0, 0.85, 0.06, 81.11, 0),
  ('ibge', 790160299, 'MARGARINA COM OU SEM SAL', unaccent(lower('MARGARINA COM OU SEM SAL')), 'Preparações', 719.0, 0.9, 0.9, 80.5, 0),
  ('ibge', 790170199, 'QUEIJO PRATO', unaccent(lower('QUEIJO PRATO')), 'Preparações', 302.0, 25.96, 3.83, 20.03, 0),
  ('ibge', 790170399, 'QUEIJO COLONIAL', unaccent(lower('QUEIJO COLONIAL')), 'Preparações', 302.0, 25.96, 3.83, 20.03, 0),
  ('ibge', 790170599, 'QUEIJO DE COLONIA', unaccent(lower('QUEIJO DE COLONIA')), 'Preparações', 302.0, 25.96, 3.83, 20.03, 0),
  ('ibge', 790180199, 'QUEIJO MUZARELLA', unaccent(lower('QUEIJO MUZARELLA')), 'Preparações', 318.0, 21.6, 2.47, 24.64, 0),
  ('ibge', 790180399, 'MUSSARELA', unaccent(lower('MUSSARELA')), 'Preparações', 318.0, 21.6, 2.47, 24.64, 0),
  ('ibge', 790180799, 'MUSSARELA DE BUFALA', unaccent(lower('MUSSARELA DE BUFALA')), 'Preparações', 318.0, 21.6, 2.47, 24.64, 0),
  ('ibge', 790180999, 'QUEIJO DE BUFALO', unaccent(lower('QUEIJO DE BUFALO')), 'Preparações', 318.0, 21.6, 2.47, 24.64, 0),
  ('ibge', 790190199, 'QUEIJO DE REINO', unaccent(lower('QUEIJO DE REINO')), 'Preparações', 356.0, 24.94, 2.22, 27.44, 0),
  ('ibge', 790200199, 'QUEIJO DE MINAS', unaccent(lower('QUEIJO DE MINAS')), 'Preparações', 240.0, 17.6, 10.6, 14.1, 0),
  ('ibge', 790200399, 'QUEIJO DE MANTEIGA', unaccent(lower('QUEIJO DE MANTEIGA')), 'Preparações', 318.0, 21.6, 2.47, 24.64, 0),
  ('ibge', 790200499, 'QUECHIMIA', unaccent(lower('QUECHIMIA')), 'Preparações', 240.0, 17.6, 10.6, 14.1, 0),
  ('ibge', 790200599, 'QUEIJO DE COALHO', unaccent(lower('QUEIJO DE COALHO')), 'Preparações', 373.0, 24.48, 0.68, 30.28, 0),
  ('ibge', 790200899, 'QUEIJO CANASTRA', unaccent(lower('QUEIJO CANASTRA')), 'Preparações', 240.0, 17.6, 10.6, 14.1, 0),
  ('ibge', 790220199, 'QUEIJO RICOTA', unaccent(lower('QUEIJO RICOTA')), 'Preparações', 174.0, 11.26, 3.04, 12.98, 0),
  ('ibge', 790230199, 'LEITE DE SOJA COM SABOR', unaccent(lower('LEITE DE SOJA COM SABOR')), 'Preparações', 64.05, 3.68, 9.06, 1.65, 1.1),
  ('ibge', 790230399, 'ADES ORIGINAL', unaccent(lower('ADES ORIGINAL')), 'Preparações', 54.0, 3.27, 6.28, 1.75, 0.6),
  ('ibge', 790240399, 'QUEIJO RALADO', unaccent(lower('QUEIJO RALADO')), 'Preparações', 431.0, 38.46, 4.06, 28.61, 0),
  ('ibge', 790250199, 'QUEIJO PROVOLONE', unaccent(lower('QUEIJO PROVOLONE')), 'Preparações', 351.0, 25.58, 2.14, 26.62, 0),
  ('ibge', 790280199, 'QUEIJO POLENGUINHO', unaccent(lower('QUEIJO POLENGUINHO')), 'Preparações', 349.0, 7.55, 2.66, 34.87, 0),
  ('ibge', 790290199, 'REQUEIJAO', unaccent(lower('REQUEIJAO')), 'Preparações', 231.0, 10.6, 7.0, 17.6, 0),
  ('ibge', 790290299, 'QUEIJO CREMOSO', unaccent(lower('QUEIJO CREMOSO')), 'Preparações', 231.0, 10.6, 7.0, 17.6, 0),
  ('ibge', 790300199, 'QUEIJO NAO ESPECIFICADO', unaccent(lower('QUEIJO NAO ESPECIFICADO')), 'Preparações', 375.0, 22.15, 1.6, 31.25, 0),
  ('ibge', 790310199, 'LEITE COM SABOR', unaccent(lower('LEITE COM SABOR')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 790310299, 'LEITE ACHOCOLATADO', unaccent(lower('LEITE ACHOCOLATADO')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 790310999, 'LEITE AROMATIZADO', unaccent(lower('LEITE AROMATIZADO')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 790311099, 'BEBIDA ACHOCOLATADA', unaccent(lower('BEBIDA ACHOCOLATADA')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 790320199, 'NATA', unaccent(lower('NATA')), 'Preparações', 195.0, 2.7, 3.66, 19.31, 0),
  ('ibge', 790330199, 'QUEIJO GORGONZOLA', unaccent(lower('QUEIJO GORGONZOLA')), 'Preparações', 353.0, 21.4, 2.34, 28.74, 0),
  ('ibge', 790340299, 'TOFU', unaccent(lower('TOFU')), 'Preparações', 61.0, 6.55, 1.8, 3.69, 0.2),
  ('ibge', 790350199, 'LEITE DE SOJA EM PO', unaccent(lower('LEITE DE SOJA EM PO')), 'Preparações', 408.33, 32.85, 42.13, 13.22, 9.18),
  ('ibge', 790360199, 'LEITE DE VACA DESNATADO', unaccent(lower('LEITE DE VACA DESNATADO')), 'Preparações', 34.15, 3.38, 4.98, 0.08, 0),
  ('ibge', 790370299, 'LEITE DE VACA SEMIDESNATADO', unaccent(lower('LEITE DE VACA SEMIDESNATADO')), 'Preparações', 42.0, 3.37, 4.99, 0.97, 0),
  ('ibge', 790380199, 'LEITE NAO ESPECIFICADO PASTEURIZADO', unaccent(lower('LEITE NAO ESPECIFICADO PASTEURIZADO')), 'Preparações', 60.02, 3.22, 4.52, 3.25, 0),
  ('ibge', 790390199, 'IOGURTE DE QUALQUER SABOR LIGHT', unaccent(lower('IOGURTE DE QUALQUER SABOR LIGHT')), 'Preparações', 102.0, 4.37, 19.05, 1.08, 0.29),
  ('ibge', 790400199, 'IOGURTE DE QUALQUER SABOR DIET', unaccent(lower('IOGURTE DE QUALQUER SABOR DIET')), 'Preparações', 51.35, 3.11, 3.88, 2.65, 0.08),
  ('ibge', 790420199, 'MARGARINA LIGHT', unaccent(lower('MARGARINA LIGHT')), 'Preparações', 253.69, 0.08, 0.27, 28.52, 0),
  ('ibge', 790430199, 'LEITE DE VACA INTEGRAL ORGANICO', unaccent(lower('LEITE DE VACA INTEGRAL ORGANICO')), 'Preparações', 60.02, 3.22, 4.52, 3.25, 0),
  ('ibge', 790440199, 'LEITE DE VACA FRESCO ORGANICO', unaccent(lower('LEITE DE VACA FRESCO ORGANICO')), 'Preparações', 60.02, 3.22, 4.52, 3.25, 0),
  ('ibge', 790460199, 'LEITE SEMIDESNATADO DE VACA ORGANICO', unaccent(lower('LEITE SEMIDESNATADO DE VACA ORGANICO')), 'Preparações', 42.0, 3.37, 4.99, 0.97, 0),
  ('ibge', 790470199, 'CREME DE LEITE ORGANICO', unaccent(lower('CREME DE LEITE ORGANICO')), 'Preparações', 292.0, 2.17, 2.96, 30.91, 0),
  ('ibge', 790480199, 'IOGURTE DE QUALQUER SABOR ORGANICO', unaccent(lower('IOGURTE DE QUALQUER SABOR ORGANICO')), 'Preparações', 98.69, 3.46, 14.62, 3.47, 2.13),
  ('ibge', 790480399, 'IOGURTE DE QUALQUER SABOR DESNATADO ORGANICO', unaccent(lower('IOGURTE DE QUALQUER SABOR DESNATADO ORGANICO')), 'Preparações', 95.0, 4.4, 19.0, 0.2, 0),
  ('ibge', 790480499, 'IOGURTE NATURAL DE QUALQUER SABOR ORGANICO', unaccent(lower('IOGURTE NATURAL DE QUALQUER SABOR ORGANICO')), 'Preparações', 61.0, 3.47, 4.66, 3.25, 0),
  ('ibge', 790510399, 'MUSSARELA LIGHT', unaccent(lower('MUSSARELA LIGHT')), 'Preparações', 302.0, 25.96, 3.83, 20.03, 0),
  ('ibge', 790510499, 'QUEIJO MUSSARELA LIGHT', unaccent(lower('QUEIJO MUSSARELA LIGHT')), 'Preparações', 302.0, 25.96, 3.83, 20.03, 0),
  ('ibge', 790520199, 'LEITE DE SOJA COM SABOR LIGHT', unaccent(lower('LEITE DE SOJA COM SABOR LIGHT')), 'Preparações', 53.2, 2.56, 8.62, 1.03, 0.69),
  ('ibge', 790520399, 'ADES LIGHT', unaccent(lower('ADES LIGHT')), 'Preparações', 39.37, 1.99, 6.18, 0.82, 0.55),
  ('ibge', 790560199, 'CREME DE LEITE LIGHT', unaccent(lower('CREME DE LEITE LIGHT')), 'Preparações', 59.0, 2.6, 9.0, 1.4, 0),
  ('ibge', 790590199, 'QUEIJO PRATO LIGHT', unaccent(lower('QUEIJO PRATO LIGHT')), 'Preparações', 297.3, 24.49, 1.22, 21.36, 0),
  ('ibge', 790600199, 'QUEIJO DE MINAS LIGHT', unaccent(lower('QUEIJO DE MINAS LIGHT')), 'Preparações', 90.0, 13.74, 3.63, 1.93, 0),
  ('ibge', 790600599, 'QUEIJO DE COALHO LIGHT', unaccent(lower('QUEIJO DE COALHO LIGHT')), 'Preparações', 297.3, 24.49, 1.22, 21.36, 0),
  ('ibge', 790620199, 'QUEIJO RICOTA LIGHT', unaccent(lower('QUEIJO RICOTA LIGHT')), 'Preparações', 92.69, 14.56, 7.08, 0.28, 0),
  ('ibge', 790630399, 'QUEIJO RALADO LIGHT', unaccent(lower('QUEIJO RALADO LIGHT')), 'Preparações', 265.0, 20.0, 1.37, 20.0, 0),
  ('ibge', 790640199, 'QUEIJO POLENGUINHO LIGHT', unaccent(lower('QUEIJO POLENGUINHO LIGHT')), 'Preparações', 231.0, 10.6, 7.0, 17.6, 0),
  ('ibge', 790650199, 'REQUEIJAO LIGHT', unaccent(lower('REQUEIJAO LIGHT')), 'Preparações', 231.0, 10.6, 7.0, 17.6, 0),
  ('ibge', 790660199, 'QUEIJO NAO ESPECIFICADO LIGHT', unaccent(lower('QUEIJO NAO ESPECIFICADO LIGHT')), 'Preparações', 90.0, 13.74, 3.63, 1.93, 0),
  ('ibge', 790670299, 'LEITE ACHOCOLATADO LIGHT', unaccent(lower('LEITE ACHOCOLATADO LIGHT')), 'Preparações', 63.0, 3.24, 10.44, 1.0, 0.5),
  ('ibge', 790671099, 'BEBIDA ACHOCOLATADA LIGHT', unaccent(lower('BEBIDA ACHOCOLATADA LIGHT')), 'Preparações', 63.0, 3.24, 10.44, 1.0, 0.5),
  ('ibge', 790680199, 'LEITE COM SABOR DIET', unaccent(lower('LEITE COM SABOR DIET')), 'Preparações', 73.29, 3.48, 7.09, 3.51, 0.39),
  ('ibge', 790680299, 'LEITE ACHOCOLATADO DIET', unaccent(lower('LEITE ACHOCOLATADO DIET')), 'Preparações', 73.29, 3.48, 7.09, 3.51, 0.39),
  ('ibge', 790681099, 'BEBIDA ACHOCOLATADA DIET', unaccent(lower('BEBIDA ACHOCOLATADA DIET')), 'Preparações', 73.29, 3.48, 7.09, 3.51, 0.39),
  ('ibge', 790690199, 'LEITE DE SOJA EM PO LIGHT', unaccent(lower('LEITE DE SOJA EM PO LIGHT')), 'Preparações', 379.58, 32.94, 59.92, 2.8, 2.4),
  ('ibge', 790700199, 'LEITE EM PO COM SABOR', unaccent(lower('LEITE EM PO COM SABOR')), 'Preparações', 405.0, 3.3, 90.9, 3.1, 4.8),
  ('ibge', 790710199, 'MANTEIGA COM OU SEM SAL LIGHT', unaccent(lower('MANTEIGA COM OU SEM SAL LIGHT')), 'Preparações', 347.31, 0.41, 0.03, 39.29, 0),
  ('ibge', 790730199, 'QUEIJO DE MINAS FRESCAL ORGANICO', unaccent(lower('QUEIJO DE MINAS FRESCAL ORGANICO')), 'Preparações', 240.0, 17.6, 10.6, 14.1, 0),
  ('ibge', 790730599, 'QUEIJO DE COALHO FRESCAL ORGANICO', unaccent(lower('QUEIJO DE COALHO FRESCAL ORGANICO')), 'Preparações', 373.0, 24.48, 0.68, 30.28, 0),
  ('ibge', 800010399, 'PAO DE HAMBURGUER', unaccent(lower('PAO DE HAMBURGUER')), 'Preparações', 279.0, 9.5, 49.45, 4.33, 2.1),
  ('ibge', 800010599, 'PAO DE SAL', unaccent(lower('PAO DE SAL')), 'Preparações', 300.0, 8.0, 58.6, 3.1, 2.3),
  ('ibge', 800020199, 'PAO DOCE', unaccent(lower('PAO DOCE')), 'Preparações', 355.23, 5.14, 55.83, 13.08, 2.02),
  ('ibge', 800020399, 'CHINEQUE', unaccent(lower('CHINEQUE')), 'Preparações', 355.23, 5.14, 55.83, 13.08, 2.02),
  ('ibge', 800021899, 'CHINEQUE COM FAROFA', unaccent(lower('CHINEQUE COM FAROFA')), 'Preparações', 355.23, 5.14, 55.83, 13.08, 2.02),
  ('ibge', 800022999, 'PAO DE MEL', unaccent(lower('PAO DE MEL')), 'Preparações', 508.36, 4.46, 85.04, 18.34, 1.85),
  ('ibge', 800023499, 'PANETONE', unaccent(lower('PANETONE')), 'Preparações', 355.95, 7.45, 58.03, 10.43, 2.14),
  ('ibge', 800023799, 'BISNAGUINHA', unaccent(lower('BISNAGUINHA')), 'Preparações', 310.0, 10.86, 52.04, 6.47, 2.0),
  ('ibge', 800024099, 'CROISSANT', unaccent(lower('CROISSANT')), 'Preparações', 455.16, 8.04, 46.84, 26.26, 1.75),
  ('ibge', 800050199, 'PAO DE FORMA INDUSTRIALIZADO DE QUALQUER MARCA', unaccent(lower('PAO DE FORMA INDUSTRIALIZADO DE QUALQUER MARCA')), 'Preparações', 266.0, 7.64, 50.61, 3.29, 2.4),
  ('ibge', 800080199, 'PAO DE QUEIJO', unaccent(lower('PAO DE QUEIJO')), 'Preparações', 363.0, 5.1, 34.2, 24.6, 0.6),
  ('ibge', 800110199, 'PAO DE MILHO', unaccent(lower('PAO DE MILHO')), 'Preparações', 316.62, 7.2, 47.96, 10.43, 4.38),
  ('ibge', 800140199, 'PAO INTEGRAL', unaccent(lower('PAO INTEGRAL')), 'Preparações', 247.0, 12.95, 41.29, 3.35, 6.71),
  ('ibge', 800150199, 'PAO NAO ESPECIFICADO', unaccent(lower('PAO NAO ESPECIFICADO')), 'Preparações', 300.0, 8.0, 58.6, 3.1, 2.3),
  ('ibge', 800190199, 'TORRADA DE QUALQUER PAO', unaccent(lower('TORRADA DE QUALQUER PAO')), 'Preparações', 377.0, 10.5, 74.6, 3.3, 3.4),
  ('ibge', 800200199, 'ROSCA DOCE', unaccent(lower('ROSCA DOCE')), 'Preparações', 422.97, 4.54, 55.53, 20.61, 1.07),
  ('ibge', 800200299, 'ROSQUINHA DOCE', unaccent(lower('ROSQUINHA DOCE')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800210199, 'ROSCA SALGADA', unaccent(lower('ROSCA SALGADA')), 'Preparações', 245.75, 12.83, 25.8, 9.85, 1.18),
  ('ibge', 800210699, 'ROSQUINHA SALGADA', unaccent(lower('ROSQUINHA SALGADA')), 'Preparações', 432.0, 10.1, 68.7, 14.4, 2.5),
  ('ibge', 800220199, 'BISCOITO SALGADO', unaccent(lower('BISCOITO SALGADO')), 'Preparações', 432.0, 10.1, 68.7, 14.4, 2.5),
  ('ibge', 800220599, 'PRESUNTINHO BISCOITO', unaccent(lower('PRESUNTINHO BISCOITO')), 'Preparações', 508.99, 8.88, 60.74, 25.4, 2.54),
  ('ibge', 800221299, 'BISCOITO DE POLVILHO', unaccent(lower('BISCOITO DE POLVILHO')), 'Preparações', 436.72, 4.46, 38.37, 29.08, 0),
  ('ibge', 800222599, 'BOLACHA SALGADA', unaccent(lower('BOLACHA SALGADA')), 'Preparações', 432.0, 10.1, 68.7, 14.4, 2.5),
  ('ibge', 800222799, 'CHIPS (SALGADINHOS)', unaccent(lower('CHIPS (SALGADINHOS)')), 'Preparações', 558.86, 5.08, 55.41, 35.25, 2.76),
  ('ibge', 800223099, 'BACONZITOS', unaccent(lower('BACONZITOS')), 'Preparações', 508.99, 8.88, 60.74, 25.4, 2.54),
  ('ibge', 800223699, 'BISCOITO SALGADO INTEGRAL', unaccent(lower('BISCOITO SALGADO INTEGRAL')), 'Preparações', 412.43, 11.49, 60.85, 16.07, 10.23),
  ('ibge', 800230199, 'BISCOITO DOCE', unaccent(lower('BISCOITO DOCE')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800230299, 'CAVACO CHINES', unaccent(lower('CAVACO CHINES')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800230599, 'SEQUILHO', unaccent(lower('SEQUILHO')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800230699, 'TARECO', unaccent(lower('TARECO')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800230999, 'SOLDA', unaccent(lower('SOLDA')), 'Preparações', 432.0, 10.1, 68.7, 14.4, 2.5),
  ('ibge', 800231599, 'BREVIDADE', unaccent(lower('BREVIDADE')), 'Preparações', 371.22, 3.18, 57.71, 14.61, 1.06),
  ('ibge', 800233499, 'BOLACHA DOCE', unaccent(lower('BOLACHA DOCE')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800233599, 'MARIA MALUCA (BOLACHA DOCE)', unaccent(lower('MARIA MALUCA (BOLACHA DOCE)')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800240599, 'QUEBRA QUEBRA', unaccent(lower('QUEBRA QUEBRA')), 'Preparações', 443.0, 8.1, 75.2, 12.0, 2.1),
  ('ibge', 800250299, 'ROCAMBOLE', unaccent(lower('ROCAMBOLE')), 'Preparações', 339.25, 6.32, 18.55, 26.93, 0.54),
  ('ibge', 800250399, 'CUCA DE QUALQUER TIPO', unaccent(lower('CUCA DE QUALQUER TIPO')), 'Preparações', 355.23, 5.14, 55.83, 13.08, 2.02),
  ('ibge', 800260199, 'BOLO DE MILHO', unaccent(lower('BOLO DE MILHO')), 'Preparações', 311.0, 4.8, 45.1, 12.4, 0.7),
  ('ibge', 800260499, 'AMIDOMIL (BOLINHO)', unaccent(lower('AMIDOMIL (BOLINHO)')), 'Preparações', 311.0, 4.8, 45.1, 12.4, 0.7),
  ('ibge', 800260599, 'ANGUSOR DE MILHO', unaccent(lower('ANGUSOR DE MILHO')), 'Preparações', 311.0, 4.8, 45.1, 12.4, 0.7),
  ('ibge', 800260999, 'GRUSTOLI (BOLINHO DOCE)', unaccent(lower('GRUSTOLI (BOLINHO DOCE)')), 'Preparações', 421.37, 5.55, 55.7, 19.8, 1.21),
  ('ibge', 800270199, 'BOLO DE AIPIM', unaccent(lower('BOLO DE AIPIM')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800270299, 'BOLO DE TAPIOCA', unaccent(lower('BOLO DE TAPIOCA')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800270399, 'BOLO DE MACAXEIRA', unaccent(lower('BOLO DE MACAXEIRA')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800270499, 'BOLO DE GOMA', unaccent(lower('BOLO DE GOMA')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800280199, 'BOLO DE BATATA DOCE', unaccent(lower('BOLO DE BATATA DOCE')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800290199, 'BOLO DE ARROZ', unaccent(lower('BOLO DE ARROZ')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800310199, 'BOLO DE CARA', unaccent(lower('BOLO DE CARA')), 'Preparações', 324.0, 4.4, 47.9, 12.7, 0.7),
  ('ibge', 800350199, 'TORTAS DOCES DE QUALQUER SABOR', unaccent(lower('TORTAS DOCES DE QUALQUER SABOR')), 'Preparações', 119.67, 2.28, 15.56, 5.38, 0.48),
  ('ibge', 800360199, 'TORTAS SALGADAS DE QUALQUER SABOR', unaccent(lower('TORTAS SALGADAS DE QUALQUER SABOR')), 'Preparações', 249.55, 3.87, 38.4, 9.86, 1.49),
  ('ibge', 800370199, 'SONHO', unaccent(lower('SONHO')), 'Preparações', 378.79, 6.02, 48.08, 18.25, 1.31),
  ('ibge', 800370299, 'FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS)', unaccent(lower('FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS)')), 'Preparações', 421.37, 5.55, 55.7, 19.8, 1.21),
  ('ibge', 800380199, 'BOLO DE CHOCOLATE', unaccent(lower('BOLO DE CHOCOLATE')), 'Preparações', 312.8, 8.71, 58.3, 6.0, 1.76),
  ('ibge', 800390299, 'BRIOCHE', unaccent(lower('BRIOCHE')), 'Preparações', 366.84, 9.04, 49.58, 14.21, 1.8),
  ('ibge', 800400199, 'BOLO DE LARANJA', unaccent(lower('BOLO DE LARANJA')), 'Preparações', 360.83, 4.8, 58.31, 13.15, 2.36),
  ('ibge', 800410199, 'BOLO DE COCO', unaccent(lower('BOLO DE COCO')), 'Preparações', 317.24, 6.33, 54.19, 8.7, 1.2),
  ('ibge', 800420199, 'BOLO DE CENOURA', unaccent(lower('BOLO DE CENOURA')), 'Preparações', 344.86, 4.17, 44.27, 17.26, 1.61),
  ('ibge', 800460199, 'BOLO DE TRIGO', unaccent(lower('BOLO DE TRIGO')), 'Preparações', 286.6, 6.91, 55.27, 4.24, 0.65),
  ('ibge', 800470199, 'BROA', unaccent(lower('BROA')), 'Preparações', 392.0, 9.8, 47.1, 18.3, 1.7),
  ('ibge', 800480199, 'BISCOITO RECHEADO', unaccent(lower('BISCOITO RECHEADO')), 'Preparações', 472.0, 6.4, 70.5, 19.6, 3.0),
  ('ibge', 800480799, 'WAFFER (BISCOITO)', unaccent(lower('WAFFER (BISCOITO)')), 'Preparações', 430.32, 6.25, 74.79, 12.49, 2.25),
  ('ibge', 800480999, 'ALFAJORES (BISCOITO)', unaccent(lower('ALFAJORES (BISCOITO)')), 'Preparações', 505.21, 6.47, 70.85, 22.55, 2.43),
  ('ibge', 800481099, 'BOLACHA RECHEADA', unaccent(lower('BOLACHA RECHEADA')), 'Preparações', 472.0, 6.4, 70.5, 19.6, 3.0),
  ('ibge', 800481399, 'ROSCA RECHEADA', unaccent(lower('ROSCA RECHEADA')), 'Preparações', 620.2, 5.57, 98.06, 26.28, 3.22),
  ('ibge', 800481499, 'ROSQUINHA RECHEADA DE QUALQUER SABOR', unaccent(lower('ROSQUINHA RECHEADA DE QUALQUER SABOR')), 'Preparações', 472.0, 6.4, 70.5, 19.6, 3.0),
  ('ibge', 800520199, 'BISCOITO NÃO ESPECIFICADO', unaccent(lower('BISCOITO NÃO ESPECIFICADO')), 'Preparações', 432.0, 10.1, 68.7, 14.4, 2.5),
  ('ibge', 800610199, 'CREPE', unaccent(lower('CREPE')), 'Preparações', 203.18, 13.96, 8.27, 12.46, 0.66),
  ('ibge', 800650199, 'PAO DIET (DE FORMA INDUSTRIALIZADO)', unaccent(lower('PAO DIET (DE FORMA INDUSTRIALIZADO)')), 'Preparações', 198.0, 9.1, 43.6, 2.3, 12.0),
  ('ibge', 800660199, 'PAO LIGHT (DE FORMA INDUSTRIALIZADO)', unaccent(lower('PAO LIGHT (DE FORMA INDUSTRIALIZADO)')), 'Preparações', 198.0, 9.1, 43.6, 2.3, 12.0),
  ('ibge', 800670199, 'PAO DE QUEIJO LIGHT', unaccent(lower('PAO DE QUEIJO LIGHT')), 'Preparações', 363.0, 5.1, 34.2, 24.6, 0.6),
  ('ibge', 800680199, 'PAO INTEGRAL LIGHT', unaccent(lower('PAO INTEGRAL LIGHT')), 'Preparações', 198.0, 9.1, 43.6, 2.3, 12.0),
  ('ibge', 800700199, 'TORTAS DOCES DE QUALQUER SABOR LIGHT', unaccent(lower('TORTAS DOCES DE QUALQUER SABOR LIGHT')), 'Preparações', 121.84, 2.29, 16.06, 5.39, 0.5),
  ('ibge', 800710199, 'TORTAS DOCES DE QUALQUER SABOR DIET', unaccent(lower('TORTAS DOCES DE QUALQUER SABOR DIET')), 'Preparações', 99.17, 2.25, 10.66, 5.3, 0.37),
  ('ibge', 800730299, 'FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS) LIGHT', unaccent(lower('FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS) LIGHT')), 'Preparações', 426.53, 6.44, 48.69, 22.95, 1.4),
  ('ibge', 800740299, 'FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS) DIET', unaccent(lower('FILHOS (BOLINHO DE FARINHA DE TRIGO E OVOS) DIET')), 'Preparações', 426.53, 6.44, 48.69, 22.95, 1.4),
  ('ibge', 800750199, 'BOLO DE CHOCOLATE LIGHT', unaccent(lower('BOLO DE CHOCOLATE LIGHT')), 'Preparações', 299.49, 4.59, 52.45, 9.36, 2.0),
  ('ibge', 800760199, 'BOLO DE CHOCOLATE DIET', unaccent(lower('BOLO DE CHOCOLATE DIET')), 'Preparações', 299.49, 4.59, 52.45, 9.36, 2.0),
  ('ibge', 800770199, 'BOLO DE LARANJA LIGHT', unaccent(lower('BOLO DE LARANJA LIGHT')), 'Preparações', 328.38, 4.76, 58.31, 9.48, 2.36),
  ('ibge', 800800199, 'BOLO DE COCO DIET', unaccent(lower('BOLO DE COCO DIET')), 'Preparações', 299.49, 4.59, 52.45, 9.36, 2.0),
  ('ibge', 800820199, 'BOLO DE CENOURA DIET', unaccent(lower('BOLO DE CENOURA DIET')), 'Preparações', 272.74, 4.08, 44.26, 9.1, 1.61),
  ('ibge', 800830199, 'BISCOITO RECHEADO LIGHT', unaccent(lower('BISCOITO RECHEADO LIGHT')), 'Preparações', 432.96, 5.88, 77.8, 13.24, 4.24),
  ('ibge', 800830599, 'BISCOITO WAFFER LIGHT', unaccent(lower('BISCOITO WAFFER LIGHT')), 'Preparações', 398.63, 4.51, 80.66, 6.92, 1.31),
  ('ibge', 800830799, 'WAFFER (BISCOITO) LIGHT', unaccent(lower('WAFFER (BISCOITO) LIGHT')), 'Preparações', 398.63, 4.51, 80.66, 6.92, 1.31),
  ('ibge', 800830999, 'ALFAJORES (BISCOITO) LIGHT', unaccent(lower('ALFAJORES (BISCOITO) LIGHT')), 'Preparações', 432.96, 5.88, 77.8, 13.24, 4.24),
  ('ibge', 800831099, 'BOLACHA RECHEADA LIGHT', unaccent(lower('BOLACHA RECHEADA LIGHT')), 'Preparações', 432.96, 5.88, 77.8, 13.24, 4.24),
  ('ibge', 800840199, 'BISCOITO RECHEADO DIET', unaccent(lower('BISCOITO RECHEADO DIET')), 'Preparações', 405.27, 8.17, 66.82, 20.83, 3.67),
  ('ibge', 800840899, 'ROSQUINHA RECHEADA DE QUALQUER SABOR DIET', unaccent(lower('ROSQUINHA RECHEADA DE QUALQUER SABOR DIET')), 'Preparações', 405.27, 8.17, 66.82, 20.83, 3.67),
  ('ibge', 800841099, 'BOLACHA RECHEADA DIET', unaccent(lower('BOLACHA RECHEADA DIET')), 'Preparações', 405.27, 8.17, 66.82, 20.83, 3.67),
  ('ibge', 801000199, 'PAO DOCE DIET', unaccent(lower('PAO DOCE DIET')), 'Preparações', 312.25, 4.83, 57.97, 6.92, 1.64),
  ('ibge', 801002999, 'PAO DE MEL DIET', unaccent(lower('PAO DE MEL DIET')), 'Preparações', 446.23, 4.38, 85.03, 11.31, 1.85),
  ('ibge', 801003499, 'PANETONE DIET', unaccent(lower('PANETONE DIET')), 'Preparações', 355.95, 7.45, 58.03, 10.43, 2.14),
  ('ibge', 801010199, 'BISCOITO SALGADO LIGHT', unaccent(lower('BISCOITO SALGADO LIGHT')), 'Preparações', 452.56, 9.67, 72.45, 13.79, 3.45),
  ('ibge', 801012599, 'BOLACHA SALGADA LIGHT', unaccent(lower('BOLACHA SALGADA LIGHT')), 'Preparações', 452.56, 9.67, 72.45, 13.79, 3.45),
  ('ibge', 801012799, 'CHIPS (SALGADINHOS) LIGHT', unaccent(lower('CHIPS (SALGADINHOS) LIGHT')), 'Preparações', 407.05, 6.53, 81.13, 7.05, 5.64),
  ('ibge', 801040199, 'BISCOITO DOCE LIGHT', unaccent(lower('BISCOITO DOCE LIGHT')), 'Preparações', 395.25, 6.45, 83.88, 4.84, 3.7),
  ('ibge', 801043499, 'BOLACHA DOCE LIGHT', unaccent(lower('BOLACHA DOCE LIGHT')), 'Preparações', 395.25, 6.45, 83.88, 4.84, 3.7),
  ('ibge', 801050199, 'BISCOITO DOCE DIET', unaccent(lower('BISCOITO DOCE DIET')), 'Preparações', 453.92, 6.22, 65.74, 21.89, 2.95),
  ('ibge', 801053499, 'BOLACHA DOCE DIET', unaccent(lower('BOLACHA DOCE DIET')), 'Preparações', 453.92, 6.22, 65.74, 21.89, 2.95),
  ('ibge', 801060199, 'BOLO DE BANANA', unaccent(lower('BOLO DE BANANA')), 'Preparações', 300.05, 3.93, 52.14, 9.07, 1.66),
  ('ibge', 810010102, 'CARNE SECA - COZIDO(A)', unaccent(lower('CARNE SECA - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010103, 'CARNE SECA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE SECA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010104, 'CARNE SECA - ASSADO(A)', unaccent(lower('CARNE SECA - ASSADO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010105, 'CARNE SECA - FRITO(A)', unaccent(lower('CARNE SECA - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010107, 'CARNE SECA - REFOGADO(A)', unaccent(lower('CARNE SECA - REFOGADO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010108, 'CARNE SECA - MOLHO VERMELHO', unaccent(lower('CARNE SECA - MOLHO VERMELHO')), 'Preparações', 255.2, 21.78, 1.08, 17.56, 0.3),
  ('ibge', 810010113, 'CARNE SECA - ENSOPADO', unaccent(lower('CARNE SECA - ENSOPADO')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010201, 'CARNE DE CHARQUE - CRU(A)', unaccent(lower('CARNE DE CHARQUE - CRU(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010202, 'CARNE DE CHARQUE - COZIDO(A)', unaccent(lower('CARNE DE CHARQUE - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010203, 'CARNE DE CHARQUE - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE CHARQUE - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010204, 'CARNE DE CHARQUE - ASSADO(A)', unaccent(lower('CARNE DE CHARQUE - ASSADO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010205, 'CARNE DE CHARQUE - FRITO(A)', unaccent(lower('CARNE DE CHARQUE - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010207, 'CARNE DE CHARQUE - REFOGADO(A)', unaccent(lower('CARNE DE CHARQUE - REFOGADO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010208, 'CARNE DE CHARQUE - MOLHO VERMELHO', unaccent(lower('CARNE DE CHARQUE - MOLHO VERMELHO')), 'Preparações', 255.2, 21.78, 1.08, 17.56, 0.3),
  ('ibge', 810010213, 'CARNE DE CHARQUE - ENSOPADO', unaccent(lower('CARNE DE CHARQUE - ENSOPADO')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010302, 'JABA - COZIDO(A)', unaccent(lower('JABA - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810010305, 'JABA - FRITO(A)', unaccent(lower('JABA - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010307, 'JABA - REFOGADO(A)', unaccent(lower('JABA - REFOGADO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810010399, 'JABA', unaccent(lower('JABA')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020101, 'CARNE DE SOL - CRU(A)', unaccent(lower('CARNE DE SOL - CRU(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020102, 'CARNE DE SOL - COZIDO(A)', unaccent(lower('CARNE DE SOL - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020103, 'CARNE DE SOL - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE DE SOL - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020104, 'CARNE DE SOL - ASSADO(A)', unaccent(lower('CARNE DE SOL - ASSADO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020105, 'CARNE DE SOL - FRITO(A)', unaccent(lower('CARNE DE SOL - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810020113, 'CARNE DE SOL - ENSOPADO', unaccent(lower('CARNE DE SOL - ENSOPADO')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810020202, 'CARNE DO SERTAO - COZIDO(A)', unaccent(lower('CARNE DO SERTAO - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020204, 'CARNE DO SERTAO - ASSADO(A)', unaccent(lower('CARNE DO SERTAO - ASSADO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810020205, 'CARNE DO SERTAO - FRITO(A)', unaccent(lower('CARNE DO SERTAO - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810050201, 'HAMBURGUER DE CARNE BOVINA - CRU(A)', unaccent(lower('HAMBURGUER DE CARNE BOVINA - CRU(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810050202, 'HAMBURGUER DE CARNE BOVINA - COZIDO(A)', unaccent(lower('HAMBURGUER DE CARNE BOVINA - COZIDO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810050203, 'HAMBURGUER DE CARNE BOVINA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('HAMBURGUER DE CARNE BOVINA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810050204, 'HAMBURGUER DE CARNE BOVINA - ASSADO(A)', unaccent(lower('HAMBURGUER DE CARNE BOVINA - ASSADO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810050205, 'HAMBURGUER DE CARNE BOVINA - FRITO(A)', unaccent(lower('HAMBURGUER DE CARNE BOVINA - FRITO(A)')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 810050208, 'HAMBURGUER DE CARNE BOVINA - MOLHO VERMELHO', unaccent(lower('HAMBURGUER DE CARNE BOVINA - MOLHO VERMELHO')), 'Preparações', 176.0, 21.56, 1.08, 8.92, 0.3),
  ('ibge', 810050299, 'HAMBURGUER DE CARNE BOVINA', unaccent(lower('HAMBURGUER DE CARNE BOVINA')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810080299, 'COPA DE PORCO DEFUMADA', unaccent(lower('COPA DE PORCO DEFUMADA')), 'Preparações', 248.66, 20.53, 0.42, 17.76, 0),
  ('ibge', 810100599, 'BACON', unaccent(lower('BACON')), 'Preparações', 541.0, 37.04, 1.43, 41.78, 0),
  ('ibge', 810110102, 'HAMBURGUER DE FRANGO - COZIDO(A)', unaccent(lower('HAMBURGUER DE FRANGO - COZIDO(A)')), 'Preparações', 206.14, 16.19, 12.64, 9.71, 0.61),
  ('ibge', 810110103, 'HAMBURGUER DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('HAMBURGUER DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 206.14, 16.19, 12.64, 9.71, 0.61),
  ('ibge', 810110104, 'HAMBURGUER DE FRANGO - ASSADO(A)', unaccent(lower('HAMBURGUER DE FRANGO - ASSADO(A)')), 'Preparações', 206.14, 16.19, 12.64, 9.71, 0.61),
  ('ibge', 810110105, 'HAMBURGUER DE FRANGO - FRITO(A)', unaccent(lower('HAMBURGUER DE FRANGO - FRITO(A)')), 'Preparações', 266.67, 16.19, 12.64, 16.55, 0.61),
  ('ibge', 810110106, 'HAMBURGUER DE FRANGO - EMPANADO(A)/A MILANESA', unaccent(lower('HAMBURGUER DE FRANGO - EMPANADO(A)/A MILANESA')), 'Preparações', 266.67, 16.19, 12.64, 16.55, 0.61),
  ('ibge', 810110199, 'HAMBURGUER DE FRANGO', unaccent(lower('HAMBURGUER DE FRANGO')), 'Preparações', 206.14, 16.19, 12.64, 9.71, 0.61),
  ('ibge', 810210101, 'SALSICHA NO VAREJO - CRU(A)', unaccent(lower('SALSICHA NO VAREJO - CRU(A)')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210102, 'SALSICHA NO VAREJO - COZIDO(A)', unaccent(lower('SALSICHA NO VAREJO - COZIDO(A)')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210103, 'SALSICHA NO VAREJO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('SALSICHA NO VAREJO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210104, 'SALSICHA NO VAREJO - ASSADO(A)', unaccent(lower('SALSICHA NO VAREJO - ASSADO(A)')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210105, 'SALSICHA NO VAREJO - FRITO(A)', unaccent(lower('SALSICHA NO VAREJO - FRITO(A)')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210107, 'SALSICHA NO VAREJO - REFOGADO(A)', unaccent(lower('SALSICHA NO VAREJO - REFOGADO(A)')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210108, 'SALSICHA NO VAREJO - MOLHO VERMELHO', unaccent(lower('SALSICHA NO VAREJO - MOLHO VERMELHO')), 'Preparações', 289.43, 8.55, 4.74, 26.09, 0.04),
  ('ibge', 810210109, 'SALSICHA NO VAREJO - MOLHO BRANCO', unaccent(lower('SALSICHA NO VAREJO - MOLHO BRANCO')), 'Preparações', 321.6, 11.3, 3.24, 29.04, 0.3),
  ('ibge', 810210110, 'SALSICHA NO VAREJO - AO ALHO E OLEO', unaccent(lower('SALSICHA NO VAREJO - AO ALHO E OLEO')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210111, 'SALSICHA NO VAREJO - COM MANTEIGA/OLEO', unaccent(lower('SALSICHA NO VAREJO - COM MANTEIGA/OLEO')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210113, 'SALSICHA NO VAREJO - ENSOPADO', unaccent(lower('SALSICHA NO VAREJO - ENSOPADO')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810210199, 'SALSICHA NO VAREJO', unaccent(lower('SALSICHA NO VAREJO')), 'Preparações', 321.05, 9.72, 3.6, 29.51, 0),
  ('ibge', 810220401, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - CRU(A)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - CRU(A)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220402, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - COZIDO(A)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - COZIDO(A)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220403, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220404, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - ASSADO(A)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - ASSADO(A)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220405, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - FRITO(A)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - FRITO(A)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220406, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - EMPANADO(A)/A MILANESA', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - EMPANADO(A)/A MILANESA')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220407, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - REFOGADO(A)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - REFOGADO(A)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220408, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - MOLHO VERMELHO', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - MOLHO VERMELHO')), 'Preparações', 321.6, 11.3, 3.24, 29.04, 0.3),
  ('ibge', 810220411, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - COM MANTEIGA/OLEO', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - COM MANTEIGA/OLEO')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220413, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - ENSOPADO', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC) - ENSOPADO')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220499, 'LINGUICA (SUÍNA, BOVINA, MISTA, ETC)', unaccent(lower('LINGUICA (SUÍNA, BOVINA, MISTA, ETC)')), 'Preparações', 396.0, 13.8, 2.7, 36.25, 0),
  ('ibge', 810220701, 'LINGUICA DE FRANGO - CRU(A)', unaccent(lower('LINGUICA DE FRANGO - CRU(A)')), 'Preparações', 244.0, 18.2, 0, 18.4, 0),
  ('ibge', 810220702, 'LINGUICA DE FRANGO - COZIDO(A)', unaccent(lower('LINGUICA DE FRANGO - COZIDO(A)')), 'Preparações', 244.0, 18.2, 0, 18.4, 0),
  ('ibge', 810220703, 'LINGUICA DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('LINGUICA DE FRANGO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 244.0, 18.2, 0, 18.4, 0),
  ('ibge', 810220704, 'LINGUICA DE FRANGO - ASSADO(A)', unaccent(lower('LINGUICA DE FRANGO - ASSADO(A)')), 'Preparações', 244.0, 18.2, 0, 18.4, 0),
  ('ibge', 810220705, 'LINGUICA DE FRANGO - FRITO(A)', unaccent(lower('LINGUICA DE FRANGO - FRITO(A)')), 'Preparações', 245.0, 18.3, 0, 18.5, 0),
  ('ibge', 810240199, 'CHOURICO', unaccent(lower('CHOURICO')), 'Preparações', 379.0, 14.6, 1.29, 34.5, 0),
  ('ibge', 810240299, 'MORCELA', unaccent(lower('MORCELA')), 'Preparações', 379.0, 14.6, 1.29, 34.5, 0),
  ('ibge', 810240301, 'MORCILHA - CRU(A)', unaccent(lower('MORCILHA - CRU(A)')), 'Preparações', 379.0, 14.6, 1.29, 34.5, 0),
  ('ibge', 810240302, 'MORCILHA - COZIDO(A)', unaccent(lower('MORCILHA - COZIDO(A)')), 'Preparações', 379.0, 14.6, 1.29, 34.5, 0),
  ('ibge', 810250102, 'PAIO - COZIDO(A)', unaccent(lower('PAIO - COZIDO(A)')), 'Preparações', 339.0, 19.43, 0, 28.36, 0),
  ('ibge', 810260199, 'MORTADELA', unaccent(lower('MORTADELA')), 'Preparações', 307.0, 11.1, 3.2, 27.7, 0),
  ('ibge', 810270199, 'SALAME', unaccent(lower('SALAME')), 'Preparações', 336.0, 21.85, 2.4, 25.9, 0),
  ('ibge', 810270299, 'SALAMINHO', unaccent(lower('SALAMINHO')), 'Preparações', 336.0, 21.85, 2.4, 25.9, 0),
  ('ibge', 810280199, 'BLANQUET DE PERU', unaccent(lower('BLANQUET DE PERU')), 'Preparações', 126.0, 17.5, 2.04, 4.84, 0.2),
  ('ibge', 810290199, 'PRESUNTO', unaccent(lower('PRESUNTO')), 'Preparações', 226.0, 20.53, 0.42, 15.2, 0),
  ('ibge', 810300102, 'HAMBURGUER DE PERU - COZIDO(A)', unaccent(lower('HAMBURGUER DE PERU - COZIDO(A)')), 'Preparações', 195.96, 16.61, 12.64, 8.35, 0.61),
  ('ibge', 810300104, 'HAMBURGUER DE PERU - ASSADO(A)', unaccent(lower('HAMBURGUER DE PERU - ASSADO(A)')), 'Preparações', 195.96, 16.61, 12.64, 8.35, 0.61),
  ('ibge', 810300106, 'HAMBURGUER DE PERU - EMPANADO(A)/A MILANESA', unaccent(lower('HAMBURGUER DE PERU - EMPANADO(A)/A MILANESA')), 'Preparações', 256.49, 16.61, 12.64, 15.2, 0.61),
  ('ibge', 810310102, 'HAMBURGUER NAO ESPECIFICADO - COZIDO(A)', unaccent(lower('HAMBURGUER NAO ESPECIFICADO - COZIDO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810310103, 'HAMBURGUER NAO ESPECIFICADO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('HAMBURGUER NAO ESPECIFICADO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810310104, 'HAMBURGUER NAO ESPECIFICADO - ASSADO(A)', unaccent(lower('HAMBURGUER NAO ESPECIFICADO - ASSADO(A)')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810310105, 'HAMBURGUER NAO ESPECIFICADO - FRITO(A)', unaccent(lower('HAMBURGUER NAO ESPECIFICADO - FRITO(A)')), 'Preparações', 236.66, 26.62, 0, 13.66, 0),
  ('ibge', 810310199, 'HAMBURGUER NAO ESPECIFICADO', unaccent(lower('HAMBURGUER NAO ESPECIFICADO')), 'Preparações', 214.0, 26.62, 0, 11.1, 0),
  ('ibge', 810360199, 'APRESUNTADO', unaccent(lower('APRESUNTADO')), 'Preparações', 178.0, 22.62, 0, 9.02, 0),
  ('ibge', 810390199, 'PURURUCA DE PORCO', unaccent(lower('PURURUCA DE PORCO')), 'Preparações', 544.0, 61.3, 0, 31.3, 0),
  ('ibge', 810390299, 'PELE DE PORCO PREPARADA (PURURUCA)', unaccent(lower('PELE DE PORCO PREPARADA (PURURUCA)')), 'Preparações', 544.0, 61.3, 0, 31.3, 0),
  ('ibge', 810400199, 'PATE (FÍGADO, CALABRESA, FRANGO, PRESUNTO, ETC)', unaccent(lower('PATE (FÍGADO, CALABRESA, FRANGO, PRESUNTO, ETC)')), 'Preparações', 326.0, 14.1, 2.2, 28.5, 0),
  ('ibge', 810410199, 'CARNE DE AVES DEFUMADA', unaccent(lower('CARNE DE AVES DEFUMADA')), 'Preparações', 195.66, 30.91, 0, 7.07, 0),
  ('ibge', 810460102, 'CARNE SALGADA NAO ESPECIFICADA - COZIDO(A)', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - COZIDO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810460103, 'CARNE SALGADA NAO ESPECIFICADA - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810460104, 'CARNE SALGADA NAO ESPECIFICADA - ASSADO(A)', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - ASSADO(A)')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810460105, 'CARNE SALGADA NAO ESPECIFICADA - FRITO(A)', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - FRITO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810460107, 'CARNE SALGADA NAO ESPECIFICADA - REFOGADO(A)', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - REFOGADO(A)')), 'Preparações', 347.0, 25.29, 0, 26.56, 0),
  ('ibge', 810460108, 'CARNE SALGADA NAO ESPECIFICADA - MOLHO VERMELHO', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA - MOLHO VERMELHO')), 'Preparações', 255.2, 21.78, 1.08, 17.56, 0.3),
  ('ibge', 810460199, 'CARNE SALGADA NAO ESPECIFICADA', unaccent(lower('CARNE SALGADA NAO ESPECIFICADA')), 'Preparações', 313.0, 26.9, 0, 21.9, 0),
  ('ibge', 810490402, 'MINI CHICKEN EMPANADO - COZIDO(A)', unaccent(lower('MINI CHICKEN EMPANADO - COZIDO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 810490403, 'MINI CHICKEN EMPANADO - GRELHADO(A)/BRASA/CHURRASCO', unaccent(lower('MINI CHICKEN EMPANADO - GRELHADO(A)/BRASA/CHURRASCO')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 810490404, 'MINI CHICKEN EMPANADO - ASSADO(A)', unaccent(lower('MINI CHICKEN EMPANADO - ASSADO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 810490405, 'MINI CHICKEN EMPANADO - FRITO(A)', unaccent(lower('MINI CHICKEN EMPANADO - FRITO(A)')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 810490406, 'MINI CHICKEN EMPANADO - EMPANADO(A)/A MILANESA', unaccent(lower('MINI CHICKEN EMPANADO - EMPANADO(A)/A MILANESA')), 'Preparações', 273.02, 16.24, 15.91, 15.63, 0.64),
  ('ibge', 810500199, 'MORTADELA LIGHT', unaccent(lower('MORTADELA LIGHT')), 'Preparações', 211.0, 13.06, 3.45, 16.06, 0),
  ('ibge', 810520105, 'SALSICHA NO VAREJO LIGHT - FRITO(A)', unaccent(lower('SALSICHA NO VAREJO LIGHT - FRITO(A)')), 'Preparações', 154.0, 11.0, 4.4, 10.0, 0),
  ('ibge', 810540199, 'SALAME LIGHT', unaccent(lower('SALAME LIGHT')), 'Preparações', 145.18, 14.7, 0.5, 8.94, 0),
  ('ibge', 810550199, 'BLANQUET DE PERU LIGHT', unaccent(lower('BLANQUET DE PERU LIGHT')), 'Preparações', 124.12, 14.99, 7.11, 3.57, 0),
  ('ibge', 810570199, 'HAMBURGUER NAO ESPECIFICADO LIGHT', unaccent(lower('HAMBURGUER NAO ESPECIFICADO LIGHT')), 'Preparações', 190.0, 27.03, 0, 8.26, 0),
  ('ibge', 820010199, 'REFRIGERANTE DE COLA TRADICIONAL', unaccent(lower('REFRIGERANTE DE COLA TRADICIONAL')), 'Preparações', 36.87, 0.07, 9.53, 0.02, 0),
  ('ibge', 820010299, 'COCA COLA TRADICIONAL', unaccent(lower('COCA COLA TRADICIONAL')), 'Preparações', 36.87, 0.07, 9.53, 0.02, 0),
  ('ibge', 820020299, 'FANTA LARANJA TRADICIONAL', unaccent(lower('FANTA LARANJA TRADICIONAL')), 'Preparações', 48.0, 0, 12.3, 0, 0),
  ('ibge', 820020899, 'SUKITA TRADICIONAL', unaccent(lower('SUKITA TRADICIONAL')), 'Preparações', 48.0, 0, 12.3, 0, 0),
  ('ibge', 820030199, 'REFRIGERANTE DE GUARANA TRADICIONAL', unaccent(lower('REFRIGERANTE DE GUARANA TRADICIONAL')), 'Preparações', 39.0, 0, 10.0, 0, 0),
  ('ibge', 820030299, 'GUARANA TRADICIONAL', unaccent(lower('GUARANA TRADICIONAL')), 'Preparações', 39.0, 0, 10.0, 0, 0),
  ('ibge', 820040799, 'SPRIT REFRIGERANTE TRADICIONAL', unaccent(lower('SPRIT REFRIGERANTE TRADICIONAL')), 'Preparações', 40.0, 0.05, 10.14, 0.02, 0),
  ('ibge', 820050599, 'FANTA UVA TRADICIONAL', unaccent(lower('FANTA UVA TRADICIONAL')), 'Preparações', 48.0, 0, 12.3, 0, 0),
  ('ibge', 820070199, 'REFRIGERANTE DE COLA LIGHT', unaccent(lower('REFRIGERANTE DE COLA LIGHT')), 'Preparações', 2.0, 0.11, 0.29, 0.03, 0),
  ('ibge', 820070299, 'COCA COLA LIGHT', unaccent(lower('COCA COLA LIGHT')), 'Preparações', 2.0, 0.11, 0.29, 0.03, 0),
  ('ibge', 820080199, 'REFRIGERANTE DE COLA DIET', unaccent(lower('REFRIGERANTE DE COLA DIET')), 'Preparações', 2.0, 0.11, 0.29, 0.03, 0),
  ('ibge', 820090299, 'MINUANO TRADICIONAL', unaccent(lower('MINUANO TRADICIONAL')), 'Preparações', 40.0, 0.05, 10.14, 0.02, 0),
  ('ibge', 820110499, 'MATE TRADICIONAL', unaccent(lower('MATE TRADICIONAL')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 820120299, 'BIDU TRADICIONAL', unaccent(lower('BIDU TRADICIONAL')), 'Preparações', 39.0, 0, 10.0, 0, 0),
  ('ibge', 820180299, 'TUBAINA TRADICIONAL', unaccent(lower('TUBAINA TRADICIONAL')), 'Preparações', 39.0, 0, 10.0, 0, 0),
  ('ibge', 820190299, 'TUBAINA LIGHT', unaccent(lower('TUBAINA LIGHT')), 'Preparações', 2.0, 0.11, 0.29, 0.03, 0),
  ('ibge', 820200199, 'CALDO DE CANA', unaccent(lower('CALDO DE CANA')), 'Preparações', 73.58, 0, 19.97, 0.05, 0),
  ('ibge', 820200299, 'GARAPA', unaccent(lower('GARAPA')), 'Preparações', 73.58, 0, 19.97, 0.05, 0),
  ('ibge', 820210199, 'AGUA DE COCO', unaccent(lower('AGUA DE COCO')), 'Preparações', 19.27, 0.73, 3.76, 0.2, 1.12),
  ('ibge', 820240299, 'Q-SUCO', unaccent(lower('Q-SUCO')), 'Preparações', 15.28, 0, 3.91, 0.0, 0),
  ('ibge', 820240399, 'Q-REFRESKO', unaccent(lower('Q-REFRESKO')), 'Preparações', 15.28, 0, 3.91, 0.0, 0),
  ('ibge', 820260299, 'NESCAFE', unaccent(lower('NESCAFE')), 'Preparações', 241.0, 12.2, 75.4, 0.5, 0),
  ('ibge', 820280399, 'ERVA MATE', unaccent(lower('ERVA MATE')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 820280499, 'CHIMARRAO', unaccent(lower('CHIMARRAO')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 820280599, 'TERERE', unaccent(lower('TERERE')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 820340199, 'LEVEDO DE CERVEJA', unaccent(lower('LEVEDO DE CERVEJA')), 'Preparações', 170.0, 16.2, 28.1, 1.3, 11.5),
  ('ibge', 820350199, 'REFRIGERANTE NAO ESPECIFICADO', unaccent(lower('REFRIGERANTE NAO ESPECIFICADO')), 'Preparações', 36.87, 0.07, 9.53, 0.02, 0),
  ('ibge', 820360399, 'CEVADA EM PO', unaccent(lower('CEVADA EM PO')), 'Preparações', 352.0, 9.91, 77.72, 1.16, 15.6),
  ('ibge', 820450399, 'CHOCOMILK', unaccent(lower('CHOCOMILK')), 'Preparações', 83.32, 3.18, 10.38, 3.4, 0.8),
  ('ibge', 820490299, 'AGUA TONICA TRADICIONAL', unaccent(lower('AGUA TONICA TRADICIONAL')), 'Preparações', 40.02, 0.05, 10.14, 0.02, 0),
  ('ibge', 820520199, 'CHA DIET (PRETO, CAMOMILA, ERVA CIDREIRA, CAPIM LIMAO, ETC)', unaccent(lower('CHA DIET (PRETO, CAMOMILA, ERVA CIDREIRA, CAPIM LIMAO, ETC)')), 'Preparações', 2.52, 0.01, 0.67, 0, 0),
  ('ibge', 820540299, 'PARAGUAI REFRIGERANTE TRADICIONAL', unaccent(lower('PARAGUAI REFRIGERANTE TRADICIONAL')), 'Preparações', 39.0, 0, 10.0, 0, 0),
  ('ibge', 820580399, 'GATORADE', unaccent(lower('GATORADE')), 'Preparações', 27.01, 0, 6.76, 0.1, 0),
  ('ibge', 820590199, 'BEBIDA ENERGETICA', unaccent(lower('BEBIDA ENERGETICA')), 'Preparações', 45.35, 0.25, 11.03, 0.08, 0),
  ('ibge', 820630199, 'CHA (PRETO, CAMOMILA, ERVA CIDREIRA, CAPIM LIMAO, ETC)', unaccent(lower('CHA (PRETO, CAMOMILA, ERVA CIDREIRA, CAPIM LIMAO, ETC)')), 'Preparações', 1.0, 0, 0.3, 0, 0),
  ('ibge', 820640299, 'CAFE SOLUVEL CAPUCCINO', unaccent(lower('CAFE SOLUVEL CAPUCCINO')), 'Preparações', 27.71, 0.26, 5.17, 0.84, 0.13),
  ('ibge', 820810499, 'MATE LIGHT', unaccent(lower('MATE LIGHT')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 820900299, 'AGUA TONICA LIGHT', unaccent(lower('AGUA TONICA LIGHT')), 'Preparações', 40.02, 0.05, 10.14, 0.02, 0),
  ('ibge', 820910299, 'PARAGUAI REFRIGERANTE LIGHT', unaccent(lower('PARAGUAI REFRIGERANTE LIGHT')), 'Preparações', 2.0, 0.11, 0.29, 0.03, 0),
  ('ibge', 821100299, 'Q-SUCO LIGHT', unaccent(lower('Q-SUCO LIGHT')), 'Preparações', 15.28, 0, 3.91, 0.0, 0),
  ('ibge', 821100399, 'Q-REFRESKO LIGHT', unaccent(lower('Q-REFRESKO LIGHT')), 'Preparações', 15.28, 0, 3.91, 0.0, 0),
  ('ibge', 821110299, 'Q-SUCO DIET', unaccent(lower('Q-SUCO DIET')), 'Preparações', 15.28, 0, 3.91, 0.0, 0),
  ('ibge', 821240199, 'CAFE CAPUCCINO SOLUVEL LIGHT', unaccent(lower('CAFE CAPUCCINO SOLUVEL LIGHT')), 'Preparações', 12.77, 0.14, 0.91, 1.0, 0.05),
  ('ibge', 821250199, 'CAFE CAPUCCINO SOLUVEL DIET', unaccent(lower('CAFE CAPUCCINO SOLUVEL DIET')), 'Preparações', 12.77, 0.14, 0.91, 1.0, 0.05),
  ('ibge', 821290299, 'AGUA TONICA DIET', unaccent(lower('AGUA TONICA DIET')), 'Preparações', 40.02, 0.05, 10.14, 0.02, 0),
  ('ibge', 821290699, 'REFRIGERANTE DE QUININO DIETETICO', unaccent(lower('REFRIGERANTE DE QUININO DIETETICO')), 'Preparações', 40.02, 0.05, 10.14, 0.02, 0),
  ('ibge', 821300399, 'CHA MATE ORGANICO', unaccent(lower('CHA MATE ORGANICO')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 821300499, 'CHIMARRAO ORGANICO', unaccent(lower('CHIMARRAO ORGANICO')), 'Preparações', 2.8, 0.25, 2.31, 0, 1.86),
  ('ibge', 821360199, 'SUCO DE CLOROFILA', unaccent(lower('SUCO DE CLOROFILA')), 'Preparações', 1.87, 0.24, 0.3, 0.02, 0.2),
  ('ibge', 827390299, 'CAFE COM FARINHA', unaccent(lower('CAFE COM FARINHA')), 'Preparações', 181.0, 0.86, 44.19, 0.16, 3.44),
  ('ibge', 830010199, 'CERVEJA (COM OU SEM ALCOOL)', unaccent(lower('CERVEJA (COM OU SEM ALCOOL)')), 'Preparações', 43.19, 0.46, 3.56, 0, 0),
  ('ibge', 830020199, 'CHOPP', unaccent(lower('CHOPP')), 'Preparações', 43.19, 0.46, 3.56, 0, 0),
  ('ibge', 830030199, 'AGUARDENTE', unaccent(lower('AGUARDENTE')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 830030299, 'CACHACA', unaccent(lower('CACHACA')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 830050199, 'BATIDA DE QUALQUER SABOR', unaccent(lower('BATIDA DE QUALQUER SABOR')), 'Preparações', 187.38, 0.54, 22.14, 3.69, 0.32),
  ('ibge', 830070199, 'RUM', unaccent(lower('RUM')), 'Preparações', 230.18, 0, 0, 0, 0),
  ('ibge', 830080199, 'VODKA', unaccent(lower('VODKA')), 'Preparações', 217.15, 0, 0, 0, 0),
  ('ibge', 830100199, 'UISQUE', unaccent(lower('UISQUE')), 'Preparações', 230.18, 0, 0, 0, 0),
  ('ibge', 830100299, 'WHISKY', unaccent(lower('WHISKY')), 'Preparações', 230.18, 0, 0, 0, 0),
  ('ibge', 830120199, 'CHAMPANHE', unaccent(lower('CHAMPANHE')), 'Preparações', 82.0, 0.07, 2.6, 0, 0),
  ('ibge', 830120299, 'SIDRA CHAMPANHE', unaccent(lower('SIDRA CHAMPANHE')), 'Preparações', 82.0, 0.07, 2.6, 0, 0),
  ('ibge', 830150199, 'MARTINI', unaccent(lower('MARTINI')), 'Preparações', 194.44, 0.01, 0.53, 0, 0),
  ('ibge', 830160199, 'CONHAQUE', unaccent(lower('CONHAQUE')), 'Preparações', 231.0, 0, 0, 0, 0),
  ('ibge', 830170199, 'DRINK DREHER', unaccent(lower('DRINK DREHER')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 830190199, 'LICOR DE QUALQUER SABOR', unaccent(lower('LICOR DE QUALQUER SABOR')), 'Preparações', 282.65, 0, 33.64, 0, 0),
  ('ibge', 830240999, 'CAJUINA', unaccent(lower('CAJUINA')), 'Preparações', 45.0, 0.8, 11.5, 0, 1.5),
  ('ibge', 830241599, 'VINHO', unaccent(lower('VINHO')), 'Preparações', 84.5, 0.07, 2.6, 0, 0),
  ('ibge', 830241699, 'CATUABA', unaccent(lower('CATUABA')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 830290199, 'COQUETEL DE FRUTAS', unaccent(lower('COQUETEL DE FRUTAS')), 'Preparações', 187.38, 0.54, 22.14, 3.69, 0.32),
  ('ibge', 830310199, 'CAIPIRINHA', unaccent(lower('CAIPIRINHA')), 'Preparações', 143.9, 0.1, 37.9, 0.1, 0.1),
  ('ibge', 830350199, 'BEBIDA ALCOOLICA', unaccent(lower('BEBIDA ALCOOLICA')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 830361599, 'VINHO ORGANICO', unaccent(lower('VINHO ORGANICO')), 'Preparações', 84.5, 0.07, 2.6, 0, 0),
  ('ibge', 830430199, 'CERVEJA (COM OU SEM ALCOOL) LIGHT', unaccent(lower('CERVEJA (COM OU SEM ALCOOL) LIGHT')), 'Preparações', 29.0, 0.24, 1.64, 0, 0),
  ('ibge', 830450299, 'CAXIRI (AGUARDENTE DE MANDIOCA)', unaccent(lower('CAXIRI (AGUARDENTE DE MANDIOCA)')), 'Preparações', 216.0, 0, 0, 0, 0),
  ('ibge', 840010199, 'AZEITE DE OLIVA', unaccent(lower('AZEITE DE OLIVA')), 'Preparações', 887.8, 0, 0, 100.43, 0),
  ('ibge', 840030199, 'OLEO DE SOJA', unaccent(lower('OLEO DE SOJA')), 'Preparações', 879.73, 0, 0, 99.52, 0),
  ('ibge', 840180199, 'BANHA SUINA', unaccent(lower('BANHA SUINA')), 'Preparações', 902.0, 0, 0, 100.0, 0),
  ('ibge', 840300199, 'BANHA BOVINA', unaccent(lower('BANHA BOVINA')), 'Preparações', 680.0, 10.65, 0, 70.33, 0),
  ('ibge', 840320199, 'OLEO NAO ESPECIFICADO', unaccent(lower('OLEO NAO ESPECIFICADO')), 'Preparações', 879.73, 0, 0, 99.52, 0),
  ('ibge', 840350199, 'OLEO DE DENDE', unaccent(lower('OLEO DE DENDE')), 'Preparações', 857.84, 0, 0, 99.52, 0),
  ('ibge', 850020199, 'SALGADINHO', unaccent(lower('SALGADINHO')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850020299, 'PASTEL (QUEIJO, CARNE, PALMITO, ETC)', unaccent(lower('PASTEL (QUEIJO, CARNE, PALMITO, ETC)')), 'Preparações', 319.81, 10.38, 33.51, 15.68, 1.45),
  ('ibge', 850020399, 'CROQUETE', unaccent(lower('CROQUETE')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850020599, 'COXINHA', unaccent(lower('COXINHA')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850020699, 'EMPADA (QUEIJO, CARNE, CAMARAO, ETC)', unaccent(lower('EMPADA (QUEIJO, CARNE, CAMARAO, ETC)')), 'Preparações', 153.96, 7.89, 12.47, 7.91, 1.03),
  ('ibge', 850020799, 'RIZOLE  (QUEIJO, CARNE, CAMARAO, ETC)', unaccent(lower('RIZOLE  (QUEIJO, CARNE, CAMARAO, ETC)')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850020999, 'ACARAJE', unaccent(lower('ACARAJE')), 'Preparações', 289.0, 8.3, 19.1, 19.9, 9.4),
  ('ibge', 850021099, 'TORRESMO', unaccent(lower('TORRESMO')), 'Preparações', 544.0, 61.3, 0, 31.3, 0),
  ('ibge', 850021199, 'QUIBE', unaccent(lower('QUIBE')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850021299, 'ABARA (BAHIA)', unaccent(lower('ABARA (BAHIA)')), 'Preparações', 289.0, 8.3, 19.1, 19.9, 9.4),
  ('ibge', 850021399, 'PACOCA DE CARNE DE SOL', unaccent(lower('PACOCA DE CARNE DE SOL')), 'Preparações', 354.0, 13.44, 43.95, 13.43, 3.2),
  ('ibge', 850021599, 'ANGU FRITO', unaccent(lower('ANGU FRITO')), 'Preparações', 74.6, 1.45, 13.0, 1.78, 0.26),
  ('ibge', 850021799, 'ANGU DE MILHO', unaccent(lower('ANGU DE MILHO')), 'Preparações', 60.58, 1.44, 13.0, 0.2, 0.26),
  ('ibge', 850021899, 'POLENTA', unaccent(lower('POLENTA')), 'Preparações', 74.6, 1.45, 13.0, 1.78, 0.26),
  ('ibge', 850022299, 'ESFIRRA', unaccent(lower('ESFIRRA')), 'Preparações', 359.42, 9.76, 37.51, 18.88, 1.46),
  ('ibge', 850022399, 'ESFIRRA DE CARNE', unaccent(lower('ESFIRRA DE CARNE')), 'Preparações', 346.45, 11.89, 26.2, 21.38, 1.07),
  ('ibge', 850022499, 'ESFIRRA DE QUEIJO', unaccent(lower('ESFIRRA DE QUEIJO')), 'Preparações', 359.42, 9.76, 37.51, 18.88, 1.46),
  ('ibge', 850022599, 'ESFIRRA DE RICOTA', unaccent(lower('ESFIRRA DE RICOTA')), 'Preparações', 320.39, 7.54, 38.09, 15.25, 1.46),
  ('ibge', 850022699, 'ESFIRRA DE FRANGO', unaccent(lower('ESFIRRA DE FRANGO')), 'Preparações', 222.39, 9.47, 17.32, 12.71, 0.78),
  ('ibge', 850022799, 'ENROLADINHO', unaccent(lower('ENROLADINHO')), 'Preparações', 274.6, 13.41, 16.54, 16.88, 0.88),
  ('ibge', 850022899, 'BOLINHO DE AIPIM', unaccent(lower('BOLINHO DE AIPIM')), 'Preparações', 212.64, 6.28, 18.51, 13.11, 2.72),
  ('ibge', 850023299, 'BOLINHO DE BACALHAU', unaccent(lower('BOLINHO DE BACALHAU')), 'Preparações', 214.01, 16.7, 7.69, 12.75, 0.83),
  ('ibge', 850030299, 'CACHORRO QUENTE', unaccent(lower('CACHORRO QUENTE')), 'Preparações', 272.47, 8.73, 24.8, 15.22, 1.09),
  ('ibge', 850030399, 'HAMBURGUER (SANDUICHE)', unaccent(lower('HAMBURGUER (SANDUICHE)')), 'Preparações', 267.16, 13.08, 32.36, 9.22, 1.68),
  ('ibge', 850030499, 'CHEESBURGUER', unaccent(lower('CHEESBURGUER')), 'Preparações', 279.85, 14.15, 28.74, 11.81, 1.49),
  ('ibge', 850030599, 'EGGSBURGUER', unaccent(lower('EGGSBURGUER')), 'Preparações', 269.44, 13.28, 17.42, 16.1, 0.64),
  ('ibge', 850030799, 'BAURU', unaccent(lower('BAURU')), 'Preparações', 229.47, 13.67, 13.96, 13.0, 0.78),
  ('ibge', 850030899, 'AMERICANO', unaccent(lower('AMERICANO')), 'Preparações', 236.68, 10.05, 16.85, 14.21, 1.0),
  ('ibge', 850031399, 'MISTO QUENTE OU FRIO', unaccent(lower('MISTO QUENTE OU FRIO')), 'Preparações', 265.42, 16.29, 18.3, 13.78, 0.85),
  ('ibge', 850031599, 'SANDUICHE DE QUEIJO PRATO', unaccent(lower('SANDUICHE DE QUEIJO PRATO')), 'Preparações', 329.29, 12.22, 31.09, 17.24, 1.45),
  ('ibge', 850031699, 'SANDUICHE DE SALAME', unaccent(lower('SANDUICHE DE SALAME')), 'Preparações', 282.99, 8.96, 30.27, 13.74, 1.4),
  ('ibge', 850031799, 'SANDUICHE DE PRESUNTO', unaccent(lower('SANDUICHE DE PRESUNTO')), 'Preparações', 230.33, 10.97, 18.73, 12.15, 1.11),
  ('ibge', 850031899, 'SANDUICHE DE QUEIJO PRATO COM PRESUNTO', unaccent(lower('SANDUICHE DE QUEIJO PRATO COM PRESUNTO')), 'Preparações', 265.42, 16.29, 18.3, 13.78, 0.85),
  ('ibge', 850031999, 'SANDUICHE DE MORTADELA', unaccent(lower('SANDUICHE DE MORTADELA')), 'Preparações', 315.97, 8.6, 32.81, 16.56, 1.45),
  ('ibge', 850032099, 'SANDUICHE DE QUEIJO MINAS', unaccent(lower('SANDUICHE DE QUEIJO MINAS')), 'Preparações', 329.29, 12.22, 31.09, 17.24, 1.45),
  ('ibge', 850032199, 'CHEESE EGG', unaccent(lower('CHEESE EGG')), 'Preparações', 279.85, 14.15, 28.74, 11.81, 1.49),
  ('ibge', 850032299, 'CHEESE TUDO', unaccent(lower('CHEESE TUDO')), 'Preparações', 279.85, 14.15, 28.74, 11.81, 1.49),
  ('ibge', 850032399, 'SANDUICHE NATURAL', unaccent(lower('SANDUICHE NATURAL')), 'Preparações', 245.58, 11.21, 25.58, 10.84, 1.47),
  ('ibge', 850040199, 'SUCO', unaccent(lower('SUCO')), 'Preparações', 41.83, 0.59, 9.81, 0.14, 0.31),
  ('ibge', 850040299, 'SUCO DE ABACAXI', unaccent(lower('SUCO DE ABACAXI')), 'Preparações', 53.21, 0.36, 12.92, 0.12, 0.2),
  ('ibge', 850040399, 'SUCO DE ACEROLA', unaccent(lower('SUCO DE ACEROLA')), 'Preparações', 23.06, 0.4, 4.81, 0.3, 0.3),
  ('ibge', 850040499, 'SUCO DE BETERRABA', unaccent(lower('SUCO DE BETERRABA')), 'Preparações', 30.77, 0.81, 7.11, 0.12, 0.76),
  ('ibge', 850040599, 'SUCO DE CUPUACU', unaccent(lower('SUCO DE CUPUACU')), 'Preparações', 24.5, 0.6, 5.2, 0.5, 1.55),
  ('ibge', 850040699, 'SUCO DE GOIABA', unaccent(lower('SUCO DE GOIABA')), 'Preparações', 62.28, 0.37, 15.62, 0.14, 0.79),
  ('ibge', 850040799, 'SUCO DE LARANJA', unaccent(lower('SUCO DE LARANJA')), 'Preparações', 41.83, 0.59, 9.81, 0.14, 0.31),
  ('ibge', 850040899, 'SUCO DE LARANJA COM BANANA', unaccent(lower('SUCO DE LARANJA COM BANANA')), 'Preparações', 56.8, 0.76, 13.84, 0.2, 0.93),
  ('ibge', 850040999, 'SUCO DE LARANJA E BETERRABA', unaccent(lower('SUCO DE LARANJA E BETERRABA')), 'Preparações', 30.77, 0.81, 7.11, 0.12, 0.76),
  ('ibge', 850041099, 'SUCO DE LARANJA E CENOURA', unaccent(lower('SUCO DE LARANJA E CENOURA')), 'Preparações', 30.77, 0.81, 7.11, 0.12, 0.76),
  ('ibge', 850041199, 'SUCO DE LARANJA CENOURA E BETERRABA', unaccent(lower('SUCO DE LARANJA CENOURA E BETERRABA')), 'Preparações', 30.77, 0.81, 7.11, 0.12, 0.76),
  ('ibge', 850041299, 'SUCO DE MAMAO', unaccent(lower('SUCO DE MAMAO')), 'Preparações', 57.13, 0.17, 14.54, 0.15, 0.6),
  ('ibge', 850041399, 'SUCO DE MANGA', unaccent(lower('SUCO DE MANGA')), 'Preparações', 50.86, 0.11, 13.08, 0.06, 0.3),
  ('ibge', 850041499, 'SUCO DE MARACUJA', unaccent(lower('SUCO DE MARACUJA')), 'Preparações', 60.14, 0.67, 14.48, 0.18, 0.2),
  ('ibge', 850041599, 'SUCO DE MELAO', unaccent(lower('SUCO DE MELAO')), 'Preparações', 31.79, 0.65, 8.0, 0.16, 0.42),
  ('ibge', 850041699, 'SUCO DE MORANGO', unaccent(lower('SUCO DE MORANGO')), 'Preparações', 59.21, 0.57, 14.51, 0.1, 0.23),
  ('ibge', 850041799, 'SUCO DE PESSEGO', unaccent(lower('SUCO DE PESSEGO')), 'Preparações', 53.99, 0.27, 13.92, 0.02, 0.6),
  ('ibge', 850041899, 'SUCO DE PESSEGO EM CALDA', unaccent(lower('SUCO DE PESSEGO EM CALDA')), 'Preparações', 53.99, 0.27, 13.92, 0.02, 0.6),
  ('ibge', 850050199, 'VITAMINA', unaccent(lower('VITAMINA')), 'Preparações', 92.78, 2.47, 16.39, 2.31, 0.62),
  ('ibge', 850050399, 'VITAMINA DE BANANA', unaccent(lower('VITAMINA DE BANANA')), 'Preparações', 92.78, 2.47, 16.39, 2.31, 0.62),
  ('ibge', 850050499, 'VITAMINA DE BANANA COM AVEIA', unaccent(lower('VITAMINA DE BANANA COM AVEIA')), 'Preparações', 108.46, 3.06, 19.2, 2.54, 1.15),
  ('ibge', 850050599, 'VITAMINA DE MAMÃO', unaccent(lower('VITAMINA DE MAMÃO')), 'Preparações', 80.59, 2.42, 12.95, 2.34, 0.38),
  ('ibge', 850050699, 'VITAMINA DE ABACATE', unaccent(lower('VITAMINA DE ABACATE')), 'Preparações', 100.19, 2.74, 12.8, 4.63, 1.34),
  ('ibge', 850050799, 'VITAMINA DE MORANGO', unaccent(lower('VITAMINA DE MORANGO')), 'Preparações', 74.61, 1.96, 13.27, 1.83, 0.8),
  ('ibge', 850050899, 'VITAMINA MISTA', unaccent(lower('VITAMINA MISTA')), 'Preparações', 83.16, 1.8, 16.2, 1.65, 0.77),
  ('ibge', 850050999, 'VITAMINA DE MACA', unaccent(lower('VITAMINA DE MACA')), 'Preparações', 82.99, 2.28, 13.98, 2.26, 0.31),
  ('ibge', 850060199, 'REFRESCO', unaccent(lower('REFRESCO')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850060299, 'REFRESCO DE CAJU', unaccent(lower('REFRESCO DE CAJU')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850060399, 'REFRESCO DE GROSELHA', unaccent(lower('REFRESCO DE GROSELHA')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850060499, 'REFRESCO DE LARANJA', unaccent(lower('REFRESCO DE LARANJA')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850060599, 'REFRESCO DE MARACUJA', unaccent(lower('REFRESCO DE MARACUJA')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850060699, 'REFRESCO DE LIMAO', unaccent(lower('REFRESCO DE LIMAO')), 'Preparações', 46.8, 0, 11.92, 0, 0.2),
  ('ibge', 850080199, 'SALADA OU VERDURA COZIDA, EXCETO DE FRUTA', unaccent(lower('SALADA OU VERDURA COZIDA, EXCETO DE FRUTA')), 'Preparações', 26.0, 2.11, 4.91, 0.36, 2.8),
  ('ibge', 850080299, 'SALADA DE MAIONESE', unaccent(lower('SALADA DE MAIONESE')), 'Preparações', 209.79, 2.71, 12.64, 16.82, 1.38),
  ('ibge', 850090399, 'PIZZA', unaccent(lower('PIZZA')), 'Preparações', 281.2, 14.6, 29.82, 11.35, 1.74),
  ('ibge', 850090499, 'LAZANHA', unaccent(lower('LAZANHA')), 'Preparações', 158.63, 10.78, 12.34, 7.31, 1.11),
  ('ibge', 850090599, 'NHOQUE', unaccent(lower('NHOQUE')), 'Preparações', 190.54, 9.31, 8.48, 13.18, 0.26),
  ('ibge', 850090699, 'CANELONI', unaccent(lower('CANELONI')), 'Preparações', 120.86, 5.94, 9.22, 6.8, 1.01),
  ('ibge', 850090799, 'CAPELETI', unaccent(lower('CAPELETI')), 'Preparações', 95.24, 5.53, 12.6, 2.59, 1.2),
  ('ibge', 850090999, 'RAVIOLI', unaccent(lower('RAVIOLI')), 'Preparações', 95.24, 5.53, 12.6, 2.59, 1.2),
  ('ibge', 850091099, 'CALZONE', unaccent(lower('CALZONE')), 'Preparações', 245.75, 12.83, 25.8, 9.85, 1.18),
  ('ibge', 850091399, 'PANQUECA', unaccent(lower('PANQUECA')), 'Preparações', 203.18, 13.96, 8.27, 12.46, 0.66),
  ('ibge', 850091499, 'PIZZA CALABREZA', unaccent(lower('PIZZA CALABREZA')), 'Preparações', 284.72, 13.74, 29.51, 12.21, 1.75),
  ('ibge', 850091599, 'PIZZA MUZZARELA', unaccent(lower('PIZZA MUZZARELA')), 'Preparações', 281.2, 14.6, 29.82, 11.35, 1.74),
  ('ibge', 850091699, 'PIZZA PRESUNTO', unaccent(lower('PIZZA PRESUNTO')), 'Preparações', 284.72, 13.74, 29.51, 12.21, 1.75),
  ('ibge', 850091799, 'PIZZA PORTUGUESA', unaccent(lower('PIZZA PORTUGUESA')), 'Preparações', 247.49, 11.75, 22.4, 12.23, 1.56),
  ('ibge', 850091999, 'MACARRONADA', unaccent(lower('MACARRONADA')), 'Preparações', 120.59, 6.22, 17.42, 2.79, 1.25),
  ('ibge', 850100499, 'GALETO', unaccent(lower('GALETO')), 'Preparações', 261.66, 27.3, 0, 16.16, 0),
  ('ibge', 850110499, 'COSTELA', unaccent(lower('COSTELA')), 'Preparações', 365.0, 22.6, 0, 29.79, 0),
  ('ibge', 850120299, 'PIPOCA DOCE OU SALGADA', unaccent(lower('PIPOCA DOCE OU SALGADA')), 'Preparações', 468.15, 6.59, 62.51, 23.28, 6.02),
  ('ibge', 850130299, 'CAFE', unaccent(lower('CAFE')), 'Preparações', 1.0, 0.12, 0.47, 0.02, 0.47),
  ('ibge', 850130399, 'CAFE COM LEITE', unaccent(lower('CAFE COM LEITE')), 'Preparações', 31.44, 1.72, 2.57, 1.69, 0.23),
  ('ibge', 850130499, 'CAFE TIPO EXPRESSO', unaccent(lower('CAFE TIPO EXPRESSO')), 'Preparações', 2.44, 0.12, 0.77, 0.01, 0.2),
  ('ibge', 850130599, 'CAFE TIPO CAPUCCINO', unaccent(lower('CAFE TIPO CAPUCCINO')), 'Preparações', 27.71, 0.26, 5.17, 0.84, 0.13),
  ('ibge', 850140299, 'MILHO COZIDO', unaccent(lower('MILHO COZIDO')), 'Preparações', 160.14, 3.32, 25.11, 7.18, 4.25),
  ('ibge', 850150299, 'BATATA PALITO', unaccent(lower('BATATA PALITO')), 'Preparações', 263.5, 2.87, 33.6, 13.64, 3.44),
  ('ibge', 850150399, 'BATATA PALHA', unaccent(lower('BATATA PALHA')), 'Preparações', 545.7, 5.24, 54.52, 35.24, 4.53),
  ('ibge', 850190299, 'MUNGUNZA', unaccent(lower('MUNGUNZA')), 'Preparações', 146.0, 4.0, 24.4, 3.9, 2.4),
  ('ibge', 850190399, 'CANJICA', unaccent(lower('CANJICA')), 'Preparações', 146.0, 4.0, 24.4, 3.9, 2.4),
  ('ibge', 850190499, 'CURAU', unaccent(lower('CURAU')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 850220199, 'FAROFA', unaccent(lower('FAROFA')), 'Preparações', 406.0, 2.1, 80.3, 9.1, 7.8),
  ('ibge', 850230199, 'MINGAU (FUBA,  AVEIA, FARINHA, ETC)', unaccent(lower('MINGAU (FUBA,  AVEIA, FARINHA, ETC)')), 'Preparações', 78.24, 2.42, 10.46, 3.06, 0.17),
  ('ibge', 850240199, 'TACACA', unaccent(lower('TACACA')), 'Preparações', 16.0, 2.0, 0.4, 0.6, 0),
  ('ibge', 850250199, 'BOLINHO DE COCO', unaccent(lower('BOLINHO DE COCO')), 'Preparações', 297.32, 6.71, 54.89, 5.8, 0.85),
  ('ibge', 850270199, 'RISOTO', unaccent(lower('RISOTO')), 'Preparações', 113.02, 6.66, 17.16, 1.99, 1.1),
  ('ibge', 850280199, 'VATAPA', unaccent(lower('VATAPA')), 'Preparações', 226.07, 13.77, 9.28, 15.61, 1.32),
  ('ibge', 850290199, 'FAROFA PRONTA', unaccent(lower('FAROFA PRONTA')), 'Preparações', 406.0, 2.1, 80.3, 9.1, 7.8),
  ('ibge', 850320299, 'CALDO DE CARNE', unaccent(lower('CALDO DE CARNE')), 'Preparações', 7.02, 1.36, 0.45, 0, 0),
  ('ibge', 850320399, 'CALDO DE FEIJAO', unaccent(lower('CALDO DE FEIJAO')), 'Preparações', 75.5, 4.78, 10.33, 1.76, 2.2),
  ('ibge', 850320499, 'CALDO DE MOCOTO', unaccent(lower('CALDO DE MOCOTO')), 'Preparações', 7.02, 1.36, 0.45, 0, 0),
  ('ibge', 850350199, 'BAIAO DE DOIS', unaccent(lower('BAIAO DE DOIS')), 'Preparações', 136.0, 6.2, 20.4, 3.2, 5.1),
  ('ibge', 850380199, 'CHURRASCO', unaccent(lower('CHURRASCO')), 'Preparações', 204.0, 30.67, 0, 9.0, 0),
  ('ibge', 850420199, 'SUSHI', unaccent(lower('SUSHI')), 'Preparações', 146.78, 5.56, 29.19, 0.45, 0.91),
  ('ibge', 850440199, 'SALADA DE FRUTAS', unaccent(lower('SALADA DE FRUTAS')), 'Preparações', 51.24, 0.62, 13.31, 0.14, 1.68),
  ('ibge', 850450199, 'SOPA (LEGUMES, CARNE, ETC)', unaccent(lower('SOPA (LEGUMES, CARNE, ETC)')), 'Preparações', 28.78, 1.63, 3.81, 0.78, 0.64),
  ('ibge', 850480199, 'SALPICAO', unaccent(lower('SALPICAO')), 'Preparações', 202.85, 14.26, 3.93, 14.41, 0.55),
  ('ibge', 850520199, 'CHARUTO DE REPOLHO', unaccent(lower('CHARUTO DE REPOLHO')), 'Preparações', 84.91, 9.63, 8.75, 1.3, 1.2),
  ('ibge', 850540199, 'ARROZ A GREGA', unaccent(lower('ARROZ A GREGA')), 'Preparações', 92.0, 2.17, 17.47, 1.69, 1.0),
  ('ibge', 850550199, 'ARRUMADINHO', unaccent(lower('ARRUMADINHO')), 'Preparações', 198.86, 9.33, 21.73, 8.47, 3.47),
  ('ibge', 850560199, 'BOBO DE CAMARAO', unaccent(lower('BOBO DE CAMARAO')), 'Preparações', 72.1, 2.63, 5.48, 4.42, 0.15),
  ('ibge', 850570199, 'CARURU (QUIABO, AMENDOIM, CASTANHA DE CAJU, CAMARAO SECO, ETC)', unaccent(lower('CARURU (QUIABO, AMENDOIM, CASTANHA DE CAJU, CAMARAO SECO, ETC)')), 'Preparações', 215.87, 6.07, 4.07, 20.07, 1.41),
  ('ibge', 850580199, 'CUSCUZ PAULISTA', unaccent(lower('CUSCUZ PAULISTA')), 'Preparações', 142.0, 2.6, 22.5, 4.6, 2.4),
  ('ibge', 850590199, 'EMPADAO (QUEIJO, FRANGO, CAMARAO, PALMITO, ETC)', unaccent(lower('EMPADAO (QUEIJO, FRANGO, CAMARAO, PALMITO, ETC)')), 'Preparações', 153.96, 7.89, 12.47, 7.91, 1.03),
  ('ibge', 850600199, 'FAROFA DE BANANA', unaccent(lower('FAROFA DE BANANA')), 'Preparações', 309.55, 1.66, 52.89, 11.17, 5.35),
  ('ibge', 850610199, 'FEIJAO TROPEIRO', unaccent(lower('FEIJAO TROPEIRO')), 'Preparações', 198.86, 9.33, 21.73, 8.47, 3.47),
  ('ibge', 850620199, 'GALINHA COM ARROZ', unaccent(lower('GALINHA COM ARROZ')), 'Preparações', 143.5, 4.46, 23.93, 3.07, 0.65),
  ('ibge', 850630199, 'GALINHADA', unaccent(lower('GALINHADA')), 'Preparações', 143.5, 4.46, 23.93, 3.07, 0.65),
  ('ibge', 850640199, 'MOQUECA BAIANA', unaccent(lower('MOQUECA BAIANA')), 'Preparações', 130.13, 13.62, 1.66, 7.54, 0.17),
  ('ibge', 850650199, 'OMELETE', unaccent(lower('OMELETE')), 'Preparações', 241.62, 11.04, 0.98, 21.26, 0),
  ('ibge', 850660199, 'PIRAO', unaccent(lower('PIRAO')), 'Preparações', 119.65, 8.05, 8.9, 5.76, 0.75),
  ('ibge', 850670199, 'QUIBEBE', unaccent(lower('QUIBEBE')), 'Preparações', 36.39, 0.72, 4.9, 1.92, 1.1),
  ('ibge', 850680199, 'QUICHE', unaccent(lower('QUICHE')), 'Preparações', 282.73, 10.34, 13.85, 20.44, 0.56),
  ('ibge', 850690199, 'SUFLE', unaccent(lower('SUFLE')), 'Preparações', 126.1, 5.11, 6.4, 9.17, 1.1),
  ('ibge', 850700199, 'TUTU', unaccent(lower('TUTU')), 'Preparações', 123.76, 5.41, 22.34, 1.64, 4.04),
  ('ibge', 850710199, 'MOQUECA CAPIXABA', unaccent(lower('MOQUECA CAPIXABA')), 'Preparações', 100.52, 14.34, 1.75, 3.66, 0.18),
  ('ibge', 850720199, 'MANICOBA', unaccent(lower('MANICOBA')), 'Preparações', 181.85, 15.09, 2.92, 12.16, 1.31),
  ('ibge', 850730199, 'CALDO VERDE', unaccent(lower('CALDO VERDE')), 'Preparações', 94.92, 3.53, 14.19, 2.9, 2.14),
  ('ibge', 850740199, 'ARROZ DE CUXA', unaccent(lower('ARROZ DE CUXA')), 'Preparações', 102.74, 2.38, 20.92, 0.95, 1.92),
  ('ibge', 850750199, 'ANGU A BAIANA', unaccent(lower('ANGU A BAIANA')), 'Preparações', 125.34, 9.01, 8.87, 5.75, 0.31),
  ('ibge', 850760199, 'CHOCOLATE', unaccent(lower('CHOCOLATE')), 'Preparações', 535.0, 7.65, 59.4, 29.66, 3.4),
  ('ibge', 850770199, 'GEMADA', unaccent(lower('GEMADA')), 'Preparações', 134.79, 3.8, 13.52, 7.47, 0),
  ('ibge', 850780199, 'ACAI COM GRANOLA', unaccent(lower('ACAI COM GRANOLA')), 'Preparações', 110.0, 0.7, 21.5, 3.7, 1.7),
  ('ibge', 850790199, 'SUCO ORGANICO', unaccent(lower('SUCO ORGANICO')), 'Preparações', 41.83, 0.59, 9.81, 0.14, 0.31),
  ('ibge', 850790299, 'SUCO DE ABACAXI ORGANICO', unaccent(lower('SUCO DE ABACAXI ORGANICO')), 'Preparações', 53.21, 0.36, 12.92, 0.12, 0.2),
  ('ibge', 850790399, 'SUCO DE ACEROLA ORGANICO', unaccent(lower('SUCO DE ACEROLA ORGANICO')), 'Preparações', 23.06, 0.4, 4.81, 0.3, 0.3),
  ('ibge', 850790699, 'SUCO DE GOIABA ORGANICO', unaccent(lower('SUCO DE GOIABA ORGANICO')), 'Preparações', 62.28, 0.37, 15.62, 0.14, 0.79),
  ('ibge', 850790799, 'SUCO DE LARANJA ORGANICO', unaccent(lower('SUCO DE LARANJA ORGANICO')), 'Preparações', 41.83, 0.59, 9.81, 0.14, 0.31),
  ('ibge', 850791199, 'SUCO DE LARANJA CENOURA E BETERRABA ORGANICO', unaccent(lower('SUCO DE LARANJA CENOURA E BETERRABA ORGANICO')), 'Preparações', 30.77, 0.81, 7.11, 0.12, 0.76),
  ('ibge', 850791399, 'SUCO DE MANGA ORGANICO', unaccent(lower('SUCO DE MANGA ORGANICO')), 'Preparações', 50.86, 0.11, 13.08, 0.06, 0.3),
  ('ibge', 850791499, 'SUCO DE MARACUJA ORGANICO', unaccent(lower('SUCO DE MARACUJA ORGANICO')), 'Preparações', 60.14, 0.67, 14.48, 0.18, 0.2),
  ('ibge', 850791699, 'SUCO DE MORANGO ORGANICO', unaccent(lower('SUCO DE MORANGO ORGANICO')), 'Preparações', 59.21, 0.57, 14.51, 0.1, 0.23),
  ('ibge', 850791799, 'SUCO DE PESSEGO ORGANICO', unaccent(lower('SUCO DE PESSEGO ORGANICO')), 'Preparações', 53.99, 0.27, 13.92, 0.02, 0.6),
  ('ibge', 850791899, 'SUCO DE PESSEGO EM CALDA ORGANICO', unaccent(lower('SUCO DE PESSEGO EM CALDA ORGANICO')), 'Preparações', 53.99, 0.27, 13.92, 0.02, 0.6),
  ('ibge', 850800399, 'PIZZA PRONTA LIGHT', unaccent(lower('PIZZA PRONTA LIGHT')), 'Preparações', 255.57, 14.6, 29.82, 8.45, 1.74),
  ('ibge', 850800499, 'LAZANHA PRONTA LIGHT', unaccent(lower('LAZANHA PRONTA LIGHT')), 'Preparações', 144.33, 10.93, 12.34, 5.67, 1.11),
  ('ibge', 850801202, 'MACARRAO PRONTO LIGHT - COZIDO(A)', unaccent(lower('MACARRAO PRONTO LIGHT - COZIDO(A)')), 'Preparações', 189.86, 5.64, 25.54, 7.18, 1.16),
  ('ibge', 850801799, 'PIZZA PORTUGUESA LIGHT', unaccent(lower('PIZZA PORTUGUESA LIGHT')), 'Preparações', 229.62, 11.75, 22.4, 10.21, 1.56),
  ('ibge', 850810199, 'FAROFA PRONTA LIGHT EM PACOTE', unaccent(lower('FAROFA PRONTA LIGHT EM PACOTE')), 'Preparações', 406.0, 2.1, 80.3, 9.1, 7.8),
  ('ibge', 850830199, 'VACA ATOLADA', unaccent(lower('VACA ATOLADA')), 'Preparações', 245.0, 11.6, 15.05, 15.04, 0.8),
  ('ibge', 850840199, 'SALADA OU VERDURA CRUA, EXCETO DE FRUTA', unaccent(lower('SALADA OU VERDURA CRUA, EXCETO DE FRUTA')), 'Preparações', 18.0, 0.88, 3.92, 0.2, 1.2),
  ('ibge', 850840399, 'OUTROS LEGUMES COZIDOS', unaccent(lower('OUTROS LEGUMES COZIDOS')), 'Preparações', 60.5, 1.24, 14.12, 0.14, 2.52),
  ('ibge', 850980199, 'CAFE DA MANHA', unaccent(lower('CAFE DA MANHA')), 'Preparações', 31.44, 1.72, 2.57, 1.69, 0.23),
  ('ibge', 857010199, 'PRATO DE COMIDA BRASILEIRO', unaccent(lower('PRATO DE COMIDA BRASILEIRO')), 'Preparações', 148.37, 6.74, 21.34, 3.86, 2.31),
  ('ibge', 857010299, 'PRATO DE COMIDA NE', unaccent(lower('PRATO DE COMIDA NE')), 'Preparações', 129.21, 6.49, 19.48, 2.66, 2.33),
  ('ibge', 857010399, 'PRATO DE COMIDA N', unaccent(lower('PRATO DE COMIDA N')), 'Preparações', 157.1, 6.53, 24.99, 3.36, 2.94),
  ('ibge', 857010499, 'PRATO DE COMIDA SE', unaccent(lower('PRATO DE COMIDA SE')), 'Preparações', 131.09, 8.62, 12.0, 5.3, 1.86),
  ('ibge', 857010599, 'PRATO DE COMIDA SUL', unaccent(lower('PRATO DE COMIDA SUL')), 'Preparações', 148.37, 6.74, 21.34, 3.86, 2.31),
  ('ibge', 857010699, 'PRATO DE COMIDA CO', unaccent(lower('PRATO DE COMIDA CO')), 'Preparações', 105.93, 5.68, 14.27, 2.91, 2.22),
  ('ibge', 857010799, 'ARROZ COM FEIJAO', unaccent(lower('ARROZ COM FEIJAO')), 'Preparações', 116.51, 4.17, 21.42, 1.5, 2.66),
  ('ibge', 857032899, 'PAO COM MANTEIGA', unaccent(lower('PAO COM MANTEIGA')), 'Preparações', 369.5, 6.81, 48.84, 16.1, 1.92),
  ('ibge', 857032999, 'PAO COM MARGARINA', unaccent(lower('PAO COM MARGARINA')), 'Preparações', 369.83, 6.82, 48.98, 16.0, 1.92),
  ('ibge', 857033099, 'PAO COM OVO', unaccent(lower('PAO COM OVO')), 'Preparações', 261.3, 10.84, 29.91, 10.38, 1.15),
  ('ibge', 857111099, 'CARNE COM BATATA, INHAME, BATATA BAROA OU AIPIM', unaccent(lower('CARNE COM BATATA, INHAME, BATATA BAROA OU AIPIM')), 'Preparações', 188.2, 12.96, 10.01, 10.5, 1.02),
  ('ibge', 857111199, 'CARNE COM LEGUMES (EXCETO BATATA, INHAME E AIPIM)', unaccent(lower('CARNE COM LEGUMES (EXCETO BATATA, INHAME E AIPIM)')), 'Preparações', 150.52, 12.47, 2.45, 9.95, 0.55),
  ('ibge', 857111299, 'FRANGO COM BATATA, INHAME BATATA BAROA OU AIPIM', unaccent(lower('FRANGO COM BATATA, INHAME BATATA BAROA OU AIPIM')), 'Preparações', 153.7, 16.31, 10.01, 5.04, 1.02),
  ('ibge', 857111399, 'FRANGO COM LEGUMES (EXCETO BATATA,INHAME E AIPIM)', unaccent(lower('FRANGO COM LEGUMES (EXCETO BATATA,INHAME E AIPIM)')), 'Preparações', 116.02, 15.81, 2.45, 4.5, 0.55),
  ('ibge', 857840499, 'ABOBORA COM QUIABO', unaccent(lower('ABOBORA COM QUIABO')), 'Preparações', 21.0, 1.29, 4.71, 0.14, 1.8),
  ('ibge', 857900299, 'ARROZ CARRETEIRO', unaccent(lower('ARROZ CARRETEIRO')), 'Preparações', 154.0, 10.8, 11.6, 7.1, 1.5),
  ('ibge', 857900399, 'MARIA IZABEL', unaccent(lower('MARIA IZABEL')), 'Preparações', 154.0, 10.8, 11.6, 7.1, 1.5),
  ('ibge', 857900499, 'ARROZ DE LEITE', unaccent(lower('ARROZ DE LEITE')), 'Preparações', 142.42, 2.98, 22.62, 4.17, 0.3),
  ('ibge', 857900599, 'ARROZ COM MANDIOCA', unaccent(lower('ARROZ COM MANDIOCA')), 'Preparações', 130.31, 1.55, 28.94, 0.75, 1.57),
  ('ibge', 857900699, 'ARROZ COM OVO', unaccent(lower('ARROZ COM OVO')), 'Preparações', 179.11, 8.09, 14.5, 9.43, 0.77),
  ('ibge', 880010999, 'PALMA', unaccent(lower('PALMA')), 'Preparações', 41.95, 1.35, 3.28, 3.1, 2.0)
on conflict (source, ext_id) do update set
  name = excluded.name, name_norm = excluded.name_norm, category = excluded.category,
  kcal = excluded.kcal, protein = excluded.protein, carb = excluded.carb,
  fat = excluded.fat, fiber = excluded.fiber;
