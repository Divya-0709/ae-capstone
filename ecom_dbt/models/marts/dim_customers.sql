with customers as (
    select * from {{ ref('int_customers_enriched') }}
),

order_stats as (
    select
        customer_id,
        count(order_id)                 as total_orders,
        sum(order_value)                as total_spend,
        min(purchase_date)              as first_order_date,
        max(purchase_date)              as last_order_date
    from {{ ref('int_orders_enriched') }}
    group by customer_id
)

select
    c.customer_id,
    c.customer_unique_id,
    c.city,
    c.state,
    c.customer_segment,
    c.region,
    c.ltv_tier,
    c.signup_date,
    o.total_orders,
    o.total_spend,
    o.first_order_date,
    o.last_order_date
from customers c
left join order_stats o using (customer_id)