-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260707120003_storage.sql
-- O QUÊ:     Bucket PRIVADO de fotos de receitas + políticas (dono só acessa a
--            própria subpasta). Path: {user_id}/{recipe_id}/{index}.jpg
-- SPEC:      specs/backend/storage.yaml + specs/backend/rls.yaml
-- ─────────────────────────────────────────────────────────────────────────────

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'recipe-photos',
  'recipe-photos',
  false,                                   -- privado: app lê via URL assinada
  5242880,                                 -- 5 MB por foto
  array['image/jpeg', 'image/png', 'image/webp']
);

-- Cada usuário só acessa objetos cujo 1º segmento do path é o próprio uid.
create policy "fotos: dono le" on storage.objects
  for select using (
    bucket_id = 'recipe-photos'
    and (storage.foldername(name))[1] = (select auth.uid())::text);

create policy "fotos: dono envia" on storage.objects
  for insert with check (
    bucket_id = 'recipe-photos'
    and (storage.foldername(name))[1] = (select auth.uid())::text);

create policy "fotos: dono troca" on storage.objects
  for update using (
    bucket_id = 'recipe-photos'
    and (storage.foldername(name))[1] = (select auth.uid())::text);

create policy "fotos: dono apaga" on storage.objects
  for delete using (
    bucket_id = 'recipe-photos'
    and (storage.foldername(name))[1] = (select auth.uid())::text);
