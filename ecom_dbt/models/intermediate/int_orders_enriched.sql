with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select
        order_id,
        count(order_item_id)            as item_count,
        sum(item_price)                 as subtotal,
        sum(freight_value)              as total_freight,
        sum(total_item_value)           as order_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

payments as (
    select
        order_id,
        sum(payment_value)              as total_paid,
        max(payment_type)               as payment_type,
        max(payment_installments)       as installments
    from {{ ref('stg_payments') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    o.status,
    o.purchased_at,
    o.delivered_at,
    o.purchase_date,
    oi.item_count,
    oi.subtotal,
    oi.total_freight,
    oi.order_value,
    p.total_paid,
    p.payment_type,
    p.installments,
    date_diff(
        date(o.delivered_at),
        date(o.purchased_at),
        day
    )                                   as delivery_days
from orders o
left join order_items oi using (order_id)
left join payments p using (order_id)