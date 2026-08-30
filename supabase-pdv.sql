-- MBN PDV compartilhado — Supabase
-- Projeto: https://supabase.com/dashboard/project/bcyyjdglhmxhskwwcrdb/sql/new
-- Execute todo este arquivo no SQL Editor.

create table if not exists public.pdv_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create or replace function public.pdv_state_set_updated_at()
returns trigger language plpgsql security invoker as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists pdv_state_updated_at on public.pdv_state;
create trigger pdv_state_updated_at
before update on public.pdv_state
for each row execute function public.pdv_state_set_updated_at();

alter table public.pdv_state enable row level security;
drop policy if exists "pdv_state_select_own" on public.pdv_state;
drop policy if exists "pdv_state_insert_own" on public.pdv_state;
drop policy if exists "pdv_state_update_own" on public.pdv_state;
drop policy if exists "pdv_state_delete_own" on public.pdv_state;

create policy "pdv_state_select_own" on public.pdv_state
for select to authenticated using (auth.uid() = user_id);
create policy "pdv_state_insert_own" on public.pdv_state
for insert to authenticated with check (auth.uid() = user_id);
create policy "pdv_state_update_own" on public.pdv_state
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "pdv_state_delete_own" on public.pdv_state
for delete to authenticated using (auth.uid() = user_id);

grant select, insert, update, delete on public.pdv_state to authenticated;

-- Habilita a sincronização em tempo real entre os dispositivos.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'pdv_state'
  ) then
    alter publication supabase_realtime add table public.pdv_state;
  end if;
end $$;

-- Verificação opcional:
-- select table_name from information_schema.tables
-- where table_schema = 'public' and table_name = 'pdv_state';
