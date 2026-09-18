create table if not exists public.birthdays(id uuid primary key default gen_random_uuid(),slug text unique not null,payload jsonb not null,created_at timestamptz default now(),expires_at timestamptz);
alter table public.birthdays enable row level security;
create policy "read birthdays" on public.birthdays for select using (true);
create policy "create birthdays" on public.birthdays for insert with check (true);
insert into storage.buckets(id,name,public) values('birthday-media','birthday-media',true) on conflict(id) do nothing;
create policy "read birthday media" on storage.objects for select using(bucket_id='birthday-media');
create policy "upload birthday media" on storage.objects for insert with check(bucket_id='birthday-media');
