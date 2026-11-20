-- Solo per l'Opzione 2 (nuovo progetto Supabase). Da eseguire una volta nello SQL Editor.
create table if not exists public.user_finance_store (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.user_finance_store enable row level security;

create policy "select own row" on public.user_finance_store
  for select to authenticated using (user_id = auth.uid());
create policy "insert own row" on public.user_finance_store
  for insert to authenticated with check (user_id = auth.uid());
create policy "update own row" on public.user_finance_store
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "delete own row" on public.user_finance_store
  for delete to authenticated using (user_id = auth.uid());
