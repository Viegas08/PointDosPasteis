create table if not exists public.orders (
 id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(),
 customer_name text not null default '', customer_phone text not null default '', items jsonb not null default '[]'::jsonb,
 subtotal numeric(10,2) not null default 0, delivery_fee numeric(10,2) not null default 0, total numeric(10,2) not null default 0,
 fulfillment text not null check (fulfillment in ('delivery','pickup')), street text not null default '', street_number text not null default '', neighborhood text not null default '',
 payment_method text not null check (payment_method in ('cash','pix','card')), payment_status text not null default 'pending' check (payment_status in ('pending','confirmed')),
 change_for text not null default '', pix_payload text not null default '', notes text not null default '',
 status text not null default 'new' check (status in ('new','preparing','ready','out_for_delivery','completed','cancelled'))
);
alter table public.orders enable row level security;
revoke all on public.orders from anon, authenticated;
grant insert on public.orders to anon;
grant select, update on public.orders to authenticated;
drop policy if exists "public can place orders" on public.orders;
create policy "public can place orders" on public.orders for insert to anon with check (true);
drop policy if exists "staff can view orders" on public.orders;
create policy "staff can view orders" on public.orders for select to authenticated using (true);
drop policy if exists "staff can update orders" on public.orders;
create policy "staff can update orders" on public.orders for update to authenticated using (true) with check (true);
-- Cadastre a conta da equipe manualmente em Authentication > Users e desative os cadastros públicos.

-- Acompanhar o pedido: o token aleatório permite ao cliente consultar apenas o próprio status.
alter table public.orders add column if not exists tracking_token text;
update public.orders set tracking_token=gen_random_uuid()::text where tracking_token is null;
alter table public.orders alter column tracking_token set default gen_random_uuid()::text;
alter table public.orders alter column tracking_token set not null;
create or replace function public.get_order_tracking(p_order_id uuid, p_tracking_token text)
returns jsonb language sql stable security definer set search_path=public as $$
 select jsonb_build_object('id',id,'created_at',created_at,'items',items,'total',total,'status',status,'payment_status',payment_status,'fulfillment',fulfillment)
 from public.orders where id=p_order_id and tracking_token=p_tracking_token limit 1;
$$;
revoke all on function public.get_order_tracking(uuid,text) from public;
grant execute on function public.get_order_tracking(uuid,text) to anon, authenticated;
