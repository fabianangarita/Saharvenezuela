-- SAHAR VENEZUELA · ejecutar completo en Supabase > SQL Editor
create table if not exists products(
 id text primary key, name text not null, brand text,
 price numeric not null check(price>0),
 sale numeric not null default 0 check(sale=0 or sale<price),
 sizes text, conc text, family text, top text, heart text, base text,
 gender text, cat text, descr text, img text,
 featured boolean default false, stock boolean default true, active boolean default true, created bigint);
create table if not exists settings(id text primary key, data jsonb not null default '{}');
create table if not exists admins(user_id uuid primary key references auth.users on delete cascade);
alter table products enable row level security;
alter table settings enable row level security;
alter table admins enable row level security;
create or replace function is_admin() returns boolean language sql security definer stable set search_path=public as
$$ select exists(select 1 from admins where user_id=auth.uid()) $$;
create policy "ver publicados" on products for select using (active or is_admin());
create policy "admin escribe productos" on products for all using (is_admin()) with check (is_admin());
create policy "ver ajustes" on settings for select using (true);
create policy "admin escribe ajustes" on settings for all using (is_admin()) with check (is_admin());
create policy "ver mi admin" on admins for select using (user_id=auth.uid());
insert into storage.buckets(id,name,public) values('products','products',true) on conflict do nothing;
create policy "fotos publicas" on storage.objects for select using (bucket_id='products');
create policy "admin sube fotos" on storage.objects for insert with check (bucket_id='products' and is_admin());
create policy "admin edita fotos" on storage.objects for update using (bucket_id='products' and is_admin());
create policy "admin borra fotos" on storage.objects for delete using (bucket_id='products' and is_admin());
-- Después de crear tu usuario en Authentication > Users, hazlo administrador (cambia el UUID):
-- insert into admins(user_id) values ('PEGA-AQUI-TU-UUID');
