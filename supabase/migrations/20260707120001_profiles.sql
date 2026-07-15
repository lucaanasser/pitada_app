-- ─────────────────────────────────────────────────────────────────────────────
-- supabase/migrations/20260707120001_profiles.sql
-- O QUÊ:     Fundação: extensão pgcrypto, tabela profiles (1 linha por usuário)
--            e trigger que cria o profile automaticamente no 1º login.
-- SPEC:      specs/backend/database.yaml (0001) + specs/backend/rls.yaml
-- ─────────────────────────────────────────────────────────────────────────────

create extension if not exists pgcrypto;

-- Perfil do usuário (dados de app que não moram no auth.users).
create table public.profiles (
  id           uuid primary key references auth.users (id) on delete cascade,
  display_name text,
  created_at   timestamptz not null default now()
);

-- Grant explícito (o CLI não concede DML por padrão): só authenticated; anon = nada.
-- Insert fica de fora — o profile nasce pelo trigger (security definer, roda como dono).
grant select, update on public.profiles to authenticated;

-- RLS: dono lê e edita o próprio perfil. Insert é só via trigger (security definer).
alter table public.profiles enable row level security;

create policy "profiles: dono le" on public.profiles
  for select using ((select auth.uid()) = id);

create policy "profiles: dono edita" on public.profiles
  for update using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

-- Cria o profile automaticamente quando um usuário nasce no Auth (1º login OTP).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  -- display_name inicial = parte local do e-mail (ex.: luca@x.dev -> "luca")
  insert into public.profiles (id, display_name)
  values (new.id, split_part(new.email, '@', 1));
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
